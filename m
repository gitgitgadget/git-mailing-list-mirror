Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571836494B
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276156; cv=pass; b=bNCp8gIsb2pyT60F6v+As9SEfqTQ/FQxLUMELzfFkc/v0LKTXW8ZLBmxv08FwL+SF1Y9d9smx4RFBJjC2+9MuppBoBme78gNnFVd0VyWaAUdIgdlumEFD7/QIphNaH+wYJy8mK8SY4VLNoSJLJUlw6X+URFsVG6XNViLMnr7u50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276156; c=relaxed/simple;
	bh=YY0qspr5HeT+oxs1XRCV1cH4Ps+/CvmWf4Y5ZPeLSBI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=fqAMWNgWGJ08+XGnMKfCd4Vym1CtDJLdL3bPAw73tOh5hVwlJiphCYd0bGL44noHxFzACoVmnzw1wvJJ6nQaO2fd7nftWXhpbM6r5JXAB100iDhp2uXPc+OzTEFIoEcwYtnYlPN7TcmH975V3nt6BXO2KLLugjyuqUvxfxvzBfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYuVVQch; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYuVVQch"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-98c78660542so220240241.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 01:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791276154; cv=none;
        d=google.com; s=arc-20260327;
        b=nfP+h9apVqEJIIhIwlRDcba01ulSjSp4y4T7HcOt3zewmU6iF7teGeL0mt2NdbsiKH
         5/bVyrmtLerJDnybBVaYSCZh/G9oJ0Eek3xDPxvysqNHlhr2Lx8CzKbGIj7tyxPOVnVm
         OJV0Lg4lNicEzl8zTTnfMcU/gtTEUpHG/7O/tSVpPboc9muV0If9HCiCu/CA2M/xaBJe
         KGwk9sm4l5dsXbBeMlpLV2APMscrfa8D4MQOXC916ZvJOhjOQzViaTeAHXEwhigBpkT0
         kGrXKabM1xDUGmvLBve9WRpl4cytw1liE6lO/kgo0uhjLrvaEDCYAZsY85cmvNjZ5EsY
         jwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=x7vprrRdspJKzBFOKdQtk8bQYYN9jXf7WGCdv7TPcmI=;
        fh=jrSWchSEyI0FXZI83ISG9gNN4D3CfJGYF9eTVAEsYHk=;
        b=sxeJk91J3R7gZYJExIKDnH3GtYQlkbEVcqIlzkANw8I6d+LPspxzqwpzQJMJfLmkOw
         QK03eYaxP57YM0r+rMVxvgjMRZImDN0XxhrKCWOWBnk6nuVQvsL1OVvbBSQXXgARrypk
         lGe+VD1Iyv45cIKBYzklEazMR3Q4iK0bfCHRXjF/6/khkOYznzp8aQNol6/0PuwYSaTE
         RQlz0zVCszeY0PWbNEPw5lNlzRe0+wEPGij1LqBpN/i/YTN/kEw6kxuTUvDtd+Kx0TsX
         +d1E1tfatgciXQ0ySGlDh3GcK6xpAi0x00CwYBK8SNOY9lHQRPyIa4OQm1gVdrPmnBc+
         LMsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791276154; x=1791880954; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7vprrRdspJKzBFOKdQtk8bQYYN9jXf7WGCdv7TPcmI=;
        b=IYuVVQchyfw1Y7V6piFYgGE7KrCARadvHULfZlD0o9l+P3tpcdg3kN/isMsmj9xUJA
         W1N84SbALqlLYT9UI2d2QDLRTZcJz2i02SlOnAhg+PWoRpl8AAHM/egqcgk9EsmtQdld
         yA1EjomyYE57/5jefI1sD+Ye3zs7l3twqJKmZcwXhozjdNzHR2UMfgx+4iohpjvcyL46
         YziIa+KnctsWGb55NJDQ8z0dCq25pP2QF6WL+pkx+plC0zfL8m+IZhXbxKI9epqSr1Dq
         hZQHN5DK2Tbr5UshwBzrdKvp4Am9Phyx1Dbs1v9SY0zb/ad9fbiNUOAKBu7pdoiO4/CQ
         PmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791276154; x=1791880954;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7vprrRdspJKzBFOKdQtk8bQYYN9jXf7WGCdv7TPcmI=;
        b=iyB+ZUUOR/S4ck2q0eP56GxoXKuz7AoHkFb51Rarc9Atp5gmH/OETcPKh+XocCewQL
         6J6I7V2cyXP4FuGhKJmUv2K8uYFCh+WvqyvzcYLK85EJYaS6rktwZ0kmoYEnqbEB6Uoj
         fkcZJCqCK8zEvyRNGFx7QXxzypZPvcads9PBb75rbZTVU5gryHY6HAk8eur/2EsZZ+NG
         QTFfYkggyfXgYr3pkhnXmdAt+dFOMG5RvmAxdRnFURVZ2UB5N4vKg6FpkU6nnaK7g51v
         UA/fxRDH2n1xGH5+ftHoX53rfvtDyFjhcWPDSatdToO7uhVNW+Lne7K5DhxyYNVe8gWK
         dfqA==
X-Forwarded-Encrypted: i=1; AKwUvBy34v304ILlaq/UCG4CqVDPLXpv6+fhvpMvDkTxhxACm+I8zOVPUBjkU61dY7qk02QwyJo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKi/JCldB4ML/axwQMR6/YmiRv/oew6Cu6Kxemp0c5ByktZ+H+W
	gfPOrdB3LczV0l9J9PKTajt4Ca3OwfoThn2pb6lHrad4VLn5iE3P24SOBzjfOKlGZ7I6/fvebLe
	eNmEO8ifrt2OOdep+QX/dhtOSzZEpTBHO0A==
X-Gm-Gg: AYBFou3nArZ4jUl9h8ytczLBb7+agfYy5w++kI65jR1IYkrNkxtmQUROP82TpSdwQWY
	Gx442WdW7Y951zBaWwq/oJj452JJ8lDPMPwHD3XPpQuJrE5eiYI426X/6fmVav2mxm1ziFmph9l
	dgMeJe30XR6LJnAQ+jucUkNzRFjiduULzyvgmdB1utfEg0N9gwUvXW/hyZwO92GG89saQNSmb2A
	TL428X5inTcY5uw3jgxFb0ae7yybNrMX1XuEybdNb28Um1ma6sNIEECqXdfi3k+dAAvxWpoQHiQ
	oJC9XEDBRCiZ5E73TAWcqRBL6SSW72z5c4seH9cMhZQygqeVwJ9xiKlKhWX6CXlrfJQltA/wnKu
	XPQ3Y0aGwMhfFRd4OKMCibaiTud2LztLFeN/ZS5PafXoNXlA=
X-Received: by 2002:a05:6102:a54:b0:79e:2b00:b4da with SMTP id
 ada2fe7eead31-7c879efd888mr135827137.6.1791276153740; Tue, 06 Oct 2026
 01:42:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 08:42:32 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 08:42:32 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-4-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im> <20261002-pks-odb-move-alternates-v1-4-8a63507b88c4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Oct 2026 08:42:32 +0000
X-Gm-Features: AclHuK-df1xFyivVPUJwCNbbD3yPcdRLHe_jtIYuj_ZFBGMIDQhP7TX9uojEz-A
Message-ID: <CAOLa=ZT-=VQNXBs=i8ZkB1yZoJV_i_n90S+Ygdgt5=tmquVOOA@mail.gmail.com>
Subject: Re: [PATCH 04/13] odb: refactor `odb_for_each_alternate()` to yield dirs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d6c613065d27fa23"

--000000000000d6c613065d27fa23
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> @@ -468,9 +470,11 @@ static int refs_from_alternate_cb(struct odb_source *alternate,
>  void odb_for_each_alternate_ref(struct object_database *odb,
>  				odb_for_each_alternate_ref_fn cb, void *payload)
>  {
> -	struct alternate_refs_data data;
> -	data.fn = cb;
> -	data.payload = payload;
> +	struct alternate_refs_data data = {
> +		.fn = cb,
> +		.payload = payload,
> +		.repo = odb->repo,
> +	};
>  	odb_for_each_alternate(odb, refs_from_alternate_cb, &data);
>  }
>
> @@ -481,7 +485,7 @@ int odb_for_each_alternate(struct object_database *odb,
>  	int r = 0;
>
>  	for (alternate = odb->sources->next; alternate; alternate = alternate->next) {
> -		r = cb(alternate, payload);
> +		r = cb(odb_source_files_downcast(alternate)->dirs, payload);
>  		if (r)
>  			break;
>  	}
>

Okay, so here we call the callbacks with the `dirs` now and this
corresponds with the changes in the rest of the patch. Makes sense.

[snip]

--000000000000d6c613065d27fa23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b7974cdfe15be5fb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRXRIWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM3dOQy85K3U4WU5WUUZhVnRnRmxlMGdZSEcvTzhwMApZNUN3YzM1SUw3
SWZ3RVB2Y09uaHQyS0pueldOK0wrYUFJY05odWRnRkJpcFp3d0h1Z3ZHNGU4L250bS9rK25UCml5
aWt2QktJejZOL2E2VXJseVROS0RUMDljZGdkZTFPM2h4N1VmbS94YnVqNVp5VkRUNXM0SXZKamRl
VjlFTDUKdnZKUUNldmYxd3ZnWkpJYzVOR1d0ZEwrdk9qVEF3U3hTS21FM3lWbmszeUFVZnU3Myti
ZXVqeUprM2VSbHNYSworREhUMnhRdk1PTXFhVERxWU5pa0xXa21Dc3VTc0dHSEd2aXcxUFltaGNF
MTk2aGxyOGw5K0lCUEtOQklQclRnCmpOanVnTFg4QVNLNXFLMUxyVC93TDRITEJCSDVnekl5L0NH
QXZPR1c5b0tkbVBOY2xWMTBab0NrbWhJNkl2b2cKUmFsMlVUVXpiWmlMeWt3SXYvb1Y4TG5ZQkh1
R0FscnV4VXFxMzNDd0hDblIwT2RtamtZbHE1YS9aNTI4T3k5cApCMVlwOGN2c1NzZ0hFdlFvU1Ev
cjNCcG9vUjdpeC9EVFVxSzJyVDRxOXJTYUkvanNraUVpRzMrM0lLYURLZlNVCnBseVhreFRhMUhE
Q0xJYjdsVXZNZVNSTUwrRjRiT0w5bU5uWGtvbz0KPXpsdnkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d6c613065d27fa23--
