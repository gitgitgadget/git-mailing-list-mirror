Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A341F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 22:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeJMF5K (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 01:57:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43022 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeJMF5K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 01:57:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so12771098eds.10
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PduoHCcnjaOaZhu1hcsVq8dwBy0uMw3WtSpxe3kc9N0=;
        b=Qq/KOwkIDXRdAuvn3nqzH8wEhK5XvRD4v4j6/WL6x/U+RyCAzwbUwJZgj32YrDKd3w
         lftujdOlwuKqBOUFY97lEXsWFuGrSswnN/0iXA4Geu+2vKc5a84K7kSZp7bLCHuY42zX
         BrXqyfys5hLSw37w9tDenXeHhtgNMRn+iJhnMtub/CLmKmqLBeSHCME6mJ5bA8gqqAyw
         U7Qb+t7iPt+uTSe4Si6v5dl+1rzdnM206F0uYXAu8eOvEoYiOHFJ8bFMginGQTIr77SC
         8adke7boGgBp37S1A+EmqDSwdXxtRpeVTIpKZNJqWfHr5PybeLlyMobtJySCPjdciHJ1
         KO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PduoHCcnjaOaZhu1hcsVq8dwBy0uMw3WtSpxe3kc9N0=;
        b=WxSwHI0ROOwNpuvkuCKzh3DbzzkMZSsFCDP+606ka6d/dTQgKu5ZIUnQReNQ6bCc6U
         ZBQI/YBOi3Km1avywicpmof0q5EReVCYRB7g/lKh6mv3rWR0yYBqxzaDXVZBHd5aZNA5
         kFjdRFTbOp0OsLINHVk34QQ4Qi6WVBa7HBunK55ZRd+j3iN1HXPQE31ldE/xWprQpyJY
         ae5m2HTYpzXnD1PmUIB7oQ0qURHabuKhcLsNL6AxY3AmTDgR5HRwQ9CnFrafr3eaxfRu
         nfN1vUrXk6IDH3+KuykZJiiyWxucBuyhm8SrK1g5IBEF1RH5VFNSu/PsIrZeiShw+Ww9
         IlRQ==
X-Gm-Message-State: ABuFfoiDp5fjKCb2bRyvqDNmBB7lRNoUs1uEjR0jr1kt+nzJWYuggnK5
        oULLut6KAH2K5USIzrUmj4c=
X-Google-Smtp-Source: ACcGV603eC57L6sc01hRwxu5JViFjJU525FmakuwW7Xb+0qyBubqxahyQW37sgMfrAPndHSf1XxL/Q==
X-Received: by 2002:a50:81c5:: with SMTP id 63-v6mr11233104ede.167.1539382957373;
        Fri, 12 Oct 2018 15:22:37 -0700 (PDT)
Received: from szeder.dev (x4dbe4f29.dyn.telefonica.de. [77.190.79.41])
        by smtp.gmail.com with ESMTPSA id k57-v6sm959807eda.55.2018.10.12.15.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 15:22:36 -0700 (PDT)
Date:   Sat, 13 Oct 2018 00:22:34 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] zlib.c: use size_t for size
Message-ID: <20181012222234.GF19800@szeder.dev>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <20181012204229.11890-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181012204229.11890-1-tboegi@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 10:42:29PM +0200, tboegi@web.de wrote:
> From: Martin Koegler <martin.koegler@chello.at>
> 
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
> 
> After doing a review, I decided to send the result as a patch.
> In general, the changes from off_t to size_t seem to be not really
> motivated.
> But if they are, they could and should go into an own patch.
> For the moment, change only "unsigned long" into size_t, thats all

Neither v1 nor v2 of this patch compiles on 32 bit Linux; see

  https://travis-ci.org/git/git/jobs/440514375#L628

The fixup patch below makes it compile on 32 bit and the test suite
passes as well, but I didn't thoroughly review the changes; I only
wanted to get 'pu' build again.


  --  >8 --

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 23c4cd8c77..89fe1c5d46 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1966,7 +1966,8 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	struct pack_window *w_curs;
 	unsigned char *buf;
 	enum object_type type;
-	unsigned long used, avail, size;
+	unsigned long used, size;
+	size_t avail;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
 		read_lock();
diff --git a/packfile.c b/packfile.c
index 841b36182f..9f50411ad3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -579,7 +579,7 @@ static int in_window(struct pack_window *win, off_t offset)
 unsigned char *use_pack(struct packed_git *p,
 		struct pack_window **w_cursor,
 		off_t offset,
-		unsigned long *left)
+		size_t *left)
 {
 	struct pack_window *win = *w_cursor;
 
@@ -1098,7 +1098,7 @@ int unpack_object_header(struct packed_git *p,
 			 unsigned long *sizep)
 {
 	unsigned char *base;
-	unsigned long left;
+	size_t left;
 	unsigned long used;
 	enum object_type type;
 
