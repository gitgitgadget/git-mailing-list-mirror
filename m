Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DEE15A5
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711060410; cv=none; b=abTMGCiVePRv2sI7Yz2WQJN89FtIHRhLC83RHxfSPFI3tr/kmwI4EFHPtXMB9IgnWEmZtyCDSysJ/fdSEgPX/7xvUi2AA1HOKBTkr+5CZh1EBFwzuamVRukjRactwdCyb69ffJz69Prj5KV6EPxJNpXk00nQjZovEjPCEwbTaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711060410; c=relaxed/simple;
	bh=Pgc5Ppc7aL3rbQGZu2U8WJVnwtUApJgy6q7rGWL8Gn8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=edKrNhHrwRpVSs3/MUqXc8bOhbnGBh39O9EPm1SzdjPzcHkBw6Sp4crGrmFgk625t0ngvgxDFhGfrQ2SxtrJwT06+zVj2wuH/mYMSs8j6mTlpJYPHES56v28iqiuJ0UMkwyDGDDtKIe3qP6yGlbVAfrt1IejkCi+nk+su+GPOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=Ak5m7v1p; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=J+YOPxrt; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="Ak5m7v1p";
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="J+YOPxrt"
Received: from localhost (7of9.are-b.org [127.0.0.1])
	by 7of9.schinagl.nl (Postfix) with ESMTP id 6D47719FB5F7;
	Thu, 21 Mar 2024 23:27:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711060026; bh=Pgc5Ppc7aL3rbQGZu2U8WJVnwtUApJgy6q7rGWL8Gn8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=Ak5m7v1pUG/MTEmA1WLvL1wZlkK0kZt8Xcm9BBWxYz3S+4IS7pfAlwBYntMhJ4ZhZ
	 CQGO9k3BSQ8gTRl8OB6J6owPNHLR69mtCWdoAB2KFRveWd7/dOWFMG2BvL8xsMxeIG
	 pwwNcXbbA3I2VrOn/nguVHXpExrENo2f1boF2Fn0=
X-Virus-Scanned: amavisd-new at schinagl.nl
Received: from 7of9.schinagl.nl ([127.0.0.1])
	by localhost (7of9.schinagl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1Nbso9d-Fi-r; Thu, 21 Mar 2024 23:27:05 +0100 (CET)
Received: from [127.0.0.1] (unknown [10.2.12.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 5425419FB5F2;
	Thu, 21 Mar 2024 23:27:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711060025; bh=Pgc5Ppc7aL3rbQGZu2U8WJVnwtUApJgy6q7rGWL8Gn8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=J+YOPxrtgIkcjV82pmO/iTqCjgUaMVx+pn5JjyUzHsAZQqaW4mLdAte3OxEeQuiMb
	 HQ0mFpI2ZD37ejxSC+x9DxjsZA+4WdSpfDCqwa4J1RMC0DfDlrw4BXRzVk1lkA2Fw+
	 A9oG4irj3CfHGQ+lelvcZcp6BQomJuN1H8wY4SsI=
Date: Thu, 21 Mar 2024 23:27:07 +0100
From: Olliver Schinagl <oliver@schinagl.nl>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
CC: git@vger.kernel.org,
 =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
 psteinhardt@gitlab.com, Christian Couder <christian.couder@gmail.com>,
 Taylor Blau <me@ttaylorr.com>
Subject: Re: Git mirror at gitlab
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqy1aba6i6.fsf@gitster.g>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl> <ZYQl_G-S4vQibHWn@framework> <Zad1S3vCuv4KYIzx@tanuki> <ZfwY_h70OeuRT7mk@tanuki> <xmqqy1aba6i6.fsf@gitster.g>
Message-ID: <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey all,

On March 21, 2024 5:34:25=E2=80=AFp=2Em=2E GMT+01:00, Junio C Hamano <gits=
ter@pobox=2Ecom> wrote:
>Patrick Steinhardt <ps@pks=2Eim> writes:
>
>>> Circling back on this topic: https://gitlab=2Ecom/git is unfortunately
>>> taken, so it's out of question=2E I'd say the most pragmatic thing to =
do
>>> would thus be to retain the already-existing location of the official
>>> mirror at GitLab=2E
>
>https://gitlab=2Ecom/git/ sems to give us 404, though=2E
>

That seems tot indicatie this is a user, not a group (gitlab is more advan=
ced then github), but I could be wrong=2E In both cases the user has set th=
is to private=2E

My guess is, someone set this up as a bot-user or something the like=2E Ma=
ybebgitlab could check activity (internally and confidentially) and see if =
the user would want to talk=2E But I admit is a bit hostile=2E Other we hav=
e no way of reaching out=2E


As for my mirror, I started my mail with I'd me more then happy to transfe=
r ownership=2E The name I post cked as a reference to git-scm=2Eorg, and ne=
ver intended to keep it for myself=2E As I initially wrote, I was just slow=
 and lazy to sort thongs out ;)

I will transfer and relinquish any and all control of the group once I kno=
w to whom=2E

Olliver

>> I still have not been able to reach =C3=86var until now=2E Unless someb=
ody else
>> has a way to contact him directly we at GitLab are wondering how to
>> continue=2E
>
>Git @ SFC has heard from avarab@gmail=2Ecom on Nov 29, 2023 but I do
>not recall any more recent communications X-<=2E
>
>> It would certainly be great to set up ownership of whatever solution we
>> arrive at such that it's more distributed across the community so that
>> we don't have a single point of failure in the future=2E Also, I don't
>> want us at GitLab to be the sole owners of the mirror, so I have been
>> wondering how the other mirrors are set up and whom we should add to an=
y
>> such mirror=2E
>
>Distribution, yes=2E  I do not think we mind if the set of volunteer
>owners end up to be all GitLab folks, but aiming for diversity is
>good=2E
>
>> In any case, once things are arranged I will collaborate with our
>> support folks to get free CI minutes for the new mirror=2E
>
>Wonderful=2E
>
>Thanks=2E
