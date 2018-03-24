Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6951F404
	for <e@80x24.org>; Sat, 24 Mar 2018 05:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750785AbeCXFbu (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 01:31:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42460 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeCXFbt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 01:31:49 -0400
Received: by mail-lf0-f67.google.com with SMTP id a22-v6so21150210lfg.9
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 22:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vL5GUwOHWcKHIhrLz9q7yzWpGuryGylRroONw/B6bR8=;
        b=M54lk/AMbjiW7ee54RmnfXn6hh1cl2FUtQIMQIXw0DxYaXdnSKKW3NoMHc1kxweSbl
         uom68FDvYMb1ckgmilvIRTFqYnjLInOvp4KnwzYM+y4TjqEwKQftfqcWrA/zlEG6NqYw
         31PO1PVdlNWCW3lGgaJzbk02zAdKy/cNyk8oe/OTYUCfoIhIfahtP5sIHJQcvbbV3CYx
         04nVnWzXjVKJ34JAVW/shruhDEU5By2TE6XzYgI5dXKfmKRj9MLoVviW8t+R9Pmg0p/P
         dupotvmnAvOIR5sNKD+gpMKjvsROfq384SszKxPStk9SZ22neIt4Vs/aQ7epR39/akJm
         +UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vL5GUwOHWcKHIhrLz9q7yzWpGuryGylRroONw/B6bR8=;
        b=HClIQXSeI9tWsYyEfp9wlfsrUtjhXU2dROIdB4VudYUgjtUv0Shfln8shuG3LbyS7O
         QgaE0SScr+At+a5JgC/SWEbe4bmMhVZ9AAxmDHxs4vtxiR+1uPxQXRNhHYTC8/F7Reds
         tHjI0CZxFkchCsh1LLaxpgjOqwOENNYJkBcXUzSFaWS4gzIzoxlQecyizqsetBjVi/D6
         1V6ON2lcZYnFJtpnhT9a8SLzKc/5ViwQIw30S7wKfI7KONVqEMQd75VhegovYBQ8ha8G
         HiWeY8OtLI7l+UUrqLS4SornpyA/YzWqQJFdS/Nw5H50AFGt1GUKS+Trj3SLeNeweFVe
         BoZg==
X-Gm-Message-State: AElRT7EItYBp5yURS58DZIuObCiTmGb9dzNPK2ddUY4IdPaGAVbbGQpS
        uhiOpwm6VNVbLLj78trYIOo=
X-Google-Smtp-Source: AG47ELs55Bc23N8tU8BtkB4ATrzN5YtztNepZcJla36gQ7EdrJ90OGn9qo/xqjLvtlxmt4OiPHix1A==
X-Received: by 10.46.152.88 with SMTP id e24mr5949974ljj.7.1521869508249;
        Fri, 23 Mar 2018 22:31:48 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t17-v6sm2630968lfi.30.2018.03.23.22.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 22:31:47 -0700 (PDT)
Date:   Sat, 24 Mar 2018 06:31:45 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/27] sb/object-store updates
Message-ID: <20180324053144.GA11420@duynguyen.home>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
 <CAPig+cQ=u2xVaptpVzVd3g_RO+9kTWVitD4V7zpZFuL+a3wmtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQ=u2xVaptpVzVd3g_RO+9kTWVitD4V7zpZFuL+a3wmtg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 06:07:33PM -0400, Eric Sunshine wrote:
> On Fri, Mar 23, 2018 at 1:20 PM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > Interdiff is big due to the "objects." to "objects->" conversion
> > (blame Brandon for his suggestion, don't blame me :D)
> >
> > diff --git a/packfile.c b/packfile.c
> > @@ -1938,7 +1939,7 @@ static int add_promisor_object(const struct object_id *oid,
> >         /*
> >          * If this is a tree, commit, or tag, the objects it refers
> > -        * to are also promisor objects. (Blobs refer to no objects.)
> > +        * to are also promisor objects-> (Blobs refer to no objects->)
> >          */
> 
> Meh.

I got too excited when searching and replacing. Here's the fixup
patch.

-- 8< --
Subject: [PATCH] fixup! object-store: move packed_git and packed_git_mru to
 object store

---
 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 63c89ee31a..0906b8f741 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1937,7 +1937,7 @@ static int add_promisor_object(const struct object_id *oid,
 
 	/*
 	 * If this is a tree, commit, or tag, the objects it refers
-	 * to are also promisor objects-> (Blobs refer to no objects->)
+	 * to are also promisor objects. (Blobs refer to no objects.)
 	 */
 	if (obj->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)obj;
-- 
2.17.0.rc0.348.gd5a49e0b6f

-- 8< --
