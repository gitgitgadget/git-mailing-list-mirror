Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177DB1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 15:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbcHQPb7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 11:31:59 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34263 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbcHQPb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 11:31:57 -0400
Received: by mail-pa0-f65.google.com with SMTP id hh10so7472455pac.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 08:31:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R3ifR5b0sQoMzDs54CEqqKpffS3yYMEl6uZxAasGiHk=;
        b=yM+VwvJeqKUtRo7C5L8eviotHwNWQi5Y2kgynhG6DA/4rtgSnq874qhII7a+U8mUVH
         vf5vlLzzsPy9m62SRX1rX5EfYXjMPH37qPKvbnIXKjKj8RdaKj5EKfAg7BADygCCWMXJ
         WYcy8Q6+pOD+w8B5XMO8atlDnOhiLzvKbedQ1Q4dHvR06VYj7f5qc+Cb/iWqaa2PZbjU
         IfLrzH8gL1LLZc+areaLJWfxew0yQUYTnSiCHOG1EcSOJlx3zVoye+v6SxfgcZcgFsdc
         UopOaOr1N6pzp7lGktqUVYMEGn4F1KWMbOI5vycA+p95DrUnhSVK0l1jEWup7CRlwK6p
         Fx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R3ifR5b0sQoMzDs54CEqqKpffS3yYMEl6uZxAasGiHk=;
        b=Cq9UUxRayPkL9w380pbycuPJUqjVAtNgSDqjzfOXEu9rK+t/pb7msZp/5PGUmw6hHc
         ybcov4DoJnWezhUevYQGBRfwiI9aN/QvDwg2WDK/1TRSFN+CuNcAWDaaGGrbj9tYDi9F
         7XQJb/rF8WENj+3BKK+Fcl2jRkjV6n08KC1bf57X/RM+OWtJZtHbgV8Js0rB6zUI9YnO
         8ZdUH5er4epjSM45w0DhMDXAVwHMQf7ALvWHCM2lqQBsshquDLIc7dhBomc9mfwdNMkJ
         EG3wlsgia6LbZT9xgIx64RpkIlTIfnovAEmxrmEHxh7pKsc2/MjxvAxNtqK0UCTQ9dDo
         uZ3A==
X-Gm-Message-State: AEkooutfeD9VITLt/YkP4SDlqu4lUbkHxKa+d+lOTtZFVWGN4fnLswBP+jiBYbGlFtss9w==
X-Received: by 10.66.54.229 with SMTP id m5mr5759143pap.91.1471447916696;
        Wed, 17 Aug 2016 08:31:56 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id fe8sm48311671pad.2.2016.08.17.08.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Aug 2016 08:31:54 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, e@80x24.org,
	Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v2 0/3] diff-highlight: add support for git log --graph output.
Date:	Wed, 17 Aug 2016 08:31:21 -0700
Message-Id: <20160817153124.7770-1-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160810085635.GA1672@starla>
References: <20160810085635.GA1672@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Changes made per Eric.

On Wed, Aug 10, 2016 at 08:56:35AM +0000, Eric Wong wrote:
> Brian Henderson <henderson.bj@gmail.com> wrote:
> 
> Hi Brian,
> 
> A few minor portability/style nits below, but contrib/ probably
> (still?) has laxer rules than the rest of git...
> 
> I think we still require Signed-off-by lines in contrib,
> though...

added

> 
> > +++ b/contrib/diff-highlight/t/Makefile
> > @@ -0,0 +1,19 @@
> > +-include ../../../config.mak.autogen
> > +-include ../../../config.mak
> > +
> > +T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
> > +
> > +all: test
> > +test: $(T)
> > +
> > +.PHONY: help clean all test $(T)
> > +
> > +help:
> > +	@echo 'Run "$(MAKE) test" to launch test scripts'
> > +	@echo 'Run "$(MAKE) clean" to remove trash folders'
> > +
> > +$(T):
> > +	@echo "*** $@ ***"; sh $@ $(GIT_TEST_OPTS)
> 
> Probably:
> 
> 	@echo "*** $@ ***"; '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
> 
> like we do in t/Makefile in case we need to override 'sh'.
> 

done, although I basically had to copy the SHELL_PATH_SQ logic from t/Makefile

> > +
> > +clean:
> > +	$(RM) -r 'trash directory'.*
> > diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> > new file mode 100644
> > index 0000000..ca7605f
> > --- /dev/null
> > +++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> > @@ -0,0 +1,63 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (C) 2016
> 
> IANAL, but I think your name (or who you represent) needs to be
> in the copyright.

diff-highlight doesn't have a copyright, so I just removed it. ok?

> 
> > +
> > +test_description='Test diff-highlight'
> > +
> > +. ./test-diff-highlight.sh
> > +. $TEST_DIRECTORY/test-lib.sh
> 
> TEST_DIRECTORY ought to be quoted since it could contain
> shell-unfriendly chars (we intentionally name 'trash directory'
> this way to trigger errors).

done

> 
> > +
> > +# PERL is required, but assumed to be present, although not necessarily modern
> > +# some tests require 5.8
> > +
> > +test_expect_success 'diff-highlight highlightes the beginning of a line' '
> 
> You can declare a prereq for PERL::
> 
> 	test_expect_success PERL 'name' 'true'

done

> 
> And spelling: "highlights" (there's other instances of this, too)

oops, thanks

> 
> > +  dh_test \
> > +    "aaa\nbbb\nccc\n" \
> > +    "aaa\n0bb\nccc\n" \
> > +"
> 
> We use tabs for shell indentation.

done

<snip>

> > +
> > +dh_diff_test() {
> > +  local a="$1" b="$2"
> 
> "local" is not a portable construct.  It's common for
> Debian/Ubuntu systems to use dash as /bin/sh instead of bash;
> (dash is faster, and mostly sticks to POSIX)
> 
> The "devscripts" package in Debian/Ubuntu-based systems has a
> handy "checkbashisms" tool for checking portability of shell
> scripts.

checkbashisms didn't output anything, and I found other instances of local in some tests. but I removed anyway.

> 
> > +
> > +  printf "$a" > file
> > +  git add file
> > +
> > +  printf "$b" > file
> > +
> > +  git diff file > diff.raw
> 
> Commands should be '&&'-chained here since any of them could fail
> ("git add"/printf/etc could run out of space or fail on disk errors)

I wasn't totally sure what to do here. I added some checks for empty files and
&& chained them with the last command to verify I wasn't diffing 2 empty files.
Hope that is sufficient.

> 
> Also, our redirect style is:	command >file
> without a space between '>' and destination.

done

> 
> See Documentation/CodingGuidelines for more details.
> Unfortunately, the reasoning is not explained for '>NOSPACE'
> and I'm not sure exactly why, either...
> 
> > +  if test "$#" = 3

done

> 
> Better to use -eq for numeric comparisons: test $# -eq 3
> Quoting $# doesn't seem necessary unless your shell is
> hopelessly buggy :)
> 
> > +  then
> > +    # remove last newline
> > +    head -n5 diff.raw | head -c -1 > diff.act
> 
> "head -c" isn't portable, fortunately Jeff hoisted it out for
> use as test_copy_bytes in commit 48860819e8026
> https://public-inbox.org/git/20160630090753.GA17463@sigill.intra.peff.net/

It didn't look like his version supported a negative number, so I rolled my own.

> 
> > +    printf "$3" >> diff.act
> > +  else
> > +    cat diff.raw > diff.act
> > +  fi
> > +
> > +  < diff.raw $CMD > diff.exp
> 
> $CMD probably needs to be quoted.  However, by the time I got
> here I had to ask myself:  What is $CMD again?
> A: Oh, look up at the top!
> 
> *shrug*  My attention span is tiny and my fonts are gigantic.
> 
> Perhaps using:
> 
> 	DIFF_HIGHLIGHT="$CURR_DIR"/../diff-highlight
> 
> Would be more-readable?

good, done.

> 
> > +
> > +  diff diff.exp diff.act
> 
> Maybe use test_cmp to avoid depending external diff.
> (or "git diff -b --no-index" in your later test)
> 
> Same comments for the rest of the series, I think.
> 
> Typically, we expect a reroll in a few days, and I guess there's
> no rush (so you can squash your comment patch in addressing
> Junio's concern into 3/3).
> 
> Thanks.

thanks for the feedback.

I've rebased my changes. Unfortunately, having 3 commits made this somewhat
tedious. I also find it weird that my new patch set makes it difficult to see
what changes I've made from my first set. What's the standard workflow here?

Brian Henderson (3):
  diff-highlight: add some tests.
  diff-highlight: add failing test for handling --graph output.
  diff-highlight: add support for --graph output.

 contrib/diff-highlight/Makefile                  |   5 +
 contrib/diff-highlight/diff-highlight            |  16 ++--
 contrib/diff-highlight/t/Makefile                |  22 +++++
 contrib/diff-highlight/t/t9400-diff-highlight.sh |  75 +++++++++++++++
 contrib/diff-highlight/t/test-diff-highlight.sh  | 112 +++++++++++++++++++++++
 5 files changed, 224 insertions(+), 6 deletions(-)
 create mode 100644 contrib/diff-highlight/Makefile
 create mode 100644 contrib/diff-highlight/t/Makefile
 create mode 100755 contrib/diff-highlight/t/t9400-diff-highlight.sh
 create mode 100644 contrib/diff-highlight/t/test-diff-highlight.sh

-- 
2.9.0

