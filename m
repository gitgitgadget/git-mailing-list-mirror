Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934D231C571
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415497; cv=pass; b=bhZLVlJHj4FLcQ2jQ3cd2sZH3/AhcqmeTxWuTvsig5RfP4exwQgaQFP3cL/Za29x/dm8aam67cqjVC7mx4EOQqzxoUcA06Ag503UQMuGuUeBxWl+QOsoTM8Vcyb4j+59IF+tbtPtZVqVlEFr8gBeIRMHZDSLcMwnBEe6xVeXiQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415497; c=relaxed/simple;
	bh=C8CUpEaQBJ4GfeMWIhM70t7sSayiv7oXxggZb+0iZlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uWXqbF29fcMdl5w+LZkqLPdUR6r59Iq4nrJNIxDlHm0/zx99O3p6J9mMDOSrzpzooQM6GO+VJYzGYkXUxtgZspRGxNXeV9SFA8EUbSEdXSNdRrQpz0PvK+bT+zr33mgVloN4dCyC8otLLSkebkIiCSrjlo4hyATrLLetS5UwjyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=XBxwQ/ET; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="XBxwQ/ET"
ARC-Seal: i=1; a=rsa-sha256; t=1757415471; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dpjA99HTABHSt+00AgOQqOCMst44KuIec9iUpeDrOvpKKfyv+6eM63rpPTHbrrTP5+UYJIOuY0DDs/VRh7sC8ikOw7vPC0eiafi/uSLRc4p7ukLfl4n5tsNPIJgsuD3VXB5f3rD2lu5YB6XdbVGWiGdoIWcgtORzUpHFTEJFWww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757415471; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vEA0o3i9G0ujnzthlKP63VRRqRoTgcFJA2kUkpqveww=; 
	b=jQFd1R8k2n2KqmWefBYNyjGpcxrhkGICstlQHq8LmCYUhUktSdbKpj9TERYIYAnmTjI9BW5ODGg3T0ZeNKr3tC7cr24Kk0BkyqwmG7gK0HAt5IPtoYPbdsEFkhN8Cpw8iiFin+sf9bV+5R5IW5SIQEPO2kw+CccFYDK6tut0+Lw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757415471;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vEA0o3i9G0ujnzthlKP63VRRqRoTgcFJA2kUkpqveww=;
	b=XBxwQ/ETMSUrur0vOWQShxgW7D+xyxVy7JPbvHGOzjhLV1hjCqkU2s0ApixM6HFS
	eSGGN/itphB0aZXXV8P4ygeCI1ZCuebBqzUht3y4IxAEs7PJZ9FcR25y500UK+HHGsi
	duO9SGeGCtFqtGIo+Wr9EGAJy2lFz/5LgZbVAUYo=
Received: by mx.zohomail.com with SMTPS id 1757415468292652.023200888755;
	Tue, 9 Sep 2025 03:57:48 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano
 <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan Nieder
 <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/9] submodule: create new gitdirs under submodules path
In-Reply-To: <5290c591-fd3d-4737-bfcb-fc091751af1a@gmail.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-3-adrian.ratiu@collabora.com>
 <fc69ee66-815f-48ec-a5fb-99cac5f4d58c@gmail.com>
 <877by9ndzt.fsf@ratioveremundo.com>
 <5290c591-fd3d-4737-bfcb-fc091751af1a@gmail.com>
Date: Tue, 09 Sep 2025 13:57:43 +0300
Message-ID: <87jz277v14.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Tue, 09 Sep 2025, Phillip Wood <phillip.wood123@gmail.com>=20
wrote:
> Hi Adrian=20
>=20
> On 08/09/2025 16:46, Adrian Ratiu wrote:=20
>> On Mon, 08 Sep 2025, Phillip Wood <phillip.wood123@gmail.com>=20
>> wrote:=20
>>>=20
>>> Does this need an extentions.submoduleEncoding (name=20
>>> suggestions  welcome) config key to stop older versions of git=20
>>> trying to read the   repository as they wont be able to locate=20
>>> the gitdir of any  submodules=C2=A0 added under .git/submodules?=20=20
>>  Very good point. I'm a bit unsure we actually need it, likely=20
>> we do.   On the one hand, older versions of git can still=20
>> initialize and work on  submodules under the legacy=20
>> .git/modules/ path ignoring the new one...   On the other hand,=20
>> there is a non-zero risk users will get in trouble by=20
>> switching git versions or can lead to inconsistent/corrupted=20
>> states, so  I'm inclined to say the answer is yes: better safe=20
>> than sorry.=20
>=20
> If we only needed to convert the submodule name to a gitdir when=20
> the  submodule was initialized and all other access went through=20
> the .git  file of the submodule in the working tree then I think=20
> old clients would  be fine because they'd find the right gitdir=20
> by reading the .git file.  I'm not familiar with the submodule=20
> code but I don't think that's the  case in which case I agree it=20
> would be safer to add an "extestions"  config key.=20

Yes, your understanding is correct and it goes beyond just the git core
(where we at least have a unified API to compute the gitdir path, so
making the subsequent accesses follow .git file contents would be easy),
it also affects JGit, libgit2 and other implementations, so it's the
most prudent approach to put this behind an extension key.
