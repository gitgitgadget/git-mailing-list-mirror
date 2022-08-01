Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA13C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 12:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiHAMnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 08:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiHAMnC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 08:43:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9960EF
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 05:25:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f11so9524508pgj.7
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=p0sOLOkvPrWs45BrUIOMpIuP9zbhlJfoW+kvma/dl7k=;
        b=SXc0FksM/O0wVkesCMEDP9d+8iO8ylV8uxDuobttnJdfeq6kwEhSsF4a1S9lfIIpt7
         qYm1GuMJG7ZI/fOb9i5LxLF7OuJPGZdqJ3/X9dfrxqMvVektriDw/8u72OcsjfNDTKdH
         5mY1VsKZA41/GyEy7TRhQzKyGO093qOfe21llfBvfabkxIE+5WcuJiVL5WHBFrXxA6Ps
         uDVfhJ+d7eqcPBpraE0JgiWsf6VGAlxv1zGnMkyD34GviIiQDs7ritcx0MHhTT1c1jFG
         rUfXE1CWw/SfiJoHBIPlPxQYY8+KfI804CUYatp6B7jhb8qDWakua2JV8s84cSbWslKc
         JT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=p0sOLOkvPrWs45BrUIOMpIuP9zbhlJfoW+kvma/dl7k=;
        b=0TbSNP9LXEVLu3RAmYwg6i5g33pz1LM70nGG2/Qkwk8hiWlrrmA7mF5Sx8PyvklerG
         CbeLwLuSgX6hM+HZKR7K/pFtz2vek/iik1YsxvVLVGLW1Ccu1FCHgoEKkCA8yf4Bnrgo
         IGlzQmiSthxC+hdl4v3H0VAHpQfwHtnE7Z2Rm0BQXt9gJup2eDk9eXaHsDLaOuB8J+Rv
         p3Ot7wvf18XcUI66YipkbvEDkCtapOBMNJsRLLL0HenwGyqtVgHoxzDR/8b6WH6DAnrm
         3qSQvvuWZnEXiU6E6KMaGStXpX95TEdomsoOVn7cb+9Q4XimaWk38eDtbePULnUy7NqU
         Upjg==
X-Gm-Message-State: ACgBeo0s3BqC6BIqaKfQRp/Nd+T+PhSBXdfUDW/xkBDwxvrlB/rnbRpl
        fxnTv/i7gJIRE8/StbS3dQ0=
X-Google-Smtp-Source: AA6agR5qI520XW9mYVnanZ3enwb3Mo1rJdOzVJYK+gTEoDmdF9B8i62EjQnE/aO4Q/Artcm0rnmJ4w==
X-Received: by 2002:a63:8849:0:b0:41c:4216:10a7 with SMTP id l70-20020a638849000000b0041c421610a7mr1104780pgd.549.1659356721413;
        Mon, 01 Aug 2022 05:25:21 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id k34-20020a635a62000000b00419ffb6445dsm7365733pgm.9.2022.08.01.05.25.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Aug 2022 05:25:21 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/2] api-trace2.txt: print config key-value pair
Date:   Mon,  1 Aug 2022 20:25:15 +0800
Message-Id: <20220801122515.23146-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <220722.86fsits91m.gmgdl@evledraar.gmail.com>
References: <220722.86fsits91m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I didn't notice this before, but this is an addition to a long section
> where the examples are ------- delimited, starting with "in this
> example.." usually.

A little puzzled. About "------- delimited", do you mean the "block" syntax?

> So this "print configs" seems like on odd continuation. Shouldn't this
> copy the template of "Thread Events::" above. I.e. something like (I
> have not tried to asciidoc render this):

I think "Events" in "Thread Events" means the thread start and end events,
maybe not a template here. So I think it might be better to keep this namingi
if I'm right, but I will use this candidate naming to show diff in the end.

I'm not good at naming so I'm glad to accept the suggestion about it.

>	Config (def param) Events::
>		We can optionally emit configuration events, see
>		`trace2.configParams` in linkgit:git-config[1] for how to enable
>		it.
>	+
>	< your example below would follow this>

I refer to the previous sections, it's like the template is :

<title>

        <brief one-line description>

<detailed multi-lines description>

So, how about this like:

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 77a150b30e..38d0878d85 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -1207,6 +1207,37 @@ at offset 508.
 This example also shows that thread names are assigned in a racy manner
 as each thread starts and allocates TLS storage.

+Config (def param) Events::
+
+         Dump "interesting" config values to trace2 log.
++
+We can optionally emit configuration events, see
+`trace2.configparams` in linkgit:git-config[1] for how to enable
+it.
++
+----------------
+$ git config color.ui auto
+----------------
++
+Then, mark the config `color.ui` as "interesting" config with
+`GIT_TRACE2_CONFIG_PARAMS`:
++
+----------------
+$ export GIT_TRACE2_PERF_BRIEF=1
+$ export GIT_TRACE2_PERF=~/log.perf
+$ export GIT_TRACE2_CONFIG_PARAMS=color.ui
+$ git version
+...
+$ cat ~/log.perf
+d0 | main                     | version      |     |           |           |              | ...
+d0 | main                     | start        |     |  0.001642 |           |              | /usr/local/bin/git version
+d0 | main                     | cmd_name     |     |           |           |              | version (version)
+d0 | main                     | def_param    |     |           |           |              | color.ui:auto
+d0 | main                     | data         | r0  |  0.002100 |  0.002100 | fsync        | fsync/writeout-only:0
+d0 | main                     | data         | r0  |  0.002126 |  0.002126 | fsync        | fsync/hardware-flush:0
+d0 | main                     | exit         |     |  0.002142 |           |              | code:0
+d0 | main                     | atexit       |     |  0.002161 |           |              | code:0
+----------------
 == Future Work

 === Relationship to the Existing Trace Api (api-trace.txt)

Thanks.
