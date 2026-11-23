Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795425818;
	b=HeZ3qftfo+v+JcuU0ARz3NgCeTosjC9SoBgaWHvc2J8QKa2MbQs406ahFmIeJt6C+TQ7
	 1wK8dxgIqzjBj5rUIopr9AfSntkKa+5Tlw+cy5XhD0R5QcxU5thag6Ljbur0bpdH5bfxt
	 qRwDUe+CwPmaT9ZRiKnSLQeKGKA0wTfafyFFHO58oVeWS6opRneLw7VdtKOkq2ob3J+/O
	 4e/gxjgm/6CoXRpgVhRGOHZE6MMH1jZAKLargwRVdQsbB/XiQUZoSY7SeehFSfb+cmyxc
	 2vImQUaeK8Pamo9wS8bGGYGVI7V3EjKbXoWouMIYatsyUQsLxRqUfpEV5gr51IlxoxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=RevUvGG/2pL0Biv5GeHtXUaQs5Sm3HAWPy3OAwtPA2M=;
	b=Cujp2NOTGzdXTDkXTtSKb19aqsFCCJXV/pKFi2UOy2FYJegIWXq7PB22Bg2PKxH0XzOG
	 hknZf7C9+bOFEvh4rnGWdgddECpRxeREWtKKfRfR5tdr9J3CZuK8pmDmJNgWspc/s3M1j
	 PohqT3GrpnjsKNbYMRaN8Gr06KMH/HbfasOwb9gU8dzvY1MzOCDWAStx6mwluJXHQs/qT
	 idm6LaG71MOZVSuCUwbPDpmWKTTP0yKlqeEt5HmlijyTwoyoweEq9Gu8g9i9Ve5Uldt98
	 xOtHhd63P0GHr5H/eOmavE1lYRiWvZ5ywBqy+ONeA+FBL13G9cYCSA217Q6KNAKjUZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R+ekGMTf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B42606A321
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 09:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0B42606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R+ekGMTf
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso3306694d50.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 01:23:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795425817; cv=none;
        d=google.com; s=arc-20260327;
        b=qZ/Bz6PYOWOJhUES7hmLlWjzH5g7bR9WeLWYxaM5iuZoQLPpVdIDkF51cKkYD9ZBIh
         +ZS8kkKKl4oXjKNsEy+ycn6gC/YiQc76H4ZTZObnxpsyxtVgJzYjS1Qw7dLOt0HN9Rqa
         YAvruRjGPQHsP5ZPOKbA8XrG3yelTtaydBoyCyuZj7fBXPWlo4lfRAJbCzTzXWlR/plG
         vuta4gyDFd5eFwgsmgbhKbTnXv9xWb5J7affitH12PndWc8XkKlLMwGJXx0rEd8VbtDH
         aAvIqpm71DnY1v77INXzt0Ovkb+qTLLYTWGuDwhYsVPqQ3F2VP65+9tvPFStC4yqgXcg
         QP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RevUvGG/2pL0Biv5GeHtXUaQs5Sm3HAWPy3OAwtPA2M=;
        fh=u2HXvIO3dn789rE2mqcm4j8Y11yJaHQ3Ds9eIxaXqaU=;
        b=TvYhEIgIYxov/uQDwbU56EiAa9XMO+LPT9NYaNhof7+hrTM+PFOe04qJLRGvhDxoeQ
         ZU1Qu/FtG/zPkbKkOO90jH0qsun0hIyzleM8YpIpKKyJYuCmw+hdlDOnimljxPbOHm06
         4BsOzPb/2fRqLNBz+0IpYc4m4m9prjRi1R4/SA9leeYdtLQpqairaaDVU5gTjbuJrL3n
         vDz1YNfroSB1oYZdo99v+Qw8tiO5VbccqkA7nM4qpo893fdFeSIs9uVnuKAK9bnAhXZ8
         BuMWaEqL2nDCrbHCkSxARv6aCOg0logch3fiWJGsG2Ycmv1DxS3xnhhpW8iB/Wag9D1j
         ct6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795425817; x=1796030617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RevUvGG/2pL0Biv5GeHtXUaQs5Sm3HAWPy3OAwtPA2M=;
        b=R+ekGMTfOJl62kl18rX88Iw5W+vId1yYew1MyE0iB2Cyf6gC9eU3UCRvtoPLgDg5Se
         JuL11e9uRw3fY03W2YTGlPlZ4zszPudc1sxtydjzTar/hYN8kdm467+V4cSbEOgTFP/0
         atQ90IrW7+qUe7nXgXgwusGN4nXYC0Gx9/qtOtIzzJqqcdpfiNWVPpNiqS/+Cqa+zMUA
         AObkb7AWX9nwDKHS3KhpuPNKX/z2lVeHhuJKpOhoXFQ3HBWITGM4At6TyD/fXsv5E5+R
         u2Qmbe/B07BiLGt/odDhyX6SgFwFwHU+u2GQkaDr0MHnHfKAJvM3RgXK/dwc3VBQlNjt
         EC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425817; x=1796030617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RevUvGG/2pL0Biv5GeHtXUaQs5Sm3HAWPy3OAwtPA2M=;
        b=mPMlsARFhD80quDX4gz8dNEb9clcYid33sjEP9PPoviOJcr+EVxdKrqtMs7K8FlAIt
         otNrw+fm7BmnQgnb4eN47opBH2AV3W613hiCKkaKok9UfQSsg1rz6iEoqlsqEtIjkSGW
         POaxo/9cZnjNKxl2lbZUFT2khogrJdWlYHm/1L4vu4FQK2ge3fZoPfRBqOfm1ZGopzcA
         c6aaGS2NB+I1x/gi3qf4TsalWDWVW2RHsS9QuxsCs4sDEVPPt7F33/pbGUZ2FWI1Zzru
         CovXDpAsMpD63Nv4RCiKgk8I2Y3yJaJUxoOgvANCkE4diLHNRE5hH1EVP7D5+bWdt58R
         lyow==
X-Gm-Message-State: APuU4Z8WHKB+0BnLgvApWgobY5U2fPD7C6UOozIfCQHUA8iKPE4QhEKu
	pv4SN8a9qfd9QCDyJn3ETn8qAQ1IaYDHh4DKodCb0htrHF1Pb4R4Ke9XYvttEUw43jedpUf4c8I
	kQF4/d3xcf6LXScamtVCLODmHYiM7uJE=
X-Gm-Gg: AZFdTZezy9pKcoTFlMLaT3B6EGvwJMBRHfdxTr8zoLufZrHH9PipzsUyiprczlERsUW
	63jclI4QRF+f4go1gQyK0u5zSreijsBQabFlgWH9CU8BeKBf+vpibUb+YlzJqkYX06p/tpWm9Kk
	UIDfZhzy/SFclwuQoxdelj6I4ioWIHl6sSLNfG732WOUAUh1Uio7FSeoeqmmrt5xobc4A+ieTnZ
	neEmNLaP7+6YOIi7Phyuzn0FVQesxg54hO9ZCGxNn2aIGWeYjaP4sJtcU6diTtsKWT09PRTaJfR
	3qk4k75B8tsPw+PxwLxReEz+tIrix9ltfxjaoJ8JFCStGyV3kgsDbgRe6ioR5rFEhX+1D6SGaFm
	pyBClcxzBYY45BfqhyQpHy1dWywEuhzmACXnZRWKw31GPltOCpp5kE2x1yXfqAwmaRad7EXa1cG
	5RuWIdILrzEzFRA0mhvz99yGmR4qDrTkv1VVv1GguPtL4uVwYv6nlm36iPTo3FdVMdX7mN8px/q
	yVHURTyjxSzzy7+yPAmlrFcp2TFMGrOWwO6OuuLLQ==
X-Received: by 2002:a05:690e:4886:20b0:67c:f37:1091 with SMTP id
 956f58d0204a3-67df444e7f2mr2758646d50.22.1795425816617; Mon, 23 Nov 2026
 01:23:36 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqq1p8zw49g.fsf@gitster.g> <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261105203344.48513-6-okhuomonajayi54@gmail.com> <avGP6txIm0tK377H@pks.im> <CAFpMFfD_+Dq7-jaeWCXH7CUQyW67fNgGN01n9oU1izppFbE89w@mail.gmail.com>
In-Reply-To: <CAFpMFfD_+Dq7-jaeWCXH7CUQyW67fNgGN01n9oU1izppFbE89w@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 23 Nov 2026 10:23:25 +0100
X-Gm-Features: Aa3M54oiDCqYRZolSjVjv-Pu6lqFG5daFdmJ-HMK54ietvVctF9goH58LtpHxaI
Message-ID: <CAFpMFfDyJ850+vXWaQGN_VfAzD+cVKiKb2n1MV+ZNVrqq2GCEQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH 5/6] notes: pass the repository to the
 combine_notes callbacks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com, gitster@pobox.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

Gentle ping on the scope question above. If it looks fine to you, I'll
send v2 rebased on current master.

Thanks,
Okhuomon


On Fri, Nov 13, 2026 at 12:40=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> Patrick, a quick ping on this series.
>
> I replied to your 1/6 and 5/6 comments  on. The v2 I have
> already renames init_notes() to notes_tree_init(), with the tree first,
> and load_notes_trees() to notes_tree_load(). I left
> USE_THE_REPOSITORY_VARIABLE in notes.c, for the reasons in the 5/6
> reply.
> Let me know if that scope is what you had in mind before I send it.
>
> Thanks,
> Okhuomon
>
> On Mon, Nov 9, 2026 at 10:18=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
>
> > Hmm. I was hoping that at the end of this series we'd also get rid of
> > `USE_THE_REPOSITORY_VARIABLE` in "notes.c". Any reason why you decided
> > to not go all the way?
> >
> > Patrick
