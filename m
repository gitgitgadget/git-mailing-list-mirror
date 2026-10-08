Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E414D4885
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483061; cv=pass; b=j+rToO+SpWSLNAj9H2KQyf9+hOQe3CTLF7y+gFQ/8yLXGRc4N0x/Olt4a1jEa3WI9/oC6B9rNq9icHYDkUK9rBVrSl8XdvZNE6vNC3B6XXi8j/hnZ7jEnWVacG4MzBgE4F7iZUZixkSsX7yCQySSSjQKj7xuDCJKX6YDwrSZi/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483061; c=relaxed/simple;
	bh=3WJILIEqCdZWgI5/wLvhd/HT9qHJ4HVj8kDkvWna+vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSvrJX/yFGivOXi5V7n6qdirssBay+s0yftHmkSktbhVGLn6nWJA0DcNgq/vPpIdF4XcM1dx5pKKBf8DIq0sBV8WUZw2GzJjSrRIq5MWgdCtgZ3i8CiJJkYSVngI7YA9OcDsLO6ja0A5XzhLazx/BXtLCrvRk9m89EoQRC87isQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHTMKJH1; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHTMKJH1"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbee846deecso3985931a12.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 11:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791483060; cv=none;
        d=google.com; s=arc-20260327;
        b=WvLLPyTWwkJHUL5iuuQ38LyUw1VDXW0QDAV+DuFHbKEomQNgulzr9P+DOjZ7cYarXu
         Z0lrlxNIRLTzAREywtXbH3BIP07lFqrI67XgRpt4tq0xRuuehri9bbBf0vTfmKW1hgiM
         sU1kE0lZoIfGBEFdjeV7Su4FHi1060XiaGxor6u5Ge+Vs30cen8TIf5poQ5x8krRLJfv
         A1Zck0r8VRVEWNL9CqdnIb6hthl6+fZpAvBCnraQuynBAOBs6HE7EnYbSg9AHvgSkct7
         SQ5/8u6qrfP4ZYulICe6p1A5XQqhYnjL5vtzA++ycX8RgJclhwfq0STvvhmDo7DgHyHK
         DtYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3WJILIEqCdZWgI5/wLvhd/HT9qHJ4HVj8kDkvWna+vY=;
        fh=1lA9mv6eQeASw2iw4K5jGFda0lnI9rvSEJBUbRs88X8=;
        b=MOGd2SUMUD99xvuhcIv9GVl5JkWfIfH0DBuNq+By5AG7WWVkLeQhon4lBKBAnRxUtV
         nMdNudk4GWyNjUs98zTuFXAgkQfDvQs16tCWYje3Da8W7NHsCBzAq5qoxhofy7TfhTfk
         NbUYTATfeVewV6TYPKkaVR/t1I07r+HnSpuWMWmdzjcxBwyAN5voHWZABeN34liyFlxW
         4bDPP3AZguicPI/dCz/mkak2BIuT5L2G4Vj3pGYBdC0cxIiXzF/onxXLD5Qa/VW4m2VS
         GyBnKNEReZwUoSe6/fLNSzX3D73Jg7OdFL4jHiGCDXzCzsOhxqBsVBhz86+LLNVjIyeJ
         wteA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791483060; x=1792087860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3WJILIEqCdZWgI5/wLvhd/HT9qHJ4HVj8kDkvWna+vY=;
        b=HHTMKJH1ufq05ww5D41UnUdHO/q+qSV1P6W/cowaE0vpZ2K/jlNGREjbX26+6ruawN
         UBwXGJzmUzCT2opBsecr6GFtzET247I4siSr4EheTM1sKCIA9uz5yEPCEUWq6qvoU+rW
         zLYClEvS7GHBPp3XKRl1ncMXf086GsRJ0lQGNhrtI/BFZNBqV8skh1JqduOX7dS9ZTPa
         qoURtziIiJPjFEje3sE6CGpY7e/drqy+OCffm+ViycVEuOEDFDCuyoXleruASBIdCyeo
         uoFd9QI3HbCZbVlFDwDWWXWm+FgqPVCfsdw/dG3pJqNOX80BxRyvxHZCo4nygK5JUFQr
         mE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483060; x=1792087860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WJILIEqCdZWgI5/wLvhd/HT9qHJ4HVj8kDkvWna+vY=;
        b=kDdyYszdUgCm3Ag73YB5zKYoG411nRM5rLbyBiuwxuNUXAZqniJy4urBggCLSPYUC9
         XSLGmctct9uAp91gDDmRe+DqtABJ53MxAk5cIkYnBwNL2ki/zM7mW79xg/si6z+/UaDx
         zE59EedATzi6DzoP0sPmdPPJ8D5l3o7oPY7JlsnV4FI5Cw5HgfZY5beZZu9yGSgypcOH
         K5vwOY6F/7uUfSPwngTsq3gFAAabur//M7r6Itkg7qeHnxtRXRWkoqLmVeOoWXg4hOQ2
         kddlJYbezXc3v6j9qjuBhzX+hfvcCf708pAhuIG4eQbeWojR1i+x/1Xq2EPuWgt9Kauy
         MQPQ==
X-Gm-Message-State: AFuF++k9GTPbtO/1fO18AdBLnU0EeDrq6MOGkkzAdmRV7YSJsW/Ebe1N
	mHHzTf0bYSBEEzEfMfdoVy8k2CwkYtLOnO7r+hggs1oSMHLIsuKbBBoMpW5e4Xv4pRsWCNx4l2q
	tFYtaUWS+QXdh19BB5DQ+fXceTMO5254ksneiy6E=
X-Gm-Gg: AYBFou3NPyrVjHhlTJ1T81qDtskCNrj8Lyez4IRUKdeVAzhcVnYBFs9pYnhyhxCwn/k
	Q+s2AEH0yC/QlLy9bpGK5VGZrfAzzfZFKP65rvJCwmnOYVcmHAtcxy0Fu/F0rsFfJrXnptmx9d/
	9pXfR3lKJ7ahphuuKtQEsgQn55kJxUW35xrgmpDVa/S+l2mJy7JaqAM/kEr8bh+L2lDENOdL13U
	WyJJtDyQ0Rb9NX8zZY+iH7xkQ+lHOp1n9dqghiLlGJk83vWo/yP2/LLkmS2bl3NCJqqv5RseQpI
	UqQ6wiCRZ+vTuVfDKkdoqAOwVh/qZEcMLssPfKDAKEHzlsa8zS9yoQWYd23zdxpbR7WrLwSbcY6
	9VhPcAeyNlu5FdNd1C7IQFwdKaVcK5X6z88AMEK0/574aRDRdeVHsoYTJB2dOJe2boKaIAoTnjN
	1NtMB95+5klwUd+gWXF8brA/XRfnueYw==
X-Received: by 2002:a05:6a21:1507:b0:3dd:a197:edf4 with SMTP id
 adf61e73a8af0-3e134113d52mr6235663637.67.1791483059440; Thu, 08 Oct 2026
 11:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007142954.31761-1-scott@gitbutler.net>
In-Reply-To: <20261007142954.31761-1-scott@gitbutler.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 Oct 2026 14:10:47 -0400
X-Gm-Features: AclHuK9eG2AFUYfFdD48AudVGX_rxXDDbKbj_DESDABFLVJu0lJB4Vi9DmNnOpM
Message-ID: <CALnO6CCc77K6bg0tUNnYg_yORTELnJ=UgoL610YJeQUe6UWBjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] SubmittingPatches: allow responsible AI assistance
To: Scott Chacon <scott@gitbutler.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 10:35=E2=80=AFAM Scott Chacon <scott@gitbutler.net> =
wrote:
>
> After the AI discussion at the contributors' summit [1], I'd like to subm=
it
> a concrete alternative for allowing AI generated work responsibly. This m=
oves
> us closer to Linux's approach: use the tools you find helpful, but take
> responsibility for what you send.

If you'll forgive me going a *bit* off-topic, I'd like to point
interested readers towards some starting points for fascinating
historical reading. It turns out, folks have questioned the use of AI
and tools for a long time, and we have a body of writing that examines
the impact tools have on us and we on them. So there's really no such
thing as "just a tool", in an important sense :)

Some starting points for going deeper are linked in the following
articles (on my personal blog, but most of the thinking and references
belong to others):

- https://benknoble.github.io/blog/2026/09/02/tool-dialogue/
- https://benknoble.github.io/blog/2026/09/20/turkle/
- https://benknoble.github.io/blog/2026/09/21/once-more/

And relatedly, some reading notes on folks studying what it's like to
actually *use* LLMs (albeit not exactly in our context):
https://benknoble.github.io/blog/2026/10/02/reading-notes-configuration-wor=
k/

I don't think this has much bearing on the conversation about Git's
policy other than to say: I don't think we ought to justify our use by
saying it's "just a tool like any other"---not because it's unlike
other tools so much as because the tools we choose and use matter;
they affect us and the people around us.

(I do appreciate that Scott's proposal has elements of taking
responsibility for what you produce. At RacketCon last weekend, a
maintainer put it a bit differently: "Review scales less than code;
manage your own backpressure.")

Somewhat more on the policy side, there is also the (polemically
written, but valuable nonetheless?) "AI Pascal's wager"
(https://ploum.net/2026-10-01-pascal_wager.html). To quote the
conclusion (note: "abandon your project" *also* seems like a
fear-mongering the stance the author tries to reject from AI boosters,
but let's try to take the rest of the argument in good faith in spite
of that):

> While mass marketing is trying to instil a Fear of Missing Out hysteria, =
the most rational and pragmatic approach is to strongly reject all AI-gener=
ated contributions to your projects. For now.
>
> Someday, we might realise that LLMs are doing good in the world, that the=
y are evolving toward ethical, reliable, sustainable solutions, and that pe=
ople who use them are happier (try to read that sentence again without roll=
ing your eyes). If that really happens, you could always change your AI pol=
icy. It will cost you nothing.
>
> But if you let the slop in now, you may regret it forever=E2=80=A6 You ma=
y be forced to abandon your project.
>
> On the other hand, if you refuse AI-generated contributions to your proje=
ct right now, the worst very hypothetical regret you could ever have is "I =
should probably have done it sooner".
>
> The conclusion is simple: If you are AI-agnostic, the pragmatic course of=
 action is to strongly refuse any AI-generated contribution to your project=
.

"Wish we'd done it sooner" is definitely the boat I'd, personally,
rather be in down the line.
