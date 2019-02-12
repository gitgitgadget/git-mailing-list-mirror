Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEFF61F453
	for <e@80x24.org>; Tue, 12 Feb 2019 18:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfBLSlG (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 13:41:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41465 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfBLSlG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 13:41:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so3857216wrs.8
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 10:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=B7Vtrn4DcyGWFONTLAEhnlYcIZCKcdrGjeFnwLv2fCs=;
        b=a5oMkbSyD/mk9Q0Mrbrr5l8c2YlNuHBiuowN3rouWh/gDGJtUZslHHdwhFQkGXrImd
         zFoWUKbBUNVlmXUm+1498X4fb85yE6UHY8rEMUXVbgAm4DaphJFNuJPzejIc516dluOf
         GgHG4OUxhoNeJ5GmQu+pkKd99o/ygQHRuSZw9wzaw+Ozxs03qL9nh58nS3o/U6cgdWNf
         R6I/UmWFiunlROWKHVmL9qG5qFA1OX6Z3oF+g05VWlXFBS1nR2t7e4f7VUGX1wnmnK6L
         qldih01cjNV/Qxzhgd/QUtm7MMYHGVwGghE5LUDWQog6Fh64qU/pFJ8lr+xHq/8FJZVZ
         EAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=B7Vtrn4DcyGWFONTLAEhnlYcIZCKcdrGjeFnwLv2fCs=;
        b=j5K2LisId4V98/tBhYNCTXEAwd9zSv3P4mpviJ3xBu3fwBdEL9oZHV3FHSo5i9uOEd
         DRGCS+ExGSTrxj0ve4YyTkBbxSw2CH178J9HOpp2SqIV+U8dEyVWpioJ/b+2lwBcDReU
         j5UpDA+tyritZRU27YyF+p0+5fpyvxFkFO82sSPaQRTj6P8lRD/Od8RLwpNPVKDohFMX
         xFgx2wSEbICaPKlg65vlgfzccSrTcTs7plZedakU2f3um4EYp82uTvm5x31cxU7VcpPf
         UP3YZp7uJwqDDJPqrzNmi3eV9iNf4KSRqDYIS/XU/Lxx5j4swp5JGnxstvRF+P0qGT05
         sByw==
X-Gm-Message-State: AHQUAuZ/Z1iYIvM8Nft3JKaz/9Jod84/eA0deUAlN5Bbn+qZur2EcLbD
        tonNqJ7l+1km5pIhz4S0oT0=
X-Google-Smtp-Source: AHgI3IanNFOP8g6pB/rct9KoUI6F9tNbPbQyG3UNC08XFwVRsHqRiT9uylpp4FgvMGVhNJc96BX1jw==
X-Received: by 2002:a5d:4149:: with SMTP id c9mr4160615wrq.58.1549996864483;
        Tue, 12 Feb 2019 10:41:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t9sm11730030wrx.73.2019.02.12.10.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:41:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
        <87sgwtjjbk.fsf@evledraar.gmail.com> <20190212124323.GA11677@ash>
        <xmqqlg2ldjg4.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 12 Feb 2019 10:41:02 -0800
In-Reply-To: <xmqqlg2ldjg4.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 12 Feb 2019 09:07:23 -0800")
Message-ID: <xmqqva1odf41.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If I find time later in the day, I may forge your sign-off and
> fabricate log messages for both patches, but unfortunately I need to
> run a long errand today during the day, so it may not happen.

Here is what I have, with forged sign-off.  I am not merging them to
'next' yet, but will be pushing them on 'pu' shortly to give them
better exposure.

-- >8 --
From: Duy Nguyen <pclouds@gmail.com>
Date: Tue, 12 Feb 2019 19:43:23 +0700
Subject: [PATCH] get_oid_with_context(): match prototype and implementation

The get_oid_with_context() function is declared to return an enum in
cache.h, but defined to return an int in sha1-name.c.  The compiler
notices this on AIX and rejects the build, since d1dd94b308 (Do not
print 'dangling' for cat-file in case of ambiguity - 2019-01-17) was
merged.

Return the correct type from the implementation to fix this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1-name.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index d1cc77c124..6dda2c16df 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1820,9 +1820,11 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 			       prefix, &oid, &oc);
 }
 
-int get_oid_with_context(struct repository *repo, const char *str,
-			 unsigned flags, struct object_id *oid,
-			 struct object_context *oc)
+enum get_oid_result get_oid_with_context(struct repository *repo,
+					 const char *str,
+					 unsigned flags,
+					 struct object_id *oid,
+					 struct object_context *oc)
 {
 	if (flags & GET_OID_FOLLOW_SYMLINKS && flags & GET_OID_ONLY_TO_DIE)
 		BUG("incompatible flags for get_sha1_with_context");
-- 
2.21.0-rc0-36-ge9bd4aa026

