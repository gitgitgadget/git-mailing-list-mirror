Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2A81F453
	for <e@80x24.org>; Mon,  5 Nov 2018 01:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeKEKj5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 05:39:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35651 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeKEKj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 05:39:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id z16-v6so7665432wrv.2
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LhmwkNxH9MbBrqrSFDTpthJsvutOzDQ7m7Coo1/nd9g=;
        b=uUYNlIieJGedg7T8b25qvQKmIxJdW3iEn0Qrh2fPjPdM6nKBfNafy8XJzdQ0OQL+gw
         L8IlWt3yWi4W1xCntZdbPT8I+s47l9lX9wChSUyltz8QGObkiJMMP9V+/7obOIW7+pgz
         cj+oJ3qqqwmhcDH+3JwuoZwb7UZpiVY5LLPR+Qm1C9AiBMAuIzI448CusMYwPxZONqhb
         UraZ5iSOOE0quS5kxxY8JrTEVo+I6+BmxzX/0eyOJmG2E+tQY/6J15qFUgxBvAP2gC8M
         4+q5fr99WPLHwFbReTJnKf9UIdKYlQtxINj+/aY0p6vfUMrmqwpr07wSi1EVdfQKszKt
         UBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LhmwkNxH9MbBrqrSFDTpthJsvutOzDQ7m7Coo1/nd9g=;
        b=rWuy7N3uLct4LBNZnn3tt4oRdg3d1Ag5zP9faXCVedw1+urSgTXMajHSr/kPlz4rPJ
         Y7E9KgKp4uj7DwU8dFHq6h7zU+v9NhW6VB+/rwLNtYeTSlJf5IFfCv0BWc6xOblbU/Fc
         qUHcHfAV+qasNEowZCYoI4KmKioT6siP9lm2JirzOpEZOmv2tfjHIsk/zS2bXsPr7NhD
         oOOkGgJmANpY87lm63QxHVftJBnEeOuLYukgiXSeQyT9nGSUY/Y3UddhrJnUYhXlBZ1T
         bsZPcu6JNs6A9++5S9vftq/2QxXKIeUqKNQbcO/xOab9nvAjepbddSzUtbW0jrRDBYRW
         bnSA==
X-Gm-Message-State: AGRZ1gJjOjP/rPTBUsxJthf8DI7l9LZ9XwTiNSAyas26BkSWzYLPZmZ8
        7JNqfCWPWPf5iVibDmTJDigMtOuaWpg=
X-Google-Smtp-Source: AJdET5e/fUecZJA88+G2Us6M9lb/0EWvGoaT5AedPxM+NTne1KKwymGPDISSUlRoq4oHP7WxA/HMqg==
X-Received: by 2002:adf:8444:: with SMTP id 62-v6mr16731349wrf.251.1541380969660;
        Sun, 04 Nov 2018 17:22:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l42-v6sm16345672wre.37.2018.11.04.17.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 17:22:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     James Knight <james.d.knight@live.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] build: link with curl-defined linker flags
References: <SN4PR0701MB3679953BCD417500EC2A267BA0C80@SN4PR0701MB3679.namprd07.prod.outlook.com>
Date:   Mon, 05 Nov 2018 10:22:48 +0900
In-Reply-To: <SN4PR0701MB3679953BCD417500EC2A267BA0C80@SN4PR0701MB3679.namprd07.prod.outlook.com>
        (James Knight's message of "Sat, 3 Nov 2018 05:12:11 +0000")
Message-ID: <xmqqbm74l3mf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

James Knight <james.d.knight@live.com> writes:

> Changes v1 -> v2:
>  - Improved support for detecting curl linker flags when not using a
>     configure-based build (mentioned by Junio C Hamano).
>  - Adding a description on how to explicitly use the CURL_LDFLAGS
>     define when not using configure (suggested by Junio C Hamano).
>
> The original patch made a (bad) assumption that builds would always
> invoke ./configure before attempting to build Git. To support a
> make-invoked build, CURL_LDFLAGS can also be populated using the defined
> curl-config utility. This change also comes with the assumption that
> since both ./configure and Makefile are using curl-config to determine
> aspects of the build, it should be also fine to use the same utility to
> provide the linker flags to compile against (please indicate so if this
> is another bad assumption). With this change, the explicit configuration
> of CURL_LDFLAGS inside config.mak.uname for Minix and NONSTOP_KERNEL
> have been dropped.

Will replace; thanks.


>  Makefile         | 30 +++++++++++++++---------------
>  config.mak.uname |  3 ---
>  configure.ac     | 17 +++++++----------
>  3 files changed, 22 insertions(+), 28 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b08d5ea258c69a78745dfa73fe698c11d021858a..36da17dc1f9b1a70c9142604afe989f1eb8ee87f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -59,6 +59,13 @@ all::
>  # Define CURL_CONFIG to curl's configuration program that prints information
>  # about the library (e.g., its version number).  The default is 'curl-config'.
>  #
> +# Define CURL_LDFLAGS to specify flags that you need to link when using libcurl,
> +# if you do not want to rely on the libraries provided by CURL_CONFIG.  The
> +# default value is a result of `curl-config --libs`.  An example value for
> +# CURL_LDFLAGS is as follows:
> +#
> +#     CURL_LDFLAGS=-lcurl
> +#
>  # Define NO_EXPAT if you do not have expat installed.  git-http-push is
>  # not built, and you cannot push using http:// and https:// transports (dumb).
>  #
> @@ -183,10 +190,6 @@ all::
>  #
>  # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
>  #
> -# Define NEEDS_SSL_WITH_CURL if you need -lssl with -lcurl (Minix).
> -#
> -# Define NEEDS_IDN_WITH_CURL if you need -lidn when using -lcurl (Minix).
> -#
>  # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
>  #
>  # Define NEEDS_LIBINTL_BEFORE_LIBICONV if you need libintl before libiconv.
> @@ -1305,20 +1308,17 @@ else
>  	ifdef CURLDIR
>  		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
>  		BASIC_CFLAGS += -I$(CURLDIR)/include
> -		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
> +		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib)
>  	else
> -		CURL_LIBCURL = -lcurl
> -	endif
> -	ifdef NEEDS_SSL_WITH_CURL
> -		CURL_LIBCURL += -lssl
> -		ifdef NEEDS_CRYPTO_WITH_SSL
> -			CURL_LIBCURL += -lcrypto
> -		endif
> -	endif
> -	ifdef NEEDS_IDN_WITH_CURL
> -		CURL_LIBCURL += -lidn
> +		CURL_LIBCURL =
>  	endif
>  
> +ifdef CURL_LDFLAGS
> +	CURL_LIBCURL += $(CURL_LDFLAGS)
> +else
> +	CURL_LIBCURL += $(shell $(CURL_CONFIG) --libs)
> +endif
> +
>  	REMOTE_CURL_PRIMARY = git-remote-http$X
>  	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
> diff --git a/config.mak.uname b/config.mak.uname
> index 8acdeb71fdab3b3e8e3c536110eb6de13f14e8ff..19e6633040b1db4a148d7b33c4e9d374fe7f87ba 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -431,8 +431,6 @@ ifeq ($(uname_S),Minix)
>  	NO_NSEC = YesPlease
>  	NEEDS_LIBGEN =
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
> -	NEEDS_IDN_WITH_CURL = YesPlease
> -	NEEDS_SSL_WITH_CURL = YesPlease
>  	NEEDS_RESOLV =
>  	NO_HSTRERROR = YesPlease
>  	NO_MMAP = YesPlease
> @@ -458,7 +456,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	# Missdetected, hence commented out, see below.
>  	#NO_CURL = YesPlease
>  	# Added manually, see above.
> -	NEEDS_SSL_WITH_CURL = YesPlease
>  	HAVE_LIBCHARSET_H = YesPlease
>  	HAVE_STRINGS_H = YesPlease
>  	NEEDS_LIBICONV = YesPlease
> diff --git a/configure.ac b/configure.ac
> index e11b7976ab1c93d8ccec2e499d0093db42551059..44e8c036b6ec417e95ca4e5c2861785900d8634c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -600,17 +600,14 @@ AC_CHECK_PROG([CURL_CONFIG], [curl-config],
>  
>  if test $CURL_CONFIG != no; then
>      GIT_CONF_SUBST([CURL_CONFIG])
> -    if test -z "${NO_OPENSSL}"; then
> -      AC_MSG_CHECKING([if Curl supports SSL])
> -      if test $(curl-config --features|grep SSL) = SSL; then
> -         NEEDS_SSL_WITH_CURL=YesPlease
> -         AC_MSG_RESULT([yes])
> -      else
> -         NEEDS_SSL_WITH_CURL=
> -         AC_MSG_RESULT([no])
> -      fi
> -      GIT_CONF_SUBST([NEEDS_SSL_WITH_CURL])
> +
> +    if test -z "$CURL_CONFIG_OPTS"; then
> +        CURL_CONFIG_OPTS="--libs"
>      fi
> +
> +    CURL_LDFLAGS=$($CURL_CONFIG $CURL_CONFIG_OPTS)
> +    AC_MSG_NOTICE([Setting CURL_LDFLAGS to '$CURL_LDFLAGS'])
> +    GIT_CONF_SUBST([CURL_LDFLAGS], [$CURL_LDFLAGS])
>  fi
>  
>  fi
