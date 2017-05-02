Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01690207D6
	for <e@80x24.org>; Tue,  2 May 2017 02:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdEBCZB (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 22:25:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36843 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdEBCZA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 22:25:00 -0400
Received: by mail-pg0-f67.google.com with SMTP id v1so18628469pgv.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 19:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yQGlvlfuV25XGHX1CS/IOaXpB7peLkYwzpIwhEgaVxc=;
        b=quw3CXiSr1/F3CiPMUHuXKzsWDUqsoKSzY+QdSXQ9hipfU/xf8vdBZk+U9JsOAGNkX
         pknZ1IbBHLyPx5N6IzbyW96FMRqU1/iG5GtVVadxpb5rRPxdP5aA5A5UZlFfzpTtHMUM
         rIfyv89p519n+1sqeIt6CVL9g0o5EZk4bxaZdkkEEI8uLJ/1LJkYMuKefV3VIjZ5zUk2
         DlKjMJxbRTRk0RxnJDkvc3+Fiumm3YU9yznr+jA1NwYvx3qB99+1fE3OV2oqh3aJnfoL
         veb3CuMNDfxV3ICRjvBlmfe/MF6D5rd3x7x1ZMHk2c7AAwwqRDvQuGruZxcECfJ7k8hJ
         z5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yQGlvlfuV25XGHX1CS/IOaXpB7peLkYwzpIwhEgaVxc=;
        b=q1IZ981ek7hrKelMiV7iOszf2hvqEwdmJQ4bs1MftQn7eHsN9WK8ONTu6E8yB53Xm7
         rA/FDoZFXm8cG98ppigZ+0GbmIeJBiUi3Gq1nXM5LskcIKz11PixJoFcu7zHhOJQ2Y69
         KO4l8bSN4BukjCDJrYjIK0EIBIv5tHKRtcJwCB8OW1AiQng+aJ/pLqgC6RZC8HlkdgW6
         RuCnQ6HHmF99GnHjL8/w/NwOsdNqdIAMJ4n4VA7ZtQzlIf6hwbRJwFKMVsUWBzef0B1W
         Vx9o0XsGz7oJd6sNkOYVsl2PQss8JjAkMqeIvaruoO49bo8/SLTyaSk7jrfArWGwX6qn
         sUuw==
X-Gm-Message-State: AN3rC/5BZ5xtiFCXnzcIv0sHggxrMXqYkx9pob2spjJpNqy4Yh5GHKn+
        7b77Gp1NEFoEYw==
X-Received: by 10.99.149.20 with SMTP id p20mr13481917pgd.112.1493691899285;
        Mon, 01 May 2017 19:24:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id p2sm27535059pfj.93.2017.05.01.19.24.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 19:24:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     xiaoqiang zhao <zxq_yx_007@163.com>
Cc:     git@vger.kernel.org, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com
Subject: Re: [PATCH v2] send-email: new options to walkaround email server limits
References: <20170501125928.11291-1-zxq_yx_007@163.com>
Date:   Mon, 01 May 2017 19:24:56 -0700
In-Reply-To: <20170501125928.11291-1-zxq_yx_007@163.com> (xiaoqiang zhao's
        message of "Mon, 1 May 2017 20:59:28 +0800")
Message-ID: <xmqqtw54dmh3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

xiaoqiang zhao <zxq_yx_007@163.com> writes:

> Some email server(e.g. smtp.163.com) limits a fixed number emails to
> be send per session(connection) and this will lead to a send faliure.
>
> With --batch-size=<num> option, an auto reconnection will occur when
> number of sent email reaches <num> and the problem is solved.
>
> --relogin-delay option will make some delay between two successive
> email server login.

Here is how I would have written the above..

    send-email: --batch-size to work around some SMTP server limit

    Some email servers (e.g. smtp.163.com) limit the number emails to be
    sent per session(connection) and this will lead to a faliure when
    sending many messages.

    Teach send-email to disconnect after sending a number of messages
    (configurable via the --batch-size=<num> option), wait for a few
    seconds (configurable via the --relogin-delay=<seconds> option) and
    reconnect, to work around such a limit.


But I am having a huge problem seeing how this patch is correct.  It
always is troubling to see a patch that makes the behaviour of a
program change even when the optional feature it implements is not
being used at all.  Why does it even have to touch smtp_auth_maybe?
Why does the updated smtp_auth_maybe have to do quite different
things even when batch-size is not defined from the original?
What is that new "Auth use saved password. \n" message about?

After reading the problem description in the proposed log message,
the most natural update to achieve the stated goal is to add code to
the loop that has the only caller to send_message() function, I
would think.  The loop goes over the input files and prepares the
variables used in send_message() and have the function send a single
message, initializing $smtp as necessary but otherwise reusing $smtp
the previous round has prepared.  So just after $message_id is
undefed in the loop, I expected that you would count "number of
messages sent so far during this session", and when that number
exceeds the batch size, disconnect $smtp and unset the variable,
and sleep for a bit, without having to change anything else.

Puzzled.

>  sub smtp_auth_maybe {
> -	if (!defined $smtp_authuser || $auth) {
> +	if (!defined $smtp_authuser || $num_sent != 0) {
>  		return 1;
>  	}
>  
> +	if ($auth && $num_sent == 0) {
> +		print "Auth use saved password. \n";
> +		return !!$smtp->auth($smtp_authuser, $smtp_authpass);
> +	}
> +
>  	# Workaround AUTH PLAIN/LOGIN interaction defect
>  	# with Authen::SASL::Cyrus
>  	eval {
> @@ -1187,6 +1201,7 @@ sub smtp_auth_maybe {
>  		'password' => $smtp_authpass
>  	}, sub {
>  		my $cred = shift;
> +		$smtp_authpass = $cred->{'password'};
>  
>  		if ($smtp_auth) {
>  			my $sasl = Authen::SASL->new(
> @@ -1442,6 +1457,15 @@ EOF
>  		}
>  	}
>  
> +	$num_sent++;
> +	if ($num_sent == $batch_size) {
> +		$smtp->quit;
> +		$smtp = undef;
> +		$num_sent = 0;
> +		print "Reconnect SMTP server required. \n";
> +		sleep($relogin_delay);
> +	}
> +
>  	return 1;
>  }
