Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444F61D54C0
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740920221; cv=none; b=nD2yYBG4/l1zw94LEw8c8i0BN/0AFbc57HBoSbsIYZnP6WZ5P+r7MEfVeO6gNQPjHOSuUfADQCjuF2EjcRdxTM2JlwMk8i2y8blw/CfLiR2//ZOGP0eI8Ne8d69afZBAQoq15TDYxxojHcS/4fu6MWI9hp/t/gtBmaZH+Hu2h3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740920221; c=relaxed/simple;
	bh=OwJukdn28CcnaI2T0dCDEe6Q75oq2p8MWAgCKHREd70=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I3jMzvmyKeHoYEmMqEuMdLVT8sHfGmoCBUlFh9UuQh0dj6XJEoSKYE0OSWS0EK1jkx1IovHBy9eTQciFwa7jUuvGoV+otOjim9kgoMf+rtT89j0bZi4br5aWgQQc0+yyITYLFibohnP2GT36Uh6+/2ERdC4seUhnKZV93d8eVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzbhMwT+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzbhMwT+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22349bb8605so68953075ad.0
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 04:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740920218; x=1741525018; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvWa/aJryUJX2MXEeDJ/036mJv0bQwfuRnRxYUFXZLs=;
        b=mzbhMwT+nNEM/p9YjFYkvkZ5A3/B8nItfB+QvPA8Qvjn6MxP2+UiWE5fbOCY0Yw5MN
         +4u8F06X7/JJ4l7K65DS7vVQVYi8huWg6HEmHwsWtpF9+j1c7q/53hIr2dF9lvXFleM6
         EimSbo/92BcSOafsekkGD1bY0+pr3WB3CPRIju078gaTEyR/LF8LajnBkc/N/1+UPDZp
         1bjFYZgmU6wNepuqs+X0DFW5DgB5Fa+sJ+o3Stby3TrNQ/JymZpnRIl2oLTuU/MT840k
         drjJMB1csggDhaky8LObt3yWrjevH70wFnJWRS8VvPiGoNaNGExk7rikpZBte62xHuCt
         gM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740920218; x=1741525018;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JvWa/aJryUJX2MXEeDJ/036mJv0bQwfuRnRxYUFXZLs=;
        b=c2tGJ8myT5q6wKCmpwBGgia5HzxJn+1c1EEfWh29pVwp8nJk0PZYV83Gk9i7MlOuAo
         p4waLWcxLBURJTBC1m9shIpu9lQAie9b4d2RmTO9OXW9hm5depGYuZY4khLRYyU5iBth
         6dRiwHD2qvVSw7FZ1A/rWTF8Sb+QRj3qFnXmOue3T85isT3aEvrCky9VfI8gminEQh1I
         zupPg9ZO9wdus/vDZjBpgsH4Nym2R6o1D2S9G4OXAL1pmAg+R54zawws7akIuUDtB/1f
         hl++Edj7SNp1WZyCqrVLeSustGv6e+6uWVqIMfdOsHjbzLznPpHil+iErQzuQanmfnlo
         y+MA==
X-Gm-Message-State: AOJu0YyLdtPhg37UbszTYBOD1AgHWwbxsljB83rHpij8gz9xlfPoyDjI
	labr/HyJQkbYHvQuCdbZf+uOhxGbqfOVySlkFrK7wqBSDhO1Ikgo
X-Gm-Gg: ASbGncv5HY86zTe/6zHhx4hquUIy8YsfzAfW3ttbFBDIwxKnMsQGA7wBqAMLl2Bezil
	HjagDm0zJ8lCg+p2qnBz1OdVWd0JzhUzf7nNllGUISBqFWiwqEJc2XqJxz3nuuJ49Qw4W7SBlIO
	Oacf3RvF4P5gv5GKLX4+YQgi3Nw+7BN657pBrC9FN6c9tQM9hfzYmFrWCgLmcbH9UoHp6P+78RN
	s956AQS2kJPNSQtRuNOQaQx2G7O/5TSohhzLkETV1LXnFqf8miIHdcJ/U2YAWgkgGK2KI/kWkPn
	39WPPXrcF94wRVMmH/3BuXmWw1qE4aLnnR05ZNm2CM5q2rMqagOX9W8eV4J3uw9tug==
X-Google-Smtp-Source: AGHT+IG7OX0/E6HZ2pMk/yB9UE/A2ara58WgELc5DLQJypPPr6lNmRznbcLioipoxdRsgKSG89lOFw==
X-Received: by 2002:a17:902:d48f:b0:223:4e54:d2c8 with SMTP id d9443c01a7336-22368fa59a0mr153166065ad.21.1740920218231;
        Sun, 02 Mar 2025 04:56:58 -0800 (PST)
Received: from localhost ([103.158.49.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5cf4sm60049195ad.130.2025.03.02.04.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 04:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Mar 2025 18:26:52 +0530
Message-Id: <D85SPKTTT47S.32GQ2NBP9J6I0@gmail.com>
Cc: <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Calvin Wan" <calvinwan@google.com>,
 "Elijah Newren" <newren@gmail.com>
Subject: Re: [GSoC][RFC PATCH] show-branch: use commit-slab for flag storage
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Meet Soni"
 <meetsoni3017@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250217055049.9217-1-meetsoni3017@gmail.com>
 <xmqqseobksfe.fsf@gitster.g>
In-Reply-To: <xmqqseobksfe.fsf@gitster.g>

On Wed Feb 19, 2025 at 12:10 AM IST, Junio C Hamano wrote:
> Meet Soni <meetsoni3017@gmail.com> writes:
>
> > Replace direct accesses to commit->object.flags with the commit-slab
> > mechanism. Introduce `get_commit_flags()` and `set_commit_flags()` to
> > retrieve and update flags, respectively, and include `revision.h` so th=
at
> > the canonical UNINTERESTING definition is used.
> >
> > Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
>
> Ohhhh.  I thought people somehow have "refactored" the commit
> traversal code here to share more with the machinery used by the
> "log" family of commands, but the change in this patch being
> contained within the single "show-branch" file indicates that it is
> not the case, which is good ;-)
>
> And the MAX_REVS limitation has been with us from the very beginning
> of the "show-branch" command.  Lifting it is very good ;-) ;-).
>
> > ---
> > I'm not entirely sure what the TODO comment meant by storing a pointer =
to
> > the "ref name" directly, so I've assumed that the intent was to store
> > flags (of type int) directly in the commit-slab instead of commit->obje=
ct.
>
> It has been forever since I looked at the code around here the last
> time, but I suspect that it meant the final mapping the code makes
> at the output phase from the bit position in the flags bits to which
> reference the bit (i.e. "I am reachable from that ref") could be
> omitted if we make the slab entry a set of (interned) refnames.
>
> But I think using a slab whose element is still a bag of bits that
> is wider than object.flags word is is the most straight-forward way
> to lift MAX_REVS limitation.  If we can leave everything else
> unchanged, that would be great.

Agreed. Looking at the code, there seems to be two prequisites for
removing MAX_REVS limitation:

- Removing dependency on MAX_REVS for allocating arrays (ref_names,
  revs, etc.)
  (can convert these to heap allocation)

- Removing dependency on MAX_REVS for storing flags (which can be
  achieved by using the slab mechanism and using some kind of bitset
  API or we can use 'bitmap' from ewok.h)

Thanks.
