Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B447C433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC5064F94
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCKSC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:02:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61877 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCKSCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 13:02:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28D2DBC15D;
        Thu, 11 Mar 2021 13:02:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=qZBugPVGVkawwCM4WVDdyok2OkE=; b=OdNSNCDyT+5hRgisbMT6E7o6LQir
        5NayibZqwsk38bxzPJzFSEd8qCCPdBaRE32+DPv27YDce1LWWCO4mxyaker8GidH
        MW63F+n6eK7nfduElFHURfqS5SL0fXORk7J9ir7njSl5vJO6MgQofXkGRWciBCnK
        qGTvCFNyhliarFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
        DibmYweHQg/Z6KutU9zv9I46s+F9Mpo2HOb0/oK/zbUTVswwEhwvkLfg9sDyhhhe
        r9djiUgR/5fVgGyJy/q6J/o2pat+YQwv3/fAhbd4rY0uO4iecakam4g7SPoW1WUT
        rbcq6DJbmgWNf7a4xpdh9R0D5Z5frEUYtnoKbsv9N7I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20EAEBC15C;
        Thu, 11 Mar 2021 13:02:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E8D6BC15B;
        Thu, 11 Mar 2021 13:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH] SQUASH??? calloc(nmemb,size)
cc:     git@vger.kernel.org
Date:   Thu, 11 Mar 2021 10:02:38 -0800
Message-ID: <xmqqa6r9efgh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F863C13E-8293-11EB-AA90-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please squash this in to an appropriate step in your series;
otherwise it triggers a Coccinelle check when merged to 'seen'.

Thanks.

 refs/reftable-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b7d12ca91d..6faad8ce50 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -996,7 +996,7 @@ static struct ref_iterator_vtable git_reftable_reflog_ref_iterator_vtable = {
 static struct ref_iterator *
 git_reftable_reflog_iterator_begin(struct ref_store *ref_store)
 {
-	struct git_reftable_reflog_ref_iterator *ri = xcalloc(sizeof(*ri), 1);
+	struct git_reftable_reflog_ref_iterator *ri = xcalloc(1, sizeof(*ri));
 	struct git_reftable_ref_store *refs =
 		(struct git_reftable_ref_store *)ref_store;
 
-- 
2.31.0-rc2-173-g36b77366ca

