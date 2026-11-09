Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250213;
	b=IRkBv5nhyNlAXidaE/kidBXR54+f9OKBtYsiZKpU5IADenK4k2M2pia2suNLMQ9CeAlO
	 Ziy1QZNZdYO0OuONXlL0lGJfuIi7lTzE8pQ7H53uxw6tUYTpzlfofPOZW5iC8JEchylna
	 FHkhRXm5KfdKkyjr6z9fhLisV3HeObN6jJ6NGYcpxwWfWxL9wUOs3D7lkUxIsAfDtRCEH
	 PE0lpq4Yna3K3tezsBSTaZrVw3pWubr0KliUn4fTFArtLJ2cyM9fZznriWp1RjPz/rmaz
	 eDcKvDhLqdwIgojvMHaZYhxuy7jyKsXcg5feH+BXacI9JMb3T1+4kJgLNpD4TpjQrsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250213;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rgA8AQ2jhVGqR+OLP/iEgOrxG7mXxEeb7bnAtuQHMY8=;
	b=CstpUDvRG1oaPbhKX2zkJkbPQg25/hrGDjfztkQIvvp9alOXgLQBNWFxXcHqq51qKBMz
	 f8iDYhc/oF/lmtU/Vut6y3CWuNdLxfjNhz190+hVV1fyo4+bQjzP6edudr9/4XorUUWMz
	 ImWoDJDsFizrH9e7zh8R5A+OHr6nPZ7EJkr4ee8St/0Exu02t6tNxWUkbPAiNpfe3WoNM
	 7e97KFZ5JOYI0ewqc5UcU8WuSXVtuqfC/BzKzelLylHBAa3ZjKqFpGgoW+TdovOpwxBAi
	 tIYyVfRZcdNLKYwIHH6dENkVBrDLB3rB3k5LQHNrNlZ5wXcwIbcAVzywvNptHfCVbrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=bRWEb81V;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA1606A326
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 18:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52AA1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=bRWEb81V
Received: (qmail 90108 invoked by uid 106); 9 Nov 2026 18:50:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jHXv9ZlCkycOOhGPdS8ZP/LecAocvTccehxZIdGT+2g=; b=bRWEb81VmMIC1dTaO1mom2HJsnZ6uW15Hr6ewUZ1mnHd4VjI/SlUUApk4TkIMke0/9tR77Qyt1nS4w6gpj1sbLxL79qPhGNvz2r5t8F3T6eo6XA9SdERBBqrR5Fnv+tRdBpdLJeDnRvA1SLKsExWv2cJn3s/Eh5T46cht6PUdB31ji4frMGQ0x9dWjNJUz2DrkKVNLd4+4HO+4IxJQl8X94+WzYyBXTSBYdBbpwGNB0pYfxZGrVV98RtRizDvS1i2DgH+Aok8iUuygVwyptxW/qyvleqdse44l2Ew1d6/O7+88wq0/ErnOrttDoENSbLUErIfTpO1FvcuGtNOL9LSA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Nov 2026 18:50:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157466 invoked by uid 111); 9 Nov 2026 18:50:04 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2026 13:50:04 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Nov 2026 13:50:03 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Ohly <patrick.ohly@intel.com>
Subject: Re: [PATCH 2/2] odb/source-loose: fix existence checks for newly
 written objects
Message-ID: <20261109185003.GA1322417@coredump.intra.peff.net>
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
 <20261104-pks-odb-loose-stale-cache-v1-2-a00d5cdb5e7d@pks.im>
 <20261105194314.GB2898829@coredump.intra.peff.net>
 <au23Hvzp09yrym9s@pks.im>
 <xmqq5wyalzi2.fsf@gitster.g>
 <avHOTt_PEJUKq9Dy@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avHOTt_PEJUKq9Dy@pks.im>

On Mon, Nov 09, 2026 at 02:44:46PM +0100, Patrick Steinhardt wrote:

> >  	/*
> >  	 * This is meant for bulk prefetching of missing blobs in a partial
> >  	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
> > +	 *
> > +	 * NEEDSWORK: rethink if QUICK is desired in this context.
> > +	 * cf. <au23Hvzp09yrym9s@pks.im>
> >  	 */
> >  	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
> >  };
> 
> Yeah, that'd probably be sensible. But I wonder whether that comment
> should rather be applied to `OBJECT_INFO_QUICK` itself, as I think it's
> way too much of a foot gun and I'm not sure whether it's ever really
> sensible to use. But I'm fine with either variant.

If you are going to get rid of QUICK (which is only implied here, but
which you said more explicitly up-thread), I think you would need to
check all of the users to see whether original performance problems it
was addressing still exist.

For instance, 5827a03545 (fetch: use "quick" has_sha1_file for tag
following, 2016-10-13) reports a 99% speedup. We have made the pack
re-scan much faster over the last decade or so, so the results now might
not be so dramatic.

We should be able to check at least that spot easily. The original
results were reported on p5550, so here's what I get after un-quicking
it (patch is below for reference):

  Test            HEAD^             HEAD
  ----------------------------------------------------------
  5550.4: fetch   0.10(0.07+0.03)   1.42(0.98+0.44) +1320.0%

Not quite as dramatic as the original, but it still makes quite a
measurable difference. I will note that p5550 is intentionally
pathological, though, so real world performance might not be as extreme.

The other thing to note (and you will see in the patch below) is that
odb_has_object() does not have a QUICK flag these days. Instead it is
reversed: callers get the QUICK behavior by default, and have to pass
the RECHECK_PACKED flag otherwise.

If you are just proposing to drop QUICK from actual object retrieval,
and not has_object(), then there are many fewer spots to consider (and
the fetch one above would not even be in the list). But if you mean
both, then there are a lot (and they are kind of annoying to find,
because you are searching for the absence of the RECHECK flag).

-Peff

---
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 09966e5ce8..2922c32f7f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -391,9 +391,9 @@ static void find_non_local_tags(const struct ref *refs,
 		 */
 		if (ends_with(ref->name, "^{}")) {
 			if (item &&
-			    !odb_has_object(the_repository->objects, &ref->old_oid, 0) &&
+			    !odb_has_object(the_repository->objects, &ref->old_oid, ODB_HAS_OBJECT_RECHECK_PACKED) &&
 			    !oidset_contains(&fetch_oids, &ref->old_oid) &&
-			    !odb_has_object(the_repository->objects, &item->oid, 0) &&
+			    !odb_has_object(the_repository->objects, &item->oid, ODB_HAS_OBJECT_RECHECK_PACKED) &&
 			    !oidset_contains(&fetch_oids, &item->oid))
 				clear_item(item);
 			item = NULL;
@@ -407,7 +407,7 @@ static void find_non_local_tags(const struct ref *refs,
 		 * fetch.
 		 */
 		if (item &&
-		    !odb_has_object(the_repository->objects, &item->oid, 0) &&
+		    !odb_has_object(the_repository->objects, &item->oid, ODB_HAS_OBJECT_RECHECK_PACKED) &&
 		    !oidset_contains(&fetch_oids, &item->oid))
 			clear_item(item);
 
@@ -428,7 +428,7 @@ static void find_non_local_tags(const struct ref *refs,
 	 * checked to see if it needs fetching.
 	 */
 	if (item &&
-	    !odb_has_object(the_repository->objects, &item->oid, 0) &&
+	    !odb_has_object(the_repository->objects, &item->oid, ODB_HAS_OBJECT_RECHECK_PACKED) &&
 	    !oidset_contains(&fetch_oids, &item->oid))
 		clear_item(item);
 
-- 
2.56.0.800.ga66132ec4f

