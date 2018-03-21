Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B8A1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeCUQqk (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:46:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35097 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeCUQqj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:46:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id t132-v6so8874859lfe.2
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aAjktMIdCHgLG3pduSggn5sOBEC8qwXvEO1PWIna9eY=;
        b=kyExqMXDHjp9LIeT0zMfR6Ruurcc/yqvUAukzTew/IyeftMTyBGjrZVq3GhFPR2ALD
         lXGnswHHaqSeE6VSLbs0ylNlR1ijBI/9N9KdHUqSnPHQviatC+GTuONkicysKUKUNOuE
         bw9UonDUi5ITfkY0HGp+U0qrP4liLgISYxSjC10rJO5GQ8my564ARzvERWD2pCvQic45
         wi+Tgo/GatwjbAUekxXB6qaEi2gcRlvxi9OEoobSkNIq5WxXGGAe1NkPX58929NjfhaO
         lWjv5LgXDtI7K+0jlLjxVFi1b3CJ2lLU5Z0/ocVuuu7mdTpA0cU4ZcqkeqA2J/6mJDaS
         s/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aAjktMIdCHgLG3pduSggn5sOBEC8qwXvEO1PWIna9eY=;
        b=Nxrsng/CFqkDh8hFDiLfcmxyaC0yAP3oKMySziiXzhk6jbUMDcfseiJVv0eaKEokvZ
         fW3VrWrZfKFH7cVeC6abj2hSNq3gl/onTnmlc/clJxZKhxZe5lIUgZ1pUDd3HlXiJGhy
         B7t+NNApkZKRZStPu8be8sSQ7v4cEOGQxsDZxl7QHkOIGm01zf7ZJJhHupZQ621dzMey
         4p5lBScp71zsBtHF6RjzWeHHP4vBbm7k2waKkdwMOMtPWmIH267rMPrIOuVQPCF+e0AT
         5OcoZqY9HG8TBL/0MiiB7up74RFx7BGpq4HCz9pqZZVE8L2OyCdCai04biB/kOmEdTRu
         r37Q==
X-Gm-Message-State: AElRT7GY1giy5MJ6lsniB04ddNTjKJghS2Zdd1z+1QpIPqDIHgHgxV9D
        cVmUxygHYlFIW+0/PnQIox4=
X-Google-Smtp-Source: AG47ELtbPddYglLd52qHcNagw3LpoK/TQfll4YmblE5RLYtFpeiCB4VV70Ppwki+AYQjiwMzV/Jy5g==
X-Received: by 2002:a19:eacc:: with SMTP id y73-v6mr13981364lfi.71.1521650797652;
        Wed, 21 Mar 2018 09:46:37 -0700 (PDT)
Received: from duynguyen (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s82sm944627lja.7.2018.03.21.09.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 09:46:36 -0700 (PDT)
Date:   Wed, 21 Mar 2018 17:46:29 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Message-ID: <20180321164629.GA27584@duynguyen>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 04:59:19PM +0100, Duy Nguyen wrote:
> About the 16k limit (and some other limits as well), I'm making these
> patches with the assumption that large scale deployment probably will
> go with custom builds anyway. Adjusting the limits back should be
> quite easy while we can still provide reasonable defaults for most
> people.

And we could even do something like this to make custom builds
easier. Some more gluing is needed so you can set this from config.mak
but you get the idea. This removes all limits set by this
series. Readability in pack-objects.c and object_entry struct
declaration is still a concern though.

-- 8< --
diff --git a/pack-objects.h b/pack-objects.h
index af40211105..b6e84c9b48 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -2,10 +2,17 @@
 #define PACK_OBJECTS_H
 
 #define OE_DFS_STATE_BITS	2
+#ifdef PACK_OBJECTS_BIG_MEMORY
+#define OE_DEPTH_BITS		31
+/* OE_IN_PACK_BITS is not defined */
+#define OE_Z_DELTA_BITS		32
+#define OE_DELTA_SIZE_BITS	32
+#else
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		14
 #define OE_Z_DELTA_BITS		16
 #define OE_DELTA_SIZE_BITS	31
+#endif
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -82,7 +89,11 @@ struct object_entry {
 				     */
 	uint32_t delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
 	uint32_t delta_size_valid:1;
+#ifdef PACK_OBJECTS_BIG_MEMORY
+	struct packed_git *in_pack; /* already in pack */
+#else
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
+#endif
 	unsigned size_valid:1;
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_valid:1;
@@ -112,7 +123,9 @@ struct packing_data {
 
 	unsigned int *in_pack_pos;
 	int in_pack_count;
+#ifndef PACK_OBJECTS_BIG_MEMORY
 	struct packed_git *in_pack[1 << OE_IN_PACK_BITS];
+#endif
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -174,6 +187,9 @@ static inline void oe_set_in_pack_pos(const struct packing_data *pack,
 static inline unsigned int oe_add_pack(struct packing_data *pack,
 				       struct packed_git *p)
 {
+#ifdef PACK_OBJECTS_BIG_MEMORY
+	return 0;
+#else
 	if (pack->in_pack_count >= (1 << OE_IN_PACK_BITS))
 		die(_("too many packs to handle in one go. "
 		      "Please add .keep files to exclude\n"
@@ -187,22 +203,31 @@ static inline unsigned int oe_add_pack(struct packing_data *pack,
 	}
 	pack->in_pack[pack->in_pack_count] = p;
 	return pack->in_pack_count++;
+#endif
 }
 
 static inline struct packed_git *oe_in_pack(const struct packing_data *pack,
 					    const struct object_entry *e)
 {
+#ifdef PACK_OBJECTS_BIG_MEMORY
+	return e->in_pack;
+#else
 	return pack->in_pack[e->in_pack_idx];
+#endif
 
 }
 
 static inline void oe_set_in_pack(struct object_entry *e,
 				  struct packed_git *p)
 {
+#ifdef PACK_OBJECTS_BIG_MEMORY
+	e->in_pack = p;
+#else
 	if (p->index <= 0)
 		die("BUG: found_pack should be NULL "
 		    "instead of having non-positive index");
 	e->in_pack_idx = p->index;
+#endif
 
 }
 
-- 8< --
