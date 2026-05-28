Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE3325483
	for <git@vger.kernel.org>; Thu, 28 May 2026 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952123; cv=none; b=kqL6MdZIWqzh5Bk5pWCUxAuwOioeIe6MtzVM0m6oPVnnmBtkUoMykTrlyVQZ77wuvrDGn1rcGICPRKtBQA3otYlOkpW166Hw0e/1QvR724jwNqi5bNS1KLSC7taVen/tjEI1qizDXEB/KNwY8Xn4oXtSnhM7m9aAx8IZm5jy2tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952123; c=relaxed/simple;
	bh=1DlHGSnqO/yMVNaMLa75JU6rNAqPS8MRsZqLqERItdM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b2bCUU2s39je473ot5u+cUpVItyqRSc4bzyiO4cdHL0NuBLhhZroWy6iUMC0oj8TY1DiBez0leYm0PDKyg31muMp3HIk61UMsItYizsgotq/v79ecN+42ui4rezzUkzQf12VmfPXl/HQ/4D8uQCNlIwurn01BcMyVYayKhY/uZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZvMlegqp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5187YwF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZvMlegqp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5187YwF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 667A47A00CD;
	Thu, 28 May 2026 03:08:41 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 28 May 2026 03:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779952121;
	 x=1780038521; bh=rye+ED1CSUrHNmDZfwCbxG45XE9f3bcOY9+QfNC6jQ4=; b=
	ZvMlegqp6DNWVcGtZkE+PlOOfFrQ77REZJnvTjbOtKJ8SNBbu/59w8SCRdzfZbt4
	rx5K9GnZiL0ViUL+GDMx9W6lPGag1quKndDIVbeu8b+qgxeSNZsQOl9HMypRlMBb
	9nPixgwZtsrg/e6/gfgQzmosUysyWbwUKMONuhNcKsmwEoRkT89pOLKPpFBe64v0
	suYnalFjbePJWljXHbclKovlyhji7hPOp9rgJ/wQnrADzMh7IT+5j8MJ9QFTdbmF
	aQeca/6yHH/Ojmw6zxefvqndfKnPxLHk/Ld4itqsUYSW6Wn0WRSklbFc0plL+Lws
	sC5VAkxLm5JALW5NI0barA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779952121; x=
	1780038521; bh=rye+ED1CSUrHNmDZfwCbxG45XE9f3bcOY9+QfNC6jQ4=; b=e
	5187YwF8Wpo0jqExILK7mHiM0RMeq6RHIgSy8dZCGXU+0pz9JMNXIZnbq06p9AhO
	6+NvlApQgY6nDGt6wkHU3KGXAphkJ7hLEtWDBORkczUOuX3zSHb05Tj2ipkivRZZ
	E102cQ0nhIrUrAieK7lqP7p/zF4kNonuQjwHyMMz5mlDmMVkZTG201ny7pB7aYPm
	yC95WzGQ3utph8Xd1OTHSwkt3sAjlqfXKUGPHUOAybu/djEM8Ifsu0DN97AEHs2f
	2vvDpD8WM9bJyQv0G7+TfKZ2xCZ6YwWaKr5T/tBSBdSZQksaPOS0kCXGk0aENWLs
	dilimQpTa7x5jGkr0tuwQ==
X-ME-Sender: <xms:-ekXavKdDjmV9_zv7zSS1uazOJj5g8gwMth-haNAjEqdJVZSj61tOVQ>
    <xme:-ekXat9_x7-jnFDOoTRS2iQ219oQZP7GjwORjozwHofBXbQvDYlOIZLFnC3Xx1Yun
    NfSmWI5OkGigkVlIhqkzMrR7m49oBzMQJzASjO8P_ybciF7NyokFQ>
X-ME-Proxy-Cause: dmFkZTFTY8yaAvlx5Z+AyKJ0NBccgh3qpbMtLPvVRn1IQqSiz2lzdkqplknQhz0fRWjSaN
    sliQXqysYRztDmigOON3zbukXV2CMnK5zKsDbrXtq2245t55oH033QqPGngPJj9MWWptsQ
    vdEiqluPADX2TZrZswyOZm1qoERDoPvkFQ1lg3K29zKZ8aKferlf8dIMsWbTbq+KnyzAQZ
    V4ch92vcf2/NjxzDXMLqT+TukSY8b2v4Vg3BCoFJZuppj4JdULAeLxfKip9lLukfsYvdvG
    VrJ0Lb0s3QBX3PYm+xOyqrhuMduTAlqiKZ650NiHZ0vcRfJa9hiiMqzVuB4E9v8iHaP9CJ
    lHPMBz9nE3eIHKXxTjWhgOddd2kr9eit4DHL7W8Ir2bPD1eT6XKPeRiR2FgK8oVhBOrZls
    EwDQLjO66THD6yM4uPZmIhmVaN9B2xjXQXsvygHY+9ybbcCnJKTYA2KFZXMPVeY6L94g2B
    AK276ZGSaWggDtZwyataG341yVRxlEf30V2v/1EFjW6jI+LtaaLW2+3C1YoI7WRxa3foZK
    t3GQVx0VghBD9okijQtKO1FmbiF0hg4Z5vX5Ao2tza8WJid5lS69wg+0AbkSdNhqzFk8gt
    wRPfeG/UvWMicdIEBizQXqf8ZsfzJyKATALZmFE058NQVguKl30TqmHVEc/w
X-ME-Proxy: <xmx:-ekXajlIq7MlPEsfF0MVgN_cj6xVFY01-SJt00dW9FSsjjGK7ERYqA>
    <xmx:-ekXaul5J05kZmc1nWpCIrUuZ7894pl4EeSAwX3Jn5vvQ3gP6oD4xQ>
    <xmx:-ekXasu5g5kGi0lHamPqO9X-HXHPEAdlXQYwiKHTMXElp6gutWFxew>
    <xmx:-ekXapn-txHRMtUt7hNMCffdgX56Ex_A8_B52u1dohhvYh9dZZ6GYw>
    <xmx:-ekXaiHFGbzPboL56aAWrkGo-WEDiGmtIvMqztMY6uRK-xqoOMbKd5UQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 25DBD3020073; Thu, 28 May 2026 03:08:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAjFm3OFsM6V
Date: Thu, 28 May 2026 09:08:20 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Koji Nakamaru" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Son Luong Ngoc" <sluongng@gmail.com>
Message-Id: <ec2be3bc-caea-4295-829c-db5fd9e121d7@app.fastmail.com>
In-Reply-To: 
 <0ab0a717441e9fc7c494da194065a948a35a7f01.1779946921.git.gitgitgadget@gmail.com>
References: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
 <0ab0a717441e9fc7c494da194065a948a35a7f01.1779946921.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 2/2] rebase: skip branch symref aliases
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026, at 07:42, Son Luong Ngoc via GitGitGadget wrote:
>[snip]
> -test_expect_failure '--update-refs skips branch symrefs to current br=
anch' '
> +test_expect_success '--update-refs skips branch symrefs to current br=
anch' '
>  	test_when_finished "
>  		test_might_fail git rebase --abort &&
>  		git checkout primary &&

This style of fixing a bug by:

=E2=80=A2 Add failing test `test_expect_failure` in the first commit
=E2=80=A2 Fix the bug in the next commit and flip to `test_expect_succes=
s`

Is legitimate and makes it easier to verify that the test really
exercises the regression. But in this project it is preferred to
just do the bug fix + regression test in one patch.

See https://lore.kernel.org/git/xmqqfrdk3aqy.fsf@gitster.g/

> --
> gitgitgadget
