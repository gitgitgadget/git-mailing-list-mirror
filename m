Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57024503B
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973439; cv=none; b=AdG8OzrJm3uawn3eFXhcKW2KeRMoH8jiAkO/jOPlEOI2ZP20r9F2octa4++U4ZrKMjFs2d9+o6CxmvJEJt1OwSl1byn9KsRdQ3kVn4z4siaTbESoF0ofvS0ex/09mapqVtRs5yBKOIHkw2KpX7lQzeBqwcCUhftk9hMIYCA99vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973439; c=relaxed/simple;
	bh=/oLNj9q2jHRgx+jQM+oqgMNTxHIztw2+Z90FpeuGNBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/IPJ2jjHOQgavrOOog9vs+5lI/TC3LmlbBgCHgl6IfTTm9HcRau3J1WUzeHFlm5lsNWWt63K5GyoLIjg5k+yAFHNOoSSYI6ZORjB7SScMRWyxg79olBsnd3Qo6nj2+qRBK3OmE3VhbuOcKY+L+ZjZ6lYiE1qNjz4lxuMAfeWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZUozb7Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZUozb7Q"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235a3dd4f0dso11516285ad.0
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973438; x=1751578238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oLNj9q2jHRgx+jQM+oqgMNTxHIztw2+Z90FpeuGNBI=;
        b=JZUozb7QkWMm+y7xJKyn9aLVLQuTv1gsnopn4nwQ/2Bv77jYobYHioJEpawB9GZlHl
         brFWsFm6AsFYkrIFQBlqZPNSWRzdWxFTOPEpuCIWUl3GwvEB45aZLA2SHe4RcwWakBWc
         OLGzmN1fXRsPToTs++uxtU4R/s9lQZg88Akdj6l1oVKIF0PSGc7X2opIZ+HG6UiQ6N94
         oGQLIojSSAMy9Bq0eq2DahpQsiztLGhyX4HN9lZbva7tIOgB8AGLr305NtsUAMl2bKPR
         JVsl5wkpXbjUAghCP5SWdUSFQFG8oFQ8uV4kOcq2wn25Wf8TfHPtdVFoWQmiNh2W3DNV
         httQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973438; x=1751578238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oLNj9q2jHRgx+jQM+oqgMNTxHIztw2+Z90FpeuGNBI=;
        b=UUTYhQ1BWWrpgcPUs0siwUO9MtY6x05/TxeNXBVdozAzdbKWDyG9VzsZlVBWQQsc29
         bPILG3Ix4TRSXvErtkV/Z5oQr3xJ7hmqiNr0FbtGKWYeA+rZegjJrGmhe73Fq7YxRSnC
         7L0YVfSP9Gle2HLQ0BSyv6eXa6xAS4JSeadxefktQUCD/r55bfH6ya0XiMfcmeZpPRQv
         Dn+/y0PQ/Y18sI6EACayama0mLnv/otl2rRIgkd09eehj4ZTB0UaSz6LaDEfIxL5wlqj
         MpCPKoCFgB5aCu+pw6A8EoRtar1owsqU603N8l9x33GOSx0j05jlt4NP5+MpB0EmlCOq
         FaJA==
X-Gm-Message-State: AOJu0YwHsrT2WxrBhm6Nd3uabCC+xMCy280KjcWQUdbTB9p92c1hpBfM
	OEY8dAUXNMDp74NLaGRK2Tf57FLkyFhYdiCGqsjzNfhHul+I6p1bGGLiVRjAJMuWODMeTSlXnBr
	yLHILiDbMclW6BUjX77sNp5GwfiU7S6JQXXLG
X-Gm-Gg: ASbGncvdOiAgszs4Jjsnl5TQTzqB+nwTCQU68cb6XDuZVuiW2p2UDejZTmSFD6WwN0s
	plM1INVyOit88R0xQl2A0v+T+jxQPpkruDiKe13Q12dGSvaANZfeYxgqpwWKIpUNulUxrnNeJws
	p1wjna55Y/JHKNEOe11ZXvWgL1sRrpUaKjl/nYQPJDMmUO2ElJQ9eUC6PuTlzcuv9Ynil+VOHJK
	D0Zrw==
X-Google-Smtp-Source: AGHT+IGLJ1CkPrnmy2uR3vlpvv6jf83oeZ/lOCdv6GJOYR8Gryu1x3NXipklYZ04B6/HpOt87ZSn92Oz107OgwyAMbQ=
X-Received: by 2002:a17:90b:2f8f:b0:311:a54d:8492 with SMTP id
 98e67ed59e1d1-318c910de41mr740412a91.6.1750973437555; Thu, 26 Jun 2025
 14:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132233.414789-1-ayu.chandekar@gmail.com> <xmqq5xgir2ry.fsf@gitster.g>
In-Reply-To: <xmqq5xgir2ry.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Fri, 27 Jun 2025 03:00:26 +0530
X-Gm-Features: Ac12FXx4WAF-Oe8KpjUKnCCJnNSkl3n36mS6V0N7beplF1XtpHUsB5Ps6B9ygxQ
Message-ID: <CAE7as+b=9sKLU1pG4xDJ+D4C=UNYUH2cpP13VaqwLfsQmLUVQQ@mail.gmail.com>
Subject: Re: [GSOC PATCH] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, shyamthakkar001@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
>
> > When core.commentChar is set to "auto", Git selects a comment character
> > by scanning the commit message contents and avoiding any character
> > already present in the message.
> >
> > If the message still contains old conflict comments (starting with a
> > comment character), Git assumes that character is in use and chooses a
> > different one. As a result, those existing comment lines are no longer
> > recognized as comments and end up being included in the final commit
> > message.
> >
> > To avoid this, skip scanning the trailing comment block when selecting
> > the comment character. This allows Git to safely reuse the original
> > character when appropriate, keeping the commit message clean and free o=
f
> > leftover conflict information.
> >
> > Background:
> >
> > The "auto" value for core.commentchar was introduced in the commit
> > `84c9dc2` (commit: allow core.commentChar=3Dauto for character auto
> > selection) but did not exhibt this issue at that time.
>
> Use "git log -1 --format=3Dreference", i.e.
>
> 84c9dc2c (commit: allow core.commentChar=3Dauto for character auto
> selection, 2014-05-17)
>
Got it, Thanks! I'll update it.
