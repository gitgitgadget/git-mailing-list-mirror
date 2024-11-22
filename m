Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036E7082F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 03:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732244492; cv=none; b=Bc0qovwBADla5hyC4oqMvCWCnezCDy5oSzeWsIc7bD41YU7R3hOsGZBpFOJh0WhOfJey7wSESc3ShMNMdXRwaGm5pOdyLQVdc8C7Xc+DlKMrL0yyyfvxqi3vkyL+YPWlkb9GXmcj3pKBXmP+N34ptJe7XmSQebc+FKN20J1FMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732244492; c=relaxed/simple;
	bh=jv4Aq4Wf1Yr1kyJQ+wlHZF1HTe04ey98lXX9SvPd+bU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EwroWjbltK2XA188AljSX/t1Zojnt66VIrsDe/sRVOfX1VBd8TraoccRGcvmPmFwjkyxAxHg4Ruja/NT2q3TStgelTcSYNCa/enw8LR3KBNsqXTW+8V4EphXLwuSvFNaY76LqtqBCNFiPVPCenNbnl+SZH380plK3CwdeGuRAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a3iFsMAb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a3iFsMAb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9889E1380215;
	Thu, 21 Nov 2024 22:01:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 21 Nov 2024 22:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732244489; x=1732330889; bh=ZxMRdPlXlb+70r3S5UaCV5T5oecSc2WwGUi
	QHEjBKc0=; b=a3iFsMAbDMEIb4crrM9RKThKCZTMpxHUwAL0Kr4oUFCX23232mD
	dW4owjX0bP8TQ1btFkUPRxp2Ke6HLLmKT5sSwphbF0peDj5rZQ+c1SB/ZHyjHifh
	sa8q0D1EdGhH+AoDMXXnnjRPSUr51XnQUNXhK5C+BadQwcivvNzDQ1Iu2soZ6rgR
	n/F66bIGMPZonLtcMKxU5+3CRep9oLD4NvaB8Yc2guMJqKyFOFwptetn03g+o8id
	czjWO5CpqlaR/IrEgUEsmzPHWAq6fuV7wzvbgUagOBXAWqcFRL6RqpUDou14RMVh
	RzhfLpUr3GLCf0HuwbgLq++JcRcFi9x8ExA==
X-ME-Sender: <xms:CfQ_ZyKaH1YX1AOG2j9-EJVBI0jDehUtSSyV6j8vGoe6sF3-fUmVRA>
    <xme:CfQ_Z6JIPetXQxwMQz3BBNGd_pdhV7k7092do9csjvR3cJ1rcmnUzD82OSwwRllYp
    bpE_BXu0-j0Pm7CXA>
X-ME-Received: <xmr:CfQ_ZyvREaHD95rk-VIXZf0Rl0Q2wUwRD7I98R0s_LilDUiurJxUPvoH4VGNvqgxhH5Zg0cSBA34KGTojc6OlPKXBHqCAd2COVX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:CfQ_Z3YdCvlJyUr9WrlSw-oXC1PlhQw89wnq1eRO-XeOft99s02_3Q>
    <xmx:CfQ_Z5ZT0tiEjJf6BldapIYkDTguNPBWi-HGL6ANR9UdNjQK_YBbYg>
    <xmx:CfQ_ZzD31Osz3-6_u1jcvV23xJ8JUbG6hZHA4GG9QvR35SKvOz7I-A>
    <xmx:CfQ_Z_bwn7KjQkErhzQ6omr0R_SpfOwT8HU3Rgg9bH93Hm69LZcPLA>
    <xmx:CfQ_Z_A1V8sN4heVrfvtpSdzju4qUHnf3ArPN2eoj4kk5g7n7JWiqssz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 22:01:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/7] pack-objects: Create an alternative name hash
 algorithm (recreated)
In-Reply-To: <20241121235014.2554033-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Thu, 21 Nov 2024 15:50:14 -0800")
References: <20241121235014.2554033-1-jonathantanmy@google.com>
Date: Fri, 22 Nov 2024 12:01:27 +0900
Message-ID: <xmqqiksgas54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> +       while ((c = (uint8_t) *name++) != 0) {
> +               if (isspace(c))
> +                       continue;
> +               if (c == '/') {
> +                       base = (base >> 6) ^ hash;
> +                       hash = 0;
> +               } else {
> +                       uint8_t nybble_swapped = (c >> 4) + ((c & 15) << 4);
> +                       hash = (hash >> 2) + (nybble_swapped << 24);
> +               }
>         }
> +       return (base >> 6) ^ hash;
>  }

Nice.  The diff relative to the --full-name-hash version is a bit
hard to grok, but compared to the current hash function, there are
two and a half changes that matter:

 (0) it is more careful with bytes with the MSB set (i.e. non-ASCII
     pathnames).

 (1) it hashes each path component separetely and rotates the whole
     thing only at a directory boundary.  I'd imagine that this
     would make a big difference for languages that force overly
     long filenames at each level.

 (2) it gives more weight to lower bits by swapping nybbles of each
     byte.

I wonder if we do even better if we reverse all 8 bits instead of
swapping nybbles (if we were to do so, it might be more efficient to
shift in from the right instead of left end of the base and hash
accumulators in the loop and then swap the whole resulting word at
the end).

Thanks for a fun read.
