Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1441F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeDBWFk (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:05:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33803 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754429AbeDBWFj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:05:39 -0400
Received: by mail-wr0-f193.google.com with SMTP id d17so426377wre.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AKofEFBI0rDKxKYfYAiOBZF866P9npcNEZNdEdqkbMI=;
        b=fNJhBckxB/nDKFjiFqOOb/R0iKC/2VSqRT07nvCmfr1k+c5KoJoteO6BS+4qSlzR1L
         bF8gTCxA6oV2z4f/6srMtEM9DL4Pwix1FQYaJoOlDRgC7HEe8Emg+IVnYbbROXparPq9
         tZl6YDWy9vNOGOCtcB53MmzkIKEJYewq42oz9n9A08sMlXqQS60ca20U5b9NYVO/F6a0
         E3d7/ha2ZexHcmsRGxlVeFMuJpgcZlZ6WpNHYX2IUq6wOa4MU9vErrXMN6gagX0/kCUU
         jCqPfSaYy5ips9/a43njBqzDZ1BVQKbI2RxCObJIebbjmPfcTfozihdwMe4kOl+aCOJM
         duUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=AKofEFBI0rDKxKYfYAiOBZF866P9npcNEZNdEdqkbMI=;
        b=LoD6IsCCroFjQnyBqB+eHZlU8+LPGpwHDGBeIZ/PtWO6IKV3N2R1FDp6CirEVEpFb0
         KjqknxwrwUpDquJAtN7kXkb79GcJExWHcKRUC0rUjP2QXYkEPkGdQ5/SgYSWDpKJrSBF
         kKC8WYUrKsCUguJL/pyIwWDMI4KuDK/yGE/ifPkuTt/ZrzPsG3od3mZIt7eCrUrNbZhw
         hyFCoRvVBUkfC4Zmce4FyeDPmdvmDNGOvZQWsa4s3QC39FoHOgmzNctRMa7jN/2bOnXE
         ZqQc5Q1s2n7xWxxVlOKzS5oMhMWJC7diMiDjBgC52NU9bSlltqK/GLigAoKiSS3+/qaZ
         syKQ==
X-Gm-Message-State: AElRT7HEuE+Xqshfmyrv8drU6Z6wOqxm8Qkc/M9Bhn1yyn87+vbaJDB6
        yTbW3W+Eh2YnAdyj/EdN0JM=
X-Google-Smtp-Source: AIpwx4+xHpbMlRjmUBK/POtLiWPz0q/WS0vGTwvHZsAEcP2WzDt/WIl7rT+7PQS0WCX3huQJQtfRNw==
X-Received: by 10.223.208.142 with SMTP id y14mr6903931wrh.20.1522706738032;
        Mon, 02 Apr 2018 15:05:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p14sm2856125wrc.30.2018.04.02.15.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 15:05:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal Nazarewicz <mina86@mina86.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: report host and port separately when calling git credential
References: <20180331180514.14628-1-mina86@mina86.com>
Date:   Mon, 02 Apr 2018 15:05:35 -0700
In-Reply-To: <20180331180514.14628-1-mina86@mina86.com> (Michal Nazarewicz's
        message of "Sat, 31 Mar 2018 19:05:14 +0100")
Message-ID: <xmqqk1tpxo0g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Nazarewicz <mina86@mina86.com> writes:

> When git-send-email uses git-credential to get SMTP password, it will
> communicate SMTP host and port (if both are provided) as a single entry
> ‘host=<host>:<port>’.  This trips the ‘git-credential-store’ helper
> which expects those values as separate keys (‘host’ and ‘port’).
>
> Send the values as separate pieces of information so things work
> smoothly.
>
> Signed-off-by: Michał Nazarewicz <mina86@mina86.com>
> ---
>  git-send-email.perl | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

"git help credential" mentions protocol, host, path, username and
password (and also url which is a short-hand for setting protocol
and host), but not "port".  And common sense tells me, when a system
allows setting host but not port, that it would expect host:port to
be given when the service is running a non-standard port, so from
that point of view, I suspect that the current code is working as
expected.  In fact, credential.h, which defines the API, does not
have any "port" field, either, so I am not sure how this is expected
to change anything without touching the back-end that talks over the
pipe via _credential_run-->credential_write callchain.

Now, it is a separate matter if it were a better design if the
credential API had 'host' and 'port' defined as separate keys to the
authentication information.  Such an alternative design would have
made certain things harder while some other things easier (e.g. "use
this credential to the host no matter what port the service runs"
may be easier to implement if 'host' and 'port' are separate).


> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2fa7818ca..2a9f89a58 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1229,14 +1229,6 @@ sub maildomain {
>  	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
>  }
>  
> -sub smtp_host_string {
> -	if (defined $smtp_server_port) {
> -		return "$smtp_server:$smtp_server_port";
> -	} else {
> -		return $smtp_server;
> -	}
> -}
> -
>  # Returns 1 if authentication succeeded or was not necessary
>  # (smtp_user was not specified), and 0 otherwise.
>  
> @@ -1263,7 +1255,8 @@ sub smtp_auth_maybe {
>  	# reject credentials.
>  	$auth = Git::credential({
>  		'protocol' => 'smtp',
> -		'host' => smtp_host_string(),
> +		'host' => $smtp_server,
> +		'port' => $smtp_server_port,
>  		'username' => $smtp_authuser,
>  		# if there's no password, "git credential fill" will
>  		# give us one, otherwise it'll just pass this one.
