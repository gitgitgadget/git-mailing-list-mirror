Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91C480954
	for <git@vger.kernel.org>; Mon, 18 May 2026 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123367; cv=pass; b=ZVx1n0rwulbdCOJHMBRxnf54/6T5iAu2/JqHq/BBR3C9e1rchbwXr/ws5GKHvQ2rbPKEKa7U4EHfuDf5yVH4qBMR8si8SWBaysyF8RIS/2vNeWSYXGQkH+6dAcRkr2KHSdD80Bafs4ru+sCsxN7zcAmtPBjgwlZtx//WWhq7z5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123367; c=relaxed/simple;
	bh=sKty2tY8oHONoscw56KwHx4R8cpTDrjHmZGqWNf+aKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTb38NsYHhLqpcOvABitBmWMQx4sG97S39EDsJbCrdKZoTyGvcaf96uV7DjAAQTwn9hNX+GLLFlVvWJFKgeSGV8MykyJFbi62ywJIIs/0iteODHgcKGA+B9bZPQEVIvUN4R6t4V7sZDHo36waMTJ9l1R6x6PBJIj8Br88ArNyeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEZfYKRM; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEZfYKRM"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6967fd0416bso1211337eaf.3
        for <git@vger.kernel.org>; Mon, 18 May 2026 09:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779123365; cv=none;
        d=google.com; s=arc-20240605;
        b=VquuIa9ASDR4nbTrHUVGa8fPtyRs58BgsfiS4n0BzRmqJ6aKC783WAR0ik9rYtWctq
         JnspBUe0Cyq/7LqrrVMAKCfso5GBw8JGl0PfAqMH1JoqUdQbfL0wN8xP6CjBBG9QeQUB
         Bnk6gEgY6EgIhef8QB3fSTrAU4EeMq6KO1pa6mf4e6apDNdRJVksQJK1uL/0vWHn2p41
         SntECq49vpxtG7rNXcG3bV4dY9NKfdY1OwZqj4BI5TBCJKPFMrwmBGlsYETvmuqcm1O3
         zLSQO+fc7I9i6ZeDzm0NTRP5O4ni4F2c1vDyz3dPK7VyGLUcuUAb1rgeQpjjxPX/ee5K
         ryHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r4889o2HDoaGZlfmMHUmY2HuhB2YOVp3MxSuwwSe5Yg=;
        fh=9snjc/vMWC+PH/sYyD86R237NGOL7qflxtLhG6PfM7c=;
        b=JKWr22ylPtE/Cje3Mk9MG+/iSpCgaWqCHJSCm1OeabAmLkwS4fFEW20luchzT/7wPk
         bqL+5DNmEdxWUfi/NIzH01ngdQ0BIq5KRtfGaMWjIlamtxbJHy9v6MgSj88sIccquBjb
         GLASGEXD8OfK6loPOOUXPlvnzKNe78k6ea4lJp6gI2kM3pvvfqa5cVTIYVtPBSBe2Dxl
         JuQTPSKh25Lt+zKaZWuCZYTqkOvTI0kfElkEoTE0Tz/P78WRebyxCpuR/ixXVy0jDwEg
         jpJajWRZbraj4qBg7ZXg7bGcYm0kocFTRCpf/cmBzaTILHhBAivGhWAWd5cU4RYCnb70
         K7+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123365; x=1779728165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4889o2HDoaGZlfmMHUmY2HuhB2YOVp3MxSuwwSe5Yg=;
        b=oEZfYKRM+7/UsvCAvyCwH/zRCSmawp1UebMYlumGXp+b9eAg+SrtGg+2ilQQDvF4xb
         ITD1WtaBWkl0DEsXsqaL852lxkuTKTeOYy63wxCA3lRVEKXv1Flg2ROH9eyB7c2bKGPT
         3iAugLu3777f9sDncuzyw0/HXP+6NS80zQz0M0nwoCwgt1sNX7S/G5BoCp0fTbvD172s
         HD6kQNVLlxA5I3CH64KcEIwC+HtJ8/MCYvcfh0GyRS8eU9c8oh9cUQSdgDjagFYkAmxq
         xrLs/j8RuUatFSPVJH8Xz/2ujWkjdPDx0xiJabKIauyMGWvZTd0sn74BPL1CSI4qO/cS
         M1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123365; x=1779728165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4889o2HDoaGZlfmMHUmY2HuhB2YOVp3MxSuwwSe5Yg=;
        b=BP1ZdmAjY6izFp2lsDWmTSeB5ExcmiJj0chZJ3HiK4EaLy7TluRvoMMiMN89z/w9ZQ
         m1LfEHMfXXIQnn95KkFCOw4af6iA0exOnvG2NbS3trLn1088MkPoNnBpabaVdCCaObZN
         RU/IjSj8Ma5toAJdnqzu7l5lDRPkIbiFyfu9loh4yEpmuRXHUsDtlq+n7Ryvn12yserp
         QvIJR9j0LHt83rfhv6m5+so2cV9Ym5moQXCywsGnzFt54Bc2diQtUeD/xttxoC9zWuxL
         /XxDQK5MXXewwvV0UBgbV1QW8v6D9FuJZoyyW9sW+v0tdtSlfO/hfyaq42NUeny6yAfl
         2T0g==
X-Forwarded-Encrypted: i=1; AFNElJ+QxGYym4BdPQPOWW5Q3kshAPl7Az6UVUJZhAxo23i+v5W+0/FhGVj2RfA/2949OIY2MT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+CrPCUFFDttZ1K+Ca5gDL6Bmr40C6tjHwRZcubtpbOH22TTw
	Ss8xa1eFNroKvqaD3pCuVtVdypntYqC0n66RJMpEPlutiLlFpMNWysavjp/bcFcReEWYN5pMxJ/
	RUruYZPXFe5bXTEehR4QKD0jWaC95UpBkRf46
X-Gm-Gg: Acq92OGI5KvySpu7mcp9jqwBvKGpmvUWetVQxwvl3rCbkf/cRhBN3bCGfwjOBw9f5Rm
	YzYd0g6fGqhDuFRw5OrvxIUj2dKjmw2PzVDJwa/bQGscjRdz6S/17oSj2KZEwfhsBUnzWVptauN
	eVyefnD+MdmG2fMFQJQbiNJbX5ysgDPeCH8d6CtHHB5Z79egehXJ61qqw2jmB18KmiqZkEhChXu
	y2hgaSVUFiVcSerZDRKE1/lRrndKPuadE7zA2W2iLZZ+IUUIVxMt1XRBInUYrKx+7oqXEGCPRxC
	B+EtIOMdIExh+PLVDLNYtmNj/J+OMzP9PD61hrkXXsMV0wVc/TIp7XFIrLPTJau6ti8KERZ5BZs
	mo7WWtfArWRVdXyXLDthU7VeFOtJVW8uL7QxhQZzgIpkY
X-Received: by 2002:a05:6820:616:b0:696:72c4:5dad with SMTP id
 006d021491bc7-69c94292336mr10051416eaf.11.1779123365494; Mon, 18 May 2026
 09:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
 <pull.2089.v3.git.1778775928.gitgitgadget@gmail.com> <0da4f159-8d4b-49e2-93c1-25aa0bf69371@gmail.com>
In-Reply-To: <0da4f159-8d4b-49e2-93c1-25aa0bf69371@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 18 May 2026 09:55:53 -0700
X-Gm-Features: AVHnY4KhC__vbXKE8PxSLZ9lTYNthZJt_eXFoJ0dwa5BfGaGifwX_cb9bCx94w8
Message-ID: <CABPp-BHzVW9zf6kzfrpcWBny3bW_J0KhkVkg5+RYiQ8ymv+OdA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Batch prefetching
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 5:17=E2=80=AFAM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 5/14/2026 12:25 PM, Elijah Newren via GitGitGadget wrote:
> > Changes since v2:
> >
> >  * Modified the final patch as suggested by Stolee to include pathspec =
usage
> >    in the testcase
> >  * Modified the last two patches to not re-download blobs we already ha=
ve
> >    locally, and adjusted the tests to verify
> >  * Inserted a new first patch, containing a documentation addition that
> >    would have helped me avoid making the above mistake in the first pla=
ce.
>
> Thank you for these changes. I reviewed the updates and documentation and
> think this version is good to go.

As always, thanks for reviewing!  Your comments on patch 3 in
particular led me to what would have been a rather annoying bug, so
thanks for calling out an improvement to the testcase that alerted me
to that issue.

> > Note: Stolee also suggest some code sharing or code movement in his rev=
iew
> > of v2 2/3, but possibly based on a misunderstanding of v2 2/3 (that pat=
ch
> > isn't about a diff) and it's not clear to me what could be shared or mo=
ved,
> > so that's not part of this round.
>
> Your detailed responses in the v2 thread helped me understand that my tho=
ught
> was misguided. Thanks for giving me extra confidence in your approach her=
e.

I can totally see where the comments came from; they did seem logical
on the surface.  I knew the changes were cherry-specific in a few
ways, but trying to figure out how to explain that and dig further
into the details to find a good angle (and try to make sure I wasn't
just missing something about how part of the logic could be shared)
took a bunch of additional time, so I'm happy to hear that others
consider it enlightening.  That makes it time well spent.
