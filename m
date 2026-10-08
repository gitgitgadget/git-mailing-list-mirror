Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E03F787E
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451472; cv=pass; b=Ki+Bzwwckr8/R1yIz1qabc314mMVSFE/XMoERqDURWMzqfInPowfFbR90sl0s8A96ccu0wG0rpj8dzlCLnwl7isvMONOPBewtaXf2CVF0TBSUoMedmrgobYGBEKGBdWniol6TQbULfKr4xc/VLDO4ea8aS7ftosfgSqV+x53Z6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451472; c=relaxed/simple;
	bh=w9UCyUERaiy4F1mNqSEHX+8TkYw94CmMyxq4278h1+Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=BriVAfZmVa1bfh1BHJrGi6RxLz6osyyaOGofOxT5dC6r3hICYwXGCv5HT4LemkiYWPKhSvwHPMGF/cmBbijMVqvn0Axyb+yFTx37CcixB6afcg7fSlPc7czItlLA06+TQ+PcLEiZhVEEjL5yOaB7CAlIjliO81dVBEh3dnFgNmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj07B9Xa; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj07B9Xa"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-98ff1011195so336289241.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791451469; cv=none;
        d=google.com; s=arc-20260327;
        b=Qy3vA//xtcqAKVITuleXhsBBUJXLbaVfFxqdE9b5/ILOX7WIPii2fHCmLMD5P1M0k7
         gwrm4fN2uxHMdFRai8h+K7/6tCzunTdlTXXUtccjvHaLqOFLIgAQbbA6ELmy8UKybCzE
         mRvJ3hE3z6KFtuXmiYtRMY0xM4e1yoEcwGNY2/8GZ5dpDtdn1iKkEY8pUyRB7vK1XRUr
         zuiNfNJNoXqSBOvxxnNXJx3UNqDkdTKpnBLnZ2uoNftbG3En0dtYbc8sOHSuZ5YYzRC9
         xBMvFWprnxkSVViwsPx9izPJdyEqh1C4xJ7XrM3psrlVXIVD4mxeLiLoqcDSqegRqv3T
         zFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=IopNeQM1eFbP49WJxcxw1HIQTXqf42oH8D+/e2YGjyQ=;
        fh=yxJ9PGZC0v1P8lZcGi62xXG5p47S9HzlelDzM1Fj+wM=;
        b=EVTE/gDrCLvIzWNHBdRNk6l9wspX4o5qp/dZ4/an+0Oye5FAnzz6mtadl2MDIRLNv7
         aw+EkuY7cenIY1+EJtfVpA15ycMDc8ugtDZk4rA+iXWBcNrJMrhfU618oIzz6vQO6XZC
         uWZxv5YZ1ERT6LkxHPM6O1dUthU9KIwFQC15hSADNQ6+6GUvQRTTfaCHz0S4CGxxQe5U
         ZDjoFF7NRN5AJ/rcVcPAUwlyPNdBKkm8vUj2gfMbM6jpZHwPrt+a+7k+CkFDkzWGgsfJ
         yE1YysF/vXZFT8zz9Olgw6tv46pPUPLBAHvIQZPNcDOMuTrPlnNlpk/jETaB21MRYZTK
         pFCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791451469; x=1792056269; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IopNeQM1eFbP49WJxcxw1HIQTXqf42oH8D+/e2YGjyQ=;
        b=Pj07B9Xap+/a4nN5+sfvcYWeFeTPZ0dqeZwG7no/6rpGNY1paQ3VPxg+009acCqky8
         ClaLUGAdhMjg+2Td3j5SOcsB5kpSQ0l3aAytfrDMBNSFbzHweKOgFNg0+cmCb/nKGibV
         2WdYqeTA8dbow+5TdVaYo1Ug8H4/AKCjzLE1jN7le26L95KuMyv79osJYCioZ1Wa9QSB
         RhXrQEl6cD1qo13j1xTx4ivKe3t9PD3+lsu1MPz34+L3N4FuucyRUBZxB0lFKVy/U7Lq
         yBDbG5UgFTLf5EeRfyRPrVcLYGjmMhUIbm5IcEjr9hivr4MiNkLsbzyQgzf/FrMzBo9G
         2aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791451469; x=1792056269;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IopNeQM1eFbP49WJxcxw1HIQTXqf42oH8D+/e2YGjyQ=;
        b=1TNTRjXzi1wtlX2JL+MB5ILb01vub67wxm55LQFTSM2zyyE7OoYHP7L/WmELE/GYMw
         RjY8dggmt+YuU3oZk/DepYhS5Wf0BNJVTsijZds/N1OPjDyIQZOzh2V5E8wlJhdSMx8O
         rCaa1PZ1lT7AhJ5+3r9NkeoOyXISL6V5ZriQ3e/n+YoqBF1fHMTYlPRF34KGhKyjiEz5
         3QTqKNeu7Uv0Ojq8zPau5DKOeRaMAbMBOWrBac2r2Thyf94PqQxCwbIQFqoyZkZNjxMR
         BI1B9Qp1xxIZ09xQ3h7gK1Db29v+WA2rMvKdVOrJQ+NBtluQkdidHXKAeAnieF7CFwUa
         NKUA==
X-Forwarded-Encrypted: i=1; AKwUvBzI7kK0M9CiYIftgFYbyEOfEg508FoMc6LksL127YnASL+DOKVfRRp/QbhNDhOp6Z+y7lY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeqK2Zvv62q6UqrGHAqj1eOzlYaQCGYPoOVhKgnuLBwxNynwzv
	HWBuN3Qs4hrU53s2bhO0awxQnuWTO8o+T+KPqdJ0IWR1bD1QJTvZzRkMG3o5qiu+kA9DX17hvWc
	mEqaZ60ZI9UCTvvYs6fsFICwYXfFSz5E08A==
X-Gm-Gg: AYBFou2ybXe+QcAjIVTQ555oH7e1juWmoqqmUKkjtYMCrVYWtHMOnu9SWfTh9d1MXY2
	L6mRXdpFqME37MDNEoudbW2RYEN9WBkPDeobmkl6BuNalHGM2A8m7Pi6hieRNWc5nvuSFFvNwN3
	dwwbEUH20MG3Xmk8xuXLggmS+8A7p16y+b3KRKf8yQlxY7+NJ74YBmWL9uJyoUOaX9TDlqIwLx+
	kZxXq7ssVjtYXRCnCwG2L8VFtgwA4ztQC1CY3hFXF0yxza/1H5jbRJEBabNMl829KI/s8v2YP+F
	z+15iDpI/giKxTGYMVA8TaCx3xTwKu8jtYL0pTz+RKoKfZ/bmze2wHhfRi9LJxbuElHJe9iAraO
	hLBiE4cZfVS0Bi/VUzy3aQt5Obq66Z/m7XuAbYdbazWreVYpZ3nU4Ikp+
X-Received: by 2002:a05:6102:b11:b0:7a7:198b:6747 with SMTP id
 ada2fe7eead31-7ca38dab566mr1630105137.28.1791451469040; Thu, 08 Oct 2026
 02:24:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 02:24:28 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 02:24:28 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im> <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Oct 2026 02:24:28 -0700
X-Gm-Features: AclHuK9vJu4ujaNDWqb9PhDtTRGL2HR70rTT28f1BKqx3AFI5IbaU37pLv2Rle0
Message-ID: <CAOLa=ZTjrzNbuvZ-kr6k5TZSMyGGMFTb4iar6DZwdnCDvUrH9Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] odb/source-files: move alternates into the backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000071f854065d50cc07"

--00000000000071f854065d50cc07
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
[snip]

> Range-diff versus v1:
>
>  1:  985b068271 !  1:  43a288604d commit-graph: require resolved packfile paths for `stdin_packs`
>     @@ Commit message
>          for a set of packfiles via the "--stdin-packs" option. Those users are
>          expected to pass in relative paths, and those eventually get resolved in
>          `fill_oids_from_packs()`. This ties the logic in "commit-graph.c" to the
>     -    specific object database source.
>     +    specific object database source, as the subsystem now needs to assume
>     +    where a specific packfile is located relative to the source itself.
>
>          Refactor the logic to instead require the caller to pass in resolved
>     -    packfiles to untangle that dependency.
>     +    packfiles to untangle that dependency. This also makes the next change
>     +    easier to implement, where we'll get rid of passing the source to the
>     +    commit-graph subsystem.
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>

This looks good, the previous version itself was in great shape. I have
nothing more to add :)

[snip]

--00000000000071f854065d50cc07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 19fa4a785c76eaee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ySFlVa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTdQQy85QmJBKzFuOWVSZHAzQ0dNcXllbUtTamh1aQp1YVQzQ2VsQ3BF
Lzc5b0VnSWJNVjcwNExseFhlek1xbFBORlEvOUVGdGU0YU1JK292SzM3ditqYm9yS1hBbzNnCjIr
NUdJbmNkUldKYnAyZ0lzcmI4WDc3UXYvWEtrL3BJcEE1elVLWGpCaXlTWlZWZjN1MnBkNm9nVjFD
UVZRajUKMUU0WWcxZ2cyalVpbUdhdEZuNllnSnVSejRRdk0zM0JuWkxyWkpYRFlDLzJHQ2d5alZY
Z29Zckcwcm93WllsSQo1eTArYU9maG9xRlVlcTdQalA3M1Y5R2lqMldnay9wa3c2KzZRcmxCVThL
N05YRXVnTGFicGpVKzNad1NzRnNECmM0OEVuL0V4eDBLRGgrL3R0WDhPczM4YjgxaWRjVllFZWZW
RGFNcFVxd2w5K0JkOUpaaWIxV1N6NUFUODBBa2UKZ0NxYWQ5Q2VMRXJPeXBqOUV6TW1WRkVOaWw1
MTB1akgyYVJPdnBhYkVYMzBzMU03QmQrVnp1dnY1MXErTmswSgo0Rnh2TXpQT2cwcHBLYktJV2ll
bFU2QW9ydXR4cUJCMmJ2M1ZJSnRNL2IzWEo3U0JpT1BMQ0FCZkpGVXVidjFICmMwVHd6NzFCckRa
VWFQREdtZlZYK3FvNHVsQWZJd3NYVXAvdGNOTT0KPVlXeDEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000071f854065d50cc07--
