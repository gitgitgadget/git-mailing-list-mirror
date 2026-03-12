Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26F3CF03B
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339212; cv=pass; b=djCe4BefCgmf7vNMVJOi9qFwjTwfQTbRoXNXlOxefPMOrdSOuIHFL6xh4N/yyAE3PLsZ3kWB/FEm+qornIG+h/HLxJTS92Yx748PeHGvyBQPZM+Gx8GAmsSDhQyyaKhNkZvRk07ZVeGahN9Kavd3Su/Qpto1khzl/zBBlEslxd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339212; c=relaxed/simple;
	bh=lRBlR1/whPyCV/5jQeWagPLJDrn/AFnNrnLYG93KRfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiBJ8EdUbVimYgNF02tBT4jUsbxlIz59e90NN4QAtIlzKuYNh9z6Emdh/6eFqIackm9bqzt0RBX6JhE1l+lmlEZr9VOzWrCx2Z5OTNqVvREHPxAAMJ5q4YItNzgW6kZa1S7X2nrSnDmMNOV/HJlZT+16q+xEagzv8EXK+d0jV2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrlpW0gS; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrlpW0gS"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56af4aa4e41so1255909e0c.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 11:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773339208; cv=none;
        d=google.com; s=arc-20240605;
        b=esIl6ybJ3MLTeXYBKgd0ZjlhgQUNLkYZr+kQUpemrZjrv+nB/IA4X5h7/pgvGcW+Rt
         qFJa4aP7oKqeYYvV3t93aoQM+/CUCF7AugTA0VXGErXnC4xPnU+ukiwg45wHJocwYY3w
         Pp5ieTAhEH8xivuFyd9p8jJtFk7VNC90Ra2W0qctUOWBWcyzr+CWMWgsDDkxZc51fjlY
         ubG8vtbkoEYm+ae9YuWVnBr281LezGFtqjMmPnMHgZDouFVcUVtSP1ZoXG634BklIsmL
         Fv49m/PtDSPUc8x90KYt1Mj/6AKZ+sDXTXR2QgXrDJAJkla88HzOc9Hux57KQmNC7ais
         J08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PfSeKqjnV/WHDe4QCr2yIKcfQL2ozkIkXt1+qj4p0A=;
        fh=WxJDLsNVRo1wf5vFji93+va6H8wEgP2QdDPNWvboC5g=;
        b=a2b2kk9DnrBECRYt1cxE8U5X3bw56DSzNBnz+dhxeOt5uJs4Hgr09W1qKVd/9ihAvV
         EJ9zrqR5qklMgl61Bs4+YJ26vCDmK2jRfK9yl7hJh86Bazumxk9lMQhD0VBz85mlvNdQ
         dBsfueIqfk1hfk0zEfwar5JuGhZLuAfwNxexvEZZUAqNfusNPNkikd6j01JfsQK+iQnN
         3FaRTIY6QVG5QnqFtDchp6x9xHhvF43NBaCbnpXZCEjJhLIrjCDeYPGMgB3wwy/W9fGh
         Y0e1OsG/KFSicIdrgVtQCO7k/r7tPbeNRbn8SB8y4s016X9KNhJF65xzqA9R08vwhdZJ
         q6Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773339208; x=1773944008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PfSeKqjnV/WHDe4QCr2yIKcfQL2ozkIkXt1+qj4p0A=;
        b=FrlpW0gS1wuUyX65OcsvKr3qnvwI2jcB/qe/rHrsCubUXM3tFSifqUYmVWs03i/k2s
         nod8a1YxUNP14hUIuLy8ee4c0VRcsjXEOEpPPqvTUgKrsgcYiTjd9QK8bM8GvC3Fep2T
         VMR2wlNha9eKYFpIkkqSTwelGajkjfc5TOAbtUe4HVQ8YorQm5AQCqe8lSgxY521L7SJ
         B+cwD+lWoXu2oYhej9E1f6SGBIDHdIjKlkTtdTzTqQyemkStKRhdTq3wezIZ5ujJGuni
         tdiEwFYNRysChIvlEUVaq4uNQIPRDtZ+/j+fw7uadXXzjQXc8OX1xOipo7TbWBKJGDl8
         5v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773339208; x=1773944008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PfSeKqjnV/WHDe4QCr2yIKcfQL2ozkIkXt1+qj4p0A=;
        b=WjydgaAmnRtGIz1CPIiHQZlJI4PJ9N3Kg62g/4J2QsTVnMqsWEbHOcviEMK8fMFkj5
         DEgjvw/X5kUb/A2XQjiyhDRyA5dQaA4pOo2UDh793c0lYWFtB2Dhbw/Lw4pGf6KGtvbF
         09y6VPXfij9ZzPjw+xrN6YPF4ovm6jt7RCsCu2hhQ3rglCM+Z1J60LZCswfnMtsVopVG
         iNti1AHNMmc1EJqUABiFZXDnY4g1Sbbnc3dDqlz88Nt+W5hhx9FSk6kDF4pcQAIU/v7K
         xAkLJTUYCZxFE3kf3hun3C/vWRnXNEaubC6CIPgGm/PSCfeeVQnu1PV4DUep396KDQrU
         wSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOmc8kP77BY17yjGmpcLzfZX3NVqIaR02HX68jKChMUDUVZMadG2Sdb4DsHStpMErVu74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZghdqLIUV2WhPyUg/+ucBdv1rKwoO37ZCisEmF5wU0ImgyDj
	nTgwxNX8JWtWvlTjJTE7yYiT9rcOGD0lwpOdepc5PraTQOjiZiSS77ohCCGCEmnbDX9njI03NUW
	JDmrfwyTIydz3Fm7xOg+nOX00m8KR0aU=
X-Gm-Gg: ATEYQzwc6P+AX4nikh4wt+zu3YKZtD2h3zxHpNNjw//kr9bHFdU/q2gldCIykpDb7rR
	+eKhkvLJksEfR48jn/59bfcv9x3gxl/hbWS/NrRRNcQ4behwcEyzWHB/Ih2I4i8kl5FZZwsv/Qx
	Zw7Afo8HBDYYra1DIKGrEJKXsYrkNp95gSgJ4iEsT7W39srYD1bv/acfYKuOfObEu4ElA/bhxMj
	2XWeF+4aXabssTrhlyyVzk7KJ8jxC0qcpXCQR2Ju9jIYp+lgA/QJc6bU/0WKRXgPnWFY77YbS/+
	TuMhtqCA1i2d/k52moG5ASWuYaO1GGLUq71uav/tLKaqUTrDODmiH90wwoHdDAF80YxNl0Ig7ka
	VakHQh/syO7g3foUju/MS2WtqoilVFDjP+cWfGmhFBjqj4xevWxPnnacQ1u4nEi43ts8glKrPMY
	5YR1IQCDtdcMZC9DU=
X-Received: by 2002:a05:6122:554:b0:567:2200:a6d6 with SMTP id
 71dfb90a1353d-56b527f0ea1mr1989507e0c.7.1773339208532; Thu, 12 Mar 2026
 11:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
 <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com> <xmqqms0dghgk.fsf@gitster.g>
In-Reply-To: <xmqqms0dghgk.fsf@gitster.g>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Thu, 12 Mar 2026 23:43:15 +0530
X-Gm-Features: AaiRm522uv-NlurqxoUMm-eW9CrOUaoNHVe5q33SwYVTkkOtyLIoc3-uAwI8pSc
Message-ID: <CAOAgETN-UVtee5OjjcLE45sRxajCkgF3nipBqXpec4JjN8+vfw@mail.gmail.com>
Subject: Re: [PATCH v6] unpack-trees: suggesting 'git checkout -m' with its repercussions
To: Junio C Hamano <gitster@pobox.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes :
> The commit message should focus on the "why" and "what" from a user persp=
ective, following the project's standard format (problem description, then =
solution).
> Also showed an example for the same.
> Also, note that "extention" is a typo; it should be "extension".
> Having said that, I am not sure if we want to suggest "checkout -m" in th=
is situation after all.
> Pointed out the difference between "stash" and "checkout -m".
> When advice requires a multi-line warning about potential data loss.
> The goal of these messages should be to provide a clear, safe next step, =
not a list of advanced alternatives with caveats.
>  After all, the users who need such an "it failed, now what should I do t=
o recover?" message the most are relatively inexperienced users and we do n=
ot want the advice to be overwhelming.
> Suggesting this "one-shot" approach to a user who is already in a state o=
f friction (and likely less experienced) might be providing them with a "fo=
ot-gun" rather than a helpful tip. Generally, advice that nudges users towa=
rd the safest "golden paths" like stashing or committing is preferred.
> For a microproject, you've successfully demonstrated that you can modify =
the advice system and update the test suite.
> it might be better to drop the 'checkout -m' suggestion and instead focus=
 on making the existing 'stash' and 'commit' advice as clear and helpful as=
 possible.

Thank you so much for the valuable feedback.

I will redefine my advice and will make it more precise and will
change it to git stash which is truly more beneficial for the new
users.
Also will update my commit so that it is properly structured with
format first "why" then "what".
I will create a v7 with all these changes.
I am really obliged.

Thanks again for the guidance.

On Thu, 12 Mar 2026 at 21:36, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Arsh Srivastava <arshsrivastava00@gmail.com>
> >
> > This comment is an extention to the already existing stash comment.
> > Added updated comment over the already existing function
> > "setup_unpack_trees_porcelain" with "git checkout -m"
> > and its repercussions
> > I have also mentioned the repercussions of using "-m".
> >
> > Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com
>
> The commit message should focus on the "why" and "what" from a user
> perspective, following the project's standard format (problem
> description, then solution).
>
> Consider a more standard phrasing:
>
>     unpack-trees: suggest 'git checkout -m' when checkout fails
>
>     When a branch switch fails due to local changes, we suggest
>     stashing or committing. However, 'git checkout -m' is a valid
>     alternative for users who wish to carry their changes over via a
>     merge.
>
>     Update the advice message to suggest this option, while
>     including a warning about the potential for data loss if a hard
>     reset is performed after a conflicted merge.
>
> Also, note that "extention" is a typo; it should be "extension".
>
> Having said that, I am not sure if we want to suggest "checkout -m"
> in this situation after all.
>
> The added message is quite long:
>
> > Try using 'git checkout -m <branch>' for a quick fix.
> > Please Note :- that using -m (merge) will not save your changes,
> > rather would directly merge them.
> > Meaning if you are not able to resolve conflicts and does --hard
> > reset your local changes would be gone.
>
> When advice requires a multi-line warning about potential data loss,
> it's often a sign that the operation being suggested isn't suitable
> for general advice. The goal of these messages should be to provide
> a clear, safe next step, not a list of advanced alternatives with
> caveats. After all, the users who need such an "it failed, now what
> should I do to recover?" message the most are relatively
> inexperienced users and we do not want the advice to be
> overwhelming.
>
> The primary concern is that 'git checkout -m' is a high-stakes
> operation compared to 'git stash'.
>
> - When a user uses 'git stash', their changes are recorded in a
>   stash entry. If 'git stash pop' later results in conflicts they
>   cannot resolve, the user can always 'git reset --hard' to get back
>   to a clean state, knowing their original changes are still safe in
>   the stash entry, which they can re-attempt to use later.
>
> - In contrast, 'git checkout -m' performs the merge directly in
>   the working tree.  If conflicts arise, the original local changes
>   are immediately replaced by conflict markers. Unlike stash, there
>   is no "undo" record. If the user realizes they are in over their
>   head, they cannot simply "abort" to get their original changes
>   back. They have only one chance to resolve it correctly, and they
>   have to do so right there.
>
> Suggesting this "one-shot" approach to a user who is already in a
> state of friction (and likely less experienced) might be providing
> them with a "foot-gun" rather than a helpful tip. Generally, advice
> that nudges users toward the safest "golden paths" like stashing or
> committing is preferred.
>
> For a microproject, you've successfully demonstrated that you can
> modify the advice system and update the test suite. However, for the
> health of the project's usability, it might be better to drop the
> 'checkout -m' suggestion and instead focus on making the existing
> 'stash' and 'commit' advice as clear and helpful as possible.
>
> Thanks.
>
