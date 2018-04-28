Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B65D1F424
	for <e@80x24.org>; Sat, 28 Apr 2018 01:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbeD1BZQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 21:25:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34794 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932939AbeD1BZP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 21:25:15 -0400
Received: by mail-wr0-f196.google.com with SMTP id p18-v6so3264259wrm.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 18:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cTRA6WzHMPXtoWReRPcuBA5aFg/QOdpeL0KDA5aCwi4=;
        b=PUPaPiy2xsL7yGbaSKfrl/2ybV++Hmpfjtwf324qSKF7RlCYwLbmhHJpECrnmmtqr1
         yLmhOPPGh3CrEFZyIXGH+58esYKMuC0H/MeJO/ib0n1LzqkSAbA+y6kbhptVb5xAJu5f
         oQk0sewW/Kwa5qeeOO292zizJOLOuu0UuxYvEERS4puBRMvfbqaHMHjBLiP7G3s7WIB9
         /Uahwh7xYuQVAsGdw2qVPaUF92jsa2Svfr7luJ42Jh27yJZgALpaBmDhyOGdDiB4CgWu
         Vy2ghwiLOUCOeis+WLHbOiPVEldetpEaEWR0jKMd4Qlphg8xPhhhNoWu2pIeViMLF3BG
         r0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cTRA6WzHMPXtoWReRPcuBA5aFg/QOdpeL0KDA5aCwi4=;
        b=OHh1l1ls8zUhVoNRJ6FFj41aPmOiwx+3UBcNgz0VLvxfl3p/DErQnUcfJFtYVi8Ycn
         yxyy96oezqAyK7Pa5+YOo0PqKTx2REBInBQdVJmVY7okUYXpYm62re5MyFOPc0jdkiqe
         60R5IPbarcqE/9AdxnMACT+c4h+HOTVEgOw4xlqA/LkcoCzHbg0ZMNciPl6vtngcu2T0
         X6+TisGImd/+4LaXuwjdG6D6M5ElBEI5UaLSAMMc8zQjnlAibTQZwmYhMidvlc4695GJ
         z049YEzSIfvG0eM/sC6agdRaC32A4jhuDpf64qpWC2yEGqI1CoTnF7VuRXRKh1RpLXTm
         n7mQ==
X-Gm-Message-State: ALQs6tBCXNhyTGaq+xRFB8mXZ57iCnyDvLz/o8pLN+olp8mYQ/heVV++
        xJOD6JbFbXldQ/sd0e57KB0=
X-Google-Smtp-Source: AB8JxZr+D5mco3dE29ryvkA/4OtQq8S7QAob5XKjf75Z6v5lB3FlfNZy9989GCcmmw+ieCq9GWypPw==
X-Received: by 2002:adf:9444:: with SMTP id 62-v6mr3117395wrq.264.1524878714280;
        Fri, 27 Apr 2018 18:25:14 -0700 (PDT)
Received: from localhost.localdomain (x590e3ec8.dyn.telefonica.de. [89.14.62.200])
        by smtp.gmail.com with ESMTPSA id u20-v6sm1120654wru.33.2018.04.27.18.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 18:25:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v6 06/11] Add a test for `git replace --convert-graft-file`
Date:   Sat, 28 Apr 2018 03:25:05 +0200
Message-Id: <20180428012505.32734-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.551.g86756ed296
In-Reply-To: <1a8c25baec240b0242873aedff8295cee7ba9742.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de> <1a8c25baec240b0242873aedff8295cee7ba9742.1524865158.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hallo Johannes,

> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index c630aba657e..bed86a0af3d 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -444,4 +444,24 @@ test_expect_success GPG '--graft on a commit with a mergetag' '

Note the GPG prereq of the previous test.

>  	git replace -d $HASH10
>  '
>  
> +test_expect_success '--convert-graft-file' '
> +	: add and convert graft file &&
> +	printf "%s\n%s %s\n\n# comment\n%s\n" \
> +		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \

This test relies on the piece of history that was created two tests
earlier in 'set up a merge commit with a mergetag', and that test, too,
has the GPG prereq.  So if there is no GPG installed, then that test
won't be executed, the history needed by this test won't be created,
HEAD won't have a second parent, and I'm sure you know where this is
going:

  ok 32 # skip set up a merge commit with a mergetag (missing GPG)
  <... snip ...>
  ok 33 # skip --graft on a commit with a mergetag (missing GPG)
  <... snip ...>
  ++git log --graph --oneline
  * ffccc9d hello: again 3 more lines
  * 14ac020 hello: 2 more lines
  * 093e41a hello: BUG fixed
  * 40237c8 hello: 1 more line
  * 8fc2a8e hello: 2 more lines
  * 4217adb hello: 4 more lines with a BUG
  * 00ad688 hello: 4 lines
  ++: add and convert graft file
  +++git rev-parse 'HEAD^^' 'HEAD^' 'HEAD^^' 'HEAD^2'
  fatal: ambiguous argument 'HEAD^2': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'
  ++printf '%s\n%s %s\n\n# comment\n%s\n' 093e41a79d4a8bfe3c758a96c95e5bf9e35ed89c 14ac020163ea60a9d683ce68e36c946f31ecc856 093e41a79d4a8bfe3c758a96c95e5bf9e35ed89c 'HEAD^2'
  ++cat .git/info/grafts
  093e41a79d4a8bfe3c758a96c95e5bf9e35ed89c
  14ac020163ea60a9d683ce68e36c946f31ecc856 093e41a79d4a8bfe3c758a96c95e5bf9e35ed89c
  # comment
  HEAD^2
  ++git replace --convert-graft-file
  hint: Support for <GIT_DIR>/info/grafts is deprecated
  hint: and will be removed in a future Git version.
  hint: 
  hint: Please use "git replace --convert-graft-file"
  hint: to convert the grafts into replace refs.
  hint: 
  hint: Turn this message off by running
  hint: "git config advice.graftFileDeprecated false"
  error: bad graft data: HEAD^2
  error: new commit is the same as the old one: '14ac020163ea60a9d683ce68e36c946f31ecc856'
  error: Not a valid object name: 'HEAD^2'
  warning: could not convert the following graft(s):
          14ac020163ea60a9d683ce68e36c946f31ecc856 093e41a79d4a8bfe3c758a96c95e5bf9e35ed89c
          HEAD^2
  error: last command exited with $?=1
  not ok 34 - --convert-graft-file


> +		>.git/info/grafts &&
> +	git replace --convert-graft-file &&
> +	test_path_is_missing .git/info/grafts &&
> +
> +	: verify that the history is now "grafted" &&
> +	git rev-list HEAD >out &&
> +	test_line_count = 4 out &&
> +
> +	: create invalid graft file and verify that it is not deleted &&
> +	test_when_finished "rm -f .git/info/grafts" &&
> +	echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
> +	test_must_fail git replace --convert-graft-file 2>err &&
> +	test_i18ngrep "$EMPTY_BLOB $EMPTY_TREE" err &&
> +	test_i18ngrep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
> +'
> +
>  test_done
> -- 
> 2.17.0.windows.1.33.gfcbb1fa0445
