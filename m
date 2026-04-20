Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A082D7DDD
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685136; cv=pass; b=fNcThy1ppjUuLNIFLlhYnyikA59QlLKn+TOWiuILpCttPXoVroXLlNEgQCKOZQbC4JDJNOvmgckjtJxyDDC2ctEiJPrZiB51BjTRc3ZhdBW5uCUlhQbXWsHWUcCo8KSAepq1ngZjgZPAAUsywzoKS9bmBo4ma6GDL4J2u4WV/io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685136; c=relaxed/simple;
	bh=yS7/htwcrWvqhkaRmU1Qoy0QcwBs5qnOinH9mpVmOj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m005rXD6dwAnINkhWB7KSNxf6lqmyI3bktNJNQkYH0yegKI4f45brOKCbNJiGafb1Ynim2P41P0cUW5Z/vVJ3T1K5O0wAb03A937Q92ctR4nclp9UEQOpxxKJR6dEv54EbtFRIokAVOtkpWSzyrDLlQWVh/OvsQA6QPID6U0tuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/nQ4beh; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/nQ4beh"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c565dd3a7so2337319c88.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 04:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776685134; cv=none;
        d=google.com; s=arc-20240605;
        b=aV9GnToYFtndGkmeLVLpIPDv4gAhPL/jUDTcL+QdB5/hVPEH6bMDbnwSb7quWtnYem
         PSRe+IiFFEeAmwh0HMDYxdoD6FckwCTM9401XzOCI1d6Z29gDEipP7eTf8U7kBUBGtlH
         vGIzz1Kr1TeT3XNZBLHGLLqgqVxHzRPH+7Ai27iNcz3hbAjKT9GX1eJ0KVTN+7MtJ8RL
         TzhsC1VN77Cc1pmYPYsFe0Ot0fRgHWaNLkUQ1XnAc+fvH/2ATnpy4GZCDGB946rdwMll
         miEjjf0X3WbJ4pLccEhFIRKvnMh90PwHgochR/BAXpnFEbph345Xz9dLVIMIVDcFgxwQ
         hK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VJ10UKhhgiq9LAUjUnniNOYwxljbzZK3MSUjv5eKtlg=;
        fh=t48Q2SN48i6WtDnDWQGGt4rrZ6UmcU4UL5Dq0xiMjPo=;
        b=Rp9Gsf/1/kcPbX10GFrgE0of++LZC4bPLWD43o8jQgVYzINahSgwzBq7R73jnYMzZw
         UyADlrGJ56YfKjdFzeitNH5LW4yJ7p5pgyeynker7fCJx4ZpwGCGXUVjn+0yfOLtCUNp
         q8g7xyhi0xSPL75Vr3aak+IkL/y9bekwP9o+eGT208JlUoLCzpBPe0C/yk9zyHOQyD5G
         Kfsikx/AoQ/cwVJ39FtQq0VwMQPIFwgL6JEMyWwREir37YqpVbADQimyV9PwI/BUJYCC
         h2VPRSeM8H2E8A0d7sJz7BnHka1q5C2bbjKohwJ43aZHS7qwi/e8NGkITqZKWtCyc+It
         9FbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776685134; x=1777289934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ10UKhhgiq9LAUjUnniNOYwxljbzZK3MSUjv5eKtlg=;
        b=h/nQ4behmUQwGLovSGrYpoeS8GQTwfrEzEFKLtFUQ3RIYQ/w7/k+LcL10GSFaOFHGV
         ICIVQpKs/cAooTtWVanNduJR3ZKQEXuZiGPpD563BEm8e2T30mXhsaPk2ToJJXl1ziuO
         prJfzkHn16wmlaOfj7xt4pho4V0eiYhepUStrn7pT6ooTSgP10Ei/OvGR004dF7H+5Wz
         ImkpKowZhOENbeQgNaRDRrbVbrCnK1cHFnKBmnVAoor7BW3PjwQ3XqIyrpGuyzJ4jPss
         AoVSFJlY13+7gLYeNm0BwpvzjDRaEOEGE+Rfznp/3ZdS4sbWFadB1LxEEjteaqxM+LwN
         7BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685134; x=1777289934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VJ10UKhhgiq9LAUjUnniNOYwxljbzZK3MSUjv5eKtlg=;
        b=GAdkzpn6ZRx3RnSzzPE78jQN3+lm7I7Zt9qn0HxmlkoW3vGM630FUIArq7OpKBOxxS
         DNZXy+bnfY6CYsOQRIB50swSBEsZ7UntmOj5YHmv2xupxZqsN+XDeqGfYUhpAW48wZzp
         pE6aA6t2rOI71DG0pIo19/uifaK/952QrognVnk33CBQEnOOBUDkTHYi4bQ2FpECx4SB
         SnBfYyKgxwuKSMdEp8uJQfQOWw+9PynfBE0W3x4+VTblIK9h58uYzyH1cQe8aqAtoUEv
         pmqg5mD4qWaEohCQA3/c5+/bV60l8PHsE1z7v2DHAbZje2ZdFQNC3yfcCBJsnLOHbJ67
         Z6aQ==
X-Gm-Message-State: AOJu0YzvaoI2SuwyXFtnffAP69MoxQe8A+olTb0ANEmvCvCAarHVShm2
	9TqBcq3wyo6o5LY01sEei+jkAriSyLG/IyeR+3rJ/jMFs36aJIjtWFLNZrLFo74aWjC06tx4oFW
	9Nicvf+gsZyM31Wsy1oOYhIPEMCCctS3ztjcGz1I=
X-Gm-Gg: AeBDieukiIhswX9IwnJO1lsH5CV5A56PhVlO0Tdd+b6yuq9QJWhaOGONo1CIy3BDAYY
	ob3e8x0Rb6GvHUgmsMO4MSuljlic9MWPOLHSBJKsjpgJU6HS3GxROS/LaGJ1XfA9umMEnAgdLAa
	molGElX2sRiOWZAv9pxAQVQQ5LL9kDj5PrOFAKF920w4lG5ySPs5awbhv17/z5Z4fb2DA8IdWfU
	ryMrAz4UKAFVpZmpaLmjnO6JqdZwAVpnS1WzhFcUCzMicSvOvz9ZKtI7Xba2JBbheZ8R8yAY8Ou
	GdG/AEkVLveycsm4PUlpyqIwFH091wWk9WGmwl1rBq9Q7YGU3CbzGbRPXtvA617XojOcqCHgYkQ
	lN3ruFMNBv4QDldzttw==
X-Received: by 2002:a05:701b:2706:b0:12c:873f:eb97 with SMTP id
 a92af1059eb24-12c873fee1amr1458237c88.3.1776685134121; Mon, 20 Apr 2026
 04:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419111136.1577323-1-worldhello.net@gmail.com>
 <20260419235723.1579499-1-worldhello.net@gmail.com> <xmqqo6jetb1l.fsf@gitster.g>
In-Reply-To: <xmqqo6jetb1l.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 20 Apr 2026 19:38:41 +0800
X-Gm-Features: AQROBzAh30o8kWJ6sbZV197zvflKWcuIS-1oSh7vE_gzitTkB-Rus_lidNoT9tw
Message-ID: <CANYiYbGvVh7R3u7AFVFNXK_-cRTsi=6s7sq5hafdJXi8qCs8qA@mail.gmail.com>
Subject: Re: [GIT PULL v2] l10n updates for Git 2.54.0
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Alexander Shopov <ash@kambanaria.org>, 
	Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 2:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> >
> > Here are the v2 l10n updates for Git 2.54.0. Changes since v1 include u=
pdates
> > to the Bulgarian (bg) and Traditional Chinese (zh_TW) translations.
> >
> > Changes since v1:
> >
> >     po/bg.po    |   62 +-
> >     po/zh_TW.po | 2699 +++++++++++++++++++++++++++++++++++++++---------=
-----------
> >     2 files changed, 1822 insertions(+), 939 deletions(-)
>
> Thanks, I only pulled v2 and thought about redoing the pull by
> getting v1 first and then v2, but it seems you retracted v1 tag
> already?  I assume that v2 is a superset of v1, in which case we are
> perfectly fine ;-)

I removed the v1 tag this morning (UTC+0800) upon receiving two new
pull requests, to prevent you from accidentally pulling it before the
updated tag was ready.

During this localization round, `po/.gitattributes` was introduced,
which helped detect and prevent a style change in location comments
from introducing a large number of unintended diffs. For example:

 - https://github.com/git-l10n/git-po/pull/913

It also caught blank lines and comments left over from deleted
obsolete entries that gettext had failed to detect:

 - https://github.com/git-l10n/git-po/pull/909

`po/AGENTS.md` was introduced, and AI-assisted review was used to
identify and fix translation quality issues in pull requests. For
example:

 - https://github.com/git-l10n/git-po/pull/906
 - https://github.com/git-l10n/git-po/pull/917

--
Jiang Xin
