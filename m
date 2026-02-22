Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D83FEF
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771803188; cv=pass; b=EaHUOGAlWURguvjW+ezqY0MiXcX+s+KYyPXBMztX67EyVi1OkNk1xhBoQsiXVN+ypziRugIqNHKdv18Ju0KpPnoy5dxk6ckJeclcg9iCuN8JGfZBblJcGPBq1+qPIp5aew1LuBDgERVXg7A9I5MsEvFSrJvqx6Og2qqggSaPPCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771803188; c=relaxed/simple;
	bh=9qUImKxQBJ4HY3NZMI2i5PF1upTCjjlwnFr/Pigt4Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlqAUPSKr2x//rlgAfI4ugRVj/uc37q8SHwzrEMQaPytGR2wXFIRR5NtN/oRnqDaLhTMBo9X1MLI9krARi5FfZUOAso//kied1yMEAAxKkjQNzJGmsgao547wdvc7qp7vNt8+T9Im7O7nnxjSJLEsPDfZU1eW/h4S6EFgnQCsC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf8i/ncL; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf8i/ncL"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506e287dd53so30585501cf.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 15:33:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771803186; cv=none;
        d=google.com; s=arc-20240605;
        b=Zb3VFN3qJbysnelbJoWPvLRzwfS2Qy96VQfZwy37/jU6t0n5VARHswvKGGFIhtQD7T
         8KebOdbiNhEosZ397a7UvJ2OzISnNvRis+tYT4TtcEanCiZ7XrId59XyNhfanc2BL37p
         Ce3gJ53Vik9qogtJ+Sqfawz+jD4S/W8egQhB4e1J/F5uFNyHBI2I8BQs3HOCUoQkWC+5
         szfTrF0M+nW0LvbT3O7b4EyiIHB9v9a1j/pMMuEbE/iSK9X3/z5KKvjqrtPTeNa3mi/c
         rMs+EBKbXWvudTQE0PTWI2Ep5NZNUBQbPrmyq+c5k2EPv5GXZuoq9tacrTrQ0MdqZieS
         4Upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9qUImKxQBJ4HY3NZMI2i5PF1upTCjjlwnFr/Pigt4Ow=;
        fh=fOfKsK4z23ltzDd9v6rHSXUBGg1St5z4DAQx7hlTzQ8=;
        b=c3szAzIuUWgUGHlwHhsJj8nX6i4UPxeLfKJliUcvlpJn/AisRaKJ8Y+19bQvw+phml
         ydeUSXbdJkUaNtjk5v9Kf1DBy04BshB2OP5FUbwCflsVDowYQz1C4nVfmWw1Mwi6E8Fx
         7NVST3pLbSD+pD0OoU/dsBTDDgq2Bc7Ybcl8AbimH8rLqLBnJk3lxyXt4Q5ZkAF73bK0
         70WmUTHS8l37X5y8ZMvMuFaWXvaDjzw3fAPXGchCf9EOcNktPf/E/5W0/50nW94m5NaD
         nl2+sTcGm7NKu33++PWxVa6Cp1/ghRdGmtzOPUg/CpF0HFlwwpbqANrEfsDeHHkeeEGA
         6d9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771803186; x=1772407986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qUImKxQBJ4HY3NZMI2i5PF1upTCjjlwnFr/Pigt4Ow=;
        b=Vf8i/ncLO7Hr01JCimu7IfgAImdcbwrrFRd/xDXIOFXEShzTmqTK5JWZ9nMMHJkx4o
         Vav1O42jzd9ubRpPTgKmkM5jTpMf7cz8DTX10ExLOC6E2tHrUYtGHYJs1g2XIL/V6CRT
         oBHQ42Ggts3REdHji82A8DVyDjTvr7g0R1xbDV8UDZ0mBuUqejgiaq82BE294qx4EpJv
         cghZAbuSCpkVTyXuJi4/7MClWv5CKaeV9gKEmYTi7+nDb2MwY8KI5xDXAgq3GdwXDPMH
         NNr2r6M/gC/bcJyKnUtLRJK/13ClgwBVfJje6FM0YEcty7wZHK0bdcYrAgtyPVuo4DSu
         0QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771803186; x=1772407986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qUImKxQBJ4HY3NZMI2i5PF1upTCjjlwnFr/Pigt4Ow=;
        b=UyB4V3rbuWswQl9INs7VXUAEOiQH/jCXh2hCAA6+Medk5yHursQGvKiPA6CBp57++C
         7R/qJLq4j6zNQyYM5OypoQL0jB4TtepL7oBTRhffo9urn1o9Xsq+32+ucQjlQab0sQQc
         Zw3mcwHecHmx56fy/ujoAu2PUhrOHB66FTNxbvFV8/7DBum/YesCnX1pc6VMchmo7nwh
         VVg5PaPyIWYfei5r2spH0bLHdjEG4/yR0gRsAdTunGye4VR+1N+FUw6kvWhcQp2Pjupi
         634iNIouSc/MO8FY4txvEt1b+LFLgnb2WhLtNv+mRbY74BShYdSVHVHytNLRkz/0e5Zz
         /Q2g==
X-Gm-Message-State: AOJu0YwDBsBp79J5hDT48gjjpm3Qjc6IHg0nUewYq0AEdnb+m3z4gF9A
	CT3hnXtHm3zG9eULwZBnb9gPlibXEhKZoNwpN7C146yDFRzBmi0Z+tfU4RD8YaBwczA9h4Mdtm7
	Z4htTmimbz7M/U9RUCmTtLL2PmKn8Yzc=
X-Gm-Gg: AZuq6aIf++qtZYalrZVI3d1ZjKE/or77zXU95oIvU2oR+cpBrGSMn1VPUZUyt9Tvbda
	/+OXqYRJWMuTB1iG7Cx759NHU9gUbckXT0qGOOgZkX00iBwQP5Ugoqbm5kJdDR7uzaLSUNcr8Ns
	Cl8y/rcNz3c3fnQuMrLdL5auZIAvyybsxn/E+iLnjLgOLy7bALnJ4ZwwXoTBDFrU81BOCpmB2xw
	Q+kdDMrjMAy+fC1PKT/l/okc+cxv6YOGhvixrHCBniviU5EjLJdQ+FTj75wshVmlwrqyrFzu+8/
	V1RySRKXcv62/wSZ7iKNV6dHbCw7CGnUWs3oUWDTyf/uK06HfMzbj+faweFQFCSLX3/sLNGMsyZ
	jPH5HpvJjBo4mSs8bEuWVi+Qxjw==
X-Received: by 2002:a05:622a:1101:b0:4f3:4edc:5414 with SMTP id
 d75a77b69052e-5070bba6b36mr106803821cf.11.1771803186579; Sun, 22 Feb 2026
 15:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLdSR=NPoD7XEbYPoRTt0VS5M0QhzHcy-OmyuZMMVN-H5w@mail.gmail.com>
 <3C0852FD-59FE-496D-9521-E123181901B3@gmail.com>
In-Reply-To: <3C0852FD-59FE-496D-9521-E123181901B3@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 23 Feb 2026 05:02:55 +0530
X-Gm-Features: AaiRm51ZGAIj3qugKVI1qqZpJoVYdG40Qov7HT-i465irwrB2na0Cxhjsf34tRE
Message-ID: <CA+rGoLeq-bnxnzsYmgFg+Cj3uPW+30ApOMFT_wvrp9p9VRwnQg@mail.gmail.com>
Subject: Re: [proposal][RFC] Improve the new git repo command
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, karthik nayak <karthik.188@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, jltobler@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Lucas,

Thanks for taking time to review my proposal


On Mon, Feb 23, 2026 at 2:44=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
>
> > A list of my past activities in Git:
>
> Looking the Git history (`git log --author=3D'K Jayatheerth'`), there
> are many meaningful patches that you didn't listed here.
>

I agree, I think adding
https://github.com/git/git/commit/ec727e189cce9e8457e2b00e0756cfdf325a12d9
Would make sense too because that patch is path related

But the others are doc changes, do you suggest I add those too?




>
> It looks to me that you're proposing too much here. I mean, I agree
> with everything that you proposed here, but maybe you won't have
> enough time to do that given the pace of the reviewing process. For
> example, my first GSoC patch series took 11 versions until it was
> accepted.
>

Alright, this is tough because to me everything seems equally important
Since you started this command, can you probably point out to me which
of these in proposals are
needed urgently? as in which of these are high impact, and do you
suggest I remove the other parts?

Regards
- Jayatheerth
