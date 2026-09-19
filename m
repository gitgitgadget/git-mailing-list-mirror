Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B992C0F7F
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789832837; cv=pass; b=EDPWW+OwBf2QKFWjwWSXQ3SPjkD21tEX4Gh+wEY35gvr1NnpT3Gatcb9Q0WzPR6hbKF0sblEVRxpmjX9HYg0r84ZEf5W0NMyEfPB3sZOwGK2quYInGrxfpgydrPVDE34LKfHEM5NhsHsFs8kvkcQCKP8NdIfVfs9AUvE96R1FYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789832837; c=relaxed/simple;
	bh=ncnAtC9Pdkf9ifce+w58ZMaSzFttHkn1xUy4+XHoQw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=r0VCedr6Nj8d3KGuDeHyhIOXyseIW6N77EXw3ZbAh0CP50+AS0LNK2G2jWBoJmPLqwDyeOBBHk7ha/R50wgYTZuIuejY93YHFPHVxhvNUUpf7/kZ73xRBLr2AyUMuUHncyeHt4alFBn0zeWgI+3nDf0Zlz4UKRPnJUa+7rpfUNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krDWjOnf; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krDWjOnf"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aa8e6bbso778158d50.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 08:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789832835; cv=none;
        d=google.com; s=arc-20260327;
        b=Rl4Yl4iBg7k9Zo1hJQfqwOjNR4mP/fhaqPNblbqMIQRgC/jx/xag7C6rm0Bd8hHMx2
         d5QzwGsAqLH2rXWmQzDFbc4W1bLMhw2jSHlzr6F0GbnRhdDEW21AcV5lZVO3Vv+hbGGR
         Kd5g+BZR9cUTP5a/OE3I/aLWI7ZKcw7G3q4iEzCZM5DO0VnHwNq8Dc1CNS2n3c7ZbiEJ
         QILUSzNNvSxSOrU2LgbSyyCySiLAZTxOitcs4ZO7K/l5tQGOP5m3hX/654vWIwYVC3/3
         DZ6Bz344Zzm0awS30ofLoYaVNPN7z4mW1BeT3BmaZDnB82/GU5kmxeBEe4rvzI3USDKj
         a99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZL0Jt1cqdyrvCy4hhUem1nc8m/9j23c0Ux3yvqARNSg=;
        fh=cvUhpxe0YRxrF82OW1Z1oQdGWYc6TftNXHv2b/6vCoI=;
        b=JAcWTCp+4NvRJk+ykg5A7OpHZTBY2KfTIln/LfE0fZM3lrsjoWXRheCZnJ6tPo9qao
         TzjGX+IA9xTEL3Idb+kK39Kwp1/oJpfPwCCf3PkLYYiJ0fjbeFs2U2p6K4f3eE3Z8wBC
         34rwAue1tbwX+ikkP024J0hVKwxjXN9GEDftCNZNnbz/ufjyW+iAdB/HZDQkkFVvGa04
         ygVenvnhUDnN5wyc3u5y65jYwNoPIjoRqvlEBB1QqihFivQmmWsueR7KDVQVbqCZJaeY
         CYgktz+1peCodh9sxq+n/L+jxq2Yl5Jo2M5FRQ1PSjN3c0SErGjqUntgSCsyPaCJ3VPb
         /G0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789832835; x=1790437635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZL0Jt1cqdyrvCy4hhUem1nc8m/9j23c0Ux3yvqARNSg=;
        b=krDWjOnfeVfPFB72bvN82CNkOFvnecm31bXHwsgdGSlNOOx3GQ1bvqOAceBOk7X7a3
         UFzph+Xpdi8qIFvekrWDOc5RuB0QJhPHcqrz9+WZyYo//9hzZc8Fg7jz0sikrJiDdRhL
         X/FBcKKgK3SGNexDJUj1nG6oCpixzlIzfn8kvzfnFXZ1usciVC6N6YJmF8Q4iwBsWHU2
         pHulqZ4+O8Hv2+UOCDdfYqYk67rm+YIqpmc5umMez0qVEnbRjHBptQTLXPngTRpbJBeQ
         +1bCxXisUIuqvm9wlL7BAuCDWbfZRetQAjaqdEVAoLQYspBTX5y4S6WRl0No43pjFLmh
         2Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789832835; x=1790437635;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZL0Jt1cqdyrvCy4hhUem1nc8m/9j23c0Ux3yvqARNSg=;
        b=esbmyydPOlsquayil+9b5ADe8ahb2FKoBl0E8fEFpTciC28YJFM9Njsi56VveAKleN
         ojo238dDFVYwPYVcNHyHsNV7RZyqZ5SXkyM6ln9/v2/SYHh0HaihLy0R5m9DNDqPhjgI
         B+9939aVJMRQ5v59FMu4CmminCzLROW0C+VLRv3muN1JIU02EGmCpjAL9r//QJ/Dg2EI
         j3rJZJQrFm65b4+ofylE8DotPMSM/5YN+w0dLqTC7bGRz2Dd54LOBYb/9UTKMh565GIa
         SOMLnsTXPKL76sNN2UbiGz8YCTqelfqwuySvc7FpxzKWPyCFUnb3TCb37zqR5SkMc1KD
         ULWA==
X-Forwarded-Encrypted: i=1; AKwUvBxWMEbfCObJuHDymA+rqLTBNRCEn6k9I4VOykDaBbJaTLTPQ/eUT5PuvOPlcjRoNm6Bo4c=@vger.kernel.org
X-Gm-Message-State: AFuF++n8Dc376CjNGUU2Zdy4l8QpeB+UwwJKdAdNLg8yiobgu9E4I+Wk
	3ILW+V4Q1ZpSUSMTjw/vu6N4cmYZiLfDq5NrMeLv2MBBwwWN05Lpm4ZIHtWF/gYkvg7b3Mhp6mD
	zaEKw+t77nTxNEp/Db4Ru4t8sWV3CcroZql9L6uhmuw==
X-Gm-Gg: AYBFou0KL+5jRFzVeVQtEEGA1zbKbNJcclP0mFCkdirfs+WfWVCHuCa6zFIiwx1QLfn
	Vlk9yN0MccLxNNFnuSlvfb29a76E6uYf/T433It0RR7q1uuEe/ToGPmoVRl1268xnroGzOme7sS
	aOmOyBLFy4ZtiNz+KfbzuZj86/3L6j98/bdwHlisYOX47SFri4aVgAL6P5Njd6rRUBEatYyv5kJ
	NIq9ZkKOSmf6697dYYznIRVQ5Eb9uPKUJEX15EYCfiPu6pNeQiFP5pQx7JVTicXNGqGSnvoGbpG
	xKjg7PTy7pCkD3YR1PPLVW22SK16ZLewRcNMpXyf7cB4n4FTnQOrJ3bXL5D7ntILhMGhtfF/zaI
	lzA5H8lTzS8T4ec8=
X-Received: by 2002:a05:690e:450b:10b0:671:484e:5686 with SMTP id
 956f58d0204a3-6717fe10f5cmr1191785d50.20.1789832834854; Sat, 19 Sep 2026
 08:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2226.git.1789826665188.gitgitgadget@gmail.com> <aq6j2yg16L2iNHoR@fruit.crustytoothpaste.net>
In-Reply-To: <aq6j2yg16L2iNHoR@fruit.crustytoothpaste.net>
From: Yashwanth Sai <ysaimuppineni789@gmail.com>
Date: Sat, 19 Sep 2026 21:16:37 +0530
X-Gm-Features: AcwNN1UTIildcbPv39TOmV-15cfdVOS1D3xRXuhAn13LmymtzoHwHGjmQ48AUN4
Message-ID: <CABykktEd-rn04SeFQqqpnB0npDaSxVLx5vQ1f9LmJGJpVckv6w@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: warn when a new commit is dated before its parent
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Yashwanth Sai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Yashwanth Sai <ysaimuppineni789@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for looking at it, and for the pointer.

You're right. I hadn't read the AI section of SubmittingPatches before
sending, and I should have. The patch was written with AI assistance to
the extent that I can't honestly claim it as my own work under the DCO,
so I'm withdrawing it. I've closed the pull request.

Sorry for the noise. If I come back to this, I'll write it myself.


On Sat, Sep 19, 2026 at 8:32=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-09-19 at 14:04:25, Yashwanth Sai via GitGitGadget wrote:
> > From: Yashwanth Sai <ysaimuppineni789@gmail.com>
> >
> > Git writes whatever the clock says into the commit object and validates
> > nothing: a commit dated years in the future, or earlier than its own
> > parent, is accepted silently. "git fsck --strict" does not object eithe=
r,
> > since fsck's badDate and badDateOverflow checks are purely syntactic.
> >
> > That would be harmless if history traversal did not assume commit dates
> > are non-decreasing, but it does. "git log --since" stops walking at the
> > first commit older than the cutoff, so a single out-of-order date hides
> > every commit behind it:
> >
> >       $ git log --pretty=3D'%cd %s' --date=3Dshort
> >       2026-09-25 C3 - inside the window
> >       2026-09-01 C2 - outside the window
> >       2026-09-20 C1 - inside the window
> >
> >       $ git log --pretty=3D'%cd %s' --date=3Dshort --since=3D2026-09-13
> >       2026-09-25 C3 - inside the window
> >
> > C1 is inside the window and silently missing. This is understood --
> > 96697781e0 (revision: add "--since-as-filter" option, 2022-07-19) added
> > an opt-in traversal mode for it -- but nothing tells the person whose
> > clock caused it, at the moment they could still fix it cheaply.
> >
> > Warn at commit time when the new commit's date precedes a parent's, gat=
ed
> > on a new advice.clockSkew setting. Warning rather than refusing is
> > deliberate: only the committer can tell whether their clock or the
> > parent's is the wrong one. Once the commit is published the date is par=
t
> > of its object name, and correcting it means rewriting every descendant,
> > so the warning is worth little later and quite a lot now.
>
> I think such a change is useful and it certainly has been discussed on
> the list quite a bit.
>
> > Co-authored-by: Claude Opus 5 (1M context) <noreply@anthropic.com>
>
> I don't think this is allowed by the `ai` section of
> `Documentation/SubmittingPatches`. I wouldn't be opposed to seeing such
> a patch if it were not produced in any way by AI, though.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA



--=20
Yours Sincerely,
M Yashwanth Sai
9491363067
