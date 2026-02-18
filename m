Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834BA328263
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771425642; cv=pass; b=ljv4kOSXj+/4/r6rpAzGL1Uyu76HlQ1x+Rze6w508nhG2HkZ/SOXEjdx2x7YJi0xrJCVp91H7en1HLvlBTFi2D60LkK7nphhud3zvSEfYwI8XoHrvcZ7BXp9YiWZp/o2/Qfoy+oQbHT3vLMJ5cFC2dDEFqYPAQBIWEuOONDIJ34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771425642; c=relaxed/simple;
	bh=6DNAjFDPQmIN5VmhWj6D+gXeQlRysU8IQsfo2+HgFFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sa5dbZBOvxRuLsW4IsAs/3mM7jFDrDPAsh7ZEgs7R+1p+w82oaikXVZuzHDIgNRmvd9t6WVNl3o9WFQVlnXwdFQoe8FnofFtvkULyJBQ1gENv2FHaotN75zq4WYlLMNkRN8TQCutMP/PMDTHD+7XsUUPoR0SSCBu2RuqUdObbUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b=X+nTnika; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b="X+nTnika"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359a16a400so5182737f8f.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:40:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771425639; cv=none;
        d=google.com; s=arc-20240605;
        b=PVyklvrD7NmMwdb8NxusJKYVCwZfnV134L/uJIs3QfqVpELsEyHp4iuolya1O8ScvW
         2wRZ04RUC0sXx1o+0J4f7FSzoXbljt9FHBI3kvb2AEKOzKzCVZeK14Yc8MUKwRk+MAEf
         TMrrcHp+L5AOcZpu5cik8MZZD2UHkXE3Bp0bGt6dijbJhUJqSzpw9Dpnr6M8KZf2UqRo
         qY/xF4ho12GmgvrlzXTXJmCJZfquCxKQ96x+DnVFHXTqo8cuS1TS1y9vnAghz4uVzW+o
         b/roxamdRIiuiJ+2o9r1qcR/uNrDMF/uUMI1Tu/rsZZMH8HnrT55xsSbxVDQ5/HU+XnQ
         R+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6DNAjFDPQmIN5VmhWj6D+gXeQlRysU8IQsfo2+HgFFM=;
        fh=DxNqiRPZT8//nQsqlfVongd71YS3di0YZsrc0O1bers=;
        b=bngakvennTKR19h+wyPtY5MnfUe7DzkQmzfoy0Rc7h5NEcjB7Aoe0GJq4+qOKAx9WV
         SIVd+DRRAB3DoH2biAlJzqFEMn9HgAzS2wsLyDFI/AW0Hw7li28DQF0B3aeR8L96Aw8v
         tjjabo3ysVzKuv/XfuU0Oo1geTN0Xm3Zc9fEW3VVpLHj4Od7909xJIjPW9BuzATIfnuN
         2Oj0co1z/PAQhwVQcCtppPQIoe4HHwWhbeer/qyoR73gyPzw+3RH53wsmet//WPCnSBy
         LfvlxhU5lERNrQiew7lqQi4pclZEYlT7ZHCVApE4wL8Sai77d/koxotzwX1RBfvpHlCC
         UTDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20230601.gappssmtp.com; s=20230601; t=1771425639; x=1772030439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DNAjFDPQmIN5VmhWj6D+gXeQlRysU8IQsfo2+HgFFM=;
        b=X+nTnikaXbs4Y1c25gybQMyO6T4624tSeBlHE+H8BgHeXZbLxTG9eBc3FaOqvlWDUC
         6WwdSDbhzA+UUv5QB0FznWS5sI6wxW/mGO4B7qVYfys94MAodJ5iSQ+8m0YDHkDKs/6u
         l57SQk25nyOTGyLIVLyjtITXQm1HbcnDVcbkyxEP5YBWPPJ1T3bod1T4PcTAvuIqF1Fn
         3lb00mS5h5C3tKrb75jObs3kSX4I3OsSygIWwpV3bgf2g1DsKVpCq1ZtE8jLrEPZ6XIM
         lZALgg9gOdzRDiCAhrKDlGyivBrrsS4GkhZRV02ZeXn8Cknv4nWIzoJqPBnODUMdCPJ5
         wcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771425639; x=1772030439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6DNAjFDPQmIN5VmhWj6D+gXeQlRysU8IQsfo2+HgFFM=;
        b=O5znygsBXf90xrDJsUyk28VFTB2RinutMrnd1hruxHKGrF9Dzb/crHy70ZeOsMwMGE
         IIansFphfE1hltdnVJ1wd7usn7D+d52mDPQ63Qs1kc6t9T9Qs7fy+ntzBcijSzrvYESO
         7iYwYzumJxk6oBxy3+OhMlYa1pvgCMBUNlWTVGs6LRKloE1UXY9cJV4NCUkG4STjzDjG
         S5ppU6Q7Ep2KtZ2LKO17zf01CeIU0Zw7NixOR/fMZYACEHfnkXJErF1DENYkcdOcczko
         1T48pO/jL7QKN9mSnSwkHPc7/H+C2M60JBAXvQ7sWgivHdvi/mfjmtl62G8VTH7YQ1mh
         xydA==
X-Forwarded-Encrypted: i=1; AJvYcCWIXtG7kAUhfvx1GrYtrvtMc4Y3Vg/H9xUsGkpkKZI2Edj4p2Ik4Xjje7IcHAdbsa0uV3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMHt+fR0sDmpRyyxoCm9Tm9AAzkCaAsIkXCgUaNfmwuir7NM3
	qNIn2ixgjmzBOcB2+ChEJ91AEXcYdNZ/lj06EOGO45Dp1R85bnfDjd7l2ns5mrOoFLrlThItz2d
	RI+P493nqypREr6CIh7vPO30d8wga3iaIMJLJW27pntyEVY2slVmS+KzV
X-Gm-Gg: AZuq6aJvsJ9msbqSidouwsY3xahxpRpiqAkK6UTjo46jL1RaTTTaXqFLRl1WrsQ12Tm
	npV+fHmDq0mxVMoJjor9bFTugrlIwIDxgiSWo/yB9TdBYGQmGP/DEgXjt9ClDOF3dfb25OqakpM
	XQ9nTqZv2mJqAMK4Ad+cRggMhDHij/BrW2hl0QJRGsJbvScauyQVK3HnBnThAyFZ0uodN7gbA2c
	Vxg0FuRkXpsE0qMYUM/dT2dam52GtD6d3lfxSaJ4j4tLZCzOuyIK2aPx4nJ09dGZhZgT2n5PJqk
	1vBmtNE=
X-Received: by 2002:a05:6000:40cd:b0:437:712a:fab5 with SMTP id
 ffacd0b85a97d-43958e4048dmr3836213f8f.35.1771425638612; Wed, 18 Feb 2026
 06:40:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2198.git.git.1771002510709.gitgitgadget@gmail.com>
 <aZQhnIcPa9sCPpBb@pks.im> <xmqqzf579kuc.fsf@gitster.g> <aZXJVtgRYQAnxNnE@pks.im>
In-Reply-To: <aZXJVtgRYQAnxNnE@pks.im>
From: Joaquim Rocha <joaquim@amutable.com>
Date: Wed, 18 Feb 2026 14:40:27 +0000
X-Gm-Features: AaiRm53nFMTFcn-WaPH_YItpFYI7yuxSopOnzVkaXztl9mjwAA2ZQbiLVsoho0I
Message-ID: <CAFJE3DEro4B+UReO0+639hrdUvFUSB6-v7LOxPFU05q15zgakQ@mail.gmail.com>
Subject: Re: [PATCH] apply: strip ./ prefix from --directory argument
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Joaquim Rocha via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Joaquim Rocha <me@joaquimrocha.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 2:14=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> I guess that's fair, but especially with command line completion it
> might be easy to arrive at such paths. That may or may not be a good
> argument, I'm not sure myself.
>
> Patrick

I understand that. TBH, while not at your (plural) level of expertise
in git, I am certainly an experienced user and still the error from
the ./ use got me confused. So my proposal goes towards developer
experience, like the similar command suggestions it also has. If
there's no down side to it, I think it makes sense to have it.

An alternative would be to have a better error message if we detect
there are redundant path artifacts, but in that case why wouldn't we
just normalize the path as it's the user's clear intention?

Cheers,

Joaquim Rocha
