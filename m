Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197636AB50
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113203; cv=pass; b=mIIRNXTsEGJ+YzGTwGYg7sLkZzZUAWftrjyftdEmN4q9nG3PDId0dHzjjDPTioWw/GxE0Jr5luzg7RjRHgN54CmNsheESjkjpCKhCent81RhHUTi8P43D30t20TBVVVEf13HbZw1htJUvPLPCV3YkYYpkmHyF1qkmJAWn7RuBFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113203; c=relaxed/simple;
	bh=GV1n8RE17GFmVu8ka/L6RB/HwVcnoIosy6pckcFf6q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6PZ3Ccj4SEeQFloi6x7s6oSKYzwrYWW7716lt0VpCkiEYa9jMxGXwL4Hzm69bBG64d6XCvNVt1ngrXtp/zAuefFlbwCGzpUeRpwImhHKDYQpKT/flZ/qKR4jmV3u9/nBKxlov5Umhjhudsy1MyXm874TH5mghTFSX/NmONnrE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+tgAFd/; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+tgAFd/"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1279eced0b9so729162c88.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775113201; cv=none;
        d=google.com; s=arc-20240605;
        b=MwL+0QV5Awr7MG0gE8hIoZexLcoTP0iNBa3F3cu64VMIPuXAYw/vw9Hd8d7jkTmwrd
         SiLCM2gi7wGd29bRXcupsbVshG+TbmofNw8u8IaHd7CxrLxIU2mA/gdQdoelfX/cDnH/
         z2OnLVPfH19jaR3ZbpfwXZXwpsU9o/p01kyohJJOE4j69VywQERX3ai7Giw+tdErXOX/
         XbK3vaosqTs+SVtrRkYLzDLVkuk7+BOCkG8qk4O7xCw0kr7S+yqSsmc3AXgEWitAKyKv
         ZfjG6tPQfPdANFqGyW3Fn4Fr/DICrYbSQvwKWsbNRL8AdpDtteUfBoK9lZ59KCcX8Nj3
         abyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GV1n8RE17GFmVu8ka/L6RB/HwVcnoIosy6pckcFf6q8=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=Z7GzNOFL82HN1LgrNuRD3uRBju0Ptza50lunj14KLg8lzZvWHirdN/tcmsw0Amn2S5
         nfKk4ASL5QLq1SXj0w9pc6ySbIpYHgo7lR7Hb1IDm5vCH+sOHJIKY8xLAks56gHVUcsh
         lwwERMUcsws7kByXpK2R43NI3lRhY3wqrbWY/9fxRaEDhE4Z5v4h5nZFzypS9TiRDnEO
         u/aC+S9TY1I058Xi2G0pN1xUTHqK3KO+GUc1jb+CvzyOPqoNwq3n09LQNTCvoF0Mg2bI
         K5SqMrcORfuBEDbAOZ3BkKjrR05YOaj23bkJFL6r9iwsKlHNcIQIecxrmM0pYTg12toe
         upSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113201; x=1775718001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GV1n8RE17GFmVu8ka/L6RB/HwVcnoIosy6pckcFf6q8=;
        b=S+tgAFd/w1bqXqdKcDnjncWvvmv/wnrHjIxsyd81kKANvEPJB7/LISxByG1NMGTTQ5
         4Iao+A43Gnc8s/VBv/yqIVaIOXUtFbY2Y1otGlsgrvFuNX0Oa70r0jb2BZR1sucQKi//
         0RsFRIbAp2gTopxN9q7Lm34WmhobJbEDf0HKSzluDA/wmbtwhfGyRDnJ9RZ0Ra5ugseQ
         3DzwA30BuoUNoJ0zHOp1posGtjp3z4GvW8YD+JAmarc9mxy5bbRuIf+Qzitha7uKi84W
         tl3n0oTxG39ozKuhP79EpOJKjnNoRJdTAkZFp1PuD65EBCniyc/xfFZT8R1HzOaBKOaD
         av2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113201; x=1775718001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GV1n8RE17GFmVu8ka/L6RB/HwVcnoIosy6pckcFf6q8=;
        b=JM6o4NhKz+qGw6L0RKYf6VtKyykENKV5TeNuSZOJdQnOGDrFC4XYgrsd5dhXp+tG8m
         JYsMkar24k/a7WPTlLYzBNPzeF82x+ieiMVhjZHGzW+Ie2zfwGjl3NDRL/3q/R8GcDwv
         6k4Hc2cFOsd4v0QNw2MHVUEQpQatKUhMJL5paJZ28dsK92TlzB04Qsuf6NHLVXWUlw/c
         VVRDYd93/AeeEfA5V+pQzsyXRC1GM/upWezMud547mbeGqgJQRWfKOoc9WBT0nkjmNMN
         ccsFoVYG0SzWFfXeBL54uCKIEmKZ3vdc7Bizol3uVTOnAzOwMYdp+8a25M5dKzT2XeMB
         tjDQ==
X-Gm-Message-State: AOJu0Yzmv8jEeZA6cmuq+ZKmdm4JcfLUhgY1x3uxcPrwx9w+p/NU3XNv
	1QSXnxy+CL47xJFwEoj4Z7IGD1I7qakCmbxRLve3FbF40FUBGaJmS/ple2mwBpRddGFLcxTLI5M
	tAWal/SbyHJ8yUsB0tzUcQiWtdKQDgaQ=
X-Gm-Gg: ATEYQzxc2mcrZgG/PaFsV/S8DWK+Oh6jI5Xe0ZUdfMujykI1Nl05XqaL4h0/lWBJBCg
	bH6e7jBy628zA02oeyIkItXycf7hs4QbuRdi9YF1GGWHK3MdHGV5Kgvpzv2icwxSJjA+dLzT7rq
	Ts8qiyMOUZZvN+O4ORm153KwMJxi42Wca/0ltYjjflM+oTqJZAddiHIOOcDea4T0r2X3lJDvzwd
	zElc62YOfsreg6j+/ILo80hnrUuDB7Gpih1gN23qhabUNtdZ9a10HYq7giea7b/PVtKMgZtHAm4
	lYbGzVVfxN7aIysQJspRGsvGfFFswuhcBQbViclBhtlw2jQ0e46ZYUtlQf/HzcfcXo3amG0c/PK
	pmUs=
X-Received: by 2002:a05:7022:6182:b0:128:c77a:6c8e with SMTP id
 a92af1059eb24-12be64cdd0dmr3699932c88.28.1775113200816; Thu, 02 Apr 2026
 00:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-9-christian.couder@gmail.com> <acUks6pBmjgzN4M3@pks.im>
In-Reply-To: <acUks6pBmjgzN4M3@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Apr 2026 08:59:49 +0200
X-Gm-Features: AQROBzBncqQaP5xncNcQ2ctLKQhjBJIMs2LCp3szDiPejUcMRliLSchWTWhJ7JE
Message-ID: <CAP8UFD2B1wHcfi_MOO6iy5bmZ2ULg1H9J2YuL-EaebAk0N302g@mail.gmail.com>
Subject: Re: [PATCH 08/16] promisor-remote: remove the 'accepted' strvec
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:21=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 23, 2026 at 09:05:11AM +0100, Christian Couder wrote:
> > In a previous commit, filter_promisor_remote() was refactored to keep
> > accepted 'struct promisor_info' instances alive instead of dismantling
> > them into separate parallel data structures.
> >
> > Let's go one step further and replace the 'struct strvec *accepted'
> > argument passed to filter_promisor_remote() with a
> > 'struct string_list *accepted_remotes' argument.
>
> Right, this is indeed something I was wondering about given that we now
> effectively stored the remote name twice.

Yeah, I think both patches together result in a nice code simplification.

Thanks for taking a close look at them.
