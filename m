Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CB1FA5
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117539; cv=none; b=mDBdcXlFhQuJRfS8CIyDkRZUuP39gO7ZlB4tS86T0bHV+vXFNmyT0dYIaBHR2db+8oqn3pB/zaBrL4ftvKUfNRtV2Szq4TBgv8aQmBxqHWnUI01mSa5pa+VsGpURJnJWpjCFsWaRT05l0D152qhP6BaUC1M5UkVBJdZZmjeb/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117539; c=relaxed/simple;
	bh=OMCotSi2vXx9Nixzz3gEzQW0JJcHXqdVFhigfZjR1Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M84gZXhq3R+F/Rf6UhHutDuqOEGp2ATw0FCHSJ/ge5/74OvQNsws4gsnTsijImuLe4qVVzS+Iz7FN0lqYlJC5h6zpLSb1R4ygTSl6F9eR1EBhy+ESvMY5dasCkJuz6ePSJO1TCngT1y74TWlFpLRmu1+RA1tVXpdJVt4cDgNANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c352be890cso5616366d6.3
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 11:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117536; x=1727722336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyY2gXUjxrj0TW5SmXqsv6UEfiH1XhOea5U5pyM1yGo=;
        b=SMcY6rki/zrDqtxswk4anpiY8XXwnHKyKBs+8CrN6KqHtlm6VCLij8eWDORe/6g0iR
         acL4oBEtqSi04DJ6dAeBpFfO+9km5QA/1qB1q/oSIfv6BPuGmC9yUr4wglUe2/qqaMxJ
         HGYg3HEmpDIQK4OyKGee30pJTGQux4D9Bc0+TXgBE3hpPFtFIgGF7eLd0uD07CF+XrnH
         aHlfhf28Rf8TX4Tr4IcmyIjtRXLTHyAKo7rXMwLCf7y0ptxKFI25/WWng8ZHZ4L+bL7T
         0ydKvrT/KRiK3t/bGFR6Sc8TSkawCTfOJjNKRQmhjgGNrWpqOIuyr6xwl9Yupa5G2OHf
         o+9A==
X-Gm-Message-State: AOJu0Yy9Zbbmh3ZWBIJtgekY3ZU2gB0vGmb8Cipmvv1FVETUatyKYgP+
	dmodaloc+R9YLz/glKYimzx1S8BiAA0V2eyUxtlimjz6hlrhZJQW03nAxkOsas2OwqLmELbVx91
	0tACaf/rec4/d9gPSzic5MfgYujYxGh4n1JY=
X-Google-Smtp-Source: AGHT+IGEiaaQimAIHX6fIqA+JvUovAHba9WaNgZxjWmHGUYRT3f/ELchJQVO0YJa9ZjbxiH/3EfHAS/HrKanNMp5nVo=
X-Received: by 2002:a05:6214:d47:b0:6c5:1413:21b6 with SMTP id
 6a1803df08f44-6c7bc694422mr83042856d6.1.1727117535988; Mon, 23 Sep 2024
 11:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
 <CAPig+cQ8=Y6sVvN_dBo_GQ5nLkQ4GJ7AM6mE2kt_2QV7CR0omg@mail.gmail.com>
 <3b579ddd-b386-4daa-ad63-1e75522b7462@stuart.id.au> <CAPig+cTkpLLoTxTa-8xfycNGFibN_M71+kkHtT-wgp6HRPi-aw@mail.gmail.com>
 <4781ff6e-c20a-4340-851b-c9d324d1fac8@stuart.id.au>
In-Reply-To: <4781ff6e-c20a-4340-851b-c9d324d1fac8@stuart.id.au>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Sep 2024 14:52:04 -0400
Message-ID: <CAPig+cTop=2+k0XbqYbsCTbJVo77evY+_a+FqDV_ziKf2q+Dzw@mail.gmail.com>
Subject: Re: "git worktree repair" modifies the wrong repository
To: Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 7:40=E2=80=AFAM Russell Stuart
<russell+git.vger.kernel.org@stuart.id.au> wrote:
> On 19/9/24 20:47, Eric Sunshine wrote:
> > The idea of relative paths has been discussed previously[*] but was
> > never implemented; although they may help some cases, they break
> > other cases or at least make the other cases more difficult. For
> > instance, relative paths only help if the main and linked worktrees
> > move together in some uniform fashion, but don't help if they move in
> > distinct ways.
>
> If breaking when moved is the criteria, then absolute paths always
> break.  Relative paths break slightly less often.  So it seems to me
> relative paths are an improvement - but not a fix.

Indeed, I don't think anyone has argued against relative paths
outright, but only pointed out that absolute and relative paths each
have their strengths with regards to making the repair process
(whether automatic or not) more robust. It was for this reason that
the previous discussion[1] eventually settled on the idea of storing
both absolute and relative paths.

[1]: The discussion begins at the "Also Eric" paragraph of this email
and continues in emails following it:
https://lore.kernel.org/git/CACsJy8CXEKG+WNdSPOWF7JDzPXidSRWZZ5zkdMW3N3Dg8S=
GW_Q@mail.gmail.com/

> It's always possible to break something by moving the wrong thing.  For
> example moving the .git directory in a normal repository would create a
> mess.  Yet, unlike moving worktrees (most?) people do not attempt to
> move the .git directory in illegal ways.  They always copy/more copy the
> entire repository.  It's intuitively obvious if you keep the .git
> directory in the same relative position, it will work.

This intuition perhaps arises from your background with "hg", but I
have not formed any such intuition.

> So my uniformed guess on how to "fix" the problem of people
> moving/copying worktrees is to make equally obvious they must remain in
> the same relative position to the parent.  One way to do that is to use
> the same structure hg uses, which is the child worktrees must all be in
> the one common parent directory, and the parent directory contains the
> .git metadata.  It then becomes self-evident you can only more/copy the
> entire thing - not bits of it.

That's a very restrictive and limiting organization. As I understand
it, one of the design goals of Git's linked worktrees was to allow
worktrees to be placed anywhere, including on removable media or
not-always-mounted network drives. (Yes, you may be able to do
something similar with "hg" and symbolic links, but that doesn't play
well with Windows users, at least not in the era when Git's worktree
support was implemented.)

> Interestingly, people (including me as it happens) start out by trying
> to emulate the hg approach using a single parent directory to hold a
> bare repository, and the child worktree directories.  Then they discover
> bare repositories mangle the remote links, and give up on the idea.

Can you provide more details about this "mangling"? Although the
use-case you describe was not directly considered in the initial
design, worktrees hanging off a bare repository became an
explicitly-supported use-case not long after worktrees were
introduced. So, it should work properly and we know that people use
worktrees this way, but we haven't had any reports of mangling in this
scenario.

> In
> my case I then tried moving/copying the worktrees as a group using "git
> worktree repair" to fix the mess, which eventually lead to this email :)

Moving should have worked, either using "git worktree move" or by
using "git worktree repair" after moving them manually. The copy case
was broken as you reported. By the way, I posted a fix[2].

[2]: https://lore.kernel.org/git/20240923075416.54289-1-ericsunshine@charte=
r.net/

> Others have published of hacks / tricks that try to solve problem in
> other ways, eg: https://github.com/Kristian-Tan/git-worktree-relative

Interesting reading.

> None of them work very well.  Going on what Google throws up, moving
> worktrees remains a commonly felt pain point.

I suspect that the best way forward is to store both absolute and
relative paths, but this needs to be done with care so as to not break
existing tooling or other implementations of Git or Git libraries
(including older versions of Git itself).

By the way, have you seen the patch recently posted[3] to explicitly
support relative paths for worktrees?

[3]: https://lore.kernel.org/git/pull.1783.git.git.1726880551891.gitgitgadg=
et@gmail.com/
