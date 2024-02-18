Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD471DFF3
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708298656; cv=pass; b=jko6NuI5DIMxycRtGdMBbfXNAJTksLcE+RlR9A7a0p8me7pTXZMmV5bD4fR2DuTPhgqdbzE5cwNUjBjkfar7MkdfayUq+7TKtj3ejuVeBxxuYCWnDJUEfpd9emYkTwb0B08B1ytX9kltowjF5VeCP61hguFGYN/9pMVSB/msjvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708298656; c=relaxed/simple;
	bh=ZM4eDc+woePQnfM013xuyPJPR/9IOmCGgNGSSd7CTL8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jmAzO9Lwj0RYBv9Fha/08OQVOkcHcfAnqsNNYPneZm4x3pCvdk8GQSFOJMqsFApAzMEFTwbo1uT2m01D2g7f5e8Eop/LFKhX5Xso6VuP4l7lbmB89oWdJNULqb2nt2SrYAEvosnbsAmwydPCzBDM4pIxX3S+Y77W02dFg8JwqFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boanderson.me; spf=pass smtp.mailfrom=boanderson.me; dkim=pass (1024-bit key) header.d=boanderson.me header.i=mail@boanderson.me header.b=KVjZiMah; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boanderson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boanderson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=boanderson.me header.i=mail@boanderson.me header.b="KVjZiMah"
ARC-Seal: i=1; a=rsa-sha256; t=1708298652; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TWQja6eBe6+0QmmAdAbkzY/EGq1y9AyMnDXok11YS3r+yFRdV0/jF8WLtJZcyyTYc0SPJVSVa8oAYzScLoT+mt6Q0WoFWQRlL62ZdAyEFyvVBonoDRvy58c7dNtH34rCoHDpFQm11fzzi7gGoI/LLmHOJjPUn9pYpGKWxoRP7I8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708298652; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZM4eDc+woePQnfM013xuyPJPR/9IOmCGgNGSSd7CTL8=; 
	b=XxjBLIOwFluJ+oLmIJM04AIBryWORz8OQFyZv1g5Y2AX/9jH10HQeU+VC15QA7gu6rJUau5acStIorg71xk4jvp5BtY80ZfaY8nOMnXzfsRg9H0oEq2I4EqCe/ViJN8Iur2bBXh1GjiOTodFAr2tHIZdwCENSFtSwJgm4DT8+J4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=boanderson.me;
	spf=pass  smtp.mailfrom=mail@boanderson.me;
	dmarc=pass header.from=<mail@boanderson.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708298652;
	s=zoho; d=boanderson.me; i=mail@boanderson.me;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ZM4eDc+woePQnfM013xuyPJPR/9IOmCGgNGSSd7CTL8=;
	b=KVjZiMah8ZwnNN10DtqAu43n6kWioN4n02bB3W0LWxYRy7iy7BTexYSoS3pEVieC
	8PB7+u6P7bSKzU0vcw75BKxw42mDVo2mrtP70h0eKHkCBZZEJW1iZl2SLjUsejBWbFU
	MbHDBN3bx/tU7cRSgiC5c7pD2PsIjrL80Z3bBHto=
Received: from smtpclient.apple (w-65.cust-u5093.ip.static.uno.uk.net [212.105.168.65]) by mx.zohomail.com
	with SMTPS id 1708298650653108.12754326046775; Sun, 18 Feb 2024 15:24:10 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 0/4] osxkeychain: bring in line with other credential
 helpers
From: Bo Anderson <mail@boanderson.me>
In-Reply-To: <20240218204044.11365-1-mirth.hickford@gmail.com>
Date: Sun, 18 Feb 2024 23:23:58 +0000
Cc: Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CFC1A507-A9EF-4330-8C98-34C2B73BC036@boanderson.me>
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
 <20240218204044.11365-1-mirth.hickford@gmail.com>
To: M Hickford <mirth.hickford@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)
X-ZohoMailClient: External

> On 18 Feb 2024, at 20:40, M Hickford <mirth.hickford@gmail.com> wrote:
>=20
>> git-credential-osxkeychain has largely fallen behind other external
>> credential helpers in the features it supports, and hasn't received =
any
>> functional changes since 2013. As it stood, osxkeychain failed seven =
tests
>> in the external credential helper test suite:
>>=20
>> not ok 8 - helper (osxkeychain) overwrites on store
>> not ok 9 - helper (osxkeychain) can forget host
>> not ok 11 - helper (osxkeychain) does not erase a password distinct =
from input
>> not ok 15 - helper (osxkeychain) erases all matching credentials
>> not ok 18 - helper (osxkeychain) gets password_expiry_utc
>> not ok 19 - helper (osxkeychain) overwrites when password_expiry_utc =
changes
>> not ok 21 - helper (osxkeychain) gets oauth_refresh_token
>>=20
>> After this set of patches, osxkeychain passes all tests in the =
external
> credential helper test suite.
>=20
> Great work!
>=20
> Could these tests run as part of macOS CI?

Do we do so for any of the other external credential helpers?

It definitely makes sense in principle. Though the concern perhaps will =
be that any new features added to the credential helpers and thus its =
test suite would need adding to each credential helper simultaneously to =
avoid failing CI. Ideally we would do exactly that, though that requires =
knowledge on each of the keystore APIs used in each of the credential =
helpers.=
