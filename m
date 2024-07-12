Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903385C56
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774141; cv=none; b=ftnjoXND7mHj1OyabQeYag7KlYCqR1PODGgbvedhOAcmZWthHVniOreUgb8PGQUKBcFXVN5RKF73KTLo3/jthKLm/o3rGVfrhxd0JLymiYis2GJdMxL8a6wciQZNpqNwF/bBQHuJzUvjUNuQiR5QRc7/EzCPGCmOJKb22uWhcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774141; c=relaxed/simple;
	bh=G5AzKbZ/ozSfnneLxTR8o3wdSTc85sqN8YkHGa8DJjU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIU9slJWfGgU6ejZHxkBoA9HyUWnwpffXNuuZ+WMKDPZd/gRtSwqXrWxAalxzDw4dk+1DdQPT0oFl1cgOmMGJGpq0GYNZsUSImPhm738qReDwfWtjauOBkK+vJh+H2g6DLJH0byzOl6R4x6DcBA7M/WRaHSGAjbj2XZwIusc6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyB6TLrt; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyB6TLrt"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c9cc681e4fso926245b6e.0
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 01:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720774139; x=1721378939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6i8hS+EOcUno+5GwvK+rgfguImBVcmJAnohOk3Iuvpc=;
        b=UyB6TLrtBjwRonSf7hvNcOHNP+7Sjr7nJpl120B26J5SHB2qbNNnZfR5qfeLkYWbD7
         2JsESKAkCj1jkUhq53Zl7HbIfrlZwLYJAf9SX4AzYOTHzMv/tmfrnr0cttCHk1ZOI0Lt
         KCoU0L+dHc3c+UXU3FrR1jDlML+s/6ENuYxmBmhJgw2Pr9PBXXVtGAn/seRz6luiGGPO
         6HOMfAhsymK0y90dIG8pmjNSl1Ud3uWEcH5gdH9LyPmIKn8aEO+2/v34eIq2suP/z3AE
         OVh0XoEo4ih5x39PfaRrgZgeuWsv4IVChP1dJZkxIxQgcMVlxyFnvYXlDO9tO01v1kPq
         fzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720774139; x=1721378939;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6i8hS+EOcUno+5GwvK+rgfguImBVcmJAnohOk3Iuvpc=;
        b=Sokl0MH3uMQMaNzkeJcnqGcnoDIfhY+GMgJkGgPjQnZzq93Mbla+psxaOy+3FCMo0K
         4djjzSqccTKxHInQeJ6RSFVPGF4VT0dmrSF6RSRT4GZQcSqSTxnzYl1+aTKoZpKhEgpZ
         ognW8RbSEVj4aizCb+9GVCMJVp//rOX09xkDI19Q+PMp0+lS+vvay4/mkvCspEsIYRjk
         595WBP2F38ZXs6HB0IW3jZ6TwQRqlSEPDAgcO3u4M+1mJpTVYc1UqXmlC7qGtvnBRQlY
         bcrBtfIhWsO4Ao/Gb4FOxAlTru62oJhneq0sPKYzNGUSHLbTo6bWpxkZUazXP/mOBAPl
         SBYg==
X-Forwarded-Encrypted: i=1; AJvYcCXCMShqxqdskN5EfBZ+qRLYRV5AlHOEk+iLeVC07ToUHMzXugzkJ4BFggBWKzyqkxGNLWVb+YXcsdgtzDg2B6vziNeV
X-Gm-Message-State: AOJu0YzIQ1inHloXmmLgIIpbHoduSMadQHdF1BbwmMS8Zk0RNHHwLoNN
	ry0TN7JcxV4EvOiJd3eEbw1lX52p5lFM4IEPs9qe+au0GbC5FdMdefHZDjEIU2LnJ68t2xa1sKK
	DBP7TpW/++QW24aWQ5eTFHxThMCz+El2J
X-Google-Smtp-Source: AGHT+IEy+KXrdSIgDhQd8Jt6M4TyuL8vnkLVeWRHTu9PK4gBXrWCJAFDRB3wei5vqRQ7WTOFXa3iBPe+8HMPefauepw=
X-Received: by 2002:a05:6870:75c9:b0:25e:29e7:14c2 with SMTP id
 586e51a60fabf-25eaec13a77mr7831986fac.38.1720774139470; Fri, 12 Jul 2024
 01:48:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jul 2024 03:48:58 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqcynjswz7.fsf@gitster.g>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240711083043.1732288-1-karthik.188@gmail.com> <20240711083043.1732288-6-karthik.188@gmail.com>
 <xmqqcynjswz7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jul 2024 03:48:58 -0500
Message-ID: <CAOLa=ZSJ-PQ+8rsURP16QQ_K8rR8xrhFO8tnAPSZD88COrzj1w@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] clang-format: avoid braces on simple
 single-statement bodies
To: Junio C Hamano <gitster@pobox.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000528312061d08f3d0"

--000000000000528312061d08f3d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>     Setting this option to true could lead to incorrect code formatting
>>     due to clang-format=E2=80=99s lack of complete semantic information.=
 As
>>     such, extra care should be taken to review code changes made by
>>     this option.
>>
>> The latter seems to be of concern. But since we only use clang-format to
>> verify the format and not to apply formatting, we should be okay here.
>
> Hmph.  Could you tell me where I can read more about "we tell
> clang-format only to verify but not to apply"?  If that is truely
> the case, perhaps I shouldn't be worried to much, but it is not
> clear to me how we enforce that this is to be used only for
> verification with non-zero false positive, and never for
> reformatting before submission.
>

I was referring to the fact that, we expose '.clang-format' via 'make
style' which only prints the diff to the STDOUT. The user has to still
manually make these changes.

However users could be using tools to auto-format on save and this could
be an issue.

> The senario I was worried about was this.  We aadd to .clang-format
> that is in-tree, and not just CI jobs but our human contributors may
> use it to check what they newly wrote before committing and they may
> even take the differences as suggested fixes (which may end up
> breaking their working code).
>
> Thanks.

I totally see your point here.

If the contributors do end up with bad formatting because clang messed
it up, that is an okay situation, since that shouldn't happen often, and
when it does, it would be the same situation as without this check,
wherein we rely on reviewers. The issue is whether it would break their
code, I couldn't find anything on this.

But overall, while I personally find this check useful, I'm happy to
drop it, My goal is to ensure we run this on CI as a first step :)

--000000000000528312061d08f3d0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3bfb3b2048bdc48b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hUTdma1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDE5REFDVE5tSzM5YUttcGd2bnQzR3c3ZFhkM1crMQp4cHlQTGdLcDI3
SG8yM0VpMmZmK2NONUNyckQvVTdiOWV5YTY4Nmp5K2MySW81ZFlRdnMxWFpBalJQbzhoWCtpCmFJ
SnI2OHlhREFYdlFIYVI5WFp2TnBTL2ZFWGJ2NHVkM3lJbXM3WW5KdDFQeHU5TXBsWjkvVVUvczRR
cWEyK0cKb2tuVytiL2l5T3ppQlBFMytDcEpsdm1sSDhjTUp0dFRwQVUzUExYMUxHNC9MUmsxMi9N
YU9RSldGQXdiWlV4MAp3NGIrNVZMd1dVZVY4RkdBZi9VTUFKei9MamNrQ09FZ0JtR2JpUUlsc29C
WVZEdDFLYWE2NkN5eXNCSmRmd0kvCmM1N0h3Ukx6TGdIYi96bjVWeFh2K0QzdktmMDJjcWoxcHNw
bGlJbVdoM1lReHEvRWxQUmRCTmxYbTJpUWh1VnoKNVpVSmZCZ1N3ejgwN3NPNFlxMWNJbjlMYU5r
bE9IMXdoVDhFbHZZMFpBekZqUlN6U2JiTG9JWVA5a2NLOXBNeQpnSVJzUzJNQTFwUFpqeWF2MVc3
Y0F0aXhZcnJhbklTdURJNDBXdkQxTWZSakxtSXhQeUorbk9IZmRmNy8rcDcxCkhnRGZlOUpveit4
YW1DNkpicTIwZHJoUWxPZEtBL2dvQlc2aEdyMD0KPWVNV28KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000528312061d08f3d0--
