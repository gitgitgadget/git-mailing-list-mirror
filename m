Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C42D9797
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318878; cv=none; b=RHqZ5foFx2cinY9opXEnfjRBsHpW3R5/FlcHySVertGOvVBAKGD6XNFZqUPubwleUL4PkupBZWpAG16oIgeMHK/ZTHGRIxMPjD9dz9IbkCcaRkSjjMKvdbKVgNGwCLBF0BZS1q6QtKVJj26QeIQ7Li44tUj6JyOx8tj5cgJYqPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318878; c=relaxed/simple;
	bh=ya8+meS1sdLC2i+CszvPfPsbxVd8PC96yC16VKwODRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0Rrzp/oYxjEnXHovQhOaOpnTZ3s0Uz37/Ez6EszRJ5D6VIR0eWVaQp5kyXzs8r8aWYMD7T5aOI609UmElafxHirKCJWNy7HyvQJv0yXZ6u+7eVwmClFVt+ezwBz2kLMr2rg/RiMML5dCiHbex/RD+d55HFQx9VLh4iRd+pcB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=rTuyT7SD; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="rTuyT7SD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759318871; x=1759923671;
	i=oswald.buddenhagen@gmx.de;
	bh=ya8+meS1sdLC2i+CszvPfPsbxVd8PC96yC16VKwODRc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rTuyT7SD4Tl9wagzM7FXskQ3RDUe3Ex5fIA4TL3dVvvS7HV8jANm6vj8H+BLiCIY
	 HV52AGl2XNV2468t4EXac0gFsf4TCHtPM/pGNC77aOnO/S5CynJZGMxa6xys5bDiz
	 WHVxrPKcplxhq3Zqa6XkGHez4DDqUdUqsHo76LgMxTwT3ojXPDqd30diWScJyCGmS
	 0asHvs/UcRVLB7u44HdCyd6vGwopYpNJJD4U83DrAeaMIgmSdPy7nkjMV3lJ09hpJ
	 0Aod1jJHyuAnCQL13WBBRahLVWVg8URLlascJV3zEAK1YEH+RZ51AB7XM+P11jh7V
	 0GrUjjb36T9QxTCOEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.101]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1uJhLr3y8X-012raY; Wed, 01
 Oct 2025 13:41:10 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1v3vCo-jBd-00; Wed, 01 Oct 2025 13:41:10 +0200
Date: Wed, 1 Oct 2025 13:41:10 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>, git@vger.kernel.org
Subject: Re: customizing "cherry picked from commit abcd" comment
Message-ID: <aN0TVmEMXOyDZEwR@ugly.lan>
References: <87v7l18nnt.fsf@prevas.dk>
 <aNus0ulSTb4rAYdF@ugly.lan>
 <xmqq5xd054r2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq5xd054r2.fsf@gitster.g>
X-Provags-ID: V03:K1:/JMAg9q7WI4sxSAU2Tk2qv7ypTuQcSt1fBG7/+cdbitkIuXG64r
 am/sINW9FvkUZuTJmD9cyBJ3wJo/GQdLjKUbIzCfELTFznUh5O81RKbbWZhEjC038h0qZsl
 RfJaMvX7kR4WJVBcGi+2engs0JpQjHXGq4Jx3dCygj2f03W2H8KES16ie9gq9R2U2hlOl+A
 Eg7KJczhtuO7Nk5mjM3aQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RjAgrSvP8/A=;4+fUdTHgGM2l3P17XBoCC1S4mF7
 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
 Hd6MA==
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 08:39:29AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> the pseudo-trailer is really just a hack in the first place, and
>> afaict that status quo results from an ideological commitment against
>> cherry-picks during the early history of git.
>
>I do not know what "an ideological commitment" refers to in this
>context,
>
it refers to the general notion "don't cherry-pick, but merge", which=20
relegates cherry-picks to being a 2nd-class workflow.

>The intention was for the original commit to be also be public and
>in the same project (e.g., you cherry-pick a commit from the main
>branch developing towards the next great version, down to a
>maintenance branch for the previous release), [...]
>
yes, exactly. this trunk-first development model is quite common, and=20
has been strongly pushed by some big players in recent years. this makes=
=20
it really surprising that git still does not provide well-integrated=20
support for it out-of-the-box.

based on your response i conclude that you would actually welcome such a=
=20
thing very much, but the impression of a bias against cherry-picks is=20
probably not unique to myself, and if so, it likely contributed to the=20
persistence of the status quo.
