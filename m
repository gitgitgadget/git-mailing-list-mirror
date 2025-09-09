Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B9322DD4
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419398; cv=pass; b=AcSdwwxt3Bn28cP7++ookbPXjN2z1/QUVBFQhM2oCB8E4n85QG3tVSVYQrb46TnFWzY+6JA94pK3TEbLR9O0Dls6GDBkubqZ2BoADLXV5OUEXPUA5EJ7oVY5SMXYK9u0AllNEYPqF2nqAs9uQISspOMQOjC/ZxI2c0Zo0GeC7Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419398; c=relaxed/simple;
	bh=BCg2XNhlUmcl65OR9BxWso1HTEHdci8eGNnXpRApgJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eVPAwC0NmjTH0txgCKIICvjq/zS50pTp+g5QJWPe9YS5giJyRikKsDNMkhljyndr/VJxyh6dVr0n33iBZ6XXTtRdVRG+chdFMe6X5/Mzn5SVtaMbKfn9Fa/J77dz54MeU5hWS4G4kgVWBlzcutWMwUBJK4fFk/ShCfacqFPmWNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Df3Qsz9m; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Df3Qsz9m"
ARC-Seal: i=1; a=rsa-sha256; t=1757419367; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GrOd9ebYS/y+VIN1mBS5LBZ/BCFVgEC0AKWF5ctHSrMKN0Jrh/xGmJUu4Kws9m9hDb81WnlxFVLnn0tz7DemR4CijtnK3Dma14dY6HEw1gapxpOWjgXmShoLpHYRqMTTk8pGU9mtJodByoShUxAMyxLSNvfeeV8Qm49j6VO4hd8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757419367; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CLCSfQKdyTA8Oni/WmICsCvKpXQqNe5QrQibRYk7Ey4=; 
	b=YzopPzrW+hAuSLeIB0Mw09C8Ed7OBysUHWrs4Wy5tLeMJBSAbEwQiy3nW9cEM3o93E2FhiunQOMKH3/kMl9jgE4ZadReUdbOS7+H/sNHyWVDuJvKdOdBDHSa0pxiECHECYbLBZ/0qAu3Oqk2zvKHpUc1/a/n7NIaDE08EZCsRdY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757419367;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=CLCSfQKdyTA8Oni/WmICsCvKpXQqNe5QrQibRYk7Ey4=;
	b=Df3Qsz9m5oOiV08vNcrDi1tkhZhSsLWOrF4AflSpdd3UPljLsvAivRA0XwN01B6c
	EAhfETfAK58+9RnTmP6kKFW6Xo9EJw8xBNxkS20ybJ+QCwZvRP/567UbOPvnrvRCKlN
	y1csT3GRxc1Z5MJ7dPgbsdYaVw4rQaFQF1cDlWOY=
Received: by mx.zohomail.com with SMTPS id 1757419365273710.2522812802426;
	Tue, 9 Sep 2025 05:02:45 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano
 <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan Nieder
 <jrnieder@gmail.com>, Stefan Beller <sbeller@google.com>, Patrick
 Steinhardt <ps@pks.im>, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 3/9] submodule: add gitdir path config override
In-Reply-To: <ee61c97a-63a5-4c81-8859-09b896bdcf42@gmail.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-4-adrian.ratiu@collabora.com>
 <ee61c97a-63a5-4c81-8859-09b896bdcf42@gmail.com>
Date: Tue, 09 Sep 2025 15:02:40 +0300
Message-ID: <87h5xb7s0v.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Mon, 08 Sep 2025, Phillip Wood <phillip.wood123@gmail.com> 
wrote:
> Hi Adrian 
> 
> On 16/08/2025 22:36, Adrian Ratiu wrote: 
>> This adds an ability to override gitdir paths via config files 
>> (not .gitmodules), such that any encoding scheme can be changed 
>> and JGit & co don't need to exactly match the default encoding. 
> 
> Reading the old email thread you linked to in the cover letter, 
> my  understanding is that this was suggested as an alternative 
> to changing  the gitdir for submodules from "modules" to 
> "submodules". Do the later  patches set this key when encoding 
> the gitdir so that JGit can find the  gitdir by reading the 
> config? 

I read it more like a complementary / good-to-have feature than a 
requirement for getting JGit & co to work or as a path to keep 
"legacy" and "new/encoded" modules in a unified dir/namespace. :)

The key is not set automatically, which also avoids unnecessary 
config clutter and is mostly useful to change the encoding and 
simplify tests.

I see your point though: it's not a necessary requirement for the 
git core encoding itself, both due to the separate dir/namespace 
and because we'll add an extension in v3, so the other 
implementations will have to explicitely add support for it.

Will reword the commit msg to make it more clear in v3. Let me 
know if you have more thoughts or any concerns.

Thanks,
Adrian
