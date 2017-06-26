Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465F0207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 12:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdFZMrY (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 08:47:24 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:32823 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbdFZMrX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 08:47:23 -0400
Received: by mail-wm0-f41.google.com with SMTP id z75so74338wmc.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rVTUHdpFZtKZe2WPWwdB72tC+haeuXiLMelNojEVihs=;
        b=Ozle0TD5hM7VXmLdpicN9F+ME7EwIv0anI8Lkhscb7jgY4D7eYl+93ptoMgEfniW/g
         XTQ+RjUidzo5q/gW/O/J3zKQVkJTRoQYJDm6xWssj9HHl4amt3BvicQfVWjE6a8mDZ+I
         O3O6+XMAfjS93uBAm+LQ3q+BKG2AIhDSWgqmEVTP/XCN6cJYTCy7CYj8rKC9bK1PNsR7
         Xty09lv1Ihb3Jtm6g/DuzSGZEmIhJqBi9ZQvOELwHMDkCAP1xcPHjQTc91yOMHzamU1Z
         3eXigTq5LWxkW1q+F8wf1A8+jY5Yg6SZ1EF6DUXbMhSePCmyfp53kR53QiCpN1YlBC27
         Zzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rVTUHdpFZtKZe2WPWwdB72tC+haeuXiLMelNojEVihs=;
        b=Z9KTpcl5o89juJH1Je5d9TLCF0o0cg7/CtE3tiegx7dHwft63iupLBeNYSSO7aNJmJ
         tIyh4npt35/QPfks/UkV/tRHhYLDILVWG+i727yBDv0w0Dc3EG+RCyCAX+j6FHL3YWc8
         Z7EDCFbMyq6SZeNDFqjuMsBY+KQM8QYYdwLznJ5YPQzY/yCXWxpVUOfgAYF02FsSgje8
         bwfXixwWKRUawcrESPO+XVLuqljkvn0j0Lvganiou/38CZvao5YFRhkRjCC2fggJCDsz
         LoHzGkEFeLueAvmazFlONgy86MVFRGFxTmYwQjQfqa1PgvdTieo9VCFBUNaBOrXIppAp
         rqpQ==
X-Gm-Message-State: AKS2vOxrgkUIpxFmVVPmlKF6xGb2i8Xy7R+H08m5lLtn+bspxB18hnAf
        YxXDF3bCUpv0ig==
X-Received: by 10.28.206.202 with SMTP id e193mr40139wmg.0.1498481241422;
        Mon, 26 Jun 2017 05:47:21 -0700 (PDT)
Received: from snth (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id j196sm12084589wmd.32.2017.06.26.05.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 05:47:20 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPTQF-0006Lt-Hs; Mon, 26 Jun 2017 14:47:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Kebe <michael.kebe@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com> <87lgofcf7r.fsf@gmail.com> <CAKKM46syoE90y-+5okxtk7A982ztaDFem8aL6GrxWhS4gGSGqg@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAKKM46syoE90y-+5okxtk7A982ztaDFem8aL6GrxWhS4gGSGqg@mail.gmail.com>
Date:   Mon, 26 Jun 2017 14:47:19 +0200
Message-ID: <87h8z2dig8.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 26 2017, Michael Kebe jotted:

> No luck with the patch.
>
> Still got:
>
>     CC sha1dc/sha1.o
> sha1dc/sha1.c:43:58: error: operator '==' has no right operand
>       (defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) ||   \
>                                                           ^
> gmake: *** [sha1dc/sha1.o] Error 1

Does this patch change anything, with or without the previous patch:

diff --git a/git-compat-util.h b/git-compat-util.h
index 047172d173..1327aea229 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -131,6 +131,14 @@
 # else
 # define _XOPEN_SOURCE 500
 # endif
+
+/*
+ * Bring in macros defining _BIG_ENDIAN etc. Should be brought in by
+ * the likes of stdio.h, but include it here in case it hasn't been
+ * included already.
+ */
+#include <sys/isa_defs.h>
+
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
       !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
       !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \

>
> Greetings
> Michael
>
> 2017-06-26 10:42 GMT+02:00 Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
>>
>> On Mon, Jun 26 2017, Michael Kebe jotted:
>>
>>> When compiling 2.13.2 on Solaris SPARC I get this error:
>>>
>>>     CC sha1dc/sha1.o
>>> sha1dc/sha1.c:41:58: error: operator '==' has no right operand
>>>  #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
>>>                                                           ^
>>> gmake: *** [sha1dc/sha1.o] Error 1
>>>
>>> The define _BIG_ENDIAN is set by Solaris on SPARC systems. So the
>>> check in line 41 gives this error.
>>>
>>> The _BIG_ENDIAN define is used few line below for defining
>>> SHA1DC_BIGENDIAN. This is needed for Solaris SPARC systems.
>>> See
>>> https://github.com/cr-marcstevens/sha1collisiondetection/commit/33a694a9ee1b79c24be45f9eab5ac0e1aeeaf271
>>
>> I can see why this would error out. In sys/isa_defs.h on SPARC there's
>> just `#define _BIG_ENDIAN`
>> (http://src.illumos.org/source/xref/illumos-gate/usr/src/uts/common/sys/isa_defs.h),
>> and (on Linux):
>>
>>     $ cat /tmp/test.c
>>     #define _FOO
>>     #define _BAR 1
>>     #if (_BAR == _FOO)
>>     #endif
>>     $ gcc -E /tmp/test.c
>>     # 1 "/tmp/test.c"
>>     # 1 "<built-in>"
>>     # 1 "<command-line>"
>>     # 31 "<command-line>"
>>     # 1 "/usr/include/stdc-predef.h" 1 3 4
>>     # 32 "<command-line>" 2
>>     # 1 "/tmp/test.c"
>>     /tmp/test.c:3:18: error: operator '==' has no right operand
>>      #if (_BAR == _FOO)
>>
>> What I don't get is how this would have worked for Liam then (see
>> 20170613020939.gemh3m5z6czgwmzp@oracle.com). Differences in Solaris
>> versions and how their headers look like?
>>
>> Does this patch fix it for you?
>>
>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>> index facea1bb56..0b75b31b67 100644
>> --- a/sha1dc/sha1.c
>> +++ b/sha1dc/sha1.c
>> @@ -36,9 +36,11 @@
>>  #undef SHA1DC_BIGENDIAN
>>  #endif
>>
>> -#if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
>> +#if (defined(BYTE_ORDER) || defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || \
>> +     defined(__BYTE_ORDER__))
>>
>> -#if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
>> +#if ((defined(BYTE_ORDER) && (BYTE_ORDER == BIG_ENDIAN)) || \
>> +     (defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) ||   \
>>       (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
>>       (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )
>>  #define SHA1DC_BIGENDIAN
>>
>> I thought maybe BYTE_ORDER would work after searching the Illumos
>> sources a bit more:
>> http://src.illumos.org/source/search?q=BYTE_ORDER&project=illumos-gate

