Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394F19B5B1
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021640; cv=none; b=VHF7sQK5uoKZzyQCNzqwXBSkteRQRz7MlEvwElpAGu65fgIo3pKrbvih7wjAiM1cs3Qu4i0yT6g5Qg7zCZIFGBMpreNQv41suuPct3vhQ98fOWG8xXHOvGXpnARxCAjTMIFfksm6Q95jYYBsJRcUyRh1OXZIBDT6MC0OL1QkQLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021640; c=relaxed/simple;
	bh=EBtoghIvqEE+ngKqzomi/dgv0Nb+kN98KR7nh1mMrAw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFZ4upXqFjm4F/JtZGhX+9AIoqCuU0n1MvojyAQxNx/Pt2/6H+EoxY5Gcq+raNL6wJ7ZnLV2dQcN73k0NRXfC9TAR0U4brQXhSKskj1Y683x7GUaQexAGCvuZ4SdQYpWqKxRMx8RJKBbJk2a8s1gcTcVFUfdaZXgK7lRY+PO0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=e1OFq+5S; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="e1OFq+5S"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e38fc62b9fso13538677b3.2
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 15:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731021637; x=1731626437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUnU2ECzYedS3ip15ZqRh7PKsN9TQcEMcUGEmDbrs8A=;
        b=e1OFq+5SBCfTyUxD0N6fLWNR+7HoZgdZGYVluhYsDgoKZkkmMygbnCrTIPu36XUJtn
         1dxFcsLnWVjuaNyHAbxhf/BF2OwIMC/0NtD580r/3tQSuUsMbBtvZR8CL5lcRYBjlM2o
         4Dw+6di7NrNEawzwz+YONNcq1OELEUqFb2OtIcFVCdnqH9E6a4CwDYCmDMUHQJ2uSmCD
         FX2HdMEXcd/VnlQAX0pfFEpBogtRwIl3hjaLEOBfIgy+6Uzz27bmym2ZLAiG7yT5dc6d
         uxnvtEb/ddWdnHbZOmQEler1nDHMWwBtguswyf3DHUdUStwiJU8I10s5zgkMIVR9ruZJ
         kdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731021637; x=1731626437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUnU2ECzYedS3ip15ZqRh7PKsN9TQcEMcUGEmDbrs8A=;
        b=QpwTg0i/EUnNZ99BJgqLWZzcpApBwFYVgXzEyYBvGAg3zy5zIIB7D0dEENlZVtBX7B
         l7wFNRGzYKFE22/zvpQQ4IfsQGR0frVBFPjKSXjk5Oqo/dUC7BLVSwf13n2HgAcQjqtQ
         qfJy7WF6lBiXwBsIWIIiegCff4kElWr61ODNHJ4J5EaEDcrzAw3Jf9qVrKnC+ROjQvkn
         SXofrfOh4cLznbRM+tEIx4NEnel4Am0FZyfej1lZjZH/dbD9nJPSOHxU7Bk0cfwRBvZn
         9HIziizM4Uu42bWRq6ccRzcWYTtBhXIRuH2TUYBb9lmaMYcuyYTsbNBGDVWFsrAyo881
         syzg==
X-Forwarded-Encrypted: i=1; AJvYcCVFBsqkVXu+JsaxVd801L9lIfcxMfSWAjwcFd7pbflqrAtenl5u2f4WbrF2nfTRF78vqiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqj+qYao4+rl/SttKIHpV65ZlsnKnY68CxnIWOikziyvgTgb3
	70QpdB0h5SGoxCBIs2Q79/7KUv34xL/0ICH98rRlSvCQTwvJ54kgqM8y3btxe8s=
X-Google-Smtp-Source: AGHT+IEqskBO6MRAijM7J2lbwdmo946mZaW5ynYO9QGHlHxgm2zqfDtThMt4/O2r9cDMItAhtv4yNA==
X-Received: by 2002:a05:690c:4512:b0:6ea:4e1f:2b42 with SMTP id 00721157ae682-6eaddd71b3bmr10403037b3.8.1731021637340;
        Thu, 07 Nov 2024 15:20:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb65302sm4879037b3.73.2024.11.07.15.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:20:36 -0800 (PST)
Date: Thu, 7 Nov 2024 18:20:35 -0500
From: Taylor Blau <me@ttaylorr.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] t/helper/test-sha1: prepare for an unsafe mode
Message-ID: <Zy1LQ7uJbut7JTHM@nand.local>
References: <cover.1730833506.git.me@ttaylorr.com>
 <0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
 <xmqqcyj9qgyf.fsf@gitster.g>
 <ZywOWn08cGBnBWM-@tapette.crustytoothpaste.net>
 <20241107013915.GA961214@coredump.intra.peff.net>
 <Zywcr2lMM_Ij8suu@tapette.crustytoothpaste.net>
 <Zy0xfVqtOXhEVDQB@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy0xfVqtOXhEVDQB@nand.local>

On Thu, Nov 07, 2024 at 04:30:37PM -0500, Taylor Blau wrote:
> > > All that said, I do not think it buys us anything for "real" code. There
> > > the decision between safe/unsafe is in the context of how we are using
> > > it, and not based on some conditional. So while the code in this test
> > > helper is ugly, I don't think we'd ever write anything like that for
> > > real. So it may not be worth the effort to refactor into a more virtual
> > > object-oriented way.
> >
> > Yeah, I don't have a strong opinion one way or the other.  I think, with
> > the limitation I mentioned above, it would probably require a decent
> > amount of refactoring if we took a different approach, and I'm fine with
> > going with Taylor's current approach unless he wants to do that
> > refactoring (in which case, great).
>
> I think it does buy you something for real code, which is that you don't
> have to remember to consistently call the unsafe_ variants of all of the
> various function pointers.
>
> For instance, if you do
>
>     the_hash_algo->unsafe_init_fn(...);
>
> early on, and then later on by mistake write:
>
>     the_hash_algo->update_fn(...);
>
> Then your code is broken and will (as brian said) either in the best
> case produce wrong results, or likely segfault.
>
> So in that sense it is worth doing as it avoids the caller from having
> to keep track of what "mode" they are using the_hash_algo in. But let's
> take it up later, I think.

The idea seemed too fun to play with, so I tried my hand at implementing
it and was quite pleased with the result.

The WIP-quality patches are available in my tree under the
wip/tb/unsafe-hash-algop[1] branch. The result, at least as it applies
to the test-tool modified here, is quite pleasing IMHO:

--- 8< ---
Subject: [PATCH] t/helper/test-hash.c: use unsafe_hash_algo()

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-hash.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index d0ee668df95..aa82638c621 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -9,6 +9,8 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 	int binary = 0;
 	char *buffer;
 	const struct git_hash_algo *algop = &hash_algos[algo];
+	if (unsafe)
+		algop = unsafe_hash_algo(algop);

 	if (ac == 2) {
 		if (!strcmp(av[1], "-b"))
@@ -27,10 +29,7 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 			die("OOPS");
 	}

-	if (unsafe)
-		algop->unsafe_init_fn(&ctx);
-	else
-		algop->init_fn(&ctx);
+	algop->init_fn(&ctx);

 	while (1) {
 		ssize_t sz, this_sz;
@@ -49,15 +48,9 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 		}
 		if (this_sz == 0)
 			break;
-		if (unsafe)
-			algop->unsafe_update_fn(&ctx, buffer, this_sz);
-		else
-			algop->update_fn(&ctx, buffer, this_sz);
+		algop->update_fn(&ctx, buffer, this_sz);
 	}
-	if (unsafe)
-		algop->unsafe_final_fn(hash, &ctx);
-	else
-		algop->final_fn(hash, &ctx);
+	algop->final_fn(hash, &ctx);

 	if (binary)
 		fwrite(hash, 1, algop->rawsz, stdout);

base-commit: d8c1fc78b57e02a140b5c363caaa14c2dc2bb274
prerequisite-patch-id: 5df87a6ba8a596bc7834ce8b5a656a3c4f1a869f
prerequisite-patch-id: c3f346e57f98b067eef8adf1e20c70ac23f41c36
prerequisite-patch-id: c5d1ec4f5e9796c5c9232442a3fc3be79379b8c4
prerequisite-patch-id: bdc2d6cbc23c467b24f184a889a5242e5c9fe774
--
2.47.0.238.g87615aecf12
--- >8 ---

To be clear: I think that we should still take this series as-is, and
I'll send the additional half dozen or so patches on top as a new series
dependent on this one.

Thanks,
Taylor

[1]: https://github.com/ttaylorr/git/compare/tb/sha1-unsafe-helper...ttaylorr:git:wip/tb/unsafe-hash-algop
