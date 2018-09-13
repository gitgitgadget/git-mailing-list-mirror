Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039B51F404
	for <e@80x24.org>; Thu, 13 Sep 2018 14:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeIMTRU (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 15:17:20 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35108 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbeIMTRT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 15:17:19 -0400
Received: by mail-qt0-f195.google.com with SMTP id j7-v6so5474523qtp.2
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9UZdPowune+/2u3Ko9CEmlVEF90cVJhdxOLq2D/cpBA=;
        b=cuhHsyFlGrEWkrQAVkvLY9prMoCu90cx1z536wFX/phH4nkRuk3aBIzQ72HT3OEHAk
         S5VYFya7aM+SgYFZrEpvxP4FHTORClgWO3vpwV7wn8ieTv4OvV2ndZGGQYGtDARb75md
         O3UQN7QToRzC3jRIDsVAOCGhWTMJhLarVIxcPATG69+N0RqcJbIIyfSE4h6Xi6wT0YS7
         7Z5z4xjgVhFF8M10HCm5jFKGMpcWyrMNYwFyZKU6+kYuWLpFNo617ImYKwDXUqFjL/oi
         hxhUwho+WRmZ5xePu9Q72ZfWfP/A/M3lPvzWAjhCSEJ9YfOHhnpub/PpWX25DGlkeCCe
         edZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9UZdPowune+/2u3Ko9CEmlVEF90cVJhdxOLq2D/cpBA=;
        b=oJfl1T8ro9uiVSwKNRq8n5GmyWrOPVrfZsi5qDaFxXALXYuB0b84soloDVfwXumhxG
         rwasJz2HTssrxBLn7CLWjbeDjZrlLcPcUMJUdJ4pZgWiAA3JHpjDpINCKEm5tl1lWwJi
         KOOXIZGVfI+Wn9jYbOw/ITLq2alFyjKxXrQjuSDu3P8n+GiImQFe52nkq9HOGinYIoif
         urir95cfD19mLxcDomL7pB82/+u1tuYsR0D5ycIebRv4JCewkTl66UF2dJ94Y/I+bLFW
         uedY81bxfPu0XKDb/QqjsOUC4Fmud0P7BJ6j9j15tvMV2hVM0XktZcNEjGLHjRyaxrcy
         VLFQ==
X-Gm-Message-State: APzg51CkmHgo4/4PAD2Y0tZDwnAlccPsFEreu14fuPsOV9Sir2QibKnT
        Y68XbHya2/B4fGJ+XIecXUTx1pn+
X-Google-Smtp-Source: ANB0Vdba5mX2JLtgItxgYjDVpzjqSUXiuE5lTeEJvqVOSzuGjrqBz14T8znaN8kV2aVc/VPeZeIgqg==
X-Received: by 2002:ac8:1a04:: with SMTP id v4-v6mr5453084qtj.183.1536847658796;
        Thu, 13 Sep 2018 07:07:38 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id h132-v6sm2357505qke.51.2018.09.13.07.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 07:07:37 -0700 (PDT)
Subject: Re: [PATCH v1] read-cache: add GIT_TEST_INDEX_VERSION support
To:     Thomas Gummerer <t.gummerer@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180912212544.33624-1-benpeart@microsoft.com>
 <20180912223101.GA1719@hank.intra.tgummerer.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <4f8b4664-6108-db7f-cb40-2bc55d9edece@gmail.com>
Date:   Thu, 13 Sep 2018 10:07:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912223101.GA1719@hank.intra.tgummerer.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/12/2018 6:31 PM, Thomas Gummerer wrote:
> On 09/12, Ben Peart wrote:
>> Teach get_index_format_default() to support running the test suite
>> with specific index versions.  In particular, this enables the test suite
>> to be run using index version 4 which is not the default so gets less testing.
> 
> I found this commit message slightly misleading.  Running the test
> suite with specific index versions is already supported, by defining
> TEST_GIT_INDEX_VERSION in 'config.mak'.  What we're doing here is
> introduce an additional environment variable that can also be used to
> set the index format in tests.
> 
> Even setting TEST_GIT_INDEX_VERSION=4 in the environment does run the
> test suite with index-v4.  Admittedly the name is a bit strange
> compared to our usual GIT_TEST_* environment variable names, and it
> should probably be documented better (it's only documented in the
> Makefile currently), but I'm not sure we should introduce another
> environment variable for this purpose?

TEST_GIT_INDEX_VERSION enables the testing I was looking for but you're 
right, it isn't well documented and the atypical naming and 
implementation don't help either.

I checked the documentation and code but didn't see any way to test the 
V4 index code path so wrote this patch.  I wonder if we can improve the 
discoverability of TEST_GIT_INDEX_VERSION through better naming and 
documentation.

How about this as an alternative?




diff --git a/Makefile b/Makefile
index 5a969f5830..9e84ef02f7 100644
--- a/Makefile
+++ b/Makefile
@@ -400,7 +400,7 @@ all::
  # (defaults to "man") if you want to have a different default when
  # "git help" is called without a parameter specifying the format.
  #
-# Define TEST_GIT_INDEX_VERSION to 2, 3 or 4 to run the test suite
+# Define GIT_TEST_INDEX_VERSION to 2, 3 or 4 to run the test suite
  # with a different indexfile format version.  If it isn't set the index
  # file format used is index-v[23].
  #
@@ -2599,8 +2599,8 @@ endif
  ifdef GIT_INTEROP_MAKE_OPTS
         @echo GIT_INTEROP_MAKE_OPTS=\''$(subst ','\'',$(subst 
','\'',$(GIT_INTEROP_MAKE_OPTS)))'\' >>$@+
  endif
-ifdef TEST_GIT_INDEX_VERSION
-       @echo TEST_GIT_INDEX_VERSION=\''$(subst ','\'',$(subst 
','\'',$(TEST_GIT_INDEX_VERSION)))'\' >>$@+
+ifdef GIT_TEST_INDEX_VERSION
+       @echo GIT_TEST_INDEX_VERSION=\''$(subst ','\'',$(subst 
','\'',$(GIT_TEST_INDEX_VERSION)))'\' >>$@+

  endif
         @if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 44288cbb59..31698c01c4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,9 +134,9 @@ export EDITOR
  GIT_TRACE_BARE=1
  export GIT_TRACE_BARE

-if test -n "${TEST_GIT_INDEX_VERSION:+isset}"
+if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
  then
-       GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
+       GIT_INDEX_VERSION="$GIT_TEST_INDEX_VERSION"
         export GIT_INDEX_VERSION
  fi

diff --git a/t/README b/t/README
index 9028b47d92..f872638a78 100644
--- a/t/README
+++ b/t/README
@@ -315,10 +315,14 @@ packs on demand. This normally only happens when 
the object size is
   over 2GB. This variable forces the code path on any object larger than
   <n> bytes.

-GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
+GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncommon pack-objects code
   path where deltas larger than this limit require extra memory
   allocation for bookkeeping.

+GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
+for the index version specified.  Can be set to any valid version
+but the non-default version 4 is probably the most beneficial.
+
   Naming Tests
   ------------

