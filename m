Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA334753B
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374043; cv=pass; b=lJ5gCH6tzsv9s6X7jhhBm7qW9GaVtGkRYp0CbTEQ4stBjhqV01siDNR4PgAvzXmlQnfzVnDNvvQe/c+wvD9Pkkbz1/lOxPxoeRKyOPhckUs20loRr5gPODlrWuGwBQg8v7wmgzsuBwDOxauFCZ4A9P7o/P6I3GOGsLfPuPQeIjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374043; c=relaxed/simple;
	bh=EenndFdLnMcE5UzWWX33lS5Wg/xT8cVg9oCecwfxilw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCb1PWF1XVt6wqWJwvWHMOJEqU7VFDKLZVGUNEhK1t3TgyZgtRGW5WdFXmm+ub0S4TBqC2MsLtizOoZnRMtKHn01wM0a031/MiB0LE+aLSEXDxTv8kFXZakgiUXoKJeJykwCOw19xbYU17TMEhJS4OOAqw1X2ad11/AoDqeSero=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8cBYNjQ; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8cBYNjQ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso365804866b.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 00:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782374040; cv=none;
        d=google.com; s=arc-20260327;
        b=L91fnRxDjVQ9Ib88X9X3Gg6beViAEH6hFasjVq8uRTNWusMLfQDtIUjaHCE+pSGVUm
         kUthPzmiR7SiIMG7P0H+Wwb/0Yw8k8+9xIeGjrHZhFCuypNm+RmJFdf8f8UuGAv0JZrC
         aTphM+S951tJQ9FyBgnGf9VqrmN79iY+WZkELXsw7lmWg9Av70scVB3koOtoudURLSFb
         MusU1tWU2iOg9B6Wsn4XViwdsrlTzl7EoSyWslMaof/VCldTqM70A1MZBOGsfoJXFden
         I3SoovU7/FybWtr8oE0MlQnI7yvIyne/4mc6FcC2wEsMziv0cUizLQ7jgpW32LRjUeng
         LYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JqVyDOmEdwSchjpX7Di7P9xE6qx7kl83IHXueEbcjhE=;
        fh=D15T3uaBSDjeJv8Pten/DR3SKAD2QA4U95Iz9m3Q21U=;
        b=mGUkEbtOyID5KE8rt01lCUcCC6zXoKkshSUcWIKDxDkvMBIuasJleVBElxHdTa1c0o
         lqjZIdBEItAiapfjyATZf+DxN+GFk51D8B27r1SqmtV3rHFx7LFfXSDsbrg1S1AWa6Gy
         k/XR7GVSSQmOZMANeBt92HQsjqYoE/CQFOr8g0sITb79N9vbFTgxspo7D4yjyuCEYRvD
         /+9jbBIyXSZPsKMISFw9kZ4CmPOm7Qp8ozbCbWQyimUwaNds7kWvabw0pIYaNs/Na9O2
         ao5E4qv1vjBXlFBKmGNxUhtD/iDY1UP3aXJSisRS4bmQOy7HiEl/3u8lWjqNRzrGkvKl
         fQMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782374040; x=1782978840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JqVyDOmEdwSchjpX7Di7P9xE6qx7kl83IHXueEbcjhE=;
        b=j8cBYNjQUPQWG6S0x+1bbO86lyRRfxCUB/TzvVpuZmNAtdoMf7NNHfFCgiCsEN8OK4
         qWd7OEYE/2qijEw94tpZlLZMMtQ1PUA0cNe838cIL9lcVK1pqzJ4pYcfsbtUTZSP0OVA
         986p68LZtbmgpLL2Dy87x9Vajjnb20HTrMnjWTsgGaoD8BurEf5lj4KsKpmNnsj/ZFVe
         At7n9Nt/0aS9Rq3iFWKQ+sJuzNIBQ0sTZJtX1xj+h8vdTyv/5sRTlXlKGTUL+m+8/crC
         vyTdsl7DQakSn/mzFFRKlDfZAGFP3SFFQvUJOt6pNN2uIm8p4Wd0r2NcdDDVmfzwg5wu
         vwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782374040; x=1782978840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqVyDOmEdwSchjpX7Di7P9xE6qx7kl83IHXueEbcjhE=;
        b=JvnkBayPGTPV1zwS6YO3tspIF4vdn+ALub6Ee5XoYgvBfZa4/vkMm4gi6tI9x8UR4T
         7sn3//21+PJM0etV0l/6Zjd0IkPNPp4qGn7aowcNBaea6qbdUp/VvQ7MZX7lv9YV/sBl
         eHmg4Z6KnWgmzOF/eYhM4xTFmwfRyYPPau/CU1dDLdaeJMAht56LuC3PY281aCCaBcEK
         RU2XUwvNhnSi6O+/Z0pK6KvUwT6W/dYtNZbkNqd+19LsySQ73TB4eXMthTWiJAazkm93
         al97P70TTfESvVgRd0EJ0UrGzc7QR/Rm0K102CT54R5gBqPaB3QsymbjAV/YuADOsQb7
         y7bw==
X-Forwarded-Encrypted: i=1; AHgh+RpV9nQbiBmS7xPJ1vFkTYK5jKl4vWhOAe9TX2T0lckLuXOCGVfa/GITSheGhh+OcgaCyhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2x2ehxDdf+MrmL9uIO1wbT36GTSQXg6QN+K3Dv00/MtcIyG+q
	M2x0JcU0pFhZIJn+JUuMkTp3oLgWn8raNqwapBYYCyjZmP/xTPLaNhjzsIpvik/9bkl2P7pFTlv
	LfY0ECx+gVcOo64+CTq4XL7MWQ75rcx4bzw==
X-Gm-Gg: AfdE7ckY4P3ti6bGKpr1o8p8TtIJxMaEo1m5l5BJ89lPzjcq5UiifTIYflRkw2Ny85h
	a7/tOZlTjuxvljQh4Cs0rGHl3yoSnbp7X9rPcuFbl/kGJDWT+SfRgLYjqSaMb0bHDqLBP5C+st9
	ARRqCisRYZSk3tczY+oUeZ4pyks80f1bdYpvh3s79Etr9rThB7epo9UFFpAK5sY9n0KBE8sTb2e
	oO8mI8fmgoI7oGF1elhOUDCdUom86kS+FR/kvYLHuFWg3YxV7pzbjqRY4ISozcVD8f30LZE
X-Received: by 2002:a17:907:1c93:b0:c11:f6cb:159f with SMTP id
 a640c23a62f3a-c120618b3cbmr84709566b.39.1782374040248; Thu, 25 Jun 2026
 00:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
 <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com> <49de5a925de506ed9a141eb72927b2548b73af22.1782338114.git.gitgitgadget@gmail.com>
 <xmqqa4sjh85o.fsf@gitster.g> <xmqq1pdvgukt.fsf@gitster.g>
In-Reply-To: <xmqq1pdvgukt.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 25 Jun 2026 09:53:22 +0200
X-Gm-Features: AVVi8Cfy_Q-sXomANnypFSOpJj36JdYxIBIFelW1wEMsOeZdOQFzsvIYvse7s70
Message-ID: <CAHwyqnWaY9bHX1ZvuMTDMGGBG8f+_tbhcPycOYbWAcW23ZAoPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] push: suggest <remote> <branch> for a slash slip
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
> >> index 80b06a0cd2..cfb294305d 100755
> >> --- a/t/t5529-push-errors.sh
> >> +++ b/t/t5529-push-errors.sh
> >> @@ -54,6 +54,37 @@ test_expect_success 'detect empty remote with targeted refspec' '
> >>      grep "fatal: bad repository ${SQ}${SQ}" stderr
> >>  '
> > t5529-push-errors.sh:59: error: bare grep outside pipeline (use test_grep)
> > t5529-push-errors.sh:60: error: bare grep outside pipeline (use test_grep)
> > t5529-push-errors.sh:62: error: bare grep outside pipeline (use test_grep)
> > t5529-push-errors.sh:67: error: bare grep outside pipeline (use test_grep)
> > t5529-push-errors.sh:72: error: bare grep outside pipeline (use test_grep)
> > t5529-push-errors.sh:77: error: bare grep outside pipeline (use test_grep)
> > t5529-push-errors.sh:84: error: bare grep outside pipeline (use test_grep)
>
> I've queued this squashable? fix on top of the branch before merging
> the result to 'seen' for tonight's push-out.
>
> Thanks.

Thank you!

Is someone working on fixing the GitHub CI? I used to rely on it
before, it would have caught this, and now I'm relying on "if less
than five GitHub CI tests are failing (with the 4GB warning) and tests
are passing locally, then I can submit" which is admittedly not a good
heuristic.


Harald
