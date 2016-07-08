Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2A62070D
	for <e@80x24.org>; Fri,  8 Jul 2016 15:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbcGHPjh (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 11:39:37 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36379 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbcGHPjf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 11:39:35 -0400
Received: by mail-lf0-f65.google.com with SMTP id a2so7899074lfe.3
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 08:39:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aSyK1u54zkzVyYTT6PtOhDXdnaQnzh6h7Ha8HMsUV6g=;
        b=GqRgICP+1qWvM2T1kQYCAoHjVYiy44vGtHxFeQZwDDoesJdBj/HG8uNkueGGW8FH0j
         bZfaNdmdSAbO4Fa5nN0gQDTJ7kFJQ0ENwprnG44nKWPSkdyIFilNY4dttk9Z8BuHyMGc
         QoyTL56TXRiVLT1QCgYY7aeTHHkOeLcg2+oG5wEGjK0BXkc7PAuEdkdRTL2JTlqpios1
         H8F1jwx10eNvyMZTCNQheJMuiigQyAPpqofhn+PxIIFycUwBD/cvO7etr2g1ssJ9E/zY
         j8ioYqcigrjm3nBl28YQcPSBUb9Os097Ylp4OMucX458hPMHYT+EcoHZe/s//+a4eu6X
         1MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aSyK1u54zkzVyYTT6PtOhDXdnaQnzh6h7Ha8HMsUV6g=;
        b=NCubEFlLTaausLy4M79GWS1P5FPvHBuw+C5TIedletRkj/AAHGwBFPRvg6HHXPtZ34
         wZcL2oP3id9m9j4J/uqtZrZEJzdV0L1vbk5X86jLkcrls9UPp8zQk07dfNLhSrdo8qA5
         m+Yxe8KiM5nt7q8ve1uEm3pg6L+Fh1l7cyR1F1uRevBfqrWbL046JXW5cBrY2NJULbB5
         DHUq560Y7sv+cBKnu1fHgFzRDmp/QSGloBS87Sdcw3jSgO6///CZeU8d1sZ79NUdI9BK
         4a/6n11+USEnaAkjO1hkUGPuRvt80ArKwsLcpMLTjMV0ZQkd4zyeGybcEppHclcqvt9I
         Gn4g==
X-Gm-Message-State: ALyK8tIDiI22Wy2tOz7/tyk9hiVLZb1IpF9ELJONTtir6BQ+zhevGu9p3o3P0LF8v9mvwA==
X-Received: by 10.25.28.145 with SMTP id c139mr1881741lfc.79.1467992373559;
        Fri, 08 Jul 2016 08:39:33 -0700 (PDT)
Received: from duynguyen (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s78sm134913lfe.10.2016.07.08.08.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2016 08:39:32 -0700 (PDT)
Date:	Fri, 8 Jul 2016 17:39:30 +0200
From:	Duy Nguyen <pclouds@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, yuri.kanivetsky@gmail.com
Subject: Re: [PATCH v2 2/2] cache-tree: do not generate empty trees as a
 result of all i-t-a subentries
Message-ID: <20160708153930.GA19448@duynguyen>
References: <20160704174807.6578-1-pclouds@gmail.com>
 <20160706184829.31825-1-pclouds@gmail.com>
 <20160706184829.31825-3-pclouds@gmail.com>
 <xmqqeg76sh44.fsf@gitster.mtv.corp.google.com>
 <20160707171237.GA31445@duynguyen>
 <xmqqmvltp9f9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvltp9f9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 07, 2016 at 11:52:58AM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > I'll deal with that separately. Let's focus on cache-tree only this
> > time. So how about this on top?
> 
> I was hoping that you would limit the scope of the test to check if
> write-tree does the right thing.  i.e. not test "git commit", but
> test "git write-tree".
> 

Yeah that's better. So the squash patch is something like this

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
index a19f06b..80880b7 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -107,7 +107,9 @@ test_expect_success 'cache-tree does skip dir that becomes empty' '
 		mkdir -p 1/2/3 &&
 		echo 4 >1/2/3/4 &&
 		git add -N 1/2/3/4 &&
-		test_must_fail git commit -m committed
+		git write-tree >actual &&
+		echo 4b825dc642cb6eb9a060e54bf8d69288fbee4904 >empty-tree &&
+		test_cmp empty-tree actual
 	)
 '
 
-- 8< --
--
Duy
