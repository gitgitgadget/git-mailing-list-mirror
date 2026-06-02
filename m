Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70E368291
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413380; cv=pass; b=o4rEQAkdAdW5HPPfk3ZY7KpDucCeLkKwhPHvJNb9qMllcZfExqo4iYfsBgSTRl9OOGVAP/pI68rUiBEU+aonA22ycKM0q2+xKTeqPskezhEi5vcAnSwaZ1Tn/nJJEFLDHsyeRoZ/BwrrtrgpZbBunQxPCm/L94/omEKxMDFdd/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413380; c=relaxed/simple;
	bh=wylFy7fO4jlgMOt5wlJkyGYx4IgMKJYfd9Z5jNflZkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqx5STeUsBIS7nDo0cNp/uMPtKYcaa7y3nBYE92PB7pyInIfpxKUD2rBxzyo7+wrbEGsYyJnwZ2RdSF4JlGrH9sAeA4lzDNNuuiqaqn1zZjtF+puatS9qwOrI9Ib5gVcikEouocKiOVLimazKMA2sksfnN3lJZO3gbTt7jRHKn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHSN2egY; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHSN2egY"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6cfdc92bfso606611a34.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 08:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780413377; cv=none;
        d=google.com; s=arc-20240605;
        b=GAODYvrx7FSDSIPywPa2E+V1AroSDXDnSCM47aVjYVf0csARmTyM8HTz38Zuu0UCZ5
         LLodUcTcotA5qNK2r2YsKSSu7cdxaFd3yhTfM659+raVeGbufgNo8+QHvUPfXpvZn7YH
         ixKFywWreHrlZdt0AEtxS4eIYxpwqnkc1/t9wXh6amzoISYNoag+se4psVR1gI5IfyZq
         HKq4nisFkB+5uXM7fAVSZt70RgissSFfv4H9zI9LHgIo0qFOzvnrCs51Hd8BQd6rmum3
         GwmeE6oN64xlj7N95ks3T1oEfI/im/UF0tm/H1V8WNgMV68PeR+taXpyWkaPaRbjJSW+
         U0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sekwh1XrX16OyqGcGbys9pl9Kn+8/9ebI/vd63SJkqI=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=IaonSAuMrigstODuaYyvs6SUf/TFgO4Nu9RVa6KHb5HfLb+kyEIAkIVrVLVbMel986
         DYy3RMmFwe1jWjVOvexih80fqEgyTmpnPlYhu5EQw1wCn7zxI95cZu5drriUaCK3lnAl
         qEJ0IxFKAFxHB6miJEpd/qC+h1fXMWy5bd5A7/dBlSA7SvYRhpe4hffCaU9np9bmGBeY
         IQUCFkTDe6iBaFuCUXFBnJABm89pEgaerGNoIK9JeaMX5Ov6G8vrwRDSpI4zDaR7S5ra
         E3uZcqAvR0sOjMewEuezKZJvdXnPWH1PMU4H7z89bhBmYQctU3k8+XQIsCaYq8KBHAd4
         sHOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780413377; x=1781018177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sekwh1XrX16OyqGcGbys9pl9Kn+8/9ebI/vd63SJkqI=;
        b=tHSN2egYKB1bkP7+HpQpplvxFtnmYQC21LP9EN4pj9E6P1w5nE4cqQ4E1iBCqfs+Ax
         +L55FOBXN0LxqYrDwWQ8UaObLtt4a/V/S4PltjOz4djDKdVsXcsSZuxpk4BHn7/9K/gU
         aTjcXDdxCPpEbmdxl5H4MH9S0pc2y6FbwvfJ+J4WOq3Cn/a/u8GmLkDUPXPDfzPegE8O
         mkJsogutcPMmYnWnVOJY2VSqfFFlolyxW8r8XRC7Yv2OH9YWmDrlby8buxC5RGunukvE
         4d2M+TvN7moGFs/OMWHiR4AnBRCdRCNWZPPQZNQ1RfHxzs9g0zoX5HVr5i5owe5J3pNb
         oJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413377; x=1781018177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sekwh1XrX16OyqGcGbys9pl9Kn+8/9ebI/vd63SJkqI=;
        b=GVeMDHGYhEKkhgwea0ljz7G3zVqU3QfehzWgTOJglsptcTZ4Y+0huxtMlyAGUYlKrx
         3iSIU90y+RLhiV5qGOyH5VCW10mw/UlesrugTD7P6oneWJq1c7N6pNrcFQ649P+x6Vy5
         rnnSr31hzqeq6X3WwpdRADibmdN8aojQcrrmvrvrwD6M4tgqSnPTGVBsLy5kHdJHT8ZS
         gINv0bZlZcew6iLTR2IP3bYpseFh7WhUAcu6oMR4l1zbKtENoKlAuyZcMh7sZ0qLkvEL
         mhrD+rsKiTc0v3bDaTWRF/BQOWnh9CisbQAQvartDTmyiqqX2AyAZXr7S5UHlvIwnOZE
         kCCA==
X-Gm-Message-State: AOJu0YwZXsR3wZbXEaB/gIkFJHySUxLnGyW9I4zMLv2xd5gtIClqxBAE
	hvvjJSPfS5aqP+FBmtD4MT9wLqFUj7vqxcqT1yUR92wul7F/6r2D2Bl0BAO4C6aX8VDFSZdNfWx
	K0ndw9rlP0suBGRmU7sLjqpTLWWcNvnw=
X-Gm-Gg: Acq92OFSWW4PSllJvow3WYLIClhgohr0X3AjcpCo6yOm8gMsEksJNy1rq9pnL61aaNs
	BWtNWEmITioZgkMKfFC9YIC1Y6oH5QPn24yB+nN6SxrTMl7dUB+OxeqNxb6yNOjviz2AHEw9VtJ
	VvBOgOKUPyqiuyHReXFxazyuB2FJtur2qZbiDMjY1RdWRQVhQi2koZm6mjZ33pkDNFplYI9vwPr
	9SrrNti/uYRNp16NxVI2syoVam2Q38lKEqlulpdKMi35mHy0Yw0FFV5LRDiT0t10VInnaTmTLhV
	w/V4kEvDEfmFgaExnQiEj/ta+h2ubfSTGDVIYby+MrdEVb60vNswLiA8ogPNT+LIIYS1gBflsL4
	jtnQ=
X-Received: by 2002:a05:6830:3812:b0:7e6:e349:539a with SMTP id
 46e09a7af769-7e6e3495b28mr342201a34.21.1780413375980; Tue, 02 Jun 2026
 08:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602090808.87837-1-gitster@pobox.com> <20260602090808.87837-2-gitster@pobox.com>
 <CAP8UFD0ij4BTVTie1dXwTC8M_9gAvroXebFLmQuY7eUCgHrJhA@mail.gmail.com> <xmqqbjdtuidp.fsf@gitster.g>
In-Reply-To: <xmqqbjdtuidp.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 2 Jun 2026 17:16:03 +0200
X-Gm-Features: AVHnY4IYKLxltAxxVGsxhPQUPgMVF20I9i4b4qGhi-w7MLkWTwXPiyt1AXuieAE
Message-ID: <CAP8UFD1Kp_bex9E4t_1Jj9bnKeUn4=fOgEHemGyqJNfWydpEYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] SubmittingPatches: separate typofixes section
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > s/typofies/typofixes/
> >
> > Thanks.
>
> Thanks.  It is amusing to see I cannot say typofixes when I talk
> about them ;-)

I wondered a bit if it was a case of satiric or ironical misspelling,
but it looks like in English the usual words for them are "grammer"
and "speling", like in:

"I am an expert in English grammer and speling." ;-)
