Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396133;
	b=1zUD5Cf9zkVakgHoV/8TZoVCvHMxOC9GAnSOSun9wEa2wmyUtsahChqVEQIzHJzhz3sp
	 jFfyolVU113cyBrcbMQ0OoBFG3t6EFwOAdWXoiX5+fixJSfx38CQNKbEwYfHOX19b6IUM
	 R2Kjfbb+6eZyrA2+AHZrrnapcWrsCKDdA2DQyH+ZI9Ia7acJ7GMe2l9RtQbpb7YyfZq2W
	 ZeIq+Ow8LyYU30INll/T3LrGNsU8mShkx23BFgNBhFEpuOwMIID26FSgzV7WyzL/unxg8
	 sqxzyywvh0EtmsV3RMGrj4ienIEWytTQ6FjlbEFkq7KpooGlpw1X+adw5UO5SNpl4vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=7fjcGz6L4YXP4jJvHwN9iBSLTtTwhYKiwcdXSFDAnHM=;
	b=ANavovAA/fqs5mvSa1Rbfh7fsEWPyF+8FAWJ41ShuCtZXXUDEtB8AA6YJ46tBbyzy9z1
	 GZ6qTQPZD7ublrQLhySmrP3FTl2qrFbO9RiVVoNFUHKAx1L8D51vYmUGrNFNkAYpCNQxx
	 orJvDnc+vB6SN+Tq4b49jGR514F+M5blnVo7vJE4o2fhK0g3arOsIVIRorM1nWPggaVxn
	 xwax+QdspsZbD9d8cmdDEL7P6jQWACTpUCa+WQE4+d05bIR4qjEV2L1/Y6ycCFGI6iKIl
	 JXxyAQkgf1ZpS77nOGJSVBX+og5g6OvsfY44/a82S0KeAMVol9vrNzKi8+9YRM3Yutw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gBr4CePI;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850FA606A324
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 21:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 850FA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gBr4CePI
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c73c63116so13987526d6.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793396132; x=1794000932; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fjcGz6L4YXP4jJvHwN9iBSLTtTwhYKiwcdXSFDAnHM=;
        b=gBr4CePIR4m1ZJ8GSaF3FlvE87dgJaknw39uQniToCIyzsEHNgOW/8g9TZZchPdcQc
         /tXE4v/KgyygWNL1bXSg9cwMfJMLhFFLwSo8q8EmSmAGOCfrNOZNLASzXEgIU39yTFEz
         bQ4DSQyRnV7KdTedjAMZaY4Hjckla2l2zCp/2XaUAYuhh5DB4hh6QUTjxTuJ1WYrs1Lq
         xl8ZFypHKmKeReJQ03WqN+3cLQoTI/1oMgWRzh2wEEkRM7tWPQGRshjkY4Xdo4MSv7pB
         ePmwhPC+JzIB7+uWZ1SV2qNCjqAWHD2g9GjxGhAvwjBnZSNmwAwXZXuLH9aTFA2PHaCu
         olaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396132; x=1794000932;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fjcGz6L4YXP4jJvHwN9iBSLTtTwhYKiwcdXSFDAnHM=;
        b=gO+pjWR6bPSA65MH0Uitf1BK6pYrwzg1akK784eSePh8n5CKQxZbPp71XIagr86M3q
         89cGqI/bYGi7IneZMZjs4Jyjter2sCDr2WFg53ZH3CLzKt+x/A2BFPeuvE+HP1Zx7GX2
         lKHzTKa/uo1fpEoyKBeQ9mp+pkyDSnRwIwFxom7+mSPiR8pfiGknZxIrzBWI3uZin4Lm
         SfNRSpSCQAkXYy/MnPj9logXJ12PVwqgOXSEttsHPxw9SrpHlZd8WWHuzCeFPkF5v+mc
         k6BJc+tvvHcgY9LcUjMgj0qLirwTf05CjEZLycAACMy1D1lR84ssYEL6C90k4OiV+oTK
         AKkA==
X-Forwarded-Encrypted: i=1; AKwUvBz4rLSlQevXvAPbty2r2R9QfT9zL9pSix+fh+VCs/MStFeY32nS5fTG5IoOzvs/yahj5NM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6wb96f5GJHwpdeGbGBs1u4N1xEOfJr6mHXe23KLdfw7kVryV2
	tjPcGutPP5DjQHnbW2Kb+VCX5RdbkruAoHkb2eZPHsOTj4S9pD6uP9/1
X-Gm-Gg: AYBFou11N2gpnqIita0xipULutYK7xhkFcoHgZP76dJNK6oka4xRCaZVqsvkUgh81B1
	PJ9ZfOsKAsEUzotHJGOFD2pXfBtFEF87GgLVGbiL54XTA6Ph8l8kQtQq5pXwzG+5jaBJdVvPest
	1WoAxM31n0T/D5JwjV1VWB2/OG6+ROjkuEYkxj+6phS3wFOoYWamX4t3tF6R/9J7zuubczfjOqw
	PbNURxaNPcKmlfKZniLE9XJ2rC/Yh2A48l1UYnN3buFdTRBClIAChCf21HpSIjIEQmpXhzfD/WU
	0cxuM4zMskE4hwAc0yN5F02ggM4IIe1DxYMXCcwdpbClQfs3JvFkdtrZ/TEwNUWdMf+9AMI1MkQ
	intFZVqFU0MU8qsAGPrkwlcvmYKw9g8S4z1t4kRbu7vEhDsvQ0qGAj2qeJtOcorIfRRTNlvbGNw
	FcO48Uimw7PriFZrKcXJxfvxAv52YIUEGzPrznKbeZU18rCZimq+HibgWgvJbpLs1pLJN5i2Z83
	as7kfNILFz+F/N5NgWHIjlfCj7dj2tSLJjuk0+7IqnpuVg3UbqKtiYMA6amiXTrtC/yiVRJLzF8
	GwYW8K3kYuBw30y+T4oOb+9HuR8nWw39+ASWwLh1GycHlYy0lYwgOBb9bKvJXHt31fy0IwrjdWh
	45ePYbQIuy153RonFiW+lPShUqMfekmfuDF2p+ObUeaq90UQkxmIWl9g5yHa3xRmD9udW0Mm5t9
	1gqV98ru96H8GMBdHOBDy6cXtq
X-Received: by 2002:a05:6214:27cf:b0:910:c44f:a81 with SMTP id 6a1803df08f44-91ca4b5958dmr55400586d6.10.1793396132193;
        Fri, 30 Oct 2026 14:35:32 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b03e:6cb9:c1f9:7732:784f:faa9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca80700b5sm25496956d6.38.2026.10.30.14.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:35:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] add -i: hide init/clear_add_i_state() functions
Date: Fri, 30 Oct 2026 17:35:20 -0400
Message-Id: <EDD8FC7B-91B4-49CA-AE6B-3475E03EF786@gmail.com>
References: <xmqqv76jxl22.fsf@gitster.g>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
In-Reply-To: <xmqqv76jxl22.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 30 oct. 2026 =C3=A0 11:30, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFPatrick Steinhardt <ps@pks.im> writes:
>=20
>>> On Wed, Oct 28, 2026 at 12:57:51PM -0700, Junio C Hamano wrote:
>>> The "add -i" machinery is encapsulated in run_add_i() function,
>>> which uses init_add_i_state() to initialize the machinery, does its
>>> thing, and clear_add_i_state() to tear it down.  External callers
>>> have no need to call anything other than run_add_i().
>>>=20
>>> Make init/clear_add_i_state() file-scope static functions, and
>>> "struct add_i_state" type as well.
>>=20
>> Nice cleanup. For historical context, these declarations are not needed
>> anymore starting with d51b61f5dab (add-patch: remove dependency on
>> "add-interactive" subsystem, 2026-03-02).
>=20
> Thanks.  I did not notice that I gave a backstory for the other
> three commits but apparently did so without digging into the history
> for this one.
>=20
> By the way, I queued the patches sent to the list on a branch (I
> initially made them on a detached HEAD without keeping a local copy
> after sending them out) and tried 'git history reword' to update
> this one, but it seems it does not honor the notes.rewriteref
> configuration variable.  I wonder if this is a known limitation, or
> a deliberate design.

Indeed. I believe it is a known limitation (one I would love to
lift, but will probably not dedicate time to produce code soon). Still, I=E2=
=80=99ll help
in the usual ways if I can ;)=
