Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795572533;
	b=TZDRUApO+53PHxAiLSysQv6Q9THR71svf01pcRc6gZvXwsYh3zs4qys3RUpr/mrMtniG
	 iLyPP4rFEHE4xY/wpfdMr09cNayxrmBNbbLTBIQz9ZmIK4P8DlX6cHIIrhdcC7s+c6WA7
	 lmJQeJ7s+B7BitOOwsssfA34/bQyyWWxpWilsVvx6y2n8meuufT11T/slE4ZZDYyGgIU9
	 NTQ/9tkqZbfonsIVd8GIIcPpnEMNmI2HwAT8G2N3Afi9wpCwS0/lCC1NDxzC4VNgmlaCA
	 jF6pC7QVDMvMQ94GVN3KwLTdHDHzmBUhmeteReQW1RM2apN3GRGTDGOBtd0/cSZfRPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=vdvkgUCZGzjCSeE6KRH9+Oc26gyqNcSOkKBd9rJZvKM=;
	b=aOycaU48xUwuW8UX1Uad4XJB+ZQuIC9x3lEVfdzESwBse+lFu0u2d3aTNGfPKYcON31d
	 xfHCBB341NW4CNrWWShiqhS7ArtZxKmfYCo3EPPXqHTdFbcCq2lj+CTy9tu7sNJXl9lXd
	 jGA3EV7IMRxPhILQhAWxYv/oJyQUU4QaSRD5iaNOh9RVrg4kcIEa6BPV7RSXeBBQq7noW
	 qTDDfR56IDH+JkmhxKZC7qZ5pgMX1CVJBNG4ufKwSZsJdKTLGf9Gr2ppNOr9U83QSi2ei
	 pjNcTxEcWoIC9RbvD/l2ar812UHHNEQtskJrTw6EXSq0i2ThnmV7NeLvcmHehlj6j+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HAZ5lGNu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3FD606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 02:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C3FD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HAZ5lGNu
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-71b7b706946so78595eaf.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:08:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795572532; cv=none;
        d=google.com; s=arc-20260327;
        b=PEhhyKBSe1qdZ5EWmDRRO+VxIt57Sdi3tPL3ZGfS1vA4XcRVr9oHgPxjIo2Vwd7eBX
         STzSW9G0G/gRm742o/h45VP8HSZk8Gw5WWc4Ru3XaD4SfrpgqgwIfMte5poqter8MaS/
         fX6Zq8lROIqWsxpI5DZeosFkHjuMKV5YmhGdD0od0K4IOeou/uQ6Reu2K59QpZsZYT1u
         2YOYrITSEt0Ug3jT6Fl9LBmc6E1vjg+qNtVr5RYAL0GHTWh9ezS31CHIBRYHVnoEzyW4
         WGm2j/1RMNK/uDxYYDl8vJk8XSlK0EKvS0k/4v1n/e+6uHSlSHAfS7Vx9as+rMC0qWFO
         fApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vdvkgUCZGzjCSeE6KRH9+Oc26gyqNcSOkKBd9rJZvKM=;
        fh=Egm/5YidTTPpY75KcdcBFTr7ZtacKXHzuPl0ncIjAks=;
        b=USJqv/FsQfNZWP8+zGWIUSBnl9W+Tgk0umrwUvOrwx1XPciRosa5FgVuJia/AuLnxT
         5CCICc3kx5ayi1bQqwOoI4spTnCjY4N4fLoMT8rMhBYJIqguZLVpXLxe/zzozephQT7l
         VHOCMAOVKTESd9i+ZXp19GPyuApU/wcxuwCSYn4LWpF0awqq1W32MWCOK2KS4uImivub
         ASa0qy2tl+lStZdQE7wKFGSU6YvZsA5oxuchqUnd8jqVfBADDyidcAUxJcUQE1sGuhJo
         nSLXl2K1dKIETSxarqmn49WpV4n5B2sAVK3h4CEW5CtxdR+XzmWNNM5QqV7XzXP/Ah3o
         eghg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795572532; x=1796177332; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdvkgUCZGzjCSeE6KRH9+Oc26gyqNcSOkKBd9rJZvKM=;
        b=HAZ5lGNu8CMwUNlOjgv0t/JRi+X6x5bC2el1mZoddtv33wWfTjV9hk0ACwo4B8fBBn
         7lDaOYGBD+uQkkxUd9FdFew4iaHbB1kgCBQ2q7PINWBAwyxqFyWtkpMHX4FAwAB7mxSA
         OMXQj32tcNb2QB8C0+jLqSKv6cktJb2OslnxOw4JOTgPfnh9mdDQ2hBz1pLINp2Ul9dM
         9nTfsFK/UGERjgMWN/GWqNxH6lRZBcEFzEuBRZqLCIggIbXjnmMQ7WkPgQd05OIexRL5
         oG/pbS+jWbax5o+l/c4tRivtkJoS+DobfnJR6Q7DjifBeeSQ67FdKk5TRSF+lTBJ977N
         gouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795572532; x=1796177332;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vdvkgUCZGzjCSeE6KRH9+Oc26gyqNcSOkKBd9rJZvKM=;
        b=dTs83ebnQP2JKyCE67+LVLxoZIVQpIehuDdafBuv58hTBTkk7xgocGTaGkTWc8ER+9
         6wOGTSkgQxapOe4JfyV1YRLzoQnzMAeGe6Gc1Vr1bOnSJCZNbO/PzpCc072uaOw0w/1d
         Lk8yPZ50HWHKz7EMASwbaXK19FRo0Fv1bNDcrZ737QxM8vywNlV+gJTDox4v79JAqyU5
         aWKV3s+/MNySASknGvLF+hdoghSDLZ6AWjyHUi99crEvmcrMD7ejYbnEowdHb7gmciRA
         beWy9PQFqR+QKSM9BKprf6Il2KTMlOumEc6hZ4M1n82VXi7PT5MHAgcpqd2qyjChXJR4
         +jzQ==
X-Gm-Message-State: APuU4Z+5kZ/RbVF2fzjjmT/ijn8lVDHmXMoA9OlglXdTwio5hWrgahCg
	njBrpKqR4DBPhPMqUyJHrjWwE9FzlcoH6urOGAOZ5jJ0txfdjBSENFkWNm41koiZCZhob+cEdZn
	sezMF5G6Jf+7rRmbZVUTsHo55aXRpw0w=
X-Gm-Gg: AZFdTZc9wO3BcOdeveC3CSAGgeIKfjnfVdbBqFFuxw8j8kRzm+hptxlmo5viu7sKEc0
	01g2W+hVIs6mt/e3gyVmABxcwhnT+3ouh3o8JBrG3sAeGX4Q3MYi6UqfUU6J6EJGa/ea7q5OBME
	NN19qi9jldmdNGrRO2DtYKHKfNP2sXnOmP/bmLH0Vj02ow9nUHDF1DNzV7uoZsSgHl650mh7D6H
	4DQ/BnXmGRbbXV7bScCjaPBdNVw84rbvBWBCgKX4F8+DytHP1gG2Np8gHdZRR9nl6I0G57iibOx
	cB52VfISdtdVaDy1gr/pBp9IahH+N2c/EUAxNigMpTk6ZT4gU29fhHVUFCyKSOkAYPMB1FgvNPm
	yJp0xVS0u3sZLQVz/Y2giULkbP0diRWUCrOkLRQzNsJpNh851+fdFHByOBgVXoQjQbrll1tPoNz
	xuOLhwKkXb/9K1yUMrsasW+7n/lDMvGfKjYp/TmbBd7avrrd2j8ltalA==
X-Received: by 2002:a05:6820:1608:b0:6dd:696d:b21f with SMTP id
 006d021491bc7-71b3920d023mr14636943eaf.2.1795572532099; Tue, 24 Nov 2026
 18:08:52 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com> <20261112-kn-fast-import-tests-1-v2-9-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-9-b8c3a0ab27e8@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Wed, 25 Nov 2026 05:08:15 +0300
X-Gm-Features: Aa3M54rvlhFQMVfWlxeS-k8jA4gv5YQ2cx5jBqCGESPE0hW_Y24-2OBYMBPp8ko
Message-ID: <CAKrRMNq=GWEwLioJXUrEXwZAS-DhOqwMtQ93DW9txGp-6u6TMw@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] t9300: make the big blob tests self-contained
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 21:51, Karthik Nayak <karthik.188@gmail.com> wrote:
> Set 'fastimport.unpackLimit' to 0 for the import so that a pack is
> written, and verify it with an inline loop in place of 'verify_packs()',
> which won't be available once the test is moved to another file.

The same loop ends up in four places, in t9307, t9308 and t9311.
Maybe verify_packs() could move into a small shared file instead, if
more tests leave t9300 later.

Thanks,
Tanga
