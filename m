Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4A3AF656
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929789; cv=pass; b=TYtm+1zuLpZbQ4fxQnj8PK0QPQOSQHjpkEfrcvhKPtOJC77H8Zt3zIe4qgs+iDFwwz0UDZv7EQqji8N+unZjpI3q93tR4oPOw0Yyv8zV6W9UxJDoq/VdrGEiZlJLhxkAPMV4U1y5+an1zeyYc7IR3yy282L3Vx+WzNiP7eMUG1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929789; c=relaxed/simple;
	bh=R9sIoH7D92Lw91sqH67DDTytjb85gSiZDGfY5uHxkGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksPtllht+Z1uP1eJV3ouaj+0UfHyM8pkxwpyMbrTczluBgE5oRxCPf4uhV9khpmjrn4XzpOXmb80lkwfwhxAWfeqmf3JOYI94VfLvM89nDVQ6fiXxquj0HTV6oUmaTJL1zeFHYFXqFBlKeNAdUGs227/MMC3vR1DWio3Z0Zl/6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJl5+o8b; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJl5+o8b"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccf2360620so8554085ad.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 04:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785929787; cv=none;
        d=google.com; s=arc-20260327;
        b=L0dyoKlwkktSUZOmcgRmXvGVw2tPDTIT5rSSV6YmYBy+0mVe4giRTPkYWIzIfHIb2v
         bQ2vVAo+ZR12uSg/naTbCpYIf4Qd8hz7ghDHpNR4JkwTagUXOrKUjCbp6ORGwIR8+aTq
         zFAigf6iiLrCifnJnoqyhw+hyBqCp1Tg4Hb0/ifKldZK540cnmFMiaSnft7CuCEPCgRF
         6xlnfqZJesNSXCYTHAYdLpY8ChjKm9EcguB4dheFarsZV6CmJvBfEebfIVqEhz3Ro2nJ
         97ZsmHYsXrztMMF9h6fDIoIbO0svyjV2u5nfkek8yvthO6vtdIuhG8RkXUjpPhOCRuMl
         QlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vr6UJXkoD7LkCySBjD4HmwtggoHaB+096Plg8WMp7e8=;
        fh=u2MGwot6xBr9jRNju3lkljFVgwsgA5VIU0PfIkmnFxc=;
        b=Ax4N5UE/TqcoZu7ClchUxDEq0rY9VXA3sN1GO5UOpIveLJ6V+Gy6Z7+2Mj6QtMtIVy
         dSlF8C+vGcCNWGraKmvuc3bzUfHMP/U2UnKFKNSmlDr1DRjftQ+IISI1gQdVg05H0RJe
         yBBNUZ8J8KulWWt9OZ5++jxw2rmHwiR6PJjlUgOi4MoOWRsh3DI3ntKTO1PprUColawT
         IFuP4U+oBK/9j4Qh8UQzwKcaBdnFEqH6/0wX0e1355z+8FGBLGTN+EkGgN6FFF9VKM81
         4UtC2IP7PlKexeFBNNHy8bgCs/YeRoSDgisNAn4gI4CPKNdJCWPBkxXRKXGWG62IKxhq
         PPqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785929787; x=1786534587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vr6UJXkoD7LkCySBjD4HmwtggoHaB+096Plg8WMp7e8=;
        b=HJl5+o8bGw2NYVioKlCpBJuru0ldx3HQR1kdj2ZIOa1zoZ3dB3SqnGw1QwxDcjAEDR
         UVuU4uOtuMPZHpDhnur/7vGHQ0bKt0ckRmUsqghrqFVmew9ke2RyXU7Lphg3tq7asK+d
         rRnxIxnmDY6RjTVQBNggdkoHDkzGC583dy8enFxO4O8sowoyxytisoIIRviTBrMAawcy
         hV8+ITje7bYNNkxJBiiN1Vh+46vAF/sicjGhyjIMD4Q2/AxqWtUW5dOK4sUN58UGm7Ur
         aectn5PIlLlXyuM/NreLwhv/HH8QRCpaob7oyOlQExRcDPtnavXqZoNoDYC/VXTYMgLP
         WTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785929787; x=1786534587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vr6UJXkoD7LkCySBjD4HmwtggoHaB+096Plg8WMp7e8=;
        b=c5Hpfg+wAiHYcXLgB95pOo8rGZRxqd/84+JgO/9k+/jZAOGj5GvuLGbOAKFTyF4mbh
         M/4Ql56uL8hXA/H4Xq6l68cjQa1+gTly+EN7qzFFXVYFi7apN0uug0STPcY7N5++9Amd
         +PfqYXPDRYeWPXYFKle6luW6FXPua5RnENZIv9PctVL6bbVfcxhRoIsBGTQ74lZJyYeu
         1MN1QNgjLE9HjeVqwi3iPIp96mV0+5IJIZItwPrFPsNN0Qex+h7ANRGn2BGMK/LrZLSe
         7c6Bkn2dXUCbc2rYG7zkBjcx5W+cPWX3W7a/L/ZbuH1ed5XgFENu1ZjknAA87EOpBjhN
         HvHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmdXRudbnLV1offUYhwfmgV4hnLDl/JwOOTPr5I9K10NJWqcw/IYNnul3mHEKsYoAnmwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoyiA9BdG9oI1JL9aAOyXIuBc1PPd/aLi0Jjv6Saq7rcs8I8OE
	MojY/H/oMI5HZN9kX4Rztb2M8rFkZB6KCITVZs5vyvVEv+Fn9hDd0F0W15h6HVGul9Tjml3aFio
	pLsXquGVpe7Kgv+cnx2fuh8y1y1cov+gLuCRJ2Ng=
X-Gm-Gg: AR+sD12IcB+MHaJgxgH9X8/5L3E2ZN7Ok4OzW23MmRhgy2NEVYMF9zdAaY8JSsnEMlH
	57dvexRRqFsYWzzYAKDyFL0DsbTi0Ci0hU8s6LNa4Ln/nSmndTJFSr2G3pcZxiL85zvVBMDiR65
	jVgoJ3fTykLsALCT8AtCKhvbiu47JSV7S3gx6hz25TRACk5GJqi2SZKpiVp0Oa+4GYOhZjAoNJ+
	OjEW+NkQoZdyKPY9hNFR8BX99gg/6bXvfoBhx7IGs97t0XQmDkizqOafCeer54nFJKWZ4Y3I535
	Pl4NDfjccF9lIo+NVPNFU/9Py2K5jtW3rTw+0olrOFHprh7bZyG4W+o6Md9WZFLA1rgC+TMKmDU
	XqZFKH6supsc8UxUSx5d6FFxNr3nnMQPitGcB/zELCiuletgTLSVMW5JgMp81PzrvTFR6CZEOSq
	DY+f+aZM5pMm3yU/BghA==
X-Received: by 2002:a17:903:2bcc:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2d0ca159fd7mr72882245ad.0.1785929786469; Wed, 05 Aug 2026
 04:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <017e01dd2441$476839f0$d638add0$@nexbridge.com> <20260805045026.GA972736@coredump.intra.peff.net>
In-Reply-To: <20260805045026.GA972736@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 5 Aug 2026 07:36:15 -0400
X-Gm-Features: AUfX_mwG9SpK_WE1lha5c3-vU9O_U7foBSfBFHRFy3upwgPiSgqQAEtLq_2ZHwA
Message-ID: <CALnO6CAhVzptUYpoHU93y5Sho3cPJgVbT81bb0ChugNCE9zsTw@mail.gmail.com>
Subject: Re: Question on textconv
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 12:50=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 04, 2026 at 02:44:22PM -0400, rsbecker@nexbridge.com wrote:
>
> > The supplied file going to the textconv program looks like
> > /tmp/git-blob-GFtIhK/simple
> > and is always empty regardless of the file contents.
>
> I can't reproduce the problem here, even for files with embedded NULs.

Yeah, same:

    dd if=3D/dev/zero of=3Dfile count=3D1
    echo 'file diff=3Ddebug' >.gitattributes
    git config diff.debug.textconv 'echo >&2 "got $*"; xxd'

shows (with "git add --intent-to-add file; git diff file") the xxd
dump of zeros from the working tree. Then

    git commit file -mwip
    dd if=3D/dev/zero of=3Dfile count=3D2
    git diff file

shows a diff between a temp file and the working tree (but still
correctly showing the new block of zeros).
