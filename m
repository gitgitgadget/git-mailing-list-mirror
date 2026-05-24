Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16415A864
	for <git@vger.kernel.org>; Sun, 24 May 2026 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779645703; cv=pass; b=kvpd2/sfmrWtF8wNk0acqA2BSWwrpCTBxALPod2wMf0ZCWXeNTO92qsPfPtjpaYy70fVO2HoS7McfuNL7ikjMyE5cnzNTtReWmibdhmffrl1ucsedCYJc0P9h6ZDQPfi6k1YL+D+jJm3ZJFTHR8GXoI+nmhRXqTt0VgC+eZGsbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779645703; c=relaxed/simple;
	bh=DrhOUrQw8bM6zorvWXs/dSBviuIoEjKzVUGlXHahUdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRZYZlEZ6pzS1s/hdirFXkZSttCmB3EiMb5j2HoBNk2+eF6H6dq3NBo0GKGhYZ+6i77T0JDfyPuMjyp9EQ8tkK4aDV7ey1AuTP01XorFRc5AMm4JSA+JCaeCzsmYwCPTPHQ4w6oqXEW8ijcij6MYHHpEE2Aq4Vi0uAUD3YCJ2eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwNJ48Vy; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwNJ48Vy"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e61b59e03eso1052701a34.2
        for <git@vger.kernel.org>; Sun, 24 May 2026 11:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779645701; cv=none;
        d=google.com; s=arc-20240605;
        b=PojNyWS0/8gdBWgl3V7n1IhKsVk61ZiARuiTLuYdsIrItCtHjBR6G7DanUUOCESjOt
         63NuDw2h1wdJsWmSQe9N9KKy1w34NfMVhbtiU+IB6UodHOX1g5atTJGce+IEpExiPvj8
         Glqf1b2tEi5oe0LSCL5OcyxppQws5TZQQ8k/lJf/3RNRV2Zm4pTDVQM4BExtTUjn22iO
         P5q4Xulcy8WxWKyOLViWs8U4htWxRHmI7hBsW7E/zhAoCvQ4Yz9YJL5JHcQcWI8pXPOh
         X7dImnA5PWl4+CMdkiCnnE608zYt3ZGcggi4ON9F5d+F2vCjUjtKaz2K12maafaZnlx4
         B5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gqnlGS/b6eue7jS0GGU7RuSmhW8y+tSx532G8seHTMo=;
        fh=6khFuHNBSq4WRUFoOfI6zGQl3315QHcT2QA3Djl9EBU=;
        b=M9t9g26/cli/Gm4LWqXH3uN0EdbAOJDx+MRBbsMSpndJsXgUQVpKaHjZMdgFeZ2LCU
         nGdFe1bLiCJeqtKFlO5hZYtAlZ0pKIh5ppLkV7nMuDf2Ci5IXQNqaH8uoopaiPDOE//5
         HS/9IBd0Jf3CXDcs+8LcS9kwfpYoxkXl3cJczmVIIV3o2Fzg16vc1wR2d6g1qH6fMnDG
         cQ5Z4tV8TA55hUHTyGAAPs0S0EAsKc7HXBE/bK6kzP10MFYLLL9qhqBOhuJYsjvYlPMF
         jeUdV/Gqt6JNbLB0gLHJxMmzqdzUA9feuVS573jRwpctBHRaWqaVYMBgpqilbXnrCRaK
         AZng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779645701; x=1780250501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqnlGS/b6eue7jS0GGU7RuSmhW8y+tSx532G8seHTMo=;
        b=FwNJ48VymP5WI3EVXOBwcdS4OFGTkEkbXS3esjxd/PbWX8LFLH8l39cIfH6BV+5oxI
         T0yRtZLg+qoapKvejqBBaTJdw+6YnRLUBZAPJSJds7nNws+EnliF1MxfvaYVQfvtrN4o
         K2sjdh+3Np8w+g+kovicILLDcAgxZZkuWl02Ez6TBqEZNumjtaTI8WeGXA5xTUokecAz
         zN51xX2Kpd1LtejrPZ4IBm1+JYS1H2UBnHNgGnalwuveMY0NAoA5OBJHva4zh+CKyXyg
         lCfJFusxVoAncrLv6gi2Ja9nd4b/BbOCQmrfJ3t/w4VPjsFoIYQ1dkLiZJmg3fiGFf4I
         G0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779645701; x=1780250501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gqnlGS/b6eue7jS0GGU7RuSmhW8y+tSx532G8seHTMo=;
        b=pu3WTOmtCuRPJ4TrfxqeV+X2nHLt7ObIWWD5F7gA1Uq5Ad0ZL+575NVBa8JQRbtPIe
         hiabGoo9evZcgkOVQppvp3HmZF0U2Qgq39cpeqM6D8vHWOIiLlxq4vGo6etZxvh6YzBS
         VZEr2B2GKKs8BBayvsTaWT43zpAaJo8zhJIZ2kAKG2tEWFpxQzaYr8EltCvq2OwaI0P6
         ykT4ozqGh8ziFI3IT4z8Q2g6+E1BbI2LVVz6MmQYYkWu1Uh66sT+gabhLD7CaPDB1xOH
         FywSLV84jFVdEmBagwGrBkYayUMUoQuG29zMIyvXU1qbgGyHyFtZgIWxqNTv2/Os8dw0
         oxyg==
X-Forwarded-Encrypted: i=1; AFNElJ+fV0s5MQx0YbUsW7lTirTtZM+H3mHG+itRgHHUfCZFTMytlB5IuZN3Sz+BMLthCIVrduY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZZwaWYJgzHTa5Oj25BK+2W+5qkjoMsdDN6RLGSFxx1p+GSmx0
	OvZPopnz7f+aPOGGR1+xKXYmw7k70v0G0eyc3c7TmB6Sf48P/5Iu3E2mAvPTD+kUvs29wxuM8Dy
	HnJQIrdmgpHSpoXajcHyy1hUBKpIcORKq+xxr
X-Gm-Gg: Acq92OFAVYs57GWb/LPLvMq70QoDqwe0GfOj83HNLLemJ7kwbqBW+CFFu/D1ItzRaGD
	BVIl/QofRnOl6NlQ7ZCgkPhTRLlyCSTo8LA87MELT7PG1AqhCfo5UuIXF1kHN7DO1ya3eYCSHQW
	yjLIN8Vdtu32wWxDJXYtg+/pihVYHX14nGAMGM2LDWivtWCYNwGx7dvHfoCJ5wq3xjaXTA/2S+U
	RxD7riNmna5WkCzKTV1YKg0WJiNpvxfUPyY0KsKtY87Uj1AlmQGGadQG4WIKZ3bEBYKrnTtFsMT
	+2ENiXaaHR+mTkxZhhE+Iyap6V2P88bxdi0cFdMD
X-Received: by 2002:a05:6820:4b04:b0:69d:5b47:bffc with SMTP id
 006d021491bc7-69d7ecf2f95mr6095253eaf.58.1779645700886; Sun, 24 May 2026
 11:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
 <8c0ea0bc0742651e634db7a3002e8cbe1240acf9.1779415884.git.gitgitgadget@gmail.com>
 <xmqq33zkui4q.fsf@gitster.g> <CAC2QwmKkwnr+TvLDnDuLEvGJeoraB=_YWC6idA57dxUqQ_5Fcg@mail.gmail.com>
 <xmqqtsrxi43j.fsf@gitster.g>
In-Reply-To: <xmqqtsrxi43j.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 24 May 2026 11:01:29 -0700
X-Gm-Features: AVHnY4Jo9mHmtYfspCIAndJrNNqiB7oqpnA4znUE5HuZ7xp27ADpvEIiKPwZXEE
Message-ID: <CAC2QwmLbFvMetGdVFdzJ3MmHo95LPx2Mohpj8NHk=uxKwt+ckA@mail.gmail.com>
Subject: Re: [PATCH 1/5] xdiff: support external hunks via xpparam_t
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 1:50=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Michael Montalbo <mmontalbo@gmail.com> writes:
>
> >> > +      * Clear changed[] arrays.  xdl_prepare_env() may have dirtied
> >> > +      * them via xdl_cleanup_records().  The allocation is nrec + 2
> >> > +      * elements; changed points one past the start (see xprepare.c=
).
> >> > +      */
> >> > +     memset(xe->xdf1.changed - 1, 0,
> >> > +            (xe->xdf1.nrec + 2) * sizeof(bool));
> >> > +     memset(xe->xdf2.changed - 1, 0,
> >> > +            (xe->xdf2.nrec + 2) * sizeof(bool));
> >>
> >> This, especially the starting offset of -1, looks horrible.  The
> >> internal layout of xdfenv_t might happen to match the way the above
> >> code expects, which is how xdl_prepare_ctx() may have give you, but
> >> it somehow feels brittle.  I guess the assumption that changed[]
> >> does not point at the beginning of the allocated area (e.g., it is a
> >> no-no to free(xe->xdf1.changed) or realloc() it) is so pervasive that
> >> it cannot be helped.  Sigh.
> >>
> >
> > Agreed it is ugly. I wanted to make sure the entire changed[] including
> > sentinels were clear as a defensive measure for downstream callers
> > (xdl_change_compact). I agree this results in something that is ugly
> > and brittle, but in the end I thought it was superior to relying on the
> > fact that upstream zeroes the entire changed[] array. Maybe if the
> > comment was more explicit about why this is happening it would be
> > helpful?
>
> Perhaps make these memset() into calls to a helper function that is
> defined in xdiff/xprepare.c with a descriptive name and placed near
> where xdl_prepare_ctx() is.  That way, the patch in question does
> not even have to expose the strangeness of changed[] (i.e., it has 2
> more elements than it would normally contain to make the memory
> region for changed[-1] and changed[N] valid, and freeing it requires
> free(changed-1)) to the code path.  It only needs to say "Hey, I am
> clearing changed[] arrays because of XXX" without having to say "by
> the way, the memory layout of changed[] is strange this way", the
> latter of which is not exactly of interest for readers of this code.
>
> >     /*
> >      * Clear changed[] arrays including sentinels.
> >      * xdl_prepare_env() may have dirtied them via
> >      * xdl_cleanup_records(), and xdl_change_compact() reads
> >      * the sentinel at changed[-1] during backward scans.
> >      */
>
> And this belongs in xdiff/xprepare.c near that new helper function.

That sounds a lot nicer. Will update.
