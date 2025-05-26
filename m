Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0CE1E48A
	for <git@vger.kernel.org>; Mon, 26 May 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275582; cv=none; b=pflDNLHQ8l/YHMSLWuo1MSlot6PCnSBjc962KmPWFfd1DslzhXJ5BXp1aJCbiHWYgWoWT7njUGAJsQj1ixJZK3TA2/iKJpB1woUq6rUG10vLTk5jeaP8pFLsuZoXcQnHci8iIwjFRrfDn6140fdWBYouFqcjRS0tfHl9Bm4+pQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275582; c=relaxed/simple;
	bh=E1C6Mhu2ryQdZQSj+BGfqIV/Eu0sLaoLfhQ2JOA+5lk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dLOoykiwZJH43Ae44QeoDpzoVnDxWKKV3YAHj6II7sm+eYWikP2X/vTxSs4oqVc+DS3Fru5mNAFVMthS8h/fyI2QTw2ZYheG46ERm1tmmv99P4xMARDqUmC4DAiROLZ89JyyEsCCHHVMGsRpDSYHBdqWOt/haB1WMt9SdJmKq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz9t1748275551ta48b7d36
X-QQ-Originating-IP: x1acpy7PFlWXLxnlREqcktPFxMD2CNj7ih9ehIWvjXc=
Received: from smtpclient.apple ( [202.119.45.42])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 May 2025 00:05:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11519780045529532879
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] pack-bitmap: remove checks before bitmap_free
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aDQO4Vkj7POztMnC@pks.im>
Date: Tue, 27 May 2025 00:05:39 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F8C41C7-8DCF-408A-AB81-B77B46D20FC9@smail.nju.edu.cn>
References: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
 <aDQO4Vkj7POztMnC@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MfJtHqZtrd+OfQubU352BVUDM0+vUcGjo49uQdLdBPM6CwPCdkNDhcj6
	h0Fz7CzbKnwQ696Dgdd8MuLkwFT8Nmt3QtchsByqZiM85JiWkfL9icNTtnKWyAY0KM5oiAd
	UrD2rdRfhhEgwOb4l+UnWZV4Xr1B6QV+jgSRc84TLS+VMJQvkpoDrVHI1FLq/9vOuQi8IGd
	uBT0SrzIirAUAwRBa220+CcErJ2+jEsoVDYRTm4+aX+aySev5t8IXe+xLSgr+2KUvoLbPOw
	QGreTRtzoYmQhFgDRuVnNQh6CjV0FXcjTQSh/7BWuPoXghGLKEBCvJ8BYDTf0p73Hvsb+hk
	upGV2TXm8pVBFR1bz7ikf4DZssEVLBnJovpN42VyTMouwVd7QfDWal9Ft/sUbbecmbh9ZJb
	b0hUkUYkPUq8fmmCIBz+u6COaNtNCu5QnvztEcTJuyEjCOE65HGqZE8XsTZ77T8aSoSqYYu
	8NnYY0/t0Y1mwtu5wgH2UFOdYUNHoWMstQSy6q4zTMXL7zpPRKW4bN82qRNQLS0mp7jPI0l
	KTsxp75Xt8ZwHJImVnm/IshVDSLyq0kjzdo7tz8JytvcI4A0LkdGLIHq/qQNbEwOxMNFcb2
	UEwcy2y/Wc8JHhvNBUdCT6Lffa7qz6Uf8yOai6IFldQBSqKt2q8mUscXaCC4QjULfNUaDr5
	91CB97sJOwJIxwlLj974aGjpIoj3qzxmbk4YCrFY8S+dRDYdekKjFGhnMXJssAiEn0EzHAa
	4x8okA6+/t0z4F6Q6/+jZO1elvDAtWy7b2OHGRylsEEH0pHdLVJSOZ9VJV/adA14Z8kM8E5
	ZgcDLeVMFw1LyiZxpkbnzbrTOR14XjNpKIELppEyai0wv0/OrihouSMmTin6qnhz9dZis0q
	GHtd7vmDwx7XDVXsEGJl16t93Vp4zwZaiZohhbxYohm7samMyRbE73bJLGKfWP/oT9tdSdE
	TbC0r8CbXkcJvD89Smoy1rq4dwyDYpA0fd+A=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=8826=E6=97=A5 14:49=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> This commit message isn't quite a convincing one. As author of a patch
> the onus falls on you to explain why the change is sensible, but even
> more importantly it also falls on you to explain why it is correct.
>=20
> It is of course fine to ask for help and input, but in that case you
> should probably mark the patch accordingly, for example with the RFC
> tag.

Thank you for the suggestion. Please allow me to keep the patch in its
 current form this time.=20

> We know that `roots_bitmap` is always allocated via `bitmap_new()`, so
> it won't ever be a `NULL` pointer and should in theory always be =
free'd.
> Furthermore, we know that the pointer never escapes the local scope,
> either.
>=20
> The next question would thus be: what does `cascade_pseudo_merges_1()`
> do with the bitmap? Are there situations where it does free it for us,
> or where it moves ownership of that bitmap? So let's go down the call
> chain:
>=20
>  - `cascade_pseudo_merges_1()` passes it on to
>    `cascade_pseudo_merges()`.
>=20
>  - `cascade_pseudo_merges()` passes it on to `apply_pseudo_merge()`.
>=20
> `apply_pseudo_merge()` itself then checks whether the pseudo-merge is =
a
> subset of the `roots_bitmap` and, if not, ORs the pseudo-merge into =
it.

I would put this into commit message. I also noticed that =
`find_objects()` in
pack-bitmap.c has similar code but without `if =
(cascade_pseudo_merges_1)`.

>=20
> None of these operations move around ownership or free the bitmap, so
> this looks like a true memory leak in case `cascade_pseudo_merges_1()`
> returns non-zero. Which would raise another question: when exactly =
does
> it return non-zero, and can we trigger the memory leak via a test?

Seems we need to make `bitmap_git->pseudo_merges->v[I]` contains some
objects which doesn=E2=80=99t exist in `roots`. I=E2=80=99ll try to =
figure it out in the next patch.=20

Thanks
Lidong

