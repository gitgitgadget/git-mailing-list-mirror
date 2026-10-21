Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792622683;
	b=YFfuCWfh9S0OzpprK0u3YMYdI/gmN0W0RcMETD7hqLrVQ5EaNdrtaWa3l+g9DUez4ktC
	 GZQwx4dgdy3rAtvHt0gE9AJ/3+oS2QE4JpCXX18kaA9emGhy5piu1Xvi0qV0KtE1FLW7f
	 Xj4jPk7oAt0pxWgEiuTURzXwgX3TcM3CMfg028zxZvLT+aYviLFzBayXidBxS5ayFXQnS
	 zDsSILpduFTU/rJIzC/WnCpN+ptATRbjUMgXUjacJl7+75odcSKG3L0813AGGWPZ+LKzP
	 phtkzY1e5IeoQws4APgQiuI/v520A2YwpSMWUtb3ps7qlk8mPVBo+ZFZF0Tnh8teyAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nJPyjbpiznu3EUQHNRLuYh08XRBetKFsy3EFNI/36KM=;
	b=piG10/cyUK9JaVH5j7L8ptbubXGjgb0FtmnwiC6JQCqyprJx7SfTDPYatxYq0kc2OMhc
	 4z7NWCOrHiVv8rrPTtdtNZ75QnmQNsVlzDw9U1iY9AMII26xZFT77xejSZoArgp/9T1GE
	 cnZbPYWbnD28ezhIP16L/0xzZyTHTjd73EPiZ7k8U7rmFYfYERenR9c2xIN6B5Ipbin8T
	 Pwt38AxFi7LCiwXeAGsKrb5ZZu38zAcBOhwUL2aHeWQEf5Xp1M0mkmBhIuxFXcgJKIfvE
	 N7p+dgwBqcAJWn1XgZICrvmx3qw8KQSc+lcNJc9H9TNnZfrlZMQ39M+TjOAzgzHZoUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D0OE4LGe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AB606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 22:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531AB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D0OE4LGe
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917ad52d7b6so12608886d6.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792622682; cv=none;
        d=google.com; s=arc-20260327;
        b=nBlnTg2DUBJRyWarVzrtN2Fk9UmOGmqXACWeep542Qgl2eS6ZdK7fbk1EkkHmMBRBz
         MyCpU2aWRw8JawZ2/x0vzxRLS78GwUrPyYdPvccx6JampV2Ln1uNIdqvymQu6fF6V+r5
         xC+TL+J0O9qIqjkfizZwwEKSBjaOvPgN+M0wNp4+WMQrhwqJUmB0XjbJIQdHZSTRhSML
         s3HnF12VLTlBEm2RaM7meTqEmTZ6bOeITRy6MjfTECyg8V6PGH2iuD31CejyKtfZUAOq
         NI6z/FCMcXVDIi0Y0LM8Ofl1roA7vNxB/q7TBIrtlyIo6CzZ+CB1/4PNRpToIK0nk4J3
         eH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nJPyjbpiznu3EUQHNRLuYh08XRBetKFsy3EFNI/36KM=;
        fh=yM0e0w1Af58QVHM7nbZeV7Tows79IxTOt5CYk2r3qvU=;
        b=SsnFWW5LRHP0aGzXggmc3ADAIWTnunDoDhYrjIiCo2H/O4Yw62QO7qTg2OX9J88gyC
         cgJOzLYaZiJ6B95Et/B1ctI3T5HvCAzRQt0avgh1qPGVZvCHlc26/e87CyTIEv4AWCHL
         YAoUbxlwJcIobj/cq2cv6ssNn5S5VhDVRyyH1dnUHU6X6wmeAYwDZ6FiH5B4Kh7CC/lR
         ph+3iT0Wp69od8OERAhVr2d0oO67HdRgZ4fZkVOYgTd7GCoP4PRCBopJaI5orMoD2A5D
         FNeLSGwjXdMdlMJt53gDRRrGtUFsuTzZiMMx+89FQVdGf7lT/4HaoP6wkJQKCoruYb2W
         Mnxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792622682; x=1793227482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nJPyjbpiznu3EUQHNRLuYh08XRBetKFsy3EFNI/36KM=;
        b=D0OE4LGeHorDHariN8KTWBSEQdj4XdOO+K1TlTOt7LMbo6OUhocDAGfUtwWPgufCGg
         UdtDV0+g7KY+/Ef2r3fVn+A1DfwuL6/NRqgT2eoVeT7QTXIgJ/M9j5CbGyhXeC3ZavBJ
         UNDaGfYynth7eiO8ZcWa8MQxfXPi8235hSphhzG1NwZ/RTr+KmynSlhtMx8kiU7Xj2eJ
         1ITK5M/qx2TajhtLDBnMUr7kyOLbZzYvMmUxoE32OMn609OWGYJ8z0Uwf27OaS2Wbwsu
         OVM1Uw/9e+U6p3PQ134b6urXcpex7H7fOtnTEsNTWTGo4QEtgO4dZfsL2NdRW1MH3kGr
         A/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622682; x=1793227482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nJPyjbpiznu3EUQHNRLuYh08XRBetKFsy3EFNI/36KM=;
        b=aw4M3h+sX6ESPLHZTYHJR0NdJZtxsGO30thnb50InXivEFS2nIFKn7z/2UvF1ETh7b
         PmOd5Lkzj906WLtc2l9wIFyKRiz1ofRHPwfgiWDfojwX0239iB7w0jWa6pf1g63djhK9
         rrvWzPJi1IC/BZpJuHaBQR4yn/F6U52mWj0nPLaUDGlERmSY12jnhjuI5RiFNwDmTLAp
         Et2qPAhJunzNinrfDZouJAJeEqwDFVFlJrI2M4RjDoQah5+55FWR7tsK4Cr1NViR/ToS
         A/8iaGnD6W1R6YbWsc3lyhQGotg1q0HBg2i4p/d+sMjYplX+dMnlNiDNp8469uXfqi1h
         T+5w==
X-Forwarded-Encrypted: i=1; AKwUvBx8cFQXWWp9FvdCCpNwHFbeNgmRylOrEkE8iU6L9j6GguOgoqUqdoOnMDNgfM5N5hFIl4I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfrDKHPm8grSroXkOaDLe2+CdWVj7EYasLtYwHuaxDicZBVxzR
	RTT8qU2votFzNFobsvdQTYGTlPTPgP12HtmmE0d2vZVCbNkG0EgcEfmQ5fB7bwhmP/Lwak5xx7b
	RzgXPEh0Zbq1rsNAKH1IxCTdAVBUqXmD+hV8S
X-Gm-Gg: AYBFou0cJAMkUGtU0HM6hnVZF4NOT2l+pdHZr7E1/WzdZZD+XSrl1yRXWjYiG0q78AX
	S6XF67TzPnA5PEFvkQiOrT7/DIVYglKZEo3Nk9uHY+o/LQ10Sk6titEyAQTNV2TolNaa9v5hwfW
	qJ1HX4xhhE5nwaDyvP477JF6yJ45Be27EHMjdeLUc9fETuZDFuiwNjaZq6TqG+T2vgyl31ABLBq
	zkjZUdDkdPAUk2PZ4U07qQllldLGqDbjJW4GWu0gvMB/DwPp8h6h9Li5E4hkOWhSbzQChdi1/TE
	2wcVERcb1fLWSZqnaeUcsnrkOXNPlHckEVepfjgDO8CKLdHQ75FpYZKS7YtR/mYwe0e7sYj/g9F
	/joT9svxe9YOYOpuf0XY2q5MDSKVKZbyOFJKcUdg8dsKqLVIWwmKdwreffx0b245X1xMkqJUkbP
	lCVShvfvAmY0kf
X-Received: by 2002:a05:6214:1308:b0:91b:ec1d:1746 with SMTP id
 6a1803df08f44-91c12f32ad5mr61727456d6.55.1792622682212; Wed, 21 Oct 2026
 15:44:42 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
 <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com> <6e2acdc5e2578da4e915fd2ac541a776349fb23e.1792512249.git.gitgitgadget@gmail.com>
 <CAPig+cRsSN9gY405MGsCQzLuxzBKcfHo2Oc8Z4WB-U3BGd6m_Q@mail.gmail.com>
 <CAGou9MgdF_xA+e8YYn8ud8TUSmY3j_q9jbUTy2wLibTz1ObJ7A@mail.gmail.com>
 <CAPig+cRCaSmEULP1JpW3fjiJDR0Lee78puq+KRaXiD9ciX3fvg@mail.gmail.com>
 <CAGou9MirKucUdx8eM-BfqO9sZrDrckwpp9sYDnDVfiqkdZ8wdw@mail.gmail.com> <43b81ed2-6cc2-409b-be39-fa5b0911f532@gmail.com>
In-Reply-To: <43b81ed2-6cc2-409b-be39-fa5b0911f532@gmail.com>
From: Jason Newton <nevion@gmail.com>
Date: Wed, 21 Oct 2026 15:44:15 -0700
X-Gm-Features: AclHuK8ruJsPD2GEb7hNG1OAuI24q19GaWgW9ZiWQ1pg7WM1hxu_c-mWjcykPp4
Message-ID: <CAGou9MjGsTNnxYh8+zJXE1V8xCfkdknHqO0kaF=FBGztJfCdVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: reap ephemeral branches created by
 "worktree add"
To: phillip.wood@dunelm.org.uk
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Jason Newton via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just matching energy levels of Eric's messaging, I did not make the
first move but I will defend my position using the same energy he
brought to the table.

The detached-based workflow does not satisfy user expectations - my
framing there is no user would like that that didn't explicitly want
detached, which I'm not sure has a use case.  At face value it does
not seem a worth while suggestion, sometimes it's worth doing a
cleaner thing even if you have 60% of a technical solution that can be
leveraged to overlapping ends.

I do understand the usecase of short and long term worktrees which
behave like branches though, and that's the common user expectation.
The current behavior of can't checkout the same branch more than once
is also not user expected behavior.

-Jason

On Wed, Oct 21, 2026 at 7:03=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 21/10/2026 09:28, Jason Newton wrote:
> > Please focus on reviewing, I use mixed but you shouldn't assume which
> > parts are and are not llms.
> >
> > What you don't realize by working in a silo for a long time is your
> > communication skills to external parties gets reduced with jargon and
> > nitpicking ; I have the llms both assume you're wrong and right while
> > seeing the undesirable behaviors your stances have to the one that I
> > know is correct.  You seem overly sensitive to the usage so far. I
> > have no tollerance left to give - so stay on point. You should
> > consider several harnesses chose not to even go through PRs and work
> > around the functionality like grok build did, patching it in
> > externally which is kind of nuts - and replicated.  I think it's
> > something you should think about the nature of quite a bit.
> >
> > As I mentioned, detached IOWs sucks and you shouldn't have bothered
> > mentioning it because it fails hard, though it was noted and evaluated
> > in earnest for a bad idea - want to go back to the long but more
> > neutral form?
>
> I'm afraid this messages falls far short of the standard of constructive
> discussion that is expected on this list. It is perfectly possible to
> disagree with someone without attacking them or telling them what they
> should or should not be doing.
>
> It is clear that you do not like the current behavior of "git worktree
> add", but replying with a generic list of the differences between a
> branch checkout and a detached HEAD and then attacking the reviewer does
> not explain what problem you are trying to solve and is not going to
> convince anyone that this patch is a good idea.
>
> Thanks
>
> Phillip
> > -Jason
> >
> >
> > On Wed, Oct 21, 2026 at 1:07=E2=80=AFAM Eric Sunshine <sunshine@sunshin=
eco.com> wrote:
> >>
> >> On Wed, Oct 21, 2026 at 3:40=E2=80=AFAM Jason Newton <nevion@gmail.com=
> wrote:>
> >>> --detach and an ephemeral branch differ while the worktree exists.
> >>>
> >>> --detach leaves HEAD with no branch, so status, push, rename,
> >>> upstream, and symbolic-ref have nothing to name. An ephemeral
> >>> branch is a normal refs/heads/ ref for the life of the worktree.
> >>> Commits go on it, and another ref can point at them before
> >>> "worktree remove" deletes that branch.
> >>>
> >>> Deleting the branch that "worktree add <path>" creates today
> >>> would change the default, so this has to be opt-in. That opt-in
> >>> is not --detach: the worktree stays on a branch until removal.
> >>>
> >>> These worktrees might be minutes or they might go on for months;
> >>> either way they should be easy to use and not require flags to assist
> >>>   in the majority of common case behaviors, moreover detached feels
> >>> ike a degraded halfway state, frequently allowing a gotcha to strike =
or
> >>>   a loss of a safety like a gc based reap.
> >>>
> >>> "git worktree remove" does not delete whatever branch a worktree
> >>> has checked out. It deletes a branch only when this "git worktree
> >>> add" created it by DWIM (the final component of <path>) and recorded
> >>> that in worktrees/<id>/owned-branch.
> >>>
> >>> A branch named with -b/-B, a branch that already existed, and a
> >>> detached HEAD are not owned and are not removed. A worktree created
> >>> by an older Git has no marker, so removing it still leaves its
> >>> branch in place.
> >>>
> >>> "Unconditional" in the commit means that this one owned branch is
> >>> deleted even if it has unmerged commits. --keep-branch turns that
> >>> off. "git branch <name> <tip>" before removal keeps the commits on
> >>> an ordinary branch; only the owned ref is deleted.
> >>>
> >>> The call that changes is "git worktree add <path>" with no branch,
> >>> followed by "git worktree remove". A caller who wants that branch
> >>> to outlive the worktree already has a spelling this series does not
> >>> touch: "git worktree add -b <name> <path>", or "git worktree add
> >>> <path> <existing>". --detach still creates no branch, so it is not
> >>> the same state while the worktree exists.
> >>>
> >>> Ownership is written only when the worktree is created, so I'll confi=
rm
> >>> an older worktree still has no marker after an upgrade.  The branch s=
tays.
> >>> Upgrading does not mark a worktree you already have so no upgrade
> >>> headaches are expected.
> >>
> >> Feeding a reviewer's comments into an agent and pasting its
> >> LLM-generated response into an email is not a good way to convince
> >> project stakeholders that the submission has value. If you can't
> >> explain its value in concrete terms in your own words, then you're
> >> going to have a hard time eliciting any responses or additional
> >> reviewer feedback.
> >
>
