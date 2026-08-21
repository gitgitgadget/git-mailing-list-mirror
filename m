Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEBB29B200
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276183; cv=pass; b=WMTvlChzic99FbfDWAdZMFSKnXBraxBm6RMOPQx1mlSga5B7VSZjno/Nq8+Kaj9h+DTXXs6naiYztV/wv8fZs6IjxedMZnY6jQetP+7kuVYMfWGKSqP3BJjmRdA0xh0rn84Kq+gpJSSsFWxNoolegjjuEIfVvWCdqLAMlg2ea+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276183; c=relaxed/simple;
	bh=NSqAYB1ffOGWEmXOF+0NMzM5ngKWqe6kgDe3Wus76eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzmRiHhr6KqwOwlqs6qQYj98mSk6Oax3I2LTHllCJlxUov1Cb77ANKwmt5XMxasS7fzBVhlXBbaMXNVjMCugIxUEGV/UEOvKOeRNxE9mDmJbov7HWl5zS0obc14gcwKzM/yJR5ye6sW3psL9aujaHSitELEc+VFHF6E5/UIIBvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4hMOQmO; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4hMOQmO"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a483a552efso253817b6e.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787276181; cv=none;
        d=google.com; s=arc-20260327;
        b=CdGc022b7vurqEfb10lq21Fn77lrhdQmW0Rzzbr9Zr14E+tyCh3Rj4ulfTHKCJGe9T
         nV0iXgFsnVqSo8IhWyPSI+OPG8KSH6Jp6osyOYw3cd8qRAxg5c+CacxprpcunLJ/Ajkz
         ZvSZEfQnEywy0fbw+c2BhejqW0uNOqLGcvGWKngjDVBEFPysFV+yH94rIDwoPXDO/ApI
         aWN/8j12sljY2jBT2uT0z7VAtbCUULYW9df5Bvod5X0hEUEkf3C03BcE3hh3SCxuSNrV
         1WMliEgSi8b5tjylhd+LFJtUINNKb7joHj9nvtGw3o8Bk++dVl7XLNndoR+QZIe5RLUF
         maVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e5XlMrhx3cWZi7TsKfhYu+KQsns7L/d+bVs0eUfd4nM=;
        fh=L4MEtavBDrDYplBB9/lpLFyU7lRjTlXmWC3xrRalgQk=;
        b=VBjPcBdeW6rqPQGEYBcp1uvdgf0tafcbgeQ900lecXdS+ghoWZLHE8zl3M3skmILol
         d18NHkmeYoP2sIMZAV5X2MkIUeMeffCaMfj+Ntm2xzylqiHHv1HGlwg8c0v9nrWmBaiI
         kKIJ0HeOjG8mItlLuRtAHIUt5Ce7xJMaeRnHcLLHd/MBuhVq+xGXHfz9o+wHbtV2ENe0
         kZaOOtsFJkxzbEelThvPxufl+4Me+V+v5B4taRgeBfJT3PxGz6oAepPJndKGeIyxmrGy
         gH8wcfdS4hWjJmM0YIR3MmfhHDLdnxqFaHv+mJ8pC/TOgDO9R8+mb2GxgAT92jAxmgty
         Lk8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787276181; x=1787880981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5XlMrhx3cWZi7TsKfhYu+KQsns7L/d+bVs0eUfd4nM=;
        b=T4hMOQmOq/8L7/WdUrh+Vl2uWZcJtQoDV8fGprHosXd2Zng4SefN5wxuD0jbtgSxzu
         pM7YxGfNJeQU+3gbV8VDYA8FPH5q3QXjhBTc9UHApxKlkDMDkijuAgECfPsbf+gsJyz5
         Ji/XT1f1Dy+jNISKQ1vY94BRrtiqyHNsz1TExsANHd+9bgpWkrXck+RC4ALXlM1JiNJB
         t7KjUBvSIA3+N9OWsAQfzGP0j55IbDfkraDCn4MQvoOaSGKWsU6lOtDRCuGFBtTUOHZ+
         s1YRsH6QPbb/YJoISwF1CLprGwLWIlw50dJtWx9Zwa1+BtaTyJ2S2CtERi/4DKsUstRy
         //3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787276181; x=1787880981;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5XlMrhx3cWZi7TsKfhYu+KQsns7L/d+bVs0eUfd4nM=;
        b=efsdtDjsU3WuVcRpwkijf0dU4G//VU1nUgbsHc1B7G1DrDRGJUaK/Z3z8ue9Puk5xb
         Jp14NQvwEM2zB6dmVR76/LWsuyHSIMFcTZCrsF17uVkHKBT+eMvLr42qYWj+1RtM+gHO
         9RXBaDZlp86EL4u/39OBn0ZPzh7M4JyT2yQ5UluqfZ7jhQvT0Z3QoUT56Rg2cjYQeUF2
         cdDUUhx8AoFMbXsWVOAiRlTREyYXhS4QMP2WY+gpei4/8/pkdgbwm6J//5RIgQhcUU1M
         nw1wbyEbHBPOUV0uzln7LkGOMGEfzqcBxxoqNffT4VJ8mZTlE9xH8O66Palh+SXFUXJQ
         J32Q==
X-Forwarded-Encrypted: i=1; AHgh+RqyqzT3t4j9F87e5jgtleqfX09CkRlskWp4eXBmgk04GPWnN7GRXiQxcR0FKUVKwEnUv9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/sDjcR90Qk0RN49cF4/AyKxhCwa7tH6vvB6fJ2P/uG8SgznuM
	xgbqLegnVAAcfBtkX/WJ3Xm9aa4aIDH0oCaWAfMn7g5+Mr4q2ZW81EHSvGrPsefCuNHGqy2eNjt
	ZwKu6/gPeik2nVApPBbEl2PeWWJCYQTs=
X-Gm-Gg: AR+sD117qseiggq7BOZQjTZXeEPeoZzkNtiNcKrcwPTL2hBLM+r+4urEZYZokwYBUiq
	lm9bq23phAS1cCpAoxr3Fq6/Klc+5NXPySkXGUy3heK9K9uWs3j0kIJH1CKwGegEh42ys+SsPob
	33uyYhM709A8cgamp+33LqoBEKiRcW99xYVRZyjYWQoQF/5+OBT2EwpT8kwXq2Cq8NmZUs/qzMI
	WciulUKQAhdE5nd3477v+a/xM77faANClX2CLJWPL4L9GYWi36q85ED5zEDJAbmlq04tsY5Cwmx
	rXJBtKt0TriEnfoboZyfUmHtbu6leZEpqV3Ie2OppHOb5GIYUJuOCLxlx4PxMIyYWYU5NgP4U1S
	1Ves4fTi8Avsu8ALWgMrpatyXQPyz7ztxXlVRicimHSFvZzWXVHzIPpl66xf0CylsW1Xe
X-Received: by 2002:a05:6808:6f96:b0:492:5684:7ab3 with SMTP id
 5614622812f47-4b2ef46b19emr3152122b6e.21.1787276181105; Thu, 20 Aug 2026
 18:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
 <aoayppoxHAkcFTBN@pks.im>
In-Reply-To: <aoayppoxHAkcFTBN@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 20 Aug 2026 18:36:09 -0700
X-Gm-Features: AcwNN1VwhtOwl6bog91oJj8R_ZpoKL5rBpQxCD6q2jfQ9p0J_II38Kcywvet-ls
Message-ID: <CABPp-BEBbdmE9q+98gWq-wLzDdhJOyazcHF=pP95o5AcmgCv1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 12:54=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Tue, Aug 18, 2026 at 10:34:06PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When a geometric repack runs concurrently with other git processes, it
> > can write a new pack and multi-pack-index and then delete older packs
> > that the new one subsumes.  One or more of those older packs may have
> > been indexed by the previous multi-pack-index.  A process that already
> > had the previous multi-pack-index open keeps using it, and that stale
> > index still records the removed pack(s) as owning some objects.
> >
> > Because a multi-pack-index attributes each object to exactly one pack,
> > an object that exists in multiple covered packs is served only through
> > its recorded owner.  If that owner is the pack a concurrent repack just
> > removed, find_pack_entry() cannot serve the object: fill_midx_entry()
> > routes the lookup to the missing pack (prepare_midx_pack() fails), and
> > the regular pack fallback deliberately skips every multi-pack-index
> > covered pack.  The object is reported missing even though a perfectly
> > good copy survives in another covered pack -- for example a large "base=
"
> > pack that geometric repacking intentionally kept.
>
> Okay. Rephrasing in my own words: the object in question exists in two
> packs covered by the MIDX. We rewrite one of those two packs, and the
> MIDX used to reference the object via the pack we're about to rewrite.
> Consequently, the MIDX is stale now and it cannot be used to find the
> object anymore because its pack has disappeared. And as we know to skip
> searching packfiles for the object that are already covered by the MIDX
> we won't be able to find it via the second packfile, either.

Yep.

> > The false negative is not limited to one caller.  Any reader
> > (cat-file, rev-list, pack-objects, ...) can spuriously fail with
> > "unable to read object", and callers that only ask whether an object
> > exists get a wrong answer too, since the OBJECT_INFO_QUICK path never
> > retries.  Writers that merge in-core, such as "git replay", are hit
> > hardest: merge-ort treats the unreadable tree as a premature abort, set=
s
> > result.clean < 0, and returns without a result tree.
>
> Hm. Isn't there a slight variant of the race though for any caller that
> does not use OBJECT_INFO_QUICK?
>
> Namely, the packfile containing our object disappears and is being
> written to a new packfile, and that file is the only one containing it.
> Without OBJECT_INFO_QUICK we would be fine: we notice the object could
> not be found, and then we perform a second read that makes the "packed"
> backend reload its packfiles. It would find the new packfile, and
> because it's not covered by its MIDX it would use it to surface the
> object. But without OBJECT_INFO_QUICK that's not the case, as we would
> skip reloading packfiles altogether, and hence we would not be able to
> find that object at all.
>
> As far as I can see though, we don't seem to pass OBJECT_INFO_QUICK in
> any of the mentioned readers. I could very well be missing something
> here, but I would have thought that those readers are fine in this
> scenario?

Nicely caught -- and you're right that the readers named above are
fine: they're all non-QUICK, so the second read reloads the packfiles
and finds the object in its new, non-MIDX-covered home, exactly as you
describe.

But the variant you describe is a real bug for QUICK callers that
don't get that second read -- e.g. upload-pack's object-existence
checks and mktree --batch.  I have three more race-condition patches
to clean up and submit, and this is one of them: it forces the reload
even under OBJECT_INFO_QUICK once we notice a pack has vanished out
from under us.

Your wording also makes me realize that my fix in this unsubmitted
patch still has a hole: it triggers when opening the pack .idx fails,
but if the timing is such that the .idx is already mmapped and only
the .pack has gone missing, it won't fire.  I'll look into that before
submitting...and then clean up/submit my two other race fixes as well.
