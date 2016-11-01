Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0AD820229
	for <e@80x24.org>; Tue,  1 Nov 2016 22:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbcKAWGV (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 18:06:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54653 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751074AbcKAWGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 18:06:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19C994BAF4;
        Tue,  1 Nov 2016 18:06:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BPnWjP/QJAJFbujeygBG/Pi82/s=; b=uwNpXT
        j0MQcZqw4OBGesJFyIJeKQ3ErxQ6+YwjiN26vHbkouZjPr/dSDxJoI+rvPeXUYWG
        uQ0VbxmQvuKvSXQVCDT1A/gG4uJ+0LKj2J3GGiKxUvs2YHQT03bpUuOjcBhlEW7E
        WxWWHcfB3DfKkQJHyuDCLLj9Dzb9k08sBSPtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RgnBVx7ja7XsEMV2hN7V4DC6S55Wvlyk
        TGRg8bUy7HJitg4YfgmhBMwJlz+GGAYdl87mY5WQzutl73BVUaiCW1IZbbxlJK3O
        5MbJe46X4Rz4V5sGd0Hrxz+BXUyH0zogYxgLCYHhvPaZBMjLzZZ28NFc1o/6FBbv
        CjeAMxnBbIo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EA0C4BAF3;
        Tue,  1 Nov 2016 18:06:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68DDC4BAF2;
        Tue,  1 Nov 2016 18:06:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
        <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
        <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com>
        <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
        <xmqqh97qoqq2.fsf@gitster.mtv.corp.google.com>
        <xmqqzilinanp.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZHajTxFRbOftH==UAXhbH7RSA_jYWO-aQXhW2aSRdUFA@mail.gmail.com>
Date:   Tue, 01 Nov 2016 15:06:17 -0700
In-Reply-To: <CAGZ79kZHajTxFRbOftH==UAXhbH7RSA_jYWO-aQXhW2aSRdUFA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 1 Nov 2016 14:41:35 -0700")
Message-ID: <xmqqr36un9d2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A3D51B8-A07F-11E6-8A64-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> -diff.indentHeuristic::
>>  diff.compactionHeuristic::
>>         Set one of these options to `true` to enable one of two
>>         experimental heuristics that shift diff hunk boundaries to
>
> We would need to reword this as well, as there will be only one heuristic left?
>> +               } else if (flags & XDF_COMPACTION_HEURISTIC) {
>>                         /*
>>                          * Indent heuristic: a group of pure add/delete lines
>
> This comment may need adjustment as well (though we could go without)

Thanks.  I've queued this as "SQUASH???" on top.

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 0c79e48d9d..39fff3aef9 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -172,9 +172,8 @@ diff.tool::
 include::mergetools-diff.txt[]
 
 diff.compactionHeuristic::
-	Set one of these options to `true` to enable one of two
-	experimental heuristics that shift diff hunk boundaries to
-	make patches easier to read.
+	Set this option to `true` to enable experimental heuristics
+	that shift diff hunk boundaries to make patches easier to read.
 
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 6cb96219cb..31ff519232 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -908,7 +908,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			}
 		} else if (flags & XDF_COMPACTION_HEURISTIC) {
 			/*
-			 * Indent heuristic: a group of pure add/delete lines
+			 * Heuristic based on the indentation level.
+			 *
+			 * A group of pure add/delete lines
 			 * implies two splits, one between the end of the "before"
 			 * context and the start of the group, and another between
 			 * the end of the group and the beginning of the "after"

