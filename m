Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794834053;
	b=yzMG4rjUBcSZyfDtJ/ri6gWDvKJYB9KE0LeNrS1Z+szVb1a8qZ7aJR0+z1dun3AP29n1
	 2J++pW6Dk3DkYm0dPFm6MSOzG72sa+gpfsspC1L42NmaeN23Xt6mNBZMkQhGyv3sKhWk4
	 26nyS4HfPzkfzb9t1tjAIE4FjJZ0FUgP0hGknOr4ly4Gvme2OGjAr8r6VdWDe/dWZFPZJ
	 WAijCBg0Vj7Gk3XBUVUO1uDliGSwHKrf/E1HX6CqyJ3GPuzcycVNBO+EWXgNnB0pEaHc3
	 Kg5h9TC+LchclCchAi/yvtrfHEt6WoY0Fndjptlb1rzRPlRaUsIuezcbjEB3PQQbO5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=7LYyvVtTTx0sTPHVNGTP95fAYKwd/T9WT3FpuFt19zA=;
	b=z9ArVqwKhfLQbNCCtPW31328UHgBO5Sgz5tcCas5sPESgWKH3M+26zIa+PehOuntF+Z5
	 zx+EUSdyv9EIVkpAOjt7ekBSuxSyAu56dLMXO36p9ccsogZdeQxXWax9/zBliuRSR9/ca
	 hCtCn5Gv+5+J7VBMMll1C9bOIyGer7xU7IKV30Cs6zoTC7NlVCY4qmVUqbEDJbYr8gH+V
	 IbC361jXmEB4/MLE6yPqJMYlUFdqHsLUcthjqoqeKSewQ2OlLpVij6CIPEpGln5fuy+Pf
	 5wiCAjYGZad+ETWya4oTbS5+/Kbe5N12Pe/MQRscF6W20Lgmy6E4xk1SuDS1fyAEkQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OgvWTYPN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906F606A329
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4906F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OgvWTYPN
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-70b875f6f1fso3737879eaf.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 05:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794834052; cv=none;
        d=google.com; s=arc-20260327;
        b=ik6AvKJ7hSp7eRJnfbhTIbUY4DgL1vWp5C8mYqmlDkb7txNegxFrwHHYV+8gf1LpRB
         bvmZISsohK4UFAtmLt5T6f8MwADj7wz3qDWC0NAPDfuBLXDopxMM2n3Ive+rMOCrP0y3
         WYnvAJfzEs0IRzpA/4z8DCma+06nqHdZE0EdEvxJYZfv+bQPq5lPaCMyjPVussAvtraC
         kQllrSDKVWpNB9Ima7iShCVLRjo2do8zn5LWYhD7uLAx4cSxMPWjji7FE7k5XsADzNk6
         vLGoVBJjygr7eg2IK5FCUd+mCpPPQwl/5HNYN8oGGY9jxJlqT4zF0ErM8pyRSdn9QF/g
         3sZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7LYyvVtTTx0sTPHVNGTP95fAYKwd/T9WT3FpuFt19zA=;
        fh=K9CE7W8RKHaUdeZ+zU7lVZOU1wGfMhgY9zF3HcyW7i4=;
        b=NbYbsxO63HYFeS0UTGfVJCdh46bMN0NfNhgRA9qoBYmMh5zmX4f8qU3Kv/uWO2q0iI
         t5PRxB34VHdTha/qkUhqbuWbsYHqUW3Qz/mRV5Heky7ESGGXSPh/j6B/Xl0b2x2pml9+
         zzRxZD2Lpt3oOj0IAYjQX7mXWHzssCfA0JL69fRlf0Pi4DOjE1HA45Mnz91jQu3W7Ek3
         klBHHWaevgJ1JkwOyCCJAbqU7VsovCMGKU2/YyvSq1u97fS/JnkqlTRDSZw4Gho1BA1G
         aZta4Rh2w/jLn06uyG6LYfnY1X8agx1L4p9O/s/089CiJaxVSo0BVBJJ+QRGxyQ4FYbx
         BHXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794834052; x=1795438852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7LYyvVtTTx0sTPHVNGTP95fAYKwd/T9WT3FpuFt19zA=;
        b=OgvWTYPNDzAxu1t7hCABNRGZVly0hOTEpwsYMkShY6awmMAf74Hmp7pgmpYSzwq+fm
         9c/Qae+hXwWHOrV/jY95nnJPcPBzcpAlhLeneKXsvZvTfhO6ccXDUqWq53CFy3UqlLf7
         IlyvA/v73SUsHabgna3broEwWHbKbQFjcUlPxaUjzGHSAkjq7gBaJsBY795rfV2Z9HGI
         OuiQaOQo/dF5MT1uKDBjc0qsgmT3IJZAN9vmUPjiSjrKg6Yv8Zfpt6nJ7CMqbZrsV8m1
         p5bRgglcvHRWm1YtdDIffWlM/TRAxEBBmUxa69ZO4FIYRdbUBy6fQ0k0bgL2dPR5Tdfj
         ykAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794834052; x=1795438852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LYyvVtTTx0sTPHVNGTP95fAYKwd/T9WT3FpuFt19zA=;
        b=cQoYGUo3H2/brRvpxRqpeo5iZFK/5iUZtNQZXa6GKveUVIZ8Sb2tL59f3OhScOG+2A
         RrrieS6vkndvZ5czqF5rc3VkX15vPz244iG572CfNhleiafULr6FjdGjICzwrCSjnHXg
         nlxDGYQdg4dT0L6qq/6GvWsfRRpmF8hZ2MqMcOVvX7V0keJK9yhSWch1DLjEQgepShiW
         aWOj0MOmiqMYP7Ep/AUrMV5cGh5AATdjc+6dBkpUKJAmy2V9bpk6iVki9HVkl81G7KC1
         2bnpVc8O+NzkjNc/M/056fHoaqzl9Vvf4XbOA3bUC2Ef9cvVJ6pKW7FaB/BTg4POMfSh
         BSeA==
X-Gm-Message-State: APuU4Z/Jije3PYq6WxSI6l2RPWrZEPgCRH8EOJXn01G33Kn9uxELLlCu
	VpSCi5WYCOqwadiJyX1gab+YfpVDzVjYZXDBgKJF2mHE7E/QtQh10zuRugLgjo0IiXKRguGm/OV
	Ig8j7jk+2dGbsgOJqV6jUG2msvEA+jPA=
X-Gm-Gg: AYBFou3MpmHXFwpZsd4a5wwbTZayTwQUFkME3cbOLkZivPD13dHGuWeGMpGYc2eGBSg
	isgUTvTni2eSglsbUGUGBOP7BAn9wdNMj6/8ErO5m4lYhzQFtGbB17W0vzOVi8FHn4ubVIaLPT8
	ZNb9BqXlOgqpz0M/4dPORwAmWR9O3kP0+yCdjSdDgd9k/c91Z6f9aIn7spzrGJJn3Aw5IzATFfC
	lcxv4lsK5XWkcUAxLfzEzh1J45v338LIrE9m1rRz5FL0Uvo35FYO953cwiuZ4E3QCjPwERwQVzr
	Qyj24528wQXgN/YhoTEAEPwao+RUnhBnkNK1EV49YHhcsA5fMvOprq0D81SOmz1fF84cZslT06M
	WHfROkyA24UX819WEkneWIFdlpVVnXKyAfMiBqBd6d4HQ7ijHUxXyMpgahJaqD0motRirJ/eZcr
	gN3C8VcyuwKKTofQ2dkJg0q+NTgDb5m+5zechNv9k2bP4ZDP1rM0uSTH0=
X-Received: by 2002:a05:6808:1494:b0:567:c9d6:b2b2 with SMTP id
 5614622812f47-56e64f07027mr7873224b6e.47.1794834051842; Mon, 16 Nov 2026
 05:00:51 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
 <89511e61-4646-45df-b5ac-b52c9424072e@gmail.com> <CA+rGoLfJyuT7+W_eVPap_KSqy4EFG4Avp2=rL=hsLu0uXxem4w@mail.gmail.com>
 <7e5188f8-ab49-495a-bddd-7ba8921c11e0@gmail.com>
In-Reply-To: <7e5188f8-ab49-495a-bddd-7ba8921c11e0@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 16 Nov 2026 18:30:40 +0530
X-Gm-Features: AclHuK_v086KzjbCciXKJ8RTsEojnaQ4I2NTFuUFWwZ3aELdRAlwaio6dESqo3I
Message-ID: <CA+rGoLdtFdyxx-MyzbXB+tU2eQLKK3Uxdq0FfGLgA+7htAoRvQ@mail.gmail.com>
Subject: Re: [GSoC Patch v9 0/5] repo: add path keys to repo info
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Phillip,

On Sun, Nov 15, 2026 at 9:47=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 15/11/2026 11:03, K Jayatheerth wrote:
> > On Sun, Nov 15, 2026 at 4:03=E2=80=AFPM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >> On 14/11/2026 16:37, K Jayatheerth wrote:
> >>>
> >>> Changes since v8:
> >>>     - Dropped `path.hooks` and `path.cdup`.
> >>>     - Renamed `path.toplevel.*` to `path.workingtree.*` to align with=
 the
> >>>       standard "working tree" glossary term while avoiding hyphens in
> >>>       configuration variable names.
> >>>     - Renamed `path.superproject-root.*` to `path.superprojectworking=
tree.*`
> >>>       to provide a descriptive name for scripts while avoiding hyphen=
s.
> >>>     - Renamed `path.git-prefix` to `path.prefix` to shorten it and av=
oid
> >>>       hyphens.
> >>
> >> The range-diff looks good. It is a shame we're still creating a new
> >> repository for each test when the majority of the tests could happily
> >> run in the repository that the test framework creates for us. No one
> >> else seems to mind that, even though it makes our test suite slower th=
an
> >> it needs to be, so I'd be happy if this is merged as-is.
> >>
> > Whoops, apologies for missing that, I made a checklist for this
> > reroll, read your
> > note about the tests, and completely forgot to add it to the list :)
>
> Not to worry, it is easily done
>
> > Also there are some newly arised questions about this in my mind:
> >
> > - I am currently writing a follow-up series to consolidate the overlapp=
ing logic
> > between `repo` and `rev-parse`, and I plan to combine and clean up the =
tests
> > there as well.
> > - Three `path.*` keys were already merged in an earlier round, so updat=
ing those
> > tests would require a separate commit anyway.
> >
> > That said, I'm open to feedback and happy to switch the tests in this
> > series to run in
> > a single repository if you think it's worth doing now.
> If you're planning some test cleanups anyway then I'm happy for the
> tests here to be cleaned up by a future series. I'd do whatever you
> think is easiest for you.
>

Thank you! The easiest in my opinion would be to directly combine the tests
and optimize them there.

> Thanks
>
> Phillip

Regards,

- K Jayatheerth
