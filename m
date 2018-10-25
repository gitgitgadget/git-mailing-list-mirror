Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CE3D1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 09:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeJYSPk (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 14:15:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36890 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeJYSPk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 14:15:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id g9-v6so8572977wrq.4
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 02:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N71M2/sOHN/bxw6eQqKN5od3l9om5HdtdeH9hFnI76k=;
        b=QPPc0Fr8UG8cnsdTZF5haC0MAZUotB9KpT4Tj5Kd/1nlrGaSX3Zdg5TgMSs38ZqA5n
         iOmxX0gju9rlgeSn/Fw//ngMjlR27WySyhyjhwd0Py0fRLk0IP1YMOCYrFD5wuP1wfoH
         KjJ8vtf3BQGXP6f8YOQqIjfQbz6X21dMLP4/L0/FKRR5eIwWBO+swwEFz2snlkNWrtSR
         Nner2tzHprI4HyjCK+IasSwsEuZ73+d+kp4z0thmhDSP9J8kIxvKH8YnWEEj1qLfK9tl
         lCckxMBx/IudNsiG8HuUgOJTL3cylAkRvncba/9OABeBS/OZq4d4R2uf7RKDCXWDRPnR
         ZPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=N71M2/sOHN/bxw6eQqKN5od3l9om5HdtdeH9hFnI76k=;
        b=b82pmg7XUoNneoE15QPA48ukjnIEbUhC2G4WdKPemd7mLdDdUP/UFsgr8LmZnuajgC
         XNlFvIRfuXhEWQVLhxunTGXQGLde/+P2Jlk6eEX6Mn//jf8zdibzQc9492s8y2uNhHZo
         JjP/tVHu+TzJZqBgPRhmfAsT/e0z2Oge7LguJGeQ8Eh5X93rDLACm8eXf3Bk0MgwOS/p
         uZUNXzX0mJr1UiCNUFud3/2SHLr7ALltOTNIL93FCXrxRmODusAoyibacy/3+VoKzcOI
         kQ/P+SWWJBhvThAvuKyPNSuEJdOX/b7I0iqwj321hVCRHPSj/jHuakRWvaZwtooKnAW0
         /JSw==
X-Gm-Message-State: AGRZ1gJaU/Rpx7bqRFN5MXxVK03zNDbCziEY3Q7Yk5ONMDuXKL0sZXL5
        9rkkdhCbdgyvrhi57CCVxm4=
X-Google-Smtp-Source: AJdET5e48Fllf1modfB/Utpl3UW9T+/uKq8BUM0VhjyEtrqJTFxC7/pZZV5gcmPg36WxtzcAWnNsIA==
X-Received: by 2002:adf:9501:: with SMTP id 1-v6mr1095891wrs.291.1540460619868;
        Thu, 25 Oct 2018 02:43:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l67-v6sm1890169wma.20.2018.10.25.02.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:43:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joshua Watt <jpewhacker@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] send-email: explicitly disable authentication
References: <20181022175248.3940-1-JPEWhacker@gmail.com>
        <20181023032425.9608-1-JPEWhacker@gmail.com>
Date:   Thu, 25 Oct 2018 18:43:38 +0900
In-Reply-To: <20181023032425.9608-1-JPEWhacker@gmail.com> (Joshua Watt's
        message of "Mon, 22 Oct 2018 22:24:25 -0500")
Message-ID: <xmqq36sugy45.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joshua Watt <jpewhacker@gmail.com> writes:

> It can be necessary to disable SMTP authentication by a mechanism other
> than sendemail.smtpuser being undefined. For example, if the user has
> sendemail.smtpuser set globally but wants to disable authentication
> locally in one repository.
>
> --smtp-auth and sendemail.smtpauth now understand the value 'none' which
> means to disable authentication completely, even if an authentication
> user is specified.
>
> The value 'none' is lower case to avoid conflicts with any RFC 4422
> authentication mechanisms.
>
> The user may also specify the command line argument --no-smtp-auth as a
> shorthand for --smtp-auth=none
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---

Thanks.  Let's queue this and merge it to 'next' soonish.




>  Documentation/git-send-email.txt | 7 ++++++-
>  git-send-email.perl              | 8 ++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 465a4ecbe..17993e3c9 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -190,7 +190,9 @@ $ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
>  If at least one of the specified mechanisms matches the ones advertised by the
>  SMTP server and if it is supported by the utilized SASL library, the mechanism
>  is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
> -is specified, all mechanisms supported by the SASL library can be used.
> +is specified, all mechanisms supported by the SASL library can be used. The
> +special value 'none' maybe specified to completely disable authentication
> +independently of `--smtp-user`
>  
>  --smtp-pass[=<password>]::
>  	Password for SMTP-AUTH. The argument is optional: If no
> @@ -204,6 +206,9 @@ or on the command line. If a username has been specified (with
>  specified (with `--smtp-pass` or `sendemail.smtpPass`), then
>  a password is obtained using 'git-credential'.
>  
> +--no-smtp-auth::
> +	Disable SMTP authentication. Short hand for `--smtp-auth=none`
> +
>  --smtp-server=<host>::
>  	If set, specifies the outgoing SMTP server to use (e.g.
>  	`smtp.example.com` or a raw IP address).  Alternatively it can
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2be5dac33..a70679484 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -82,8 +82,11 @@ sub usage {
>                                       Pass an empty string to disable certificate
>                                       verification.
>      --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
> -    --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms.
> +    --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms, or
> +                                     "none" to disable authentication.
>                                       This setting forces to use one of the listed mechanisms.
> +    --no-smtp-auth                   Disable SMTP authentication. Shorthand for
> +                                     `--smtp-auth=none`
>      --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
>  
>      --batch-size            <int>  * send max <int> message per connection.
> @@ -341,6 +344,7 @@ sub signal_handler {
>  		    "smtp-debug:i" => \$debug_net_smtp,
>  		    "smtp-domain:s" => \$smtp_domain,
>  		    "smtp-auth=s" => \$smtp_auth,
> +		    "no-smtp-auth" => sub {$smtp_auth = 'none'},
>  		    "identity=s" => \$identity,
>  		    "annotate!" => \$annotate,
>  		    "no-annotate" => sub {$annotate = 0},
> @@ -1241,7 +1245,7 @@ sub smtp_host_string {
>  # (smtp_user was not specified), and 0 otherwise.
>  
>  sub smtp_auth_maybe {
> -	if (!defined $smtp_authuser || $auth) {
> +	if (!defined $smtp_authuser || $auth || (defined $smtp_auth && $smtp_auth eq "none")) {
>  		return 1;
>  	}
