Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A32FC011
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794716; cv=pass; b=iERIXt1JO75ByjycY6S7mNnDomHO4CCax23xka8sywz8NXVxJsTnOWHwDyANqTIOx/T0kfVoUmjYtgz4XgSb6E2WQW3AWVWU1dExh/t7qQ2vkcqGSTPgmNNqBohQPknzBRp1AFZtHiRr922Awdpiu/8NcFy8JzrK7nZLEO8bZtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794716; c=relaxed/simple;
	bh=fCd4z6fvY158ki35PzmYzbxR3EkAk+HCSBVFA+FFeAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gu9I3TDrhuOXUogNuzneSabKGnpZg/mQN8jr6VQS2oCLF2SOWsIUS7f6a8pf7QBwlt6X3LY6OwBWXn1k3ukdNlmtzjZqi4+tf1Fz97IFLCLP/tLwF2e64CPzhNayRFKoGNptVS5Qy3vCabU9+YgRG3k8bSr73IgZJngwa44ThAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ctoMee/n; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ctoMee/n"
ARC-Seal: i=1; a=rsa-sha256; t=1762794697; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wj6RxiGfrOHJxwpGuQSb4hMbigtqcrgVZr6zYorABKVrAi8DWE9uTvUdxBKmQXRDMVBJIUmmZp9OKkQ/kvXaTGl1NU0xi+WXNuvACLSlfzFoA2lzx+GDhhYF8Ed6lMO6FKkiaM0E9ifGLk7PU6LN1yb1IFnt3lGGWgdfnjW+aUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762794697; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Nme+MMo5rzvg1lHt5DE/6Wf3Z6D27dnEwgq8lUexJCo=; 
	b=QVhlbNFVyMCWFjYbjromRVOkU5JLw1SBUeGQ/6Fd34jdiHL8wKFOnkoU5hlDXs2eKRr6dd53xF8JSf7D9cLtEHOLiPvFzfLskkxv310lA+s8y7VklsDAQn2RmW4OxkWOdRdpnJaPRO73iZMdKT8CCi7/FpabWtr9Ae7xUdz2va8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762794697;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=Nme+MMo5rzvg1lHt5DE/6Wf3Z6D27dnEwgq8lUexJCo=;
	b=ctoMee/nX6Xt4k6xvkNrB3D2oHS9+iyyTwOdnbCHggqXYiQkztCMm6jcxx//YMZA
	cI6g6y0rGw6r5VpeU8mvmxrPAAhp0VofqXsiE9/qmsO7fXt1S89G5Kw9AuVILQZE35M
	3pNXxiov1XuuCjag259TDtFFVEUjbc6DspCZ+jIE=
Received: by mx.zohomail.com with SMTPS id 1762794694719140.12738273564162;
	Mon, 10 Nov 2025 09:11:34 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Aaron Schrab <aaron@schrab.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Jonathan Nieder <jrnieder@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] submodule: fix case-folding gitdir filesystem
 colisions
In-Reply-To: <20251108T182050Z.vbNv4y2kizC1@fnord.qqx.org>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-5-adrian.ratiu@collabora.com>
 <20251108T182050Z.vbNv4y2kizC1@fnord.qqx.org>
Date: Mon, 10 Nov 2025 19:11:29 +0200
Message-ID: <87ecq5ke2m.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Sat, 08 Nov 2025, Aaron Schrab <aaron@schrab.com> wrote:
> At 17:05 +0200 07 Nov 2025, Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>>Add a new check in validate_submodule_git_dir() to detect and 
>>prevent case-folding filesystem colisions. When this new check 
>>is triggered, a stricter casefolding aware URI encoding is used 
>>to percent-encode uppercase characters, e.g. Foo becomes %46oo. 
>>By using this check/retry mechanism the uppercase encoding is 
>>only applied when necessary, so case-sensitive filesystems are 
>>not affected. 
> 
> What happens if `Foo` is added first and doesn't conflict with 
> anything,  then later a new submodule is added which would 
> naturally get the name  `foo` which would conflict and doesn't 
> have any upper case characters to  encode to avoid the conflict? 

What an excellent question. Thank you!

Right now, in v4, in this case the user adding the second `foo` 
module will have to manually set the submodule.foo.gitdir config 
to avoid the conflict, because Foo already uses the coliding path.

I can add a test specifically for this edge case to exercise 
config overrides on case-folding file-systems conflicts.

OR...

Maybe we could derive a new path automatically (eg foo2 or foo_, 
suggestions welcome) and use it if valid. This way, there is no 
user intervention.

Do you have any preference?

Thanks again,
Adrian
