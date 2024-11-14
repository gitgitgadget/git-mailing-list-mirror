Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971D2E64A
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607012; cv=none; b=UkdocFZClxvNP1SXEergvDs8uDoND9wAUXo43fGn5qLVZpiUvab0YhIMT+XXd/hv84tD6nmc+TuKyyUJGB1/IE/4Y0d1jr3ZPE6v9UvSS/lq2cZOhhkBMnm6ZJHGacceO1UYcrA5qTqTy8dx7m+g0VGV29OE8EN7W2dstH6wTTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607012; c=relaxed/simple;
	bh=n9XnwqNqoUR3ZgSGChj4+a34PKPcdOVIw9BRkuwZrPA=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sfie2BeazbhlfSx62yOEHzsRNJma64V3CK/Rjml8DqBJy7KO+4x3CbE46pIeAaz+f3n5s6vVqgG3Z85cOSmAEuQ/k51zcH85Y5uGJfSqww+x0MCAzFF0aSGAkN7N4mMZF7Vcj7pYEEZ91/vhyCweTWqNWl0cagWr7G9gB20IPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lsd03uAf; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lsd03uAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=sr5d6e3335di3awz522xnq5vxm.protonmail; t=1731607008; x=1731866208;
	bh=n9XnwqNqoUR3ZgSGChj4+a34PKPcdOVIw9BRkuwZrPA=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lsd03uAftPn0Z7jyPXVpRwbvEiD+2Q0Bwr2YqSKCgKc1IbYXxHknrM8tr4ln1yRqQ
	 NBE5vZ6+azyuDwlmWnK8IXbCRyLy9mRRmlrHG3/kl/pQxW8ZgymoIK3YcGbUjpPA4F
	 3ydnhdSn2Q62kJ+MNrq34Zp719u3nXSGglJ5UjyAKFx92QcRt6WNWbrvSYaFXuoeeY
	 +Hw2XT2D7rYnEM28xAzOAu9ObHaqikrgqWmq6wigxveROKKduSuTOMbECNX2W/g8gJ
	 I7TPbkvWJk5AvE8jYEy4oXTp9fiF3qV/QYCw1Wl4o/1e/HPgjYFqRXHNae4P/59Clo
	 598xQhIeX1Z+g==
Date: Thu, 14 Nov 2024 17:56:43 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: Fw: [bug] user may be cornered into delete files #9901
Message-ID: <ZJaaSrglj_jUGE-7IfLWHaUIKKLGlw1SJfPP8MeyvdVKO7iMFhbTQaBKeJVLePFGkw3Dvo1co7B6MBKkTN7v5J6hRqjb8yHiB6_-4H8PnAs=@proton.me>
In-Reply-To: <P_ttzPnNTtUgpAy8cg_ntLvwskJhz7cmv-fFgDw0K4Y2vOCx8v_AXxHtHEuBtpREOQu9pxpvK6JgLusc5Uyn2wDZ4HZvC3ttM4k-Ry6jBs8=@proton.me>
References: <P_ttzPnNTtUgpAy8cg_ntLvwskJhz7cmv-fFgDw0K4Y2vOCx8v_AXxHtHEuBtpREOQu9pxpvK6JgLusc5Uyn2wDZ4HZvC3ttM4k-Ry6jBs8=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 0cbedbd518f2bbfb5c32982bb15e4f1a9e5f0853
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_dNYiqljVDHzog4m0F3ZhuOAij86kq3QBZJoTu5fGu80"

--b1=_dNYiqljVDHzog4m0F3ZhuOAij86kq3QBZJoTu5fGu80
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





from A_bughunter@proton.me

Sent with Proton Mail secure email.

------- Forwarded Message -------
From: A bughunter <A_bughunter@proton.me>
Date: On Thursday, November 14th, 2024 at 17:53
Subject: [bug] user may be cornered into delete files #9901
To: git@vger.kernel.org <git@vger.kernel.org>


> [bug] user may be cornered into delete files #9901 pls see https://github=
.com/cli/cli/issues/9901 and look into all of the links.
>=20
>=20
>=20
> from A_bughunter@proton.me
>=20
> Sent with Proton Mail secure email.
--b1=_dNYiqljVDHzog4m0F3ZhuOAij86kq3QBZJoTu5fGu80
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_dNYiqljVDHzog4m0F3ZhuOAij86kq3QBZJoTu5fGu80--

