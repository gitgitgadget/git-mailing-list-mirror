Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD0B215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932073AbeEASlA (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:41:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55856 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756480AbeEASk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:40:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id a8so18981011wmg.5
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UQdPsTBGQbTNiDbTfJb9hKPMhB/WVrDiYWmoKicFm6w=;
        b=ObPAlorl8YaEZzHU9d5qJozr3s3wqVxTFuC5kU5FomUA1Tgt4+wmH75onjYbRhoQmC
         haChdQAg87TT/m5h1hq011Cyo6KCHV+xLD91Hsk5Ps1lWpqT6/+rjc9AzcnpaaZMiizS
         IwYhRNxX3GaiTghQz0TvDFMDGb0523qYT8Su6E8nMhGAYiUgWGIX+4JMciKmNH65Fal1
         fA2Pq/XhWnv88WKwkY94uS4BttB10ett0ewHeG4Kp9qgk3RY4dGvc4MshFgJ9Y2eGYHy
         PcKCCHVQMvwt4Mb2xMA+wGZb5T9zpww4Q1VkwQURTYsEeg44aWvl7JdefiKtOVHbiJ05
         lxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UQdPsTBGQbTNiDbTfJb9hKPMhB/WVrDiYWmoKicFm6w=;
        b=M8OXgAIbAYkh7kKxXEjLLkiysucN0nSnuqmDr7sm+9t1BxAKz9O20eglE6V3kH2jLj
         Sm79u64f0T2WL0P6HzAb/HkkGOdsYCk3IXzzcs48YZZnHL4LrwQ28ohQowIKaQqmoh1X
         xkUVN1aRx0sVWwm/w+k3q2fFuOf8ykVP7GMd+9zD1uiOJpm5JOALgQiKk50VIIGnuGhI
         YDfDof+qkLbYb2Fe43N7f2w8wIaAA1IJFoKCPyHFKW2I99+JSPcddaR0IlzX+UzYgfDQ
         UNM1y+eWzRbqaZmpoONUnbIU2KgcI2boXMYd3Pn8YwCjhUTgNDWb0sNAddTNBx4mhM53
         4bdw==
X-Gm-Message-State: ALQs6tBTBI6uqMZBr3WISGousnXLhCBHrYShdmGbsplVAVsfiTleaWbk
        KU9gRjJOPvIkSuNeSrqfgEPbLtki
X-Google-Smtp-Source: AB8JxZqy0u5s54IcAHBwL83aWwOxG2oyuOnZr5pc09QaC4Cats9xCAdyQGK2Cv1QqkibVFm30WhDQg==
X-Received: by 10.28.116.7 with SMTP id p7mr9567293wmc.132.1525200056578;
        Tue, 01 May 2018 11:40:56 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/12] config doc: document core.disambiguate
Date:   Tue,  1 May 2018 18:40:15 +0000
Message-Id: <20180501184016.15061-12-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501184016.15061-1-avarab@gmail.com>
References: <20180501184016.15061-1-avarab@gmail.com>
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core.disambiguate variable was added in
5b33cb1fd7 ("get_short_sha1: make default disambiguation
configurable", 2016-09-27) but never documented.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..14a3d57e77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -910,6 +910,19 @@ core.abbrev::
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
 
+core.disambiguate::
+	If Git is given a SHA-1 that's ambigous it'll suggest what
+	objects you might mean. By default it'll print out all
+	potential objects with that prefix regardless of their
+	type. This setting, along with the `^{<type>}` peel syntax
+	(see linkgit:gitrevisions[7]), allows for narrowing that down.
++
+Is set to `none` by default to show all object types. Can also be
+`commit` (peel syntax: `$sha1^{commit}`), `committish` (commits and
+tags), `tree` (peel: `$sha1^{tree}`), `treeish` (everything except
+blobs, peel syntax: `$sha1:`), `blob` (peel: `$sha1^{blob}`) or `tag`
+(peel: `$sha1^{tag}`). The peel syntax will override any config value.
+
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
 	Tells 'git add' to continue adding files when some files cannot be
-- 
2.17.0.290.gded63e768a

