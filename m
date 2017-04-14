Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8847820970
	for <e@80x24.org>; Fri, 14 Apr 2017 12:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdDNMpV (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 08:45:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36172 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdDNMpT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 08:45:19 -0400
Received: by mail-pf0-f194.google.com with SMTP id i5so15157031pfc.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TA4KKiWihWqEeIVE1U4jDhLFsCHEw0Kt2PphA+8xz0g=;
        b=hra5CdoNsPDJj2rL4UKxJP30cFjRsZp/BFqZ3EUSTvNv1n2xW7lkOQFZIuAhBzFKAe
         cxtcE8+YzkRbsSYqVqbYEXOim7OhvYTWXPTwEgAeEzaPEwpxNhtjOIY2tiLsnt0HMws7
         e8ZJpqacl3zw6Kc4scGOmsudbgglBgMUZjzjX6dWEHSals+tze7UL+y9XLL0+CqAxiw7
         9RSvnq4ZtsoeQ0XbWiWgHH62WnxigdU0i6b+xu3+sSusR5gxbCAC9Bkw37LZAT8uRStz
         O6Pj5Ngj+ExzETvD+6l3NstZLxqBfdLOQM8MdGWhiJ39AZxA2er8SFdRTofbGGksSeC9
         dGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TA4KKiWihWqEeIVE1U4jDhLFsCHEw0Kt2PphA+8xz0g=;
        b=XetKVtRT5cCtq+mOVzuTgFdO8e6BRUpcqNzpb0aCGwCh/dOlfmZDivuWmafwCzRNMB
         zKyZCqNi1XqUoXldz6wh3+bNwFVrwlJm7XMmrExvtp/yoVRT1p+X5KSA+Jj/lfyp3SQ0
         NSHseDj+6oeevDHgUQaKvPmVvhQYxEC+lqGi7n2MJJFJ4EP+YZbeVJ0KobIGVldnUNrm
         MiDd66YUYs0DfvBj2XFwJI+zL/Lt3XQYySoHzeXBbDNx2VULAal7cryXHRs5h8SlqsZk
         8AI4EESw6Sh0hu5vbrpgaW+ViYsI/dT1IIosDXEat08oA6AXRUL6tiB8cUMsOA69El9S
         jKsw==
X-Gm-Message-State: AN3rC/6ecsPWnb94P+iEIxy4xu2ARJWdkbqilNFjjgO3TIGW9Iug1J+m
        Af6JNhOhScuKbQ==
X-Received: by 10.84.222.129 with SMTP id x1mr8770080pls.44.1492173918728;
        Fri, 14 Apr 2017 05:45:18 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id m20sm3355584pgd.32.2017.04.14.05.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Apr 2017 05:45:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 14 Apr 2017 19:45:12 +0700
Date:   Fri, 14 Apr 2017 19:45:12 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 0/5] Kill manual ref parsing code in worktree.c
Message-ID: <20170414124512.GA20466@ash>
References: <20170318100206.5980-1-pclouds@gmail.com>
 <20170404102123.25315-1-pclouds@gmail.com>
 <xmqqk26nojfm.fsf@gitster.mtv.corp.google.com>
 <xmqqd1cfoifl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1cfoifl.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 07:02:22PM -0700, Junio C Hamano wrote:
> Oops, I shouldn't have done that.  When applied on top of the
> files-backend thing (or have you updated that one and is my tree
> lacking it???), this breaks quite a few tests.
> 
> t0001#41 dumps core from "git worktree add ../linked-worktree" for
> example.

This is embarassing. I worked on and off on this series over a long
period of time. I guess at the end I thought everything was ok "since
the last time" and just sent it away without realizing I hadn't
actually run the test suite, because it does fail here, now.

This fixup patch should make the test suite pass. I'm sorry for
wasting your time on this.

-- 8< --
From 09c6d432490b8e9de99eca09cdbdaebf53bbad2c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?=
 <pclouds@gmail.com>
Date: Fri, 14 Apr 2017 19:39:53 +0700
Subject: [PATCH] fixup! refs: introduce get_worktree_ref_store()

---
 refs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index a4083caf6a..05045a64e1 100644
--- a/refs.c
+++ b/refs.c
@@ -1600,11 +1600,13 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 	unsigned int refs_all_capabilities =
 		REF_STORE_READ | REF_STORE_WRITE |
 		REF_STORE_ODB | REF_STORE_MAIN;
+	const char *id;
 
 	if (wt->is_current)
 		return get_main_ref_store();
 
-	refs = lookup_ref_store_map(&worktree_ref_stores, wt->id);
+	id = wt->id ? wt->id : "/";
+	refs = lookup_ref_store_map(&worktree_ref_stores, id);
 	if (refs)
 		return refs;
 
@@ -1617,7 +1619,7 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 
 	if (refs)
 		register_ref_store_map(&worktree_ref_stores, "worktree",
-				       refs, wt->id);
+				       refs, id);
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85

-- 8< --
