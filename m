Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF621DF96B
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397176; cv=none; b=i5qpmjhwcw814CVO0hI95WgvEbay7N62XwIPOjAb5t96Pk+R2qOS5EHcn9s6rtMfOV4AoW5wxxVvknjszIaCpSBxLbWpSLloF0bgRcS5ZkenfJsEnuwZlLag7wlkn0Y/cRdeK664I8l+X+juOg++aZVQltW5Ye5gNi03025twIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397176; c=relaxed/simple;
	bh=Z3iHkWhCyI9EWPAMMAgldwZIyzQq9sWXs1TyMfL5hhE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ags8SXk7PyB+LwwaIOmDWh1onfG8oOjE+Rmo2EMCzCsWBlyVuc9xs2fBAp7Ms1/gVSJeVXIBFQJCKkihI7nXesQpDOKFQn6j28j9ungnuQMo/bv12SfqaPGtj73tua4gmOEvys4goqsVn1A3nQUjAyio5kK/hbEwF9cSy9h/boo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=WMCkU+AP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i+uJorE+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="WMCkU+AP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i+uJorE+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C00C114018C;
	Tue,  8 Oct 2024 10:19:32 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 08 Oct 2024 10:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728397172; x=1728483572; bh=tTiFwsImHgJmj+T3DbDcXCEJTSyRY4EV
	rzLJXe2+ZK0=; b=WMCkU+APzHyi/1Stj2l5LyfmP91UlCgqr2y5Ul880YzaAqG5
	khmYV7oc+wDujvH1wAf1sgt52kvzaMts11iS6andKjFxOjm6AGlop71dhYyuNtOZ
	pcitv7n8322HY/wi3n5wSX+1BQYtd9/qQYd+UBTLktZslRKJ6Dmrf3J7hrwvSNkM
	FqiET651HAw12E7dMutj/SR/eDqsIjxPLx8wrV2mr5DNtaBqTPxxEzFyObao19aR
	FWE2lIz1xYnlBsLmt9SlryouhvJKMEpyKRvh52MhkiwlfR1YrZhc1BJWRh9UfhtZ
	KKVOp8B0f241e0EeM42x7n36EH73EOSJQTZZEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728397172; x=
	1728483572; bh=tTiFwsImHgJmj+T3DbDcXCEJTSyRY4EVrzLJXe2+ZK0=; b=i
	+uJorE+t9PteFW/4tecMYhCFKjGcf9UTgaG9biQpnBTFbAvXyYgaOJ7b10O0ypnE
	TAPVP69eeeN9fSz3Kwv7yfZsNs09ApIUZFbji44k7N3jbHx476P8vNBw/ICSzMYM
	Js1TSDOhJdXL3f5W4ZvD7xs/MNKa/Hq0V7i5Sc15vmhmiwOQI3jgQ/zSlr8OxSn+
	SZV+TgjyfafX+0WCD9XMnACFwt1D43mxcr3RiOxAsqNB0z2yIsAqAN6RwCZInC4s
	widfWhBhYVf3DkU1Uh9t4xTWtp3JeD14qaQrUNvH0aQ4EY5N9+fld/S7wCM815VT
	jThDTbDf85HoJmFMByVIg==
X-ME-Sender: <xms:dD8FZx3qKvF13lt0E_2ntAWHDIsYgXXCHryufwF7AY1sBNkv1Ud1uJQ>
    <xme:dD8FZ4HYTX4x5Rd9nkBp8GTpBGK5QjNN57LmtJnfZCKqbfPxuqXuu5xj6qck-vw9u
    1fnfRlgFQz9N5lCrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenuc
    ggtffrrghtthgvrhhnpefggfeuteekjedutefffedtgfetveelledtheffhfegueduieeu
    hfekheffueefhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgs
    rghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dD8FZx5t9SMHmX_eqtYjpb7cOB38ZRlPYz2Oc9ddqTrRZ_ume9HNbQ>
    <xmx:dD8FZ-3VE7DraBfcOVd9qK4OkWRk4NUh8w7O9BTZfxUZb_ErB-mNPQ>
    <xmx:dD8FZ0HIZMOWNfwk_j-y2RTMKevTPsFCL_3mH0em7pp6amGZk7f1Dg>
    <xmx:dD8FZ_9Fpjgnf6S9FrU5sF8bVeUB6MP3ZnBXEZMfkAbDvtEtOpb2pw>
    <xmx:dD8FZ4DMa_c19y_qiBt_QpWY6QfOjzylmERLszKXVvBF9ohsSAbAeKM->
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 23612780068; Tue,  8 Oct 2024 10:19:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 16:19:10 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <3af78a3c-afb9-4ce7-aea0-a5bbddd4f34a@app.fastmail.com>
In-Reply-To: <ZwUxdz_HobRGF9yq@ArchLinux>
References: <cover.1728331771.git.code@khaugsbakk.name>
 <ZwUxdz_HobRGF9yq@ArchLinux>
Subject: Re: [PATCH 0/3] object-name: don't allow @ as a branch name
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024, at 15:19, shejialuo wrote:
> On Mon, Oct 07, 2024 at 10:15:16PM +0200, Kristoffer Haugsbakk wrote:
>
> [snip]
>
>>   =C2=A72 Disallow `HEAD` as a branch name
>>=20
>> This was done later in 2017:
>>=20
>> https://lore.kernel.org/git/20171114114259.8937-1-kaartic.sivaraam@gm=
ail.com/
>>=20
>>   =C2=A72 `refs/heads/@` is apparently disallowed by git-refs(1)
>>=20
>> See `t/t1508-at-combinations.sh`:
>>=20
>> ```
>> error: refs/heads/@: badRefName: invalid refname format
>> ```
>>=20
>
> It's true that using "git refs verify" will report "refs/heads/@" is a
> bad refname.
>
> From the man page of the "git-check-ref-format(1)", it is clear that
>
>     9. They cannot be the single character @.
>
> Because I am interesting in this patch which is highly relevant with my
> recent work, so I try somethings here and find some interesting results
> as below shows.
>
>     $ git check-ref-format refs/heads/@
>     $ echo $? # will be 0
>     # git check-ref-format --allow-onelevel @
>     # echo $? # will be 1
>
> The reason why "git refs verify" will report this error is that in the
> code implementation, I have to iterate every file in the filesystem. So
> it's convenient for me to do the following:
>
>     if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
>         ret =3D fsck_report(...);
>     }
>
> Because I specify "REFNAME_ALLOW_ONELEVEL" here, so it will follow the
> "git check-ref-format --allow-onelevel" command thus reporting an error
> to the user.
>
> I am curious why "git check-ref-format refs/heads/@" will succeed, so I
> try to use "git symbolic-ref" and "git update-ref" to verify to test t=
he
> behavior.
>
>     $ git symbolic-ref refs/heads/@ refs/heads/master
>     error: cannot lock ref 'refs/heads/@': unable to resolve reference=20
> 'refs/heads/@': reference broken
>     $ git update-ref refs/heads/@ refs/heads/master
>     fatal: update_ref failed for ref 'refs/heads/@': cannot lock ref=20
> 'refs/heads/@': unable to resolve reference 'refs/heads/@': reference=20
> broken
>
> So, we are not consistent here. I guess the reason why "git
> check-ref-format refs/heads/@" will succeed is that we allow user crea=
te
> this kind of branch.
>
> If we decide to not allow user to create such refs. We should also
> change the behavior of the "check_refname_format" function. (I am not
> familiar with the internal implementation, this is my guess)
>
> Thanks,
> Jialuo

Thanks for the careful analysis.
