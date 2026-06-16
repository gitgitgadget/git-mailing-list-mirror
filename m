Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984D313E07
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637376; cv=pass; b=MNAkp/LhKHescaSNcHnoULhHrJpTqwAm18af4FIFWldbmlOvBR+NYv7ADsZfue3FyrPaev1pL3fPdU456KwhTAWKnSpKTNrR+fM6GSNyuWtLn6O+gaTMP0oF9xNyIy5Vf1Uxdph3USipU/3NKtg0FD8IpgDZHxjNC/c83cSxHxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637376; c=relaxed/simple;
	bh=mVdX2wM8bTpBYC8a2tvxvqi86mkwgzGMP4NwQE54XvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVEkTIVHsQs3MMXdb2EmPYil0jvN9QP0GdZkKMqTJilb2SOiVow3IYwyO+g/ozdLvWdBavAqz8+DlG7rHC3zj3iGlabfOqm14Hq3STZSuPazdUDCypTGj8WgGNrDomtddIneDiI0ri8ejK3MpndQP+VeTGn6BYyddCSrDi7Laps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdg91KW2; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdg91KW2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69170548d0eso7334713a12.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 12:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781637373; cv=none;
        d=google.com; s=arc-20240605;
        b=MmKth311bQV4Sr4a8uJcniXDFjM2R+rMhqNNyvRKjSK/nmYdxKeNoRmeLbbstsohDq
         dBFAUx3iMjH3LEjof0pu0OIQ67LWbNY3jLucj08SnxjQFpNB6FQx6peRuhHzXseKKwl4
         oq/PtLfLVVFt88Tn67oPUO9oiKvj1io2lE4axDcrqlgZuN2nA2/e6yiMCbHPR0hKGbwC
         NHSPtJ8L5J0NtKY/10tUUis6vhakrg58NqSlZ7z44XTiBazEuP3ab31g4dNxcVJE0XhN
         7mAOVtWrheofQV2PaQs6o5RLUvceXUeuCQ7lsZcIcC6pMGoaQ0FAS3g+2ba3m86PuQEb
         AeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CHovJ7l0QaLLKNXJP+lLmY+E4v7j0lEa5jZTjYMCvrA=;
        fh=p2OK4dDOOulgxmHjEcHDKGv6nTAHg7LWnY1lMQQkodM=;
        b=kp3fFxBoWXBQ0LAJtqodYuT1ZnYDwlD+M8qOaehN18Y9MzFkQLaAr+1NaOyjgZn4wT
         TlF71R9M5BZ5b0mujO94fUiYubaIa45ZH3fD3EBw6zHPnD6FBhdregw3AtJu20c5c31j
         T1/s4InadJ0RM+Qblxe2/zRqTHjv2/vDAeGSL3mYwtm1DDO098QWKvik1FYF/TYGBg1J
         3WfA+ZkWWxSsMlVd0xckIFFINGu2od78Q7G11ZMoKNWoa2VblBLR6IPLxsgzaTBYB5Ze
         s1Kv+gzhwORcWNHIQP1Tfh3h4+iZwI2q6+dXHeUgID0AhbpAhvTKLwEcMyS+Yg+Bv8sq
         diKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781637373; x=1782242173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CHovJ7l0QaLLKNXJP+lLmY+E4v7j0lEa5jZTjYMCvrA=;
        b=gdg91KW2CEmCZsP6fayEV96jEUT5nU1MkUuBgilGmR8i7aarvZBYfQVIsy4XLUhB8n
         9vEV+MGY+fX0AZxmwuws9nMGEOB4IG15eUtqzw7fYhD/JXjHEDHPjO21doyHlAhmJlWI
         zoNByE8HEeijHt0/DRCLVqBvycm49LfuaraCrFsu0sI1/8q2Hz1PVce57R6fhLlW3u+e
         nEFdtYkm0T3bVbjjY5fQKMttvuOuSn/iElQnsEl2FAQeAHemF90VlTnQn+oKvFNmp7Uj
         B7hnafaqIfNI9X8S3fKysW7+WdFnGLnLASWk58s1jWK2gHrL2+OVoJfj6+3FREJ8e2DX
         nJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637373; x=1782242173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHovJ7l0QaLLKNXJP+lLmY+E4v7j0lEa5jZTjYMCvrA=;
        b=a07ddOQ/R2EShyfiMx7uTlQQI1Nodba3OgnKQfNC6clUDsQU/WlmXMpbvQwTFmRgFk
         ut1IHHKmKyWkxAk1MeaH3eDGE5BGVZHVM/MmlDnyQqdqGa9Iw2r64B0vopAmWsr8wyeu
         lkZrTyz7GTZYHe2NaQHuDfVcNptXnVE1RfsrFlX2kRNKO8QwwplAyRbrlnPhT1GRdu2u
         SB37fXr+8bUOK0We9Ho4q1twa822F7RbE1fTI4GPMqOVqsT3GcuETsqvMQzC0UxtsgJ8
         z/ePn3Als5CZAoKdwSIl3hcdcSTxIj0H9hQb60cLJQfzv9IPDBp7uFw+sgWBg5Gl7k5Y
         xPlw==
X-Forwarded-Encrypted: i=1; AFNElJ+2I115BDZkj+9Mvmo7toNvhSTGjtQEmCsDUQ1PMrsitUxVLEePlgmNQ6renDz5gGp2yyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9nEOYQYjsrJR1SSYxqygWUsy1TujECXgYhKT0nxPJ7YAHw0R
	Taf6jLExh7TZF97tJohjkis/Cgi6fIDoar6Gh6ZaIeiHf1QI+RXR8x59GciGr1PCgILkfN3XjUX
	kF5IpJngQBjpkJoFS+HDaGKAWx830QbSymDvL
X-Gm-Gg: Acq92OFJxP9xlCcGAxMnazTyjdjGc6qKUgJQbKBWH2b4F2sTy3m1hlwcZcHPNcR7aes
	5UWKc+4DdN0fxBDtJmA5Em2kbVf/PnxCBR2INyIPaFbbMJdOoF7VcsXj/y1ptprDJx719cng/8u
	pnkE2WCZFRe0mKrtuDIZl60v4KFG6dYwkaEI7NmLbA/2IYE6oOARyVyeyoWutJn3O5HvEsEKHIO
	j8PwSztxwd/LBDBLEJNdmq1FVh+nOCf58MMzJvlCfha1gern7IcpCk3wlvPUoZKrXAKa1OVSHBL
	gHYi6Sg=
X-Received: by 2002:a05:6402:5242:b0:687:cfde:ddaf with SMTP id
 4fb4d7f45d1cf-69546fe5d47mr381752a12.7.1781637373178; Tue, 16 Jun 2026
 12:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com> <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
In-Reply-To: <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 16 Jun 2026 21:15:36 +0200
X-Gm-Features: AVVi8CeOHaapNdtZdil2VJLaa920sYU5x960N-FlRy1fRWM-63zjzW4HE2k4WZU
Message-ID: <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> > index 4e7deddc04..27ea1319bb 100755
> > --- a/t/t3200-branch.sh
> > +++ b/t/t3200-branch.sh
> > @@ -1809,4 +1809,205 @@ test_expect_success '--forked requires a value' '
> >       test_grep "requires a value" err
> >   '
> >
> > +test_expect_success '--prune-merged: setup' '
> > +     test_create_repo pm-upstream &&
>
> The rest of this test would be easier to read if we did
>
>         (
>                 cd pm-upstream &&
>                 ...
>         )
>
> rather than prefixing every command with "-C pm-upstream"

I feel like the discussion to nest or not to nest has come up many
times in other topics as well. I don't feel strongly about either way,
but I just want to flag that if I change it now, another reviewer
might ask me to change it back later.

Should the rules be to nest inside of setup functions (and helpers?)
but not inside the actual tests?

> > +     test_commit -C pm-upstream base &&
> > +     git -C pm-upstream checkout -b next &&
> > +     test_commit -C pm-upstream one-commit &&
> > +     test_commit -C pm-upstream two-commit &&
> > +     git -C pm-upstream branch one HEAD~ &&
> > +     git -C pm-upstream branch two HEAD &&
> > +     git -C pm-upstream branch wip main &&
> > +     git -C pm-upstream checkout main &&
> > +     test_create_repo pm-fork
> > +'
> > +
> > +test_expect_success '--prune-merged deletes branches integrated into upstream' '
> > +     test_when_finished "rm -rf pm-merged" &&
> > +     git clone pm-upstream pm-merged &&
> > +     git -C pm-merged remote add fork ../pm-fork &&
> > +     test_config -C pm-merged remote.pushDefault fork &&
> > +     test_config -C pm-merged push.default current &&
>
> So we clone upstream and add fork as the default push remote. I find the
> pm- prefixes rather distracting. It would be clearer to me if we just
> called the repositories "upstream", "fork" and "repo"

Good point.

> > +     test_must_fail git -C pm-local rev-parse --verify refs/heads/one
> > +'
> > +
> > +test_expect_success '--prune-merged warns instead of erroring on un-integrated commits' '
> > +     test_when_finished "rm -rf pm-unmerged" &&
> > +     git clone pm-upstream pm-unmerged &&
> > +     git -C pm-unmerged remote add fork ../pm-fork &&
> > +     test_config -C pm-unmerged remote.pushDefault fork &&
> > +     test_config -C pm-unmerged push.default current &&
> > +     git -C pm-unmerged checkout -b wip origin/wip &&
> > +     git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
> > +     test_commit -C pm-unmerged local-only &&
> > +     git -C pm-unmerged checkout - &&
> > +
> > +     git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
> > +     test_grep "not fully merged" err &&
> > +     test_grep ! "If you are sure you want to delete it" err &&
>
> I'm always suspicious of test_grep when we know what the output should
> look like - it might be better to use test_cmp. This test does not check
> that we also delete branches that are merged when we see one that isn't.
>
> I'm going to stop here - the tests I've read seem to me to be too much
> like unit tests checking one aspect of the implementation in isolation
> rather than checking that the whole feature works as expected.

I'll respond to the rest here: Excellent points regarding the testing
aboce, I will take a look at doing this.


Harald
