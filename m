Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422081;
	b=25tGyPrIp5exMeH2DbmXCQ0msavQgW7lErs2IJKvftNDmYh8LfMdz1mlj05lUXOAxp09
	 v0uoom5e2joAdDuvB7Z3005r1ZfLkVE8O2YxvvqRLkX6EYGQkzGAIegcGvIioeNRx96Xj
	 NPDclgtf+fJvjlfZlSL2zlYJLcHgkUK1sPaxk4X3XaRLlv2zyFfEntbllTGFwQCBysnOp
	 10zmQfRMbjgLWwVmiGqbGzCdrKxY1e6nlLae2Z3PlM1pzb2gKOJD5jdB10N8p4MYgRX46
	 nNxi4c97XnLZbYrJF6WsjCAz0svE8YYtoSZ0iBoKoMENPEGecKkWnk/YCvVv8koV7ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=10YJik5kL3VCXmE9N5/F8J2SsXRK0SgEnJShFD3vXuQ=;
	b=tUnhMWr7pIr4dP+iLyLxebiWJDZV2LFsLseSM2WN9UoLQvfSELN9JrCOojpJKybW/Ipf
	 VzHU9AmHphEEhuqBcsAo14shsrv9SgPdVv/20BwhMWn+BS0XkEzaKYcr8vSOTMnVztcfo
	 p4MF6BKFxRjJvbxDFNkhBCd8GWIZKm4jZ6AmSneM949YVevsfjiVCT8hNSDjVuOYRirIu
	 vLHxsIsCuLQAaMey4rxwSCBJ0cfr4yQDrhAZz+XOIIbgSgFqdzXcZNkiwk7DZQ4r/f6a3
	 CTRtQQsYE80MzKdzYxfR2Tx9h/GU11x9JhM6kqT5uiSKXn9rAX9T9E+t1BGNbtsw8Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hx0fFQFj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.68
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com [209.85.222.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D233607AF0E
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 15:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D233607AF0E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hx0fFQFj
Received: by mail-ua1-f68.google.com with SMTP id a1e0cc1a2514c-9902a746546so1478578241.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792422080; cv=none;
        d=google.com; s=arc-20260327;
        b=EOCbyAAZMa9wE4yg92HwRjbIgRGsaqlc2976tMUy5hZ4UuQq27SPiK1JNXT10k1acJ
         eYQEf7FtwY0bqFxL8FjfqJ/sJ7aufuhrupYAhekD3dpsi+nPx6dc2H5UMt40jRAo+RGZ
         paVOTqcZGgmpLc31N0NslpN1Vgu0O2R6M85v33T5EMVwJqFroPqFdIUMIydsdW/9QGX/
         D/E5QlUYJsE3p74bjqQy1CZA6tV7YHyKrzt1pHYReuOkAeWGhNt3Q+pWz7VjEal2kmPZ
         tQNDURBNniuAJN/bqYZp4b03sO3YZKxFu91qntzPJDwyFRmbUuFD2yFif9zZXm5omywT
         QSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=10YJik5kL3VCXmE9N5/F8J2SsXRK0SgEnJShFD3vXuQ=;
        fh=+JocfjCtfLXSt6uzEE1H/Rx3oQ62MA1If1rNninh/eI=;
        b=IXENEr5GO7ZVQX7bY4jSgN0mAbNxEbDNQOSRwhDF4eS55HJJ+hoSv/BpDu4F8+Zm+o
         7qQCD4milMlHPOCApZ6RckSqVgsMBrAGb4ZEmCzRFVra7Q0EKhkVt/Jwm8yi7JQnkJpp
         m3iCBGLqbkgvUp9CLzc4u7s594hSQ8vd56WPd4EIrwdXgNxppnBMubJmUZwBcaW0J3Us
         KGShdBteEGqQwTnCfeM13Y+UeAquUoZ4Q4gZxqJIQUyvFx9W5Cn4T09uxKuFdkMrDOB8
         zBDSiyBdyM+S/uAfBEhK3tKiyj53UVZEHOCuchFwfM9tUMFpgrPfj7uIiU4i0aNKoOY6
         LXUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792422080; x=1793026880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=10YJik5kL3VCXmE9N5/F8J2SsXRK0SgEnJShFD3vXuQ=;
        b=hx0fFQFj9uDYJxNpRBN9d5atZRU5IE/2sBN/OT4VcWIxVXEMjIQAjR9qu85wI0gPk3
         qggLqlV/LB96becgLOV/qCM3r1kZPxPxzV8ZrV4mRfqpPf4TOBTypji6pZm/Bhg6Hplc
         xkxNL1B60kEzD5sY7tmUNzqB2fh/3eBMIU2MmWEjq7JoYYVQp3xfljASUFcIQ/ivdH1p
         YRpQyvaTP0TD/w3xR7XXUkl1nc9I7DGtCF1iBtU4g86Sj2bhyBPqUIsxgIiA9Pa1Sfyd
         S9g+LhmJaay/ifhiomj7KjTLAK01wV+rSv3032/AqXaMxtoLkuLyBmg4w+T2OLV6fhUE
         xqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792422080; x=1793026880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=10YJik5kL3VCXmE9N5/F8J2SsXRK0SgEnJShFD3vXuQ=;
        b=l1GyS4B76P9pX8TZdLMwnFYG40wyiWYTUQzdtCWJZyqDH9wRMjp2K+tL/yJ66ea2uK
         YvSalVCRlY+tKQ6hnF+vqodKfexZI0OMCqw5QBSGCrsQUIhEttdy35iLcondIue8Ayr2
         jWWHJOmFTwn1Z9yveJXkHdQUOyow31rTZtj/ReuvD/pkLl4yoE/+p+Kl6+dosWnuzW4P
         TsTMPr6mZzgabUsbAzcCf7wOtM6gv8Bgwm2L7dQN3KWstDfGHv/oTiR12l1gyhh+fCA7
         sqYnq5rRsaaDREkoOliULkxW3llhv7p2ZEDS192POfolHvJu2KCMUy8WJFWreXDtkKxn
         ERHg==
X-Gm-Message-State: AFq9FYJayiLiLksJhAgEG4DA6NMfQKEsA7D3h/18TNfIWZypxT+tH21F
	6WmKJBr74YEV14FmjYfTAsAgFwBAnd8Hfcr9Thkq4pfiVZe1L3ZN+5XeNiWV2fOlDc82zof1E/k
	3QOoPF+9yAD48/zbA5mPSwIQdBpHAZOeRL08sFIa8ontb
X-Gm-Gg: AYBFou0wZuCQFmJaYD/vo9mpjJrhe8gzSYWqb5vxcaakXXku2aqDDc3iK7by7mjzX//
	AT5oRhU7CeZykPxbwlKRzGhU2J8ixYMljYufioXSnoQSzJvyMwtMQCsltq9l7SnO5q79Uu6Iu9t
	x50dNOTR/3oAfF+Ig8zhQ/C7LhfGI2ag4swOkvJ/o2t70ZBOn31jT8zN1ubDkhVefYuUpc2ynBa
	nB7HanFPhXwYmceOTjAhXdPQo1rfPWMubKU8HOqiSqjB6M/G34dghrUuXSf1kVkBHJghNv7lSUx
	u8CB+0/D1iHzXAV9zn+uaVPjUhqfu0eY6o20BvShnUILwzpWRhnIUUagUxt7Nqg9upEz7r4NqtG
	woEc+ly/k3Mg=
X-Received: by 2002:a05:6102:1915:b0:7ca:8f2d:5c29 with SMTP id
 ada2fe7eead31-7cc181cc3d2mr2319757137.27.1792422079670; Mon, 19 Oct 2026
 08:01:19 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Joy <cryptocurrencydiva@gmail.com>
Date: Mon, 19 Oct 2026 16:00:39 +0100
X-Gm-Features: AclHuK8jVoBtdEuYYrS_-j5HKjK6FSLgeCWM3sxJtyABjPa6dgM-Nv9Hwut36UQ
Message-ID: <CAKA8Uu1oLhdhNC9hGwMvQSC1+jzJqXnnWPGHLZUm5ZBdPkEM0A@mail.gmail.com>
Subject: Outreachy: request for a focused global-state migration task
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm preparing my contribution for the Outreachy project, =E2=80=9CReduce Gi=
t's
global state to enable Git's libification.=E2=80=9D

I've set up the Git development environment and studied the available
migrations into struct repo_config_values, including push_default and
has_symlinks. I also took a look at the abbreviation globals, but
found that minimum_abbrev is used across several components, so I
don't want to introduce a broad change without guidance.

Could you recommend a small, well-scoped follow-up task suitable for a
first contribution to this project?

I'm happy to investigate the relevant code, implement the change, and
run the appropriate tests before submitting a patch for review.

Thank you for your guidance.

Best regards,
Joy Gundu
