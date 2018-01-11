Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56AE51F406
	for <e@80x24.org>; Thu, 11 Jan 2018 11:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbeAKLjz (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 06:39:55 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33290 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeAKLjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 06:39:54 -0500
Received: by mail-wr0-f182.google.com with SMTP id p6so1892122wrd.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 03:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=8X8PMN4oFDoVLEN1ZUyVY2xaf0QqYItXbh9jM7qWfWs=;
        b=TYmcEDzWYzT0FkSZGLr+kNZaILpy0QOr33KgZr9Hao3ftiFshFRV82ODT5bo1XelG/
         +tjOS5HY3e6Dn0BwGNKJxjI7daoKTk/5FTt/f9ECx3rXyRTf4dsX8ObOwRGW/KDCVe3l
         yU7hj57zf7YgIhQOJtvsVGvLzxohkdFFivWI7dDjzthyC4DUl6tc7k8sqjQq9rtPCox6
         lz2lQL59NXqQiN/jSGPOwPTne9MaTYGmbriTm+yY5M2p73imV+4YhAfRQayK2wrwvSpL
         rhlrAJm0pmmgiiG1VcixzUFbJBFW8YklUjvVNh3zL7d10mJFlTgCmRIta0SqLgXUkbju
         y8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=8X8PMN4oFDoVLEN1ZUyVY2xaf0QqYItXbh9jM7qWfWs=;
        b=H2Izj84NR2d83lJ4r0quCERR7O/hNeykx2lZ634Csbi0x4jqSLdRgH/in0pNT/gs8F
         6pv6oTdIx18vMlTA59bqPQNarLdVCgMmHrEHTrkz/++ATDiNQoY2znbLshPlsasUAbew
         erxTa9HPCAWFHUrvj9RvD8v+MJYfslE4w2A0QbyKL0axpNVgvtGE+eIcT+BfdhJEOi1B
         caX5e+RdBMRCXtA0tVT641BfppIBuTVPmgeRokmplGRll4HPXmwD7T0VXMq0bcQima57
         D9PNre+4UyCkXgUH7kgfPW76dTaSKa505M9AI+oe20tt+Llen4rEa8frxn+WutmV7NdU
         blgw==
X-Gm-Message-State: AKGB3mIgBKjSzVgdvrxS4NJJdAf5mtjPHjjeOcfT9MPMTpJnaUmQjaHQ
        5gkTSUZXGT0bu87QwOQW6L4=
X-Google-Smtp-Source: ACJfBovquclR0R1a9336HcprmG/7AkapO1ziBfs7IsDHtHz+OmgDm8cI9kvVhVv6bbgKRq61tjVo0w==
X-Received: by 10.223.198.69 with SMTP id u5mr19604663wrg.157.1515670792924;
        Thu, 11 Jan 2018 03:39:52 -0800 (PST)
Received: from localhost.localdomain (x590c5d6f.dyn.telefonica.de. [89.12.93.111])
        by smtp.gmail.com with ESMTPSA id c19sm501991wmd.5.2018.01.11.03.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jan 2018 03:39:52 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: read test snippet from stdin [was: [PATCH] t3900: add some more quotes]
Date:   Thu, 11 Jan 2018 12:39:28 +0100
Message-Id: <20180111113928.6412-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.105.gdd2bd9e18
In-Reply-To: <20180110195323.GA26186@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I've often wondered if
> our tests would be more readable taking the snippet over stdin.
> Something like:
> 
> diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> index 9e4e694d93..09ad4d8878 100755
> --- a/t/t3900-i18n-commit.sh
> +++ b/t/t3900-i18n-commit.sh
> @@ -39,14 +39,14 @@ test_expect_success 'UTF-16 refused because of NULs' '
>  	test_must_fail git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
>  '
>  
> -test_expect_success 'UTF-8 invalid characters refused' '

Note that the test snippet started right after that last single quote,
i.e. it started with a newline.

> -	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
> +test_expect_success 'UTF-8 invalid characters refused' - <<\EOT
> +	test_when_finished 'rm -f "$HOME/stderr $HOME/invalid"' &&

And now it starts at the beginning of this line, i.e. without that
leading neline.  This change leads to the following when run with '-v':

  expecting success: 	test_when_finished 'rm -f "$HOME/stderr $HOME/invalid"' &&
	echo "UTF-8 characters" >F &&
	printf "Commit message\n\nInvalid surrogate:\355\240\200\n" \
		>"$HOME/invalid" &&
	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
	test_i18ngrep "did not conform" "$HOME"/stderr

Notice how the "expecting success" and the first line of the test ended
up in the same line.  I find this more annoying than the lack of empty
line between the colored and indented test code and the uncolored and
unindented test output.

>  	echo "UTF-8 characters" >F &&
>  	printf "Commit message\n\nInvalid surrogate:\355\240\200\n" \
>  		>"$HOME/invalid" &&
>  	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
>  	test_i18ngrep "did not conform" "$HOME"/stderr
> -'
> +EOT
>  
>  test_expect_success 'UTF-8 overlong sequences rejected' '
>  	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 1701fe2a06..be8a47d304 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -391,11 +391,32 @@ test_verify_prereq () {
>  	error "bug in the test script: '$test_prereq' does not look like a prereq"
>  }
>  
> +# Read from stdin into the variable given in $1.
> +test_read_to_eof () {
> +	# Bash's "read" is sufficiently flexible that we can skip the extra
> +	# process.
> +	if test -n "$BASH_VERSION"
> +	then
> +		# 64k should be enough for anyone...
> +		read -N 65536 -r "$1"
> +	else
> +		# command substitution eats trailing whitespace, so we add
> +		# and then remove a non-whitespace character.
> +		eval "$1=\$(cat; printf x)"
> +		eval "$1=\${$1%x}"
> +	fi
> +}

Command substitutions don't eat trailing whitespaces in general, only
trailing newlines.  POSIX:

  The shell shall expand the command substitution by executing command
  in a subshell environment (see Shell Execution Environment) and
  replacing the command substitution (the text of command plus the
  enclosing "$()" or backquotes) with the standard output of the
  command, removing sequences of one or more <newline>s at the end of
  the substitution.

Bash and dash conform to this.

How about this alternative (also adding the missing leading newline
mentioned above):

+		eval "$1='
+'\$(cat)'
+'"

The indentation is yuck, but overall perhaps a bit less hacky...

