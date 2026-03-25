Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1723A1D02
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461554; cv=pass; b=TW736c0ALZkVUROGC7k9h1Oc+8/ki+eCnVg8iRpHEVQg+c8VtWLs3azlERX8YD35Nxf9Lz50qieW7Ba1c7aem3eHXbTPIDIjBjEsPVa2ph7sovTF62aAchfcLamDG+1CNIGuPiJ4FiROiRuVntaZZ+TjPfj/41TfTLL8ohO+Vak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461554; c=relaxed/simple;
	bh=oCfdOLSALtfnu7ZZVxSRC3Eh8PDUh457UXw/9MRutGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0vQApwEsrg6Cbb/D8H86n5qXplQyzuwwpx4OEzV+YH2gdzH2BVBsG8vxZUagXvygMFTtqFv+BwMPInvGFEotq4gJYkZFBDIvgbXM6dt/NfPY0FMPc1N6OcznaBhdX3qW+rY1kHDgDPfYymnYJB/3pnkc7FWZ1Nn+NXpssvRbjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOjgLuJA; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOjgLuJA"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7986fb839f5so1413377b3.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774461549; cv=none;
        d=google.com; s=arc-20240605;
        b=JPHDzoSLKXYVIgcT7PBHdCgBgSXCRx8guTbH8IUInY4o42uRSoX7pnNtlEgOIdYO/a
         aBwCEQ0rYr79VAxugLV12tnmnjG7EKxnqBnxUctzDSm1g/WRal//1LZc0Y22iWwgsnQZ
         sMitQbipuir8TkkDsDTInR9aeUiwChxddcXfehO+jOpF8Nv4w6McWCQ9e6YqpzV2CQSR
         rcpPe3Qz1iTxajZji0RVgqQlamphlrywt//hQM12E1PMpZ6Nxt3HemacWOCZT2nIMiz4
         oYSx9C1uorRap5Qd4oQlQq2eniycgIAxtRDLNX6jV3dO4gCNUKC4wOdmJHm/V7ZxYFjX
         zDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oCfdOLSALtfnu7ZZVxSRC3Eh8PDUh457UXw/9MRutGU=;
        fh=l8kei/ISnp0G9d8U1WNAwPclTtA4k+mGl+59NZjqY3s=;
        b=avUA3CGuFCh/cRMaYHjsvOiOWB52RokBxQre4JEhdXgaFoU/3AHSaOYdPoxnS8DvBY
         CKzhIY9njkjpYBPf+x8SOqnXIOg91CCyek1fSsGBFR3rF9cBd0aGZ6KYV1um1KP3iDGN
         K1DL6NuYsiOKLhAPFlQr3+JP8OfgPXpeLIY2TSBEhCtg8Hc6OpZOkhMJblhpzHnf4PnP
         5OlOEIVk7fcxutEsJ2dHevU1A+hUcV1ovmWahjVXS3RDF5nrbJhQMzNGEA5EhCJNsZwM
         JRuk7rUr2t4Aalas3uJi7ofxGGnqGjz07bM+Y47Humvj5kXbeAFp/KM8V5yqtkfWWjvW
         YhQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774461549; x=1775066349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oCfdOLSALtfnu7ZZVxSRC3Eh8PDUh457UXw/9MRutGU=;
        b=FOjgLuJAFn5UvkzNTrR93PxXpjAGu7MwK3t99gMEbRw3E6A6nBOwgv7EOfjDRFAsWw
         NCiXRe+JFqIBgntAk+W8fy/8W/GELTUKPC6yaoOyY5SqgLYo8LnFyMu4f+lzUMmNHSc1
         J60cSfjwil8KP65kpBjlxzKG9H0U5b1dKKMGcXS/UgyIzrINk8hR3oaALHEMeDlQDWcW
         HMrl1j7RJSOjUJXmtHb2RIap7bc3emB0RAzgngy3g04pveDE79EPLPP0v4Ub6oSxoWwR
         qPe805Yo2EEz8nzJ1szvf0Li0NWWarqd0Xshzo8p1jtVuhnPcHhLHl1B4wi/JZzh3of2
         hEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774461549; x=1775066349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCfdOLSALtfnu7ZZVxSRC3Eh8PDUh457UXw/9MRutGU=;
        b=ZkbenYwycPah0RYupH9xeH6KURDxiZPcO49DM5XgLEJgLoxNkx3CUxkmMmbE5/cqUb
         TpTFp/10FXnoN0OhT6upYz3ElEUSXGECkVT7pVX+Wwq7dBfsNE81WGH7/M4dqZD9HgSl
         sDW4gsGaUYmNmuAvlAplN2A01DIhjAvV5WaBeuNGPv9OyzEE3N/kD9Np7zkGYmbNx/wF
         I5fOaG2uCQyANkbbh/4TJPiyOcb3ou48WGRDZ+/GTaiwA1m15u3Rbiksn4rdFTrJuHFB
         egG0AyDZOSjOMr7xj95TE8u4sgMUgzG2lEyKrOQ0SyGdxH+yiX+o0ATtzL1iPsPSRq15
         G6ag==
X-Forwarded-Encrypted: i=1; AJvYcCXmoNhY1ebEhY4ji3OaAzNwjo6t7NIWOe0Q2kZO1wyyEL3gXNen9khgzKj4D9Ie1iR0cnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSn0b2wIgpXQpXo9tQFkA4aD+5Z3vWvYEq1Nt991ADMYd+EOJ
	q1LcAWrkG39qu0KnBU2HYtPtpI4A9ksBpGJ/0n33oOuMlxXKZgGO7MlJ6rJr/HNLap5FeBX0cad
	9euhc5ycBJR5uXVtC5Mnm3ZeVlRH8bHo=
X-Gm-Gg: ATEYQzzJs+7OZE6D8mEKJt+/T29862QI9EmOz8KRfPLYqljUA56LqLZ+hXt9IzNnvM9
	N2gCpJWVlqRV9oP3HNIZpr6Ntv7duTAba8opMED3srvercA5bpUDdstHUKDQuE3oYHL//WndJ0x
	b4dNCRiY0iIVT1kWigwQyuHClta/HbHEi0gfVMJAJqvzy17zLma/HkSO3yRWEOI6mAegz8rBh5d
	I0b/vUoUkZn3zIFRB4qcDoZC+JlvTVsdF0dnEhy0YDp7jcuQ5PG2NSqGCBzGDR6tkjVh5IubeSZ
	BmR96PPylqVHXtVtzud4XiKjlbkIi/aSPiWobifGYkICZIWnPWAQ2FwqGyePvQxvZNLQIDXrHg4
	4ZgR8iAkHJoiROO6WwF22hrg=
X-Received: by 2002:a05:690c:9988:b0:79a:c7f8:d98c with SMTP id
 00721157ae682-79acf614bccmr48702477b3.38.1774461549113; Wed, 25 Mar 2026
 10:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com> <fae2f8e3-029a-43c7-aa6e-45a452026853@kdbg.org>
 <CAN5EUNTXy+cFyHApdrhGKUqrvBGO0bb9X-=MaAWgp4DWOAkA-A@mail.gmail.com> <251cbdd8-26ca-4569-9801-5eb278de7e0c@kdbg.org>
In-Reply-To: <251cbdd8-26ca-4569-9801-5eb278de7e0c@kdbg.org>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 25 Mar 2026 18:58:52 +0100
X-Gm-Features: AQROBzDMs2sLk0DkmF7ro_mQfb94yO4sj3aiw1ysEH7aIevM6_cQDK0UZL9rmb8
Message-ID: <CAN5EUNQdq7Eg+yd9ZqVGbYuKSYOhAB5rc2np7SeQT-Zc10aqDw@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 0/3] graph: add --graph-lane-limit option
To: Johannes Sixt <j6t@kdbg.org>
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Johannes Sixt (<j6t@kdbg.org>) writes:
>
> Am 25.03.26 um 13:28 schrieb Pablo:
> > Johannes Sixt (<j6t@kdbg.org>) writes:
> >> Let me suggest a different separation.
> >
> > I'll merge 1st and 2nd patch together into a single one, adding the option
> > together with the actual logic that does it. This fixes what SZEDER said about
> > the first patch alone breaking the build.
> >
> > And the documentation + tests on a separate commit.
>
> It is better to add documentation and tests in the same commit that add
> the feature, because both serve as a specification what the code is
> supposed to do. This way reviewers can decide whether the code does
> indeed work as designed. On top of that, when the code has to be
> inspected later, the commit that introduced the code shows immediately
> whether a certain behavior was intentional or not.
>
> So, you would end up with a single patch.
>
> But to make reviewing easier, I proposed a different split:
>
> >> 1. The first patch limits the graph width with a hard-coded limit, say
> >> 15 lanes. It limits the graph *always*. Choose a limit that is large
> >> enough to pass all tests.
>
> This change will touch the graphing engine, but almost nothing else.
>
> >> 2. The next patch adds --graph-lane-limit and its documentation. Let it
> >> do its thing. Revert to the default limit value 0, i.e., unlimited.
>
> This change now introduces all the plumbing that passes the user's
> option through to the engine.
>
> >> 3. Next, add additional eye-candy. I am alluding to the line that marks
> >> where a graph lane was truncated.
>
> If possible, this change provides final touches that can reasonably be
> left out from the first patch without compromising its basic functionality.
>
> >> (4. If more detailed document is warranted, e.g., an example chart, do
> >> this as a separate patch that can now show all bells and whistles that
> >> the earlier commits have implemented. Whether this makes sense as a
> >> separate step, or whether documentation grows with the earlier patches,
> >> is a judgement call.)
>
> This could be a new paragraph in the manuals with example charts if
> doing so makes sense.

Ok, I'll do that to make it better for reviewing, thanks. I've just
sent the v5 at the same
time with this morning's feedback so it has the 2 patch split I talked
about but I'll
do a v6 following this.

>
> -- Hannes
>

Thanks for explaining everything, the patience and the feedback.
Pablo
