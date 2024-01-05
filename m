Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F81DFCC
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAkzekzC"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso1489830e87.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 19:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704424847; x=1705029647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At6WoFGGAIXcXnkRyn/4q+YvVxliTMa6ymuwj+Ufh1I=;
        b=MAkzekzC7hwRDHWrF0357Vn+tGqa4WpYN+2SlaVYr1geMcxnprUmKxeCxyp3fX+l80
         RiVGCDYqAWPVTb7BYUPmT78uigcA+F8iQTdGGRvwTDO1G7yrib+qpWXk07daTUU5QQBC
         FCi/lBji+bnyuvljbCmdkRvaIBKaHK1bT4V92kJinfVA1Er54j7K+nzYDg1QP0lNENAF
         1L7ET9tjfSC4qeXsB+7cpRzUoMdwdWdiZy7i6onHUESnIr9yUHs67f05h2E+GHx2K43Z
         XrxjS1INcnwZrMdpt8iyscuJB975tvfia0lIfVGxhtrCQ2EBTuvO4h4HEIWORx2FXVQr
         F/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704424847; x=1705029647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At6WoFGGAIXcXnkRyn/4q+YvVxliTMa6ymuwj+Ufh1I=;
        b=nLb+lzkEiTSEODHDL5rkk9OSK6D3Z2a30eUe8RQnDikF2GlOEfX1c2OPHkZ+1df4TS
         AF75W+HAqe3ljt0T7+cNTbPBdm62Qq7qxpF3xNCHRpi58OLyKGBmoDTOMcAtArDdOYWL
         KPopb/YX67EhF5ycf+8Y09KPcEwhIueTCCJrmtP6XKWfeOnkZmD/OFdKgxX+8SRpN8yE
         7bGjPa14batpgUfyZ8z3DIcIgTZWkiyUQDl5GCJ5gviBi350lSfzCWVIz2J7sz6F7MXf
         I0NPTCMnex67CapBc9zIOAdmECuRDdRGXJ53FcHruPPhUz6HES2ANwbgM5pEMZ1yL8nN
         6Idw==
X-Gm-Message-State: AOJu0YzaKABT002vF5jvkLvKR9jf0syrpbx/fHUEqwm/cEYF2y/LIhgY
	iwaz1pwJR6CEWVWT84dYf4A+UgNzR3klO4fUvfwsF1qJh4o=
X-Google-Smtp-Source: AGHT+IFPRls8dqQxDTX4XDkTsQ+dTHDh/jvea+e9g37VI2TQoLHPAr2GEbDDdDkVXB7TRSg855YuMWcMBQiA+rSk8T8=
X-Received: by 2002:a05:6512:2395:b0:50e:6b4f:9808 with SMTP id
 c21-20020a056512239500b0050e6b4f9808mr907751lfv.96.1704424846910; Thu, 04 Jan
 2024 19:20:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPHrSevBdQF0BisR8VK=jM=wj1dTUYEVrv31gLerAzL9=Cd8Q@mail.gmail.com>
 <ZZcIG+mNXhZ0rHw3@nand.local> <CABPp-BGJfvBhO_zEX8nLoa8WNsjmwvtZ2qOjmYm9iPoZg4SwPw@mail.gmail.com>
In-Reply-To: <CABPp-BGJfvBhO_zEX8nLoa8WNsjmwvtZ2qOjmYm9iPoZg4SwPw@mail.gmail.com>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Thu, 4 Jan 2024 21:20:10 -0600
Message-ID: <CAHPHrSe51_y445m0Hn_SqdpwJNKLrKHKm3LzY=APG+QzBygt7w@mail.gmail.com>
Subject: Re: Does extending `--empty` to git-cherry-pick make sense?
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 8:28=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:
>
> I was indeed focused on simply getting the multiple rebase backends to
> have consistent behavior (we had like 4-5 backends at the time,
> right?) and just didn't consider cherry-pick at the time.  Now that
> those are more consistent (though there's still work to be done on
> that end too), cherry-pick and rebase really ought to share a lot more
> between each other, from command line flags, to temporary control
> files written, to more shared code paths.  Adding an --empty flag to
> cherry-pick as a step along the way makes sense.

I appreciate the insight from both of you.

It sounds like I'll be diving into some C code for the first time in
over a decade, then! I'll plan to take a crack at this soon.

-Brian Lyles
