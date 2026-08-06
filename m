Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383844C51E
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014075; cv=pass; b=IZmQrZlLDkFcDZ6+exT4DRtNpNj8vxgftxqcUG5ZD+TMOVUJwV4UPAdaA+xjfu3IGkk/mVUXAHvJ39a2uWPdVSPGBKot5hBb5Owf5oOwkyKmNxV1NVfFwVsJDjzhyHJdfojWAgzQlDK3Chvw661Jk7sYL4zeY3DiOxT18EMSbmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014075; c=relaxed/simple;
	bh=MFO7O6QcUM91Lsf6C+pBZrl1nLpKV89W+lA2lnXZ1AQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnxtSO+HVbWdK2I4YwDGmIZD6CG0eEtgJbjTYJcEP7O/wbIlgo5I4d8TtOpyM7Nck0miSX76rV0IrB4WzxfCpqYlF82X71gMGDYhDG3w4V96OreBERM1+8HkGECZ6MwzYF6JXkcijhh+LArGDVs0w6EGngKMQh2NcApVuon3sFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMTBU8qK; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMTBU8qK"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-96944741eaeso656069241.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786014073; cv=none;
        d=google.com; s=arc-20260327;
        b=jqcNrouV3Zlog6ik7OFchQ6DpimPxlNFNwTWA2eCgNDU//VCPP/kaK3pMx8UUq7YQO
         4fFYc7kVeEOuWV1Qt/ScEPj27oBRYEw4S5Y3BOmAkqf5cd0SlSEKVISjqU5htlwmVA57
         JemgqbqI/2i6TLsQbHpJwOub5GtmtufM2SXxZb+xrQi4N3Dxoz7K2R3l6UDK9hncJcC3
         c79YXtdalYIYdBTeQv3N1ylBjqij1wY6gSXVEh8uUcVqLxeRZF6bVG3aiFHRGlI2H6s8
         mUoE/4ruaf1RBShdYAgtxrSKAxF2yAcWwHywBfUs5CzqMHKlPHgmghWo4k+5e1ERWb3i
         Yg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wD3pK7oQsllmVkYVlMZe1s9nKtpHGbwWzsLSu/iNioU=;
        fh=7vBjRnUjldYsdch2MPji9bsgZOo4tHFoiEA9zSKxCC4=;
        b=VHBIr7TsVEP3hSdqyRxDi3O8KrtY9pvNkX28Ec/S62ESf6G1kIVU8nB22sNAhu0Xc4
         8tL04705YaWf5D7mDDJkdE7wxaYOTRkh4q//0y5BGr4SwPwWzzwn5CAztwi5fEhSbno0
         tqm3rklQg5g3evu4h8Zp2eg/J/kzhs8cTw+0O31NcmljnVybYsLytPRdrF+pkebi2SwE
         7uMLCk+q4Z0dc2a1m4zU6bmInCPY8WwS4xCwbAYvttYuai+LLEHaBUDi8Y6HhBkq0936
         oXseWmelCoClYIDFtdWXUQS5vsScmDneplB3vmWtSDex28/bmyQzLMbNdWNhthXbubVJ
         roaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014073; x=1786618873; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wD3pK7oQsllmVkYVlMZe1s9nKtpHGbwWzsLSu/iNioU=;
        b=bMTBU8qK5Paqx1Zrx5QDNQ/NMrKnHE7UTrrZKrlQ/kc86SrB/pKEbtK63gXboAj933
         mLihSssV57ccdl7B0oVHkjzXKVG/l+Spda5M4WkaQLjOpwttCIYvrF3uTgPHkoAlMe4k
         Gu+XaEH2SuleSAGZguU1m/OR5hMYcsPebqH+GMPh1vfvzafYn6xfBqaozwbwrwzqXRvJ
         StUzo/KfDoraYUFmMAtEnnG0hxIigAjX2ntpvucL8U6HzIWa9Hkr8nhefWcDIlVAg7r8
         uRULgyHojs/OBx/K4QAzrc2Ay+YUOSGqmzkTApOXAbIVB97CPiPvC+4nWlEAmnBNKcHQ
         v2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014073; x=1786618873;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wD3pK7oQsllmVkYVlMZe1s9nKtpHGbwWzsLSu/iNioU=;
        b=fhDIeSy1ehah8JGiJ11Q1ji6p5UF0BnLpoc8ArGmtg+ErYyNeXj42lwX3jzjNevjoy
         1kej1HttPNLMukpP8tB2fEUcQKMneQTYcNsEDwfiH+2GnoUPbjJnFftIpDFsJY/dVDuO
         /j9Q1CjptRCN29VT6PanteCSNT7eUtVj2cuordDqAZYV4hseS+6II4pr1Xpg7/kTLCm8
         RqC4LvSeZMHJEJ8HXpx1U3H9R+ke80MkpcVsfaQZPbZqQaETiMiZ1wZN2AoAgFBStZEh
         JhH4vM/FsVaykDghWoxtDI7wY3U8OOH0aK5cJEOOXk4cpz2uEtLW9uMcUy5cAIfjTERk
         9rtQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFyHmG6T1FPXopwbMz4Do75imoeFVmzy0Z9j5nkbrXH2R6/ITErBBZ8eanRBib/oj7diE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDB0grFqoE4f28ZjsoQY75BvuxRONukNjFOQGntWnTgcDkIFLk
	yt37Bu7efoTW8LEVmdTuXLVUjcd0wXfgC1r8Hr7ClMGjsXaoCtMxbDCbvo6RXrwMD4YIV1lbOye
	yQAzQMGdR9N6lo5UEEzbbf8To2i4eQq0=
X-Gm-Gg: AR+sD11X8nvGuM5mztN0hKz6K7S1ifsMIPqqvO+awTHpaxJthxIqh/osTMHRPl/abMz
	O8e56MvdC2tvUCLZbA31nsXlg0TnnpwWQ3/eywOtgXhg2mT15/Ja9X/4IXqsm7GC/QTvCeraETr
	0jhgLR5lBmedB53KJGUZZ2ZJutnceqThsjVbayRzYIga+dHEgPrrKoBZM1roo7jt5ppflXdXpoz
	8g7Sz3oEys78RuksDv1Oc2CWvQYn9N8HRomnK/QxMMGpNfD7x9PiyT9thj+tcH9PqPhcFF0bEBX
	QcGNIPZ0FOkUFxbZJI/6KaOF/rg/iiiUMbWpOHPs8OJYH24mg0p0vcYCtXuM8vSyY+oxCCiAI5Q
	iDwvavNMfxpfuJiqwgbAkyRqFPluYNuc8ZE+VzKJRBBE=
X-Received: by 2002:a05:6102:6c7:b0:631:28c1:154c with SMTP id
 ada2fe7eead31-760e9e4714cmr3291883137.9.1786014072803; Thu, 06 Aug 2026
 04:01:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Aug 2026 04:01:12 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Aug 2026 04:01:12 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <V3_CV_git_ref_migration_warning.b23@msgid.xyz>
References: <CV_git_ref_migration_warning.b09@msgid.xyz> <V3_CV_git_ref_migration_warning.b23@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Aug 2026 04:01:12 -0700
X-Gm-Features: AUfX_mwqxTOeu9MyZlKjHGz1GCn4aieJDJNU6QsymHaqCHHiYHDU9JsEpBCExRU
Message-ID: <CAOLa=ZQQnrRca60BAfnm6Azu=bHvnoVhcGwQ3KkDT7yqLDd8Dw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] doc: refs: put ref migration warning under the command
To: kristofferhaugsbakk@fastmail.com, Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000005fb04406585ece1a"

--0000000000005fb04406585ece1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name (applied): doc-refs-migrate-limitations
>
> Topic summary: Put ref migration warning as an admonition under the comma=
nd
> so that it is visible.
>
> That=E2=80=99s the first patch. The second patch adds a missing `linkgit`=
 since it
> touches that same warning text.
>
> I have two other patches that are not included here. They are unrelated
> cleanups that I will post later. Here are the commit subjects and the fir=
st
> paragraph so that you can see what they are about:
>
> =E2=80=A2 doc: refs: wrap standalone placeholders in underscores
>
>   This is a synopsis manpage which means that standalone placeholders[1]
>   are supposed to use underscores (_), not backticks (`).[2]
> =E2=80=A2 doc: refs: use inline-verbatim throughout
>
>   Use inline-verbatim backticks (`) for literal commands, options, and
>   subcommands listed under the =E2=80=9CCommands=E2=80=9D section.
>
> =C2=A7 Cc list
>
> The two people that I have the impression that have worked most on
> this command.
>

Sorry for the late review, been a bit busy. The two patches look good to
me! Thanks!

--0000000000005fb04406585ece1a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8f96c09df02c98d2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wMGFYWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0Z5Qy85MDB2dVhmYUZwK2pBRVpSd0dCVlVYZmxEbApzbmkxRXF1cUNU
QXhtUXNxeU9qNCtyYTdLc1RuZTU1TzBOblRRSURLczR1c1lZYmtWMVJNanE3dVhVTU5pdjN5CjNT
ZGFGMjNrK3ZCZnVaOHk4TUJiZnY3bFF6NmZNU1RSMC9ESXNTUGJ5cDY0UGFVcnhpRTAwSVp6UThJ
d3IvY1UKV3NLT09jelIvZkQ2MG0rd1dWV2p0NENqTysvbDJuaDFzekdNeHhibFF5SDBUaHRBRE9h
dy9neG93RE5pTzBtbQp0akorb1M1RHBkUGxnUGQrNnY1b3ljYmhqaW1kbTNFSFAzaitvNGVRVWs2
RWFLTGVvWENmeEJLVjkvM0xGMHdXCjdFYVlmUkNtVGdzNGVZc21KQUgxT1JjbC8ydXZxMU1DY2Vt
eEczZ3UrOHdaemIzdXdFRE5OV1cwbVZMbnZGUGsKVmUyUlpaTE95QUVuRDNTSEw2NTFFRjhBRTZP
eHhjSklCZXdBLzJnYm11b3hFVmFPa1RtQUZiYUFQTGNlUk40Vgo2NlEzM3lNOFJYQkdsdURCbjRs
cm0zN0V0Kzd0Q2kzVmlFSlNMZ3BPcGttaStjTUdBeThubDVqTTQ4UEc4NXV5CnM3MUk0ZW5ieExj
bHFXUzV0QUpDRkxvY3BCYmh4Q3NlZlhsZGNlaz0KPTR5cHMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005fb04406585ece1a--
