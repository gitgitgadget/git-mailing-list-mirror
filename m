Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0AAB202AE
	for <e@80x24.org>; Thu,  6 Jul 2017 00:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbdGFAhN (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 20:37:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35790 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdGFAhM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 20:37:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id q85so684749pfq.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 17:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=P1Yst8zvdIERbv3mgd9DhUEXQbSegxuSJyzQKleSTL0=;
        b=riq04H+uqcEJERsQ2VverLeseb4tb6ZJVPw71d9K4v3FUqoxE8b8qi8vss3o5PNWtG
         GH3Jm6SYW2YCcQUzTJ4oM/6WBFiGaBGBu+oLJpQABKG07XOXEXZSM7VeFABWksEb7PCO
         ppQHZ2mB+Ujf1lNDbhWnzxPQTcnQQj6yDwz06QD6vbMxCeESKtqo6L7YVsqhf+Xk8eUb
         /fL8YlKzbQCBcybaDsOXl2jTsnBgCelxifq+/uaWEIZeIaL0l0mESkgM6BjGoMYAFGxm
         6b7hpGcjIZNK4di4AUWKMBLSEqSdZM8nWhSKwa+gJpn6p4gbfRDvrA7YP/Po1uU6c9cJ
         d8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=P1Yst8zvdIERbv3mgd9DhUEXQbSegxuSJyzQKleSTL0=;
        b=HS/FAAiZoShEb0W9tb66LNzerISzQUqI0qf49wmGLWFY+FfntV26tY9OHFnEH4/j6a
         yXXZPVPYuPSj8DSYOjeXqd5jqQ3JhjKuWNiQx+M8GacakgYVteppXNpN/FMNO9aoSNXi
         BntliS7AKAB7OHFdDd0F/OLfVCSuJZVr+Wom7eoPPfttn89YgIEBLJddB3Wwkzb7FP/s
         yTO6fvi159pH70lHdOkDp9CrnpKrethvnhZVHWabWbARgLITPab2D/BG/OIhMuB+tuis
         VfIU4h/AYqW+P/LtkJBqw38uVkkzrJ31q8hdUDASxTx6UX0QntYAu25XVLyKFfGHrnHE
         FEzQ==
X-Gm-Message-State: AIVw111sCyf12sINiLM/gfKV7J5Wilr2TUoSmbNR148Oi46ACPwczELK
        7oPP0zy3pdZ2tg==
X-Received: by 10.99.121.1 with SMTP id u1mr23039574pgc.20.1499301432072;
        Wed, 05 Jul 2017 17:37:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id u9sm501585pfk.131.2017.07.05.17.37.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 17:37:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 0/3] branch: add a --copy to go with --move
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
        <20170705231454.15666-1-avarab@gmail.com>
Date:   Wed, 05 Jul 2017 17:37:10 -0700
In-Reply-To: <20170705231454.15666-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 5 Jul 2017 23:14:51 +0000")
Message-ID: <xmqq60f6h03t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Even though this modifies some of the same files as
> mh/packed-ref-store it looks to me like this doesn't conflict with
> that topic in any meaningful way, but I may be missing something. I
> can't get a merge between this & gitster/mh/packed-ref-store
> compiling,...

That is because each ref backend is required to implement a new
method by that topic.  The following patch needs to be squashed in
while merging the two topics, making the resulting commit an evil
merge.

FWIW, the result of applying these three patches on 'master' and
merging the result to a commit on 'pu' that is just before the merge
of previous round of the same topic, with the attached fix-up, exactly
matches the commit on 'pu' that merges the previous round, iow, I see
there is no meaningful change (perhaps other than log message?  I
didn't check) in this new round.

Note that I am not complaining that this new round does not bring
any improvements---I am not commending that you didn't screw up
while rebasing to a new commit, either ;-).

diff --git b/refs/packed-backend.c a/refs/packed-backend.c
index dc09012300..96f9141656 100644
--- b/refs/packed-backend.c
+++ a/refs/packed-backend.c
@@ -794,6 +794,13 @@ static int packed_rename_ref(struct ref_store *ref_store,
 	die("BUG: packed reference store does not support renaming references");
 }
 
+static int packed_copy_ref(struct ref_store *ref_store,
+			   const char *oldrefname, const char *newrefname,
+			   const char *logmsg)
+{
+	die("BUG: packed reference store does not support copying references");
+}
+
 static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
 {
 	return empty_ref_iterator_begin();
@@ -859,6 +866,7 @@ struct ref_storage_be refs_be_packed = {
 	packed_create_symref,
 	packed_delete_refs,
 	packed_rename_ref,
+	packed_copy_ref,
 
 	packed_ref_iterator_begin,
 	packed_read_raw_ref,

