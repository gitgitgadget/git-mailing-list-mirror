Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F932652B0
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011244; cv=pass; b=WEmmelP6Y4TC1oaYNp5ufW/yHakMYYxPwSpcTYx8JDXcP9C67CVp/lV+5PA1UiDkxYkma3D0E5nYGv5GACuacJYP8MBKDnM/rq37tqchYyqOX2VB37vILsgIJ6D1Kzfmws7Z+KiHsKUUtjXDJp6JkxNIZK7iuaGYQYaXdBmwbQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011244; c=relaxed/simple;
	bh=2LsxMAcZ3L6VwRDGj2BmiOzTzycSK+gNz0crRr39EAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mtda8qjLK6J4G/TAecJAjTaru81d5Yw+dbJYpECHdXwSok/7fYPpNfy0aa1x+cLKqSxarvSAdAFB8xAklW4WUMHGaPhM5+4uD8xGj2coHLr2XkbO6J6TnxHPyU/OpSZgSuI0Fb4bT0wSnHGfQ5qf3NYB09I6/sT5QtTQQyeWTh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKA9jItg; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKA9jItg"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so7036882a12.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 06:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781011241; cv=none;
        d=google.com; s=arc-20240605;
        b=PWyyHu2bwVIFOWPetOZYbRx8/hP8Qwd/jzlDZxuA+rMHSw5+cDTlAhIOKLelrGs8Jq
         7vusblPWS+Iid/hrS+tBu2QPlSWwVK2wo7yb8fjBrHnpx5ZjhJmMND8aVgVdo+gWBYP6
         EerYdYDYFl/2mD3bwHCerrUIoMoCLoS2ix7Df3F2zaYrC3iSl6mrZVCDR4ifQe+FThZy
         V129UQIuzw24Hg6621+I42flhlBp2EXgcYwa67e6G4W5I6xIUx5mZj/EazZ6jon3icAa
         ER+F8jOhri8WsusOObGBJyQo3+ZyuUPmn1854MwCwRK3tJ7OyIX1c7Ca42Kjr2G9NCJb
         Um8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LmNuQqzTwnQQMqRRX35my4pBTFNDnlfTZeuIn/V+t50=;
        fh=XNrnnaEltYM+EQh9HKHNyEpL8r0DhJfj9mnINyKB9GI=;
        b=kcL6Z4ue6zLUYHOGGsNvCfd+XAKteIC/060wtgSU4LoPWqSxGtf1bFZmdgWPwlACRH
         Is06MBnEKxp4ElA7oueRwykOTVEKLsJ3/oRyzwpUQPgXJasqlq4akOPNILslekXEI6dI
         hrZPxwT1SPQ13C/eKPeYGfMQs65CmWSPQN47NbjEfHZpbp06kbC+JYj8JczI0fhPtsul
         qalyJLrHAO5q2eXdAMiPA/4p4XcEZSn4Tf03xyaEUtvnaniqrXjpwOND0ScT5PWm3KcV
         vra/OdfNIWg2TBf3/OR5svf1uBejhmIt7N3Hy94VdLq03oD5ffiU7mxs81m0JYXGqiUe
         MgZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011241; x=1781616041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmNuQqzTwnQQMqRRX35my4pBTFNDnlfTZeuIn/V+t50=;
        b=DKA9jItgTrJjmv2wDqrhAaIjh7pv9o25x5yw5l6Oeivn435Oa2Vh77dqdpldhxJp52
         3DiI/nfPRpmZlhoIc7dOrQtLTMRjVJvbGoA4Laa1Vxco/Tge8V9+uofbhwYXqwY21Y10
         wysP2ZL7TaHxT9WJbO8CYj1E85nNiB8oLTmyksYSZi4FBXiw2oqupWuV7EtFSxgGBsac
         +MollRJ/v1W7fp+lHAmjuz2njGC97+lZbv4cWBi21uBPvGa915LpMIhMwVn00Th1mcqu
         X1kmLsVy5IzG6NNTBoJ4UIGaqW7EHj0m4QRXO11NTG9REl20XMqPzInJ3HM2gEvLv0Ke
         eMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011241; x=1781616041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LmNuQqzTwnQQMqRRX35my4pBTFNDnlfTZeuIn/V+t50=;
        b=IwKHxbpuVc0/oyy1deHwIoN01cSODn0m2ghuT3BeeLb50zbl/G5iQWmFvKwrEfE2Mp
         I8ls//wG4U61PY5wGwW8yKtqFf2GjH7D5H4XgXdHiAKFc5jdAdTNEVh+SQ0iq8I4W/Ls
         KqytOQJnR/oRAHqQHfVKWgai3QzB/AXF74PWZJ8sL2AjV9HGV/OYdijvKf/YxCnIXM/s
         6PHkn0YuSOvb6DV9oN4Momh8RhvbabNM5LwYS/j0ZNi6zEazz0ryRHzZLc7CPH1P7Fj1
         LEnNhQCi0So3jeU7wSlbsgt8b63++fCr2idjeayDjMJKBxigYSsFdBhUbaVtSuYcmHzP
         EhLg==
X-Forwarded-Encrypted: i=1; AFNElJ+42Q0fnee7wo8tQvpm6TiYVfkrlyGXAv+Tr7L7ZjQVl+TJjXdsQ++kqZbWpkqu2RQTKGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXPcsCM0V7ztFGPqv/7/fzJSrreXI+5mRGB8v0ZcPn4mK1fIl4
	xG5/wKz7DsbTkSCNWJ7vDHhK24zZfrjrrbsDapZ4pyuLFWK+X+0d/WP50wsxBomARqa23uuslaA
	g6n6pjq9BxsVAjYHp2yt+DHhcGcRhuaY=
X-Gm-Gg: Acq92OFaqPOUJII9AbDpE3KvfekuNQRtG/BA+1H7Q0sid+wzu+H4/5jJIbPz/CXI9ZB
	2iGECJ9GWnVhnE3evutcby2tl2PWboJDIok5XHnAZigMg1btnqapzR6CJWeW6YUwAxuhl0iYvwc
	Z5YeZDqvGizih1JDN+nh4IdEhr69epsKD4bJegIAtVgEV6RnBb8KS6CEJH6iJZyHKpTdG2fZwti
	MhgKXabc1ayQqpeA5UOwUoKSvkETbMGi+mkyHK4iRelAlUzrXXE2t/CmQnc6luJ2F8N8hI+6o+s
	eSFj01zkK8TgjgomQw==
X-Received: by 2002:a05:6402:a504:10b0:68f:cc95:8c11 with SMTP id
 4fb4d7f45d1cf-68fcc958d5cmr5555658a12.28.1781011240985; Tue, 09 Jun 2026
 06:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
 <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com> <a7672713f67d6a44992c0f0cf989770c7e9ca38b.1780684553.git.gitgitgadget@gmail.com>
 <xmqq4ijcvb64.fsf@gitster.g> <CAHwyqnWpkF-8czt8+G4GJpMTb1qXG6FtN1HKrT5H+OcfAjQL=Q@mail.gmail.com>
 <xmqqa4t3ubwj.fsf@gitster.g>
In-Reply-To: <xmqqa4t3ubwj.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 9 Jun 2026 15:20:04 +0200
X-Gm-Features: AVVi8CeFZdnA_pfDPItg9iaozoFRdc1l5qL2DW4dEsxUwly9md2DSwGFOUJrjXw
Message-ID: <CAHwyqnVBL9F8tYgDL7B-auFKHVXT3g=R=PQ-W1hp38P3qtqyEg@mail.gmail.com>
Subject: Re: [PATCH v13 2/6] branch: let delete_branches warn instead of error
 on bulk refusal
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 2:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
> > The GitHub CI has been broken for some time, maybe I should have told
> > you about this earlier, but it coincided with a period where other
> > open source projects I worked on also had mass CI failures, so I
> > chalked it up to upstream issues (GitHub, Linux, etc). But it seems to
> > have not gone away.
> >
> > All of my GitHub pull requests have broken tests (see e.g. which a
> > quite minimal change: https://github.com/git/git/pull/2313). This
> > makes it harder to detect actual issues. But of course it's not an
> > excuse.
>
> FWIW, the breakage was observed in my local testing, and that is why
> I found it so disturbing.  Apparently you didn't see such breakages
> that can be detected so easily during your local testing (otherwise
> you wouldn't have pushed it out to update your GitHub pull request),
> which may mean something in the test are platform dependent?

No, it was broken on my local machine as well. I was sloppy when I
pushed out v13 and didn't run tests locally.

Usually I will push to my GitHub PR incrementally as I work on a new
version. I don=E2=80=99t necessarily keep the GitHub PR clean between
submitting versions. I will diff against my latest version tag to see
my own progress, and if I mess it up I can always hard reset to the
latest version tag to start over from there.

Normally, I would never push out a new version unless the GitHub CI
passes. But it=E2=80=99s been broken for a month.


Harald
