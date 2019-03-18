Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162AF202BB
	for <e@80x24.org>; Mon, 18 Mar 2019 06:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCRG2r (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 02:28:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40710 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfCRG2r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 02:28:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so15628473wri.7
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 23:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fSqyMRT0+W1+3vybvgRRmFkpZS+tJO1CLYtiu5tbehQ=;
        b=jphSTYmyqm1+4+viJ3kEIpT0tfgE3IT8045Tt6XdZ5b7tg6jwdRkb5eM3Vqp3FvCuz
         +3yAps+sTZHZppsc0i0K3vn9T9vxNELvdnT/RNPeuvJVjOyCIQVb3jLkQuoWGVHznSJP
         D7ayWxQPgRQQPQhO81TLP6dJtPeUBrw1BKggHkRWlJIoQ1w3wJ0JjUcMYe2X4AMwcCpe
         T1wxO2FNOrjWXjTlsS1eCgxnJX8tKtALkUKqCYuQ054XN9lBoMvzEbep1glJrGJZ2zZO
         kZsY1Fw60rOnheIzK699IAqm/BWmp9z7o14XR2qwNtPzBCKLkkN9sB/KhaMODbtCFoUR
         uSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fSqyMRT0+W1+3vybvgRRmFkpZS+tJO1CLYtiu5tbehQ=;
        b=dwAJsj+vNEMFLto8UGhox0lYaJqTsbONNCszX/rQ8/+7BQlEQSvbYpggSU/XAACqsg
         binC3XoLrJgv3MvkhFtVh1rAlik0LsVv7ZrIGufx56n9HIPZbFcx+RQguGNk6fUmNbLA
         Mv48Zc/A2YHhXm+zh1XZ4Hyk5iDtRfjsDVB4xl7Y/gfOLC/NxQgfc3lyFoho0SuQN0oP
         yM/Ifnp/OAxhvooxIuWKGd2+OErtQYhu0U6oXsbLH/VTB0riU5wdsKGgTk+j55pIupD1
         dpY44IkoYqbA0P/31Lxzo42ekQ8AOvt2C+8Syxzmf1TtWjoDLCctmTX6OXvsySy7SdHp
         ByQw==
X-Gm-Message-State: APjAAAXqaMnSJDLD4fDHST/H1QwSFwrnNY8qLKHanghtFIIbBhqUFPxn
        8wmuyx3DlLjvKWakHgypzeQ=
X-Google-Smtp-Source: APXvYqxaA1rU3jZWUoKucCUaX51qiquIEyHIw1Mcxo8JK/Zi6FgXS4EtwAsfrTQ4At4dhw3mUiSo3Q==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr5583215wrp.197.1552890525473;
        Sun, 17 Mar 2019 23:28:45 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id p6sm12553250wre.63.2019.03.17.23.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 23:28:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Baruch Siach <baruch@tkos.co.il>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
        <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk>
        <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com>
Date:   Mon, 18 Mar 2019 15:28:44 +0900
In-Reply-To: <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com> (Joe
        Perches's message of "Sun, 17 Mar 2019 18:56:08 -0700")
Message-ID: <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> My preference would be for correctness.
> I presume something like this isn't too onerous.

I am guessing that /^---/ is to stop at the three-dash line *OR*
after the initial handful of lines of the first diff header (as the
last resort) and that is why it is not looking for /^---$/.

If that is the case, I think it makes a lot of sense.  It is a
general improvement not tied to the case that triggered this thread.

Independently, I think it makes sense to do something like

	/^([a-z][a-z-]*-by|Cc): (.*)/i

to tighten the match to exclude a non-trailer; that would have been
sufficient for the original case that triggered this thread.



> ---
>  git-send-email.perl | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 8200d58cdc..83b0429576 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1697,9 +1697,10 @@ sub process_file {
>  		}
>  	}
>  	# Now parse the message body
> +	my $in_patch = 0;
>  	while(<$fh>) {
>  		$message .=  $_;
> -		if (/^([a-z-]*-by|Cc): (.*)/i) {
> +		if (!$in_patch && /^([a-z-]*-by|Cc): (.*)/i) {
>  			chomp;
>  			my ($what, $c) = ($1, $2);
>  			# strip garbage for the address we'll use:
> @@ -1725,6 +1726,8 @@ sub process_file {
>  			push @cc, $c;
>  			printf(__("(body) Adding cc: %s from line '%s'\n"),
>  				$c, $_) unless $quiet;
> +		} elsif (/^---/) {
> +			$in_patch = 1;
>  		}
>  	}
>  	close $fh;
