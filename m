Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30E19B3FF
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993147; cv=none; b=UO91QoJfG5MXAD/SV4PxG/+RksRWGZ8tKX9wxsMyhtj9mTK3V/cky09nl/BiMl1tD7+HrcZ1wJwtdgcDMLDs1zx5ctmDgt1KZRildCspL04AXWNbTtyTzCAQnQ0wxaOKJlTZsGv4ufEkWUBfDVHG2Jq/v7i763nkrUDKjG27Xds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993147; c=relaxed/simple;
	bh=zFWB1YosRikiWWsdvW+ZcAMi38CW+sv/QdUugdMene0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ahe98ueRJFR6G/91ofZMjYAWlxs8bBliGEP3aUGa1uasOcNax+eav5Hg/YLlXxF1wkiOrCb2yxap1XWKcad+H3/H8ztcBOPljHb0XI9H4w9fFuPWN1M6XHtp/z+97ytwm5iYLrKKrfe8Sg0M0MiILyLosRQzeZKC9h4hcqZAxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6+5ieqU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6+5ieqU"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4ba20075so3470053f8f.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728993144; x=1729597944; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFWB1YosRikiWWsdvW+ZcAMi38CW+sv/QdUugdMene0=;
        b=G6+5ieqULsPG4LceBtr3f/sXZRmLBJCm6QLJ8szk9Un4QtzVWDMx3TG4uANgEQ6E32
         pJsIm3KNtwPfGkO1NC8nBduqyX1WOrBWWawI1tkcPG/d4UY/1kBitWc/VxZP7CS+PviJ
         R1l29C9ux1n1KDK8V+phwCuQt43Pu5sQgsMPwkskKj29490lDPC0ev4xx6caDKF+lb4D
         /aDNMv3LiFI3vqdMrZyOPN4nQrPe66if8H97KwSNlKhffOufqMdoAdGycB+u+3+hYGxR
         yA6FlT7i6P4VkGRs1hT24cE+yb4HN8607XUDY7WHiRJ7tEdqoPbWPaoFmgM2X7jycAHo
         gY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728993144; x=1729597944;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFWB1YosRikiWWsdvW+ZcAMi38CW+sv/QdUugdMene0=;
        b=ST1Rs58NZLn11bNrEVnyVtZkgp4rjOy8qhJFddwEHN+YEBrbew5yk0bhsDXyrkPg8V
         33ehVdjylLx0XyJPFj04g2gnAQMcr469WGfXbRcAwvcauqARiFjIyrj6aLtFX87oPCaj
         gsumz6fr2X3PrhugFnfk+4l1xIMT2XR5vc0A+316NEqgthKoYZBxqET03nMEsI2yqjKR
         iv2dVyQNvB7DpToawgEVhQNH93VfFuJht2XcMuTGaeWsM/sCppOzLjaEov1FMTUp2Yi1
         Zy7E2+NQorS4CEUgJbhRHq4mEhelpqvlubN7HePyNStgkB++ZIstEEgzp2Be4s9/stlD
         d57w==
X-Gm-Message-State: AOJu0Yz4kPUxEzs5eGHKKiY0/jgoZ3+wL6IwknsBbxjTbXbU6JRkpsxS
	SBNQOeFjT4jP9rj4p8OyCSv11gkrOw3b24zYiyVj2aewzaaCsf0fj9eVvOzV
X-Google-Smtp-Source: AGHT+IEpkEib9vxM/h4UQqnOgWTxW6qGk1mbivkx2JhAxWGx+CdSeBNE6xrKELSpk+UPhtYsSuk+EA==
X-Received: by 2002:a05:6000:194f:b0:37d:4afe:8c98 with SMTP id ffacd0b85a97d-37d551fb5acmr9941204f8f.26.1728993143731;
        Tue, 15 Oct 2024 04:52:23 -0700 (PDT)
Received: from smtpclient.apple ([212.36.34.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a1c8sm1377277f8f.21.2024.10.15.04.52.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2024 04:52:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Should object repacking only update server-info for packs instead
 of doing it for refs?
From: Luca Milanesio <luca.milanesio@gmail.com>
In-Reply-To: <Zw5LwB2ap1QnmG6L@pks.im>
Date: Tue, 15 Oct 2024 12:52:12 +0100
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
 Taylor Blau <me@ttaylorr.com>,
 Martin Fick <mfick@nvidia.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: quoted-printable
Message-Id: <428B24FB-A648-43BA-9381-1B46D99E2F37@gmail.com>
References: <LV8PR12MB9407CB282D1FD4998C659D29C2442@LV8PR12MB9407.namprd12.prod.outlook.com>
 <569E3AEA-AC68-4186-B38C-2E47DAB9890E@gmail.com>
 <Zw2MVqi0FLcMuR8Z@nand.local> <Zw5LwB2ap1QnmG6L@pks.im>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On 15 Oct 2024, at 12:02, Patrick Steinhardt <ps@pks.im> wrote:
>=20
> On Mon, Oct 14, 2024 at 05:25:42PM -0400, Taylor Blau wrote:
>> On Mon, Oct 14, 2024 at 09:33:17PM +0100, Luca Milanesio wrote:
>>>> It seems counterintuitive that an operation designed to repack
>>>> objects would be performing maintenance of any sort on refs?
>>>=20
>>> True, it should not touch info/refs IMHO, as you=E2=80=99re really =
not
>>> changing any refs.
>>=20
>> Right. I don't think that the current behavior is a bug, but just =
that
>> it's doing unnecessary work from within 'git repack' to update the
>> info/refs file when it's known ahead of time that the refs haven't
>> changed.
>>=20
>> I think it's reasonable to skip this step when repacking, but of =
course
>> we would still want to update info/packs (assuming that the repack
>> wasn't a noop, of course).
>=20
> It certainly may be reasonable. But in my opinion, it would be even =
more
> reasonable to not use the dumb HTTP transport at all. If you don't =
there
> is no reason to run git-update-server-info(1) in the first place, so
> you'd neither generate info/refs nor info/packs.

I don=E2=80=99t believe anyone uses it anymore, but someone *may* still =
use it, and therefore, Git should update the info/packs during geometric =
repacking.
However, why not introduce a =E2=80=9Ckill switch=E2=80=9D in git config =
to disable it so that all tools can automatically skip the expensive =
info/packs (and info/refs) updates?

> We have been discussing in the past whether the dumb HTTP protocol
> should be deprecated, and in the context of that discussion we were =
also
> wondering whether we should start disabling git-update-server-info(1) =
by
> default.

+1 from me.

> Users don't generally need this, and most server operators
> don't need this nowadays, either. So why generate data that is useless
> in almost all cases?

Certainly not IMHO.

Luca.

