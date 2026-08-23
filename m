Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A91258CE7
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787491190; cv=none; b=XUxj7WtAU0SVEHETjQkko/Y10Zjv9rCbKUcQdCKiDgYGuYp5Ssjwr07l0YmRAnn5r7FwXui28hgTmd8qdaCMeLGT3MvvZLWy21QagRIh8Y/h4u+GtfdNHKWgbJPE9tYKbeOWOyirHfv/xBK2UKW6opk4+19Ep0ShZIDcK3+TqxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787491190; c=relaxed/simple;
	bh=1HzEvCvbPhuNBz0e/ibOC6ZlTqtk5GJ0j78Lxiv4Na8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM7uED8e4yl9blbAXwOei8Z27jrYr6x3GZh8bsxo70KmmvGnSGsjGzkZwkGEKSVUuukBeghPOUuIf6/w2wODN+SM1k8z/AClK8wvZiUbJ8sxA2d+LQx3tUYBlBHldhpyJUH8A15dMWdzMQ/dJgDcWNf86N10J5/RZ/LLrJB+fcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=jKf2hQvn; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="jKf2hQvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787491186; x=1788095986;
	i=oswald.buddenhagen@gmx.de;
	bh=1HzEvCvbPhuNBz0e/ibOC6ZlTqtk5GJ0j78Lxiv4Na8=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jKf2hQvnS8GruFWVtt1Pz+j4uwQpPhmM8Y3yhTCqtwyDyBxVJfhcKkZ6GRYdsqXa
	 o+UAVwZgMx/gF6zJM5zqPo1/yLsUiHGnnrmxqbLjaXhLABGw8xH6HEyTSygpWfe9O
	 FaJtlCboRy1+kw1xRFRGzXJnjTOojLTnyGZ3WAHxtMuz/cy2o39s5ahQpPKFaChVg
	 pHdzxQmxtmco+nFkESWzXL0X+fvcgyaM3bVJtlKf6oPyPxCprXk1LVwFfaEjfH+Bq
	 t9FnMQaskxHqbh9q2cSPQYSeimVsNVDPmhMHGJHTgqdgr0JNzRLCrytV9X1GNDlGW
	 DwDuBwOjOw4kb5inxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1wRoQn0aXH-00e5QX for
 <git@vger.kernel.org>; Sun, 23 Aug 2026 15:19:46 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wy86z-BEC-00
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 15:19:45 +0200
Date: Sun, 23 Aug 2026 15:19:45 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Subject: Re: [GSoC Patch 0/2] add unicode support to git repo structure
Message-ID: <aorzcZVdCK27pdjG@ugly.lan>
References: <20260821135410.429698-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqse47pfyy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqse47pfyy.fsf@gitster.g>
X-Provags-ID: V03:K1:3x9J2bIGREHooS2gBJp8PVIbEZ+/bCGEMN0qnbQ5R4kZE4b6tfm
 ENp/rMKaE0n7YmeG3R3DefP6sAf//JBtIvBrG/PXWWl+JMhqo8TVieW88t6b+1z3z/lp71j
 GmkiJWic5rUKNqcHSkUwpd0mPXLyJ1gTphxEXnbqr/HTqpLNDsEc+v1SYQtLgEjKr6od280
 5SAVn+AGG0KFtqHpgNTzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bjaCe3YgOWE=;uqTu9owa0dBYnYKVJACM2LHvgxA
 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
 R0gQIoOdOQwfARROLm0tFwGXxvm1A=

On Fri, Aug 21, 2026 at 09:59:17AM -0700, Junio C Hamano wrote:
>K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
>> Currently, `git repo structure` always renders its table output using p=
lain
>> ASCII characters (`|`, `-`, `*`), regardless of the user's locale. This
>> series introduces Unicode box-drawing characters (`=E2=94=82`, `=E2=94=
=9C`, `=E2=94=80`, `=E2=94=BC`, `=E2=94=A4`)
>> and bullet points (`=E2=80=A2`) when a UTF-8 locale is detected, provid=
ing a cleaner
>> and more visually distinct hierarchical output on modern terminals whil=
e
>> gracefully falling back to the existing ASCII formatting otherwise.
>
>Generally speaking, Unicode box-drawing characters do not work as
>ASCII art components as well as they should, because terminals often
>do not agree on how wide they should be rendered.
>
i can instantly think of two popular applications i'm using every day=20
which use box drawing chars: mutt (thread and attachment tree displays)=20
and midnight commander (panel/dialog frames). if "often" above were=20
accurate, these projects would be getting a lot of complaints about=20
that, which they don't.

if compatibility with broken terminals/fonts is considered important, an=
=20
option can be introduced to opt out from the modern experience.

(any takers for giving `git log --graph` the same treatment?)
