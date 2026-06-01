Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C971DEFE8
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294593; cv=none; b=rYogC7uyeYrpuSc5O86AIq/vNEQMSC7scTTaYflV4uu1TdAGWgn2wHg5oyu2KUbN/JRiH7jAsJqNvl/SowzrOEP9f4RB7iNjY0Hi8M0nhiEB82g6O4w8zMv1W9Mm/UuGMm0t/bpqloGcNbM5+gswZx9dwY5/mTXoiBY41DJtk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294593; c=relaxed/simple;
	bh=8s9qlEBnCh9WNzZvESdMbyZkHm//cRLGkAkb8D9o8Zk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PX8gjTdfZq5+eu0LXiqkwR6i2h6OXxmlGSpFojocBttkfdpGcW5lZnBbV+eowlaoqmEroEsBlFY94dDaaqCmnSUBzQRxVZKCC34semMUeWA8c0d4TyKbJkK+Jb6+D/XFAvimDdLFKf4r/c9ORil3GuNGcUyy0Q9RLuDZH/qXz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dy7AeOsq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWd3v0sF; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dy7AeOsq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWd3v0sF"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E3487A00C4;
	Mon,  1 Jun 2026 02:16:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 02:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780294590; x=1780380990; bh=BDDf5rTf6K
	CxXjqsSPNwLGeuhpG2KYzm+sP4fEQkVjg=; b=Dy7AeOsqbfj1i4kFiq74+E4NJJ
	7aSuj2zefMsY6U/E6FjbjFcI1E/HiRxr5iD0CJDxHMQSnU6BFovVknn+9YZwW/mt
	RwkfUeIAfzJf4pbqzOpvjGAJ/3uaXXuBkBixNX/u3XEJnfisYwtTGaq91WciCA0U
	DkhlTGM7mVwVZS4dlwJf+N1uC5P/vbM87fEmOfLks+vP8zzyKqjF1C3/sQYOoLKi
	KtafsmdOc17/SC2JFDsPWpE77meC/i0shAyOIGdofsKlIrtozLtY9VaLPcONj9iW
	eeSQiw1mdrjPYWqkDAp/5IsqS1159KA+3tVoQNBzPWauE5/I+gYPYjwRNCrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780294590; x=1780380990; bh=BDDf5rTf6KCxXjqsSPNwLGeuhpG2KYzm+sP
	4fEQkVjg=; b=TWd3v0sFFUBpxEwKSvXZAIryTVeIJUUYv2+GXD1YwRaeHebnT03
	mrAnP5BsV0pRDuRwvWbMDEgJKyawTAm0gyrzl90Br45+N7P6XCNaim2xa2WmdFiz
	0PS42WAUy47aj7ioeokHKyInRA7Hg/2CvnnAaz4G1REkpBC2RWZBK9dIDXzXQpNW
	zf039BKCb089kCc6Q6r1rWGEEn1AJI/tR2kF0ZD5c3EJEiZIwX2H6Tsk+qYdPebt
	tRUumcwmU/gOsjgsWYuIPNtOh/SxK6tSYMI0zhGvFviPRUuKHjvJZCO1z2Vvpx3r
	VK8nHPMThNggRaik2e1efR90KjLYSGOgKMQ==
X-ME-Sender: <xms:viMdatIrBeJed7LoiHD_fUgGGCJJ6emNJB4W6rruSO5K9JcHqWHltg>
    <xme:viMdagIVWcaVvSzswP2sU25qXavOtWGK08FqBKGBxm7VYlF7yB7U2LvFrPh5GCSt2
    0Vd3CEk5sFA8V-1Thj0hOBViH_9wq2P_FOmpBD350js4PR5ifrl_w>
X-ME-Received: <xmr:viMdaqvLjwR6CkTkwel46e8Cw-S8s62cDejt7C6K0Vd2iFq5f6qeTN7DHFwtjcoXm4g8aWzCvJkn5DeWz-rvt0o2vqpxchiy13jv>
X-ME-Proxy-Cause: dmFkZTELOZ+jvm9OYodyKX6ocNz961tAL2quQUQvCNhI6DTk/MBOhCv8jNJvFs4lh6JFel
    yWVeKQ27WlPS/Io8+SVu2GrMfDoQ4Du1tMRaYHORo5UbTOjmudmwqSLuYEuygPX0cRrkx7
    6BUtYmfg0Qub0YuleTXAODx970RqRBwnlkjKZYrJVtdJJqeeKOxrGoAR9wYLzNgn8xMc1L
    HZGjp9KQi4Ukfsxa+7e/PAy+nvZz13eWm7/PEkNzECWLPW9MTJh1y966gN+LnTYxngOUTG
    YsC87w5iuQ+d2VDnimbPq0ZqfybN33KMAdHZKcDFoFdOo+b/5ZdXQbnWEWJpgKWVuHDxKW
    ij57NIIPRe1uniFtlbBnOFVx1XF89P8zCREhIWmJbhab9bxJNPFmPdK5S2nELw9wC6fJQI
    Pts9tKLCgZLtpkA5ZMK+bkbqx4d9a8ZFzPTFhXH0/MK4HasE1qy+ZLqu1VTotd49jw65t+
    qZeg4b45+9EX6QzSyJptlaT8Y8VwtJut3g8W7AiWYdA5OE7UCLgHlqV0bvrN2TRK+iVIcD
    zPgOcRcJ2Wj/iDYbHpQisG/lwlSGskdaZCZIF3Av5gn5vWyvyhy8sWQtNWcU+MuxEU5xvk
    aJjhgYOi9k/0ZYQFabKzbejg0Y3jdwH5wnHob0EkjNfVVyW/8xc3mxsbtjTw
X-ME-Proxy: <xmx:viMdatRn-QaG4E_jQJGNMxr1gqSQLVqytklSSXZgYDoancaW15pzRw>
    <xmx:viMdagPjKkjSgfEqsQi-KVVyzIPIWpCQ-Dz6298lmhTlBt3PRxOcKw>
    <xmx:viMdaiaokXEarPWJZR66vG8zluxhdm8c81D3_4fC18yNcOTbE1BU1A>
    <xmx:viMdaqzPCbc0HVR_deoQbrqByQ3m9RTF986O1HRILgAjzpbY5eLXOA>
    <xmx:viMdaj2b9kDwsZEy1xfkMW_VZb0Pq3NSmmb6RiKADduTK6e8URie8mI2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 02:16:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] prio-queue: use cascade-down sift for faster extract-min
In-Reply-To: <pull.2132.git.1780250236304.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Sun, 31 May 2026 17:57:15
	+0000")
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 15:16:29 +0900
Message-ID: <xmqq5x42aipu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/prio-queue.c b/prio-queue.c
> index 9748528ce6..18005c43c4 100644
> --- a/prio-queue.c
> +++ b/prio-queue.c
> @@ -62,17 +62,21 @@ static void sift_down_root(struct prio_queue *queue)
>  {
>  	size_t ix, child;
>  
> -	/* Push down the one at the root */
> -	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
> -		child = ix * 2 + 1; /* left */
> +	for (ix = 0; (child = ix * 2 + 1) < queue->nr; ix = child) {
>  		if (child + 1 < queue->nr &&
>  		    compare(queue, child, child + 1) >= 0)
>  			child++; /* use right child */
> +		queue->array[ix] = queue->array[child];
> +	}
>  
> -		if (compare(queue, ix, child) <= 0)
> +	/* Place queue->array[queue->nr] (left by caller) and sift up. */
> +	queue->array[ix] = queue->array[queue->nr];

Here we always sift/bubble up the last element.

I am wondering if it makes sense to teach sift_down_root to take an
extra argument, "struct prio_queue_entry entry" (passed by value)
and sift/bubble it up, not always queue->array[queue->nr], and ...

> +	while (ix) {
> +		size_t parent = (ix - 1) / 2;
> +		if (compare(queue, parent, ix) <= 0)
>  			break;
> -
> -		swap(queue, child, ix);
> +		swap(queue, parent, ix);
> +		ix = parent;
>  	}
>  }
>  
> @@ -89,7 +93,6 @@ void *prio_queue_get(struct prio_queue *queue)
>  	if (!--queue->nr)
>  		return result;
>  
> -	queue->array[0] = queue->array[queue->nr];
>  	sift_down_root(queue);
>  	return result;
>  }
> @@ -111,8 +114,7 @@ void prio_queue_replace(struct prio_queue *queue, void *thing)
>  		queue->array[queue->nr - 1].ctr = queue->insertion_ctr++;
>  		queue->array[queue->nr - 1].data = thing;
>  	} else {
> -		queue->array[0].ctr = queue->insertion_ctr++;
> -		queue->array[0].data = thing;
> -		sift_down_root(queue);
> +		prio_queue_get(queue);
> +		prio_queue_put(queue, thing);

... update this part in the else clause to do something like

		struct prio_queue_entry entry;
		entry.ctr = queue->insertion_ctr++;
		entry.data = thing;
		sift_down_root(queue, entry);

to retain the optimization?  It would perform a single cascade-down
sift, followed by a single sift-up, so it would save a comparison, a
copy, and a swap in the worset case compared to the get+put sequence?

Of course, the original sift_down_root() caller (i.e. prio_queue_get())
needs to pass queue->array[queue->nr] as the second parameter to match.

>  	}
>  }
>
> base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
