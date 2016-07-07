Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C07A2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 18:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbcGGSNI (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 14:13:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33078 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcGGSNG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 14:13:06 -0400
Received: by mail-lf0-f66.google.com with SMTP id l188so2064692lfe.0
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 11:13:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=74bcItZtV895dGCpZc7W1OHSTZB8N1OyLcsK1QZ4Y68=;
        b=1F3TbmTm9EmFGMgN5x6/J0i3UU5h5uvOxJ+TkU5IY/4ZRiUxuYNJhVn/wRKHVm3TY9
         e+Wjxk1lSJGh/Zx1d2lQVbDv7Eki2GG1nRq/7uDFNSdjNx1N7TibpEOtLeNdSfSltmpU
         ofi0GCpVg74Tx0knC3hiBUMwREbMUhPgvRhPmT9XGAXbSYMzqdSMw1dm69JiTVg5CKYV
         mRMYKcJAqCmIOKDm16I+9mLCQFDLdvSUoUZNgsruB9jG0y90rKlerjs1844K/24gVjPE
         6uVcoFyi1y+1HHJ7VPLnDNzj2gqrz6oBbIR9sD/5mpKqNIvXqeCRThclJsnWSoLJlvwH
         fV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=74bcItZtV895dGCpZc7W1OHSTZB8N1OyLcsK1QZ4Y68=;
        b=Hut753cGozX5pf/yHsC4RbBotCeRtPY3F4kMRwi5IPd3O6TAhbOlyy0gxcN+Vm/DTt
         IPCESh3r9dNNqBa7boJImlcU2oNpsZMx4rXn57/KXH/r8wIu/xLetjuFJqGLWiELl7EG
         xZkUAjA9HOpmHzpRVMV9NESUxjE3UqEwpTwfdsmQoU6VXK8i/XVGH8DJ8Sov4Wj9//wR
         qATTK9sJPncW7yDnY1g85/7CzfrmXPl56nTCt7M/dDYWN4a2em2W6dF46sduFPX8X6JU
         U3YOshCBAglwJi+oIdzSNwoAt9L1kZrzOXFNKCrzN0YKm+3Tt/4P6IcsWBamMPHsTp7C
         PZ3w==
X-Gm-Message-State: ALyK8tLb4IuqRtzKd1TLII9rYFtvc38QaS/nn/KMREUxN0GryRZiaOMl+IGm0uuC9ivo+Q==
X-Received: by 10.25.158.79 with SMTP id h76mr433313lfe.152.1467911560916;
        Thu, 07 Jul 2016 10:12:40 -0700 (PDT)
Received: from duynguyen (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g28sm990228ljg.24.2016.07.07.10.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2016 10:12:38 -0700 (PDT)
Date:	Thu, 7 Jul 2016 19:12:37 +0200
From:	Duy Nguyen <pclouds@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, yuri.kanivetsky@gmail.com
Subject: Re: [PATCH v2 2/2] cache-tree: do not generate empty trees as a
 result of all i-t-a subentries
Message-ID: <20160707171237.GA31445@duynguyen>
References: <20160704174807.6578-1-pclouds@gmail.com>
 <20160706184829.31825-1-pclouds@gmail.com>
 <20160706184829.31825-3-pclouds@gmail.com>
 <xmqqeg76sh44.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqeg76sh44.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 06, 2016 at 12:26:19PM -0700, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
> > @@ -426,6 +433,15 @@ int cache_tree_update(struct index_state *istate, int flags)
> >  	i = update_one(it, cache, entries, "", 0, &skip, flags);
> >  	if (i < 0)
> >  		return i;
> > +	/*
> > +	 * Top dir can become empty if all entries are i-t-a (even
> > +	 * from subdirs). Note that we do allow to create an empty
> > +	 * tree from an empty index. Only error when an empty tree is
> > +	 * a result of the i-t-a thing.
> > +	 */
> > +	if (it->entry_count < 0 &&
> > +	    !hashcmp(it->sha1, EMPTY_TREE_SHA1_BIN))
> > +		return error(_("cannot build a tree from just intent-to-add entries"));
> 
> The test would not let you tell between the two possible ways the
> last step "git commit" fails.
> 
> Did it fail due to the protection this change adds (i.e. you should
> be checking if "git write-tree" fails if that is the case we want to
> cover), or did it fail because you recorded an empty tree as the
> root commit without giving the --allow-empty option?
> 
> In any case, I am not sure about the logic in the comment, either.
> "git commit --allow-empty" should be able to create a new commit
> without any files in it, no?

You're right. If an empty index can produce an empty tree, then an
index full of i-t-a entries should also be able to produce an empty
tree.

git-commit not failing when --allow-empty is not given is another
(known) problem, where it miscounts the number of real index entries.
It's not right to "fix" it in here.

I'll deal with that separately. Let's focus on cache-tree only this
time. So how about this on top?

-- 8< --
diff --git a/cache-tree.c b/cache-tree.c
index 75e73d7..2d50640 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -433,15 +433,6 @@ int cache_tree_update(struct index_state *istate, int flags)
 	i = update_one(it, cache, entries, "", 0, &skip, flags);
 	if (i < 0)
 		return i;
-	/*
-	 * Top dir can become empty if all entries are i-t-a (even
-	 * from subdirs). Note that we do allow to create an empty
-	 * tree from an empty index. Only error when an empty tree is
-	 * a result of the i-t-a thing.
-	 */
-	if (it->entry_count < 0 &&
-	    !hashcmp(it->sha1, EMPTY_TREE_SHA1_BIN))
-		return error(_("cannot build a tree from just intent-to-add entries"));
 	istate->cache_changed |= CACHE_TREE_CHANGED;
 	return 0;
 }
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index a19f06b..1a01279 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -104,10 +104,17 @@ test_expect_success 'cache-tree does skip dir that becomes empty' '
 	git init ita-in-dir &&
 	(
 		cd ita-in-dir &&
+		echo ground >ground &&
+		git add ground &&
 		mkdir -p 1/2/3 &&
 		echo 4 >1/2/3/4 &&
 		git add -N 1/2/3/4 &&
-		test_must_fail git commit -m committed
+		git commit -m committed &&
+		git ls-tree -r HEAD >actual &&
+		cat >expected <<\EOF &&
+100644 blob b649b43b0708f5604ac912f5a15f7da2bad51a1b	ground
+EOF
+		test_cmp expected actual
 	)
 '
 
-- 8< --

> > +test_expect_success 'cache-tree does skip dir that becomes empty' '
> > +	rm -fr ita-in-dir &&
> > +	git init ita-in-dir &&
> > +	(
> > +		cd ita-in-dir &&
> > +		mkdir -p 1/2/3 &&
> > +		echo 4 >1/2/3/4 &&
> > +		git add -N 1/2/3/4 &&
> > +		test_must_fail git commit -m committed
> > +	)
> > +'
> > +
> >  test_done
