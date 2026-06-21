Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05152E1746
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782060394; cv=pass; b=ZVTduH2Z4mhUHUnhVtfdgjc8yImDuygVmo4A+21+b+rQGp7ih7C/4Lx91cUQS2E0X82Rk8MQQOkteSJrfttimawuuQuxKNyxjGaTpk3PM+XLgzFTCJdI0HXzY0PL+jd34WiDt23uqV7AybwGwdD5YW4KVu1TnEkxAPDjNIYcX88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782060394; c=relaxed/simple;
	bh=qxlp/gE5zGaKa08O1d8h7Pie6u8NS39pc5027u+tc7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV4GTSfsmJnwwp0KbsUuRV09Lvqnxc8DSALfFbUJWjDfwhWb4CC4v7wvLDZmUv0bnCxeBsfpB7RGHRBtahu1NV6mv/6OJsDIS6F01i48utqMoE11VWw50yr0xbQG6Dq8+6+/oIeFE5P6nqgJS8z3ACmP1mIV5xOUehvL38O9LpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKzo/445; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKzo/445"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c88b7c92577so1519784a12.3
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 09:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782060391; cv=none;
        d=google.com; s=arc-20240605;
        b=WadePjoqKPd1079bRBqDWaXxIu032WlAsIG7H8bu3Zk5sjNWJggW2nDe4Z+RpVBqi5
         FdJwjK654JCLoBlK4KpwVh3T4JvJ7+J1MekfBDgktsUYuEUhhxbAK17QjN2QOkOLRMoF
         DW75PbhjTb7uPUJa/TqBXQXukkZ3HsK+zoSAPWust6G91yQIMYjv9xUDJYFJuhsl8Duq
         LeAPTz5fqpQm3CBkvoCoTQJAf8ADP7hNakUnYXO2StYQ7ZfIxoLOUsOMnxQ8pJ2L3Qog
         QZgMv9RGZBtF5hTj58NClljVnzFho47WNso2TfbUro/Sk13yw1J9qcDOO+/oS4z871qq
         vrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lTZ6xL8w0VfRNLuLqZJn3PHMcp8Hl5gfLcIzhzbBGlA=;
        fh=3NV3HWNDS3r1WWZaV+Mtl8wUy4bMW1y9xaMOZZu6Iz4=;
        b=UDMz6DsFuTiWv1NTDLbKNh8eHOCVyC7xjjAlZ0XdnobhPeHGwACYmBGW7G5Y+O63Lg
         9oLL/K+6p+JyqITLhS8jS8PNB0p40XmFOfM8SJ1UgkXRkSLU98nOJOeLdu+VBoRv8x9u
         +VWa7ao71eobuBeJwQ78v8S/uOZtmytzHqIrf5vzAShcFrzmJonJ0gUauV0W2heErXjM
         dfjrAmRSfP++1uvxPhLt9Mv4fai/WIVn+AIiJE8D4gkWetu88MSkbXT51nrmPSAOKQc5
         BsA6h7XVkrj4daMW/egDphELxqlBchFaYF3WFlofVDWs08pF0fqdrJ7LtVec21g7KQG2
         mOMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782060391; x=1782665191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTZ6xL8w0VfRNLuLqZJn3PHMcp8Hl5gfLcIzhzbBGlA=;
        b=cKzo/445AwIugFWvcHDjjZl/z6DDqzoRC9KfP3tVKGBHCk3fz+SKHvIyYVLXOMHNnT
         Iaqzl+3aee8yo8QpvphbvC6jDYHvsrUYGxZqWAMgVPo7sipF9XRJYalTz637aULHRd5F
         PuHxNd+YQ0asHSMs8Pk5ixSndZvFkBg4GR04prb2z5eZDCHVBXqu13dFjaak8aqfi6qk
         pUKQFixpZDbQ8W3/CJYkXlOQRldlfk7lknuiK1hO3UlI5eZgaURnQGuLMPZGQA9ociRx
         WOfaVeISvLsOo8V3tnYfBZ246vN7OXiY6eKD2ZyB786P5QRBo5ESLBgALxkKJf1u4NlG
         oFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782060391; x=1782665191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lTZ6xL8w0VfRNLuLqZJn3PHMcp8Hl5gfLcIzhzbBGlA=;
        b=o3cJDuj8r6bR/ktRHOQKEHsLwhZWDdYvWqK7CyaDHRg0a9IUCovWtYmLPjgszJSCvD
         0T0GDPXYFGnQ0T6xxPYw6meRBlIUP3t2+ciRw3Y4l86t8o0PuuohIsQE6yhdK76qloMg
         As1/O0j/wN6Y33glW55FG+GNrBQsZDFz2Mp/J3HsxNOr/0hGGQoVc9rco0L/YFedxgJL
         BMba9/wiBprYORxnxH7pc+uK4Qr9pnMd2E/hovOV4QudgA3Y9XCz9AfcRYB4GjQ+DEZW
         /HZkLoEMMwSuZsISLsoaXyShxmLdMAyo2B9PqGrP8AloLUwaZOwzN2GOp8ekd3dZczh5
         MPZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Fcn/AHjjPMJz4i02aqcawZF0L7KM39W0w08Em8K48UrxFZszNBEv3EPVsJBD+YYQCdgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTL9np2lea59yoWMY8SGuIGSB6PWc2U6JfE/7JUFez0gOCIxF/
	6SnRlUTIUD88xUMjfd3vrdvjbEMVwlJYR6j+CnJtCTT86TR6o34PrG/rG7xlTb5L1fwnyZL2n1H
	cPxs48Lj767WYEEejW4SfAXDt+0XiUvU=
X-Gm-Gg: AfdE7cmuDYvWb/hQElYG1Z7K64eTm1XVwVAOpPEBMOM3453NJCyvA8bzVd5ZzCtivfz
	qtIYwetZUxxMxZbqE9SuuQtcVTkH0MZCB9DFT4NOaA4W9//QyS2OOms6h1gv4NVSRY1NB/+WjuX
	XIzcixMQgZ8+C8alyh7ukO/lEet3JHBuNSxNK30H4CnQGqKq6EgU5cTon06To1695Yp1xJLSjKY
	kC9VVc02QSAgHfE08flpAonsseWvftMOAnbUq3Z9VvmUF4drEGbjz/wL6RGXEwccnu9kYosw5e7
	pKw41i6pxlGvMPzgQeglTGYe/0+Zq45Wa1DYC7J/0YVexZ8hleQLgqfvfB1Jet0p3BahNA==
X-Received: by 2002:a05:6a20:1443:b0:3b9:545d:c004 with SMTP id
 adf61e73a8af0-3bb3231b3c6mr13340627637.17.1782060390923; Sun, 21 Jun 2026
 09:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
 <pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com> <xmqq1pe0g08t.fsf@gitster.g>
In-Reply-To: <xmqq1pe0g08t.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 21 Jun 2026 12:46:19 -0400
X-Gm-Features: AVVi8CeweMwmtYe0Od8LBCxf4KAGgys6FLk5CdzDYeOz1GY1rl1tKJFoPimUoOs
Message-ID: <CALnO6CBuxz_5x808Km0Z4Y4dh-WcZRKpT1fTNMWOF8_7Pjxt1w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] completion: hide dotfiles for selected path completion
To: Junio C Hamano <gitster@pobox.com>
Cc: Zakariyah Ali via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Zakariyah Ali <zakariyahali100@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Small typo correction that may affect how the message is read]

On Sat, Jun 20, 2026 at 9:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The completion helper for index paths uses git ls-files rather than she=
ll
> > filename completion. As a result, leading-dot paths such as a tracked
> > .gitignore were offered even when the user had not started the path wit=
h ..
> >
> > Hide leading-dot path components for git rm, git mv, and git ls-files w=
hen
> > completing an empty path component. Explicit dot completion is still
> > preserved, so git rm . can still complete .gitignore.
> >
> > This removes the existing TODO expectations in t/t9902-completion.sh an=
d
> > adds coverage for explicit dot completion.
>
> OK.
>
> > Validation:
> >
> >  * git diff --check -- contrib/completion/git-completion.bash
> >    t/t9902-completion.sh
> >  * bash -n contrib/completion/git-completion.bash
> >  * ./t9902-completion.sh
>
> I am not sure what you wanted to say with these lines.  If you did
> the above to build confidence that your patch works, that would be
> great.  Or are you telling readers to do these things and when they
> do not see any issues consider your patch perfect?
>
> What is missing around here in this cover letter is a description of
> how this iteration is different from the previous one.  And ...
>
> > Zakariyah Ali (2):
> >   completion: hide dotfiles for selected path completion
> >   completion: hide dotfiles by default for path completion
> >
> >  contrib/completion/git-completion.bash | 53 +++++++++++++++-----------
> >  t/t9902-completion.sh                  | 19 ++++-----
> >  2 files changed, 40 insertions(+), 32 deletions(-)
> >
> >
> > base-commit: 9b7fa37559a1b95ee32e32858b0d038b4cf583e5
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2=
311%2Falibaba0010%2Fcompletion-hide-dotfiles-v3
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2311=
/alibaba0010/completion-hide-dotfiles-v3
> > Pull-Request: https://github.com/git/git/pull/2311
> >
> > Range-diff vs v2:
> >
> >  1:  056e239e06 =3D 1:  056e239e06 completion: hide dotfiles for select=
ed path completion
> >  -:  ---------- > 2:  7482ee4645 completion: hide dotfiles by default f=
or path completion
>
> ... I find this range diff very troubling.  If we look at patch 2,
> it seems that it redoes some part of what is done in patch 1 saying
> "oops that was wrong, so let's do it better this time".  Such a
> drunken-mans' walk that goes in one direction in an earlier step,
> only to be corrected to move to a different course, is now how we

"is not" :)

> want a new topic to be presented.
>
> The end result may be much easier to read, mostly thanks to updated
> loop in the awk script, so if we really want to pretend this as two
> patches for "small pieces are easier to digest" value, perhaps have
> [PATCH 1/2] that updates the awk script (without doing anything
> related to hide-dotfiles theme) to make it easier to read by not
> having multiple "print pfx p" in it, and then build on top of that
> improved base, have [PATCH 2/2] that adds the support to hide
> dotfiles, perhaps?
>
> Since the initial iteration was quite a while ago, I no longer
> remember the details of the review I gave, but I recall having hard
> time telling which callers of the complete-index-file helper hide
> dotfiles from their output and which callers do not hide them, and
> how the patch decided to choose which ones should and should not
> hide.  Has it been improved and if so how?  That is something we
> expect the cover letter to tell, too.
>
> Thanks.
>


--=20
D. Ben Knoble
