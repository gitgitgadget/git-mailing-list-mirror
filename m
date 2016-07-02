Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1AE1F744
	for <e@80x24.org>; Sat,  2 Jul 2016 09:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbcGBJLx (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 05:11:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34088 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbcGBJLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 05:11:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id l102so938590lfi.1
        for <git@vger.kernel.org>; Sat, 02 Jul 2016 02:10:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F0cGv5ziJkHwQuwpGcXVNjB5XhhkX63ZgWDe4aHpeTM=;
        b=KqQcI5wwAOP7fV5Mia/Yi+d/IBLUDDOnNpK8HnH8GWgUQ1S3pBvqTpEeDtbOtoPW2t
         AiToNGNzexwW3YhpatSZjZjmRd1RMAxT03EMMa3D4JrGLgH6kSNt5P3JWQnQXw4UWJKH
         7K1TNrL2FL4vqSU3mONU9ZGMfVONzPfX3iodC+oM7xZf4GKyAXZUofM6tjrWiEsgVhTb
         NzWkXcR9mZQ+Danf2EtwJQJY99W2526i03T8SyuAbVMQ3t3N9YDSO30WElffbOu4s2xK
         U6l0eTWgnwBKMHnByw3WX9jso7hvmws4ROaygkNgBLd5NdDTVcLO1ZmPmwTCP/k4o7q6
         5/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F0cGv5ziJkHwQuwpGcXVNjB5XhhkX63ZgWDe4aHpeTM=;
        b=iacNJZ1EYMtDSHbwUFg12y8s7JlHH5xrpO3Mqu27sGvN7NK854jyYpUf/anvh1XrQs
         rHx4gUrcGPUnM626KH663h3ELPJjF85nGbleAQHiTXuFuopz79aaHyk+3cMatK2KXpd+
         dTSsCxbyY19jBefdgopEnHHvgGdKf/bCRVMChCbb5GHV9LLkYQg3b2TCAgIjkg37Ptlo
         U0n1mlMVFax/8d2PfPrzk6amMRabPysW2IVZdHU26Hl/ZUCLTqTxgcaWZPUkm90rxwSB
         JQAJbfHffXaszqDXjcCvqbACUG7HaO0b8XUpcOWb7n4v+sCbP2K23lYjhykUYugBoxfc
         km3g==
X-Gm-Message-State: ALyK8tK3dKMj36cWT24M2JzyzRIdsS03oOKfOvB3S+kHji0knHNuW/rmKhpyM7BvjUsw6g==
X-Received: by 10.25.218.211 with SMTP id r202mr452207lfg.161.1467450638296;
        Sat, 02 Jul 2016 02:10:38 -0700 (PDT)
Received: from duynguyen (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id r132sm3024678lfr.17.2016.07.02.02.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jul 2016 02:10:37 -0700 (PDT)
Date:	Sat, 2 Jul 2016 11:10:34 +0200
From:	Duy Nguyen <pclouds@gmail.com>
To:	Christoph Michelbach <michelbach94@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [bug] Reliably Reproducible Bad Packing of Objects
Message-ID: <20160702091034.GA31852@duynguyen>
References: <1466807902.28869.8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466807902.28869.8.camel@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 25, 2016 at 12:38:22AM +0200, Christoph Michelbach wrote:
> Hi,
> 
> when run on a 32 bit system (Linux system, don't know about other
> systems),
> 
> mkdir test && cd test && git init && touch someFile && git add someFile
> && git commit -m "Initial commit." && dd if=/dev/urandom
> of=bigBinaryFile bs=1MB count=4294 && git add bigBinaryFile && git
> commit -m "Introduced big biary file."
> 
> reliably produces this error message: "error: bad packed object CRC
> for"


I tried with a 32-bit git build on 64-bit system and did not see this
message. Maybe it's because the 64-bit system. Just too lazy to bring
up a 32-bit VM to process 4GB of data.

But I did look around a bit, and the problem is probably number
truncation. Could you try this patch?

-- 8< --
diff --git a/sha1_file.c b/sha1_file.c
index d5e1121..cb571ac 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2281,7 +2281,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 
 		if (do_check_packed_object_crc && p->index_version > 1) {
 			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-			unsigned long len = revidx[1].offset - obj_offset;
+			off_t len = revidx[1].offset - obj_offset;
 			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
 				const unsigned char *sha1 =
 					nth_packed_object_sha1(p, revidx->nr);
-- 8< --


If your system has large file support (you must or things must have
failed badly from the beginning), then both offsets in that
subtraction expression are of type off_t, aka 64-bit. However "len"
would be 32-bit and truncation can happen. check_pack_crc() takes
off_t too, so it seems well prepared already (but I didn't test).

PS. There's a similar statement in pack-objects.c, but I don't think
you have done anything to trigger it. OK, 'git gc' may..
--
Duy
