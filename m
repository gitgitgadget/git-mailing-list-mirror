Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D844A5C55
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353066; cv=pass; b=PpDBnR1V1NwpbNzaXCoR2tuBLr/E1C1CZgk98K+dj+wjx/1O5G1GBNfXp0oVDdHwlHjx1hjisFs3OC/TFqgvqeu8BQ8YYZbWrIMldjfBi0d75a42vXcRDWwUM9kgYgRZdSxTpykkFT6ubSiiVmjt5A9L3GP80yupKx+RaD6fnkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353066; c=relaxed/simple;
	bh=bsJ+h6HipZ3Xg50Uxpeb4MzHMTA23BTjA+MKyd23SBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t400+i/46CuVUOahc+2j+7AA2vWsARbPXxKbU3g+EOk2rSvHW26kciLuFMkWQxO4kvTh/0lJKvgpltE24RH9rgQescrpLM5Do5u87EjKLcxxlymQUo+0No41RKz9l9NM1nQQRTEzQvQo3eb+LKbO4EIfGhr8XOmccsX/rP9zMRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGck90Wd; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGck90Wd"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc78d45f78fso519395a12.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790353064; cv=none;
        d=google.com; s=arc-20260327;
        b=JzpS/yJzwVOhnxZDhnTs3OFJxCE30OZ+j9qWfVuoy7qa5pz+L+BGRfup09pk+bttn2
         QF+ABHPdcnInTJFvgM5ffcRiin7QN1KYdG6426+Gk2e9aU8fzOXn4EM/7wcD1QVgYrp2
         NHuoDeODdJ3cC09pAOpV/UCoZA50W2ekfhdRKKd95fTyD00GxY73/ujM2TNBWuv/J4N+
         WwTwm18PNXRvL8eJc2hdiJLCIhp1/mzzh8c6YP9h5O8ZyOB9shAjzSiyoYLM3/jyYClx
         7nhLvqjz3Nj/zP76XXkLADYm/82EecYbF2loMp43Iweo34mne3FsmQBD9INhD4dCmI7w
         83Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsJ+h6HipZ3Xg50Uxpeb4MzHMTA23BTjA+MKyd23SBA=;
        fh=vsIQf0EsFq4ZxyHuwbYXoOBrJp9/M1rTtX9ags3UxnI=;
        b=aXjzN9BsgQQ3KJ9SyH8hqhSkwIH6NVLZttEWp1b766iEHT8MwDqfV+j214iE2iYgPJ
         sfVI7EyDZqgRpxwrUkn43+ST+St5xo3EhIV8mHpuwGXY6A+3fOeONHxc1uJPxnjsPPCu
         bbL1zq7x/ajFqFZqT1ZIm/aQlqpb+m8f+wluYelaAcn4R2R45H26ruxcygwPFpK7kbLA
         ZQlPh5U+uDWMqD1OnURZHxGAkDZbH+r7E2dM0AAS3duE2blvZup5I7pzbVOuvilJeh6c
         TLm24vAtKxsQfqCpaMS2816P99x0UITlTVbWjPkUxSbnB5c+PwW/rXHxzzRB8qj2YrN5
         HRGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790353064; x=1790957864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bsJ+h6HipZ3Xg50Uxpeb4MzHMTA23BTjA+MKyd23SBA=;
        b=GGck90WdA/s+HfDvSH3/D1EpOUnB7Q//iUDrS4gm80JQHmVKF9t+CcnoN0XVAwYtbM
         JsBMjvCR3DBWZcUcn08zJS0M1epbSUExiN4JkaR/Kq69ff+2IopXlbRBTVd42R6oxXZ2
         XYlXDkFtvGzaz9Thwj5M8HFxppRc/0/PJhj+G9VMNAp7Khv/UZoiTnVGvqTcU1ybMUui
         J2rUdf5Ce73/d4ByV1y3YO8HsADxrYLH+cwv+H5FvY3TKQVyKmIZ/eH18aJY3xYJQlNU
         dq2T6sJXmePoZqpqAVSTfA7myTbB+Ps56im2aoYwuH3GpzLgjI+pGCEXZt7BbDPzEm3H
         S8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790353064; x=1790957864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bsJ+h6HipZ3Xg50Uxpeb4MzHMTA23BTjA+MKyd23SBA=;
        b=ab821FmTeXYqmY34a+1T+CtdFNZO39i6V36TX9SJw1CyGRLixXn2xAAT98nyG46hUH
         kaahRon4Wqtj/X9l6ZSUbv/M+g7CaqIbTDAtKDKLNrnB2+dG0CDYQcWMoj/xXdm8SoWF
         pBmdD56h3V36C8oBTGlaQO8M2BassKIo7IatdVyHTDo70ibHWjuBVlT2TUdLmM44joM4
         nmcRa7U9RhLFSZT8ski9QoGILhOZEAr21msiUJ58njnmPfW+UNdMUEjMPwSkSqdoCQBL
         qlCm/Tx6oRZcW2A1Mwhq9rQhoFPVKdTULOLV1dgFU4iOk+RzeA/k4NacrTdDx39BtCRY
         au0w==
X-Forwarded-Encrypted: i=1; AKwUvBz8XLewySsPGZQK31ueIh/W3MD6P1uT3WACrvbOZXv3V7EMOsaO+oWPPWMlSeksauLtdWo=@vger.kernel.org
X-Gm-Message-State: AFuF++mbf7QhS5xvv2GdDkrSLW/gH0z4ooG9+SXooPdrpwcUhfsqn1uU
	IEDUENakepPN6/OB+TKFijHcsPFLBaZhBoLuZ65vjn6ykOE/6Clq0Hr+Kdode6Yl4Lsg9SqwbEG
	GjoIoDouV6ipty69G5Y0q+ogPHc8tx58=
X-Gm-Gg: AYBFou2r+ZUhwxUMogIjxQYqW8G7onS3813W8FRN0ReucAh7fS1fkvhco8BbOOmoF89
	v3HyGNbPphU+DYEU9GpdLc5SC5A1G6wcRCH+SbF/uagxuIZJg5pzT8j4BnW6pg84kA3WTMdpKWS
	pdlHBK3yCGSxWARLPfNb20d62oRmpbygB6JYKsR63zIblfLoeFLX+atSiW4JZKRqnQWfFOFhu3k
	Xbbw18d1keyueTkDToXfSAz4X+GY9NIttIAa9Hv771gYcE4a3WsgR+O678DADhTHyGtl6Mrx52c
	pm3ABy6UAsXrxmndy8+b1USg+SJ9QH5M6RSqLHbN3oPSALaHRjA5tBF8L7yq+ktGZCFp2yN6Uk9
	uEcL21YWyKLKlvxsezdIGTUMsh8QPnvqZLw37LguyBuLBQlzRJaXG0xUIsPbioF0BL4RjdyDUHu
	SJL0MowcusZJDZoDKxigX7pyMuCMXPvKhbmNO9W5Vv
X-Received: by 2002:a05:6a20:d48c:b0:3de:94b:7e37 with SMTP id
 adf61e73a8af0-3de0e6f5365mr6370806637.14.1790353064317; Fri, 25 Sep 2026
 09:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
 <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
 <xmqqse2yz4y4.fsf@gitster.g> <6e6420e8-3cbd-4975-a781-645e1ffbc1d2@gmail.com>
In-Reply-To: <6e6420e8-3cbd-4975-a781-645e1ffbc1d2@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 25 Sep 2026 12:17:31 -0400
X-Gm-Features: AclHuK_2vEA68AwXv8TQEgSyiE-sc9WMsoav1xHPE2Tnx49c_01GrQGHjcM1cQI
Message-ID: <CALnO6CDzbUMSAqLgZ_A1xx=XJPN1_HR-tJUDqG4-Q_xV2Ypzkg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Adam Johnson <me@adamj.eu>, Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>, 
	Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 12:04=E2=80=AFPM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Junio
>
> On 24/09/2026 22:59, Junio C Hamano wrote:

[snip]

> > Perhaps the true culprit in this confusion is that the order in
> > which merge_ort_nonrecursive() takes its three trees (head, merge,
> > and common) and the order in which merge_incore_nonrecursive() takes
> > its trees (merge_base, side1, and side2) are different, and if we
> > fix them to match, it would make it easier to work with?
>
> I think it is definitely worth fixing them to take the trees in the same
> order. My preference would be "base", "stage1", "stage2" but so long as
> they match each other I dont object to "stage1", "stage2", "base".
>
> Thanks
>
> Phillip

FWIW, I concur with changing them (and Phillip's preference of order),
but I'll elect to leave that out of scope for this series.

--=20
D. Ben Knoble
