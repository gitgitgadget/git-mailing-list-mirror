Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0995381B8
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779539; cv=none; b=tncRooNBJD4qfQ510Kd64MyWyyyyVXDA+kqUqY+K0MozTT6aa6BCX8pudenVQqSvLIT8llEZN9kSA/Pygm8ObO5W5F+iyZgbMnqcg9wOZHigKk6wZPrpCqdsLVRDiWhFPIOIrwjv4Zj1eUr+jr6JW1ewaLmnxpPxPeAnUVtpJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779539; c=relaxed/simple;
	bh=Ug1wb5JqGv2Bm41oSzgj9UCfzOLYCYHmJbR66QLDm2g=;
	h=MIME-version:Content-type:Date:Message-id:Cc:To:From:Subject:
	 References:In-reply-to; b=CFFrL03aEu5q4PZ+ry3DGKwozZkytdR9KD3cDjbetqkO0JBm/0sOL4g4C24YGZYD2ZvGtctjCf8lDxORUyTSNliXudQ4N8fgRVYUGKIBExzuBsv3wwXCMvFeQpsfhvGLB1tRpV5tp8s8ZEKpcYbM3CC98eKsPF3AHFkh2u6MlNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=DQg0mADK; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="DQg0mADK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=dbpg3c8ibMwl/5luSdkYthFsjv3CXe+xKSrSj6WL8Fw=;
 b=DQg0mADKG6H9HEtQgJkAULHlju7XAmOl58a6LNBeLbCDbO8nc7o/ZBuxn++FM29TbNLgc+O/kuS+
   pAeW+xJtiIzq6RN/fG/WuXjGM+uFbukLfntZq3AJ/y/9u6jykyq2eDK8j4FDR25oaywi2Fmqe+yG
   RGh5pHDIe+1IOBlFz3b1Bkk/3G+YLb8AJlJzsapXie7VytHjXvyAJdiAK0q100lfLRwevAa31n/2
   /vGbs5NqQpPJiDFZLfK1C6EBAOryRuXT4P/7TlxT73ZHQVyt70ECHLIxE9U2FNT5r1dydkhgAkSn
   fcFaiu0zrmjHUE71JW4KaCVHdI+66E+sQdxsiw==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SK2005G8VDO6230@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 19 Sep 2024 20:53:48 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 19 Sep 2024 22:53:05 +0200
Message-id: <D4AK4USDVP5T.10INJOFE2I8LE@ferdinandy.com>
Cc: <git@vger.kernel.org>, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Christian Schlack" <christian@backhub.co>,
 "Jeff King" <peff@peff.net>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v3] set-head: no update without change and better output
 for --auto
References: <20240915221055.904107-1-bence@ferdinandy.com>
 <xmqq5xqvo37s.fsf@gitster.g> <D48UGAZA205N.37QFSURUDN3ZS@ferdinandy.com>
 <xmqq34lyknqy.fsf@gitster.g>
In-reply-to: <xmqq34lyknqy.fsf@gitster.g>
Reporting-Meta:
 AAFJBnzJ6nXx21qQ3kWU/7f8WE5yPmlMW7wARfUUIvdMhLp1rvKIMbgFRioAiutY
 3WY7jhBeWgXtHFfd1poXrmSIhpbZ7bjYBNxhUJtRewfyWhwFoTiBaKKAUElL252L
 e3LFnc0ZUm71epXZ+aX3A9nkikmxO58jkw+DvrOjXkNTXK/+IqkbsRQjsLYJTcNV
 6LYw3wwdc4MSWbtcfk8guSwiGlpbXyhfLi75EOE+VfIfjc9ONT49otJUKZD/qj5R
 nnWW3GLHyKDiL2FhvbxFgClKng71GHhc0L9oNuPy+9w4SC+ZsUnTFYOGvbCgP+6J
 Z3hWPEAZSws09STj/qHs/2KBjNoV/BWMFljDDILjTwMgiA4zlk3XTiEf+ZQ6/kh3
 S0XueAIou+6XVAOBxvjeZq3rOQzZkMp8+Y67Mg3MjUpvLO1mzE2In7d2nXF26UAe
 iZz5xK6yuq6Kcw6dO/NLyK7iRdfqKvIu1IyEbvfXIJEqISnaT9ROvcY=


On Tue Sep 17, 2024 at 22:51, Junio C Hamano <gitster@pobox.com> wrote:
>
> So, as long as we can explain the behaviour to the end-user well, I
> do not care too deeply.  My impression was that avoiding it by just
> taking advantage of the atomicity afforded by create_symref() looked
> like a low hanging fruit, but that can be done by somebody who are
> curious to see how involved such a change actually is and can be
> safely left as a #leftoverbit ;-).
>
> Thanks.


Now that I've poked around a bit (cf.
https://lore.kernel.org/git/20240919121335.298856-2-bence@ferdinandy.com/T/=
#u)
that fruit does seem to hang lower :)

My idea is the following: Add a new member to the ref_update struct that
records the value of the ref _before_ the update transaction (in the
files-backend), that can then be accessed post transaction_commit in
refs_update_symref. If we want to pass this info up to the caller of
refs_update_symref then I guess the only option is to pass an extra buf whe=
re
we can write this, or if we're fine with update_symref itself doing the
printing we probably need a bool to turn this on/off.

My PoC seems to work and pass tests, although judging from previous
interactions I'm probably overlooking a couple of edge cases.=20

Does this seem reasonable?

Best,
Bence
