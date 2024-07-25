Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6BB19CD05
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922770; cv=none; b=e6j4JyUJMItT/iQnvBdKvJF96Fw/PQBQHrEYRc/GayY9229qRE9K2AE1G/U06LXCzk5UxMWz1msroyUPFwh/tJqmS+683f9tpRjo1kSD2syUE8IjPK2fxH17Fsd9JfdVWXrTc1DuqL6tYX89n/tmSeMBsvnjQQ63YgOELVCf7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922770; c=relaxed/simple;
	bh=ge1rh001IngKaBgkWk6iSJR6CH6rWnr6G+qmWeopkis=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=LPT7Hgt/Ua4fE4UJ45iflsbRQa2fV8zxF7bIM7NmnLz8nDyCCQFwaQZDB0afyU41vqzlWPXNWLvAh/MOs51kJ3JTF7XuFYYt5lb9aq9ce1Tlcd8XW0URWBIDhFsSKyhmzqR0NRdQdqc6R9JF+H2PnNPMqOtmZJyvC1Pr/WxHhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=R1M6kyAE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMQwSqKl; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="R1M6kyAE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMQwSqKl"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5CC15138010E;
	Thu, 25 Jul 2024 11:52:46 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute4.internal (MEProxy); Thu, 25 Jul 2024 11:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1721922766; x=1722009166; bh=B2RtK3toNi1jE98ngtsiwt5Kc8hrrAnx
	fLYLw5GuLUQ=; b=R1M6kyAEvyb0S+nRzEUMweMKdyQ22vm4uaV+sWZ5rEkHyT9d
	yfaBL3rAQHQ+iyLZKKpOD3aiBD+7ax05LPvML/O+nj22Ytg2DZO3+EhwXm7Mpl8U
	CGh5LlUhsHL7mKhhj7BMXNWfrl6W7UsHpJT3/b0U5pqEu1W3s80na4J6cmkM8oBb
	l4G0s4vkG5kA4+hXlayH2REzM363BgJLgQ7n3EUq9REHUnPVqSXe0j51GkhdZpwf
	+6V1iVN8rX4+cmy/Euyq7Vy6mLAuf53b7CmI5l4NxTt0o2SdiH5hY+RJm8nAJGPX
	+C4/ZvwtkzbSSMtP16rDosaE5BxF2aMax/vmGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721922766; x=
	1722009166; bh=B2RtK3toNi1jE98ngtsiwt5Kc8hrrAnxfLYLw5GuLUQ=; b=J
	MQwSqKlI9kvyZnM+R8TGcWfbhfUDGSnH+VeMAGpZ24PjRiPRcb4uQjkl2VtTeAHh
	Yfg9wXUmmeNMjgvyoZmq3MiTUi6ll9QCRvxxcEUJ12DTl6QLdigvxL9FC3FHI6Fu
	5sMV/mQRk9mXSJ0VeO7p3d9qCDtzBmKkeMaF6c/kZ0BrIDMcGgVyEFuXCU8Se1AJ
	2/iJhUCWMVhKh7C4cUKh5BK8A/BaHIq9BlYq0JE9TTbAg7twqN7A0Yr4fcdBSLus
	quILf8748QhYKGv0iVEbl5BgT5jIqTrvrYxgMXjAzE50ndcPPTFsNhcUAircAoSo
	BfKjsfm+bbpbHYgsISgxg==
X-ME-Sender: <xms:znSiZuTQmMgt6B-pZu0M0EZHksTbT5ply6OOp4oC1vLa3pD788gTxf8>
    <xme:znSiZjzl40Yr3lI2-LUW37-Q8PpjVylHrnXM37LNNQaoP05N8Y7mIhIIVLKPDM0Jv
    hX6Cz8ibel6bzOVgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhn
    sggprhgtphhtthhopedt
X-ME-Proxy: <xmx:znSiZr3arEHwThainWX_nMV514EorQ2wDk9bN9LKx-OkUcyxnUzieA>
    <xmx:znSiZqBcPhSGQC_p48IPTHIq5cYLzpEy-_iVwd61p4cLGXMcInPllQ>
    <xmx:znSiZnj0iAXLn6tg0hMgLXeYFc7kqzgsewcziymcxUHBPVSn_AfCuQ>
    <xmx:znSiZmqDelYwac1Q2TvZo7-AqhNWUNGNQGLgKOQ2Nk8B840ma5dm9A>
    <xmx:znSiZqsYoWCBmL9VqkU1yFkibB6dLbnzAkfXrH15__tQxm2vCF_jh3Fj>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 165B615A0092; Thu, 25 Jul 2024 11:52:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5fdccb84-1e60-477e-99d9-b22e3ef83f54@app.fastmail.com>
In-Reply-To: <20240725144548.3434-2-ddiss@suse.de>
References: <20240725144548.3434-1-ddiss@suse.de>
 <20240725144548.3434-2-ddiss@suse.de>
Date: Thu, 25 Jul 2024 17:52:25 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "David Disseldorp" <ddiss@suse.de>
Cc: "Teng Long" <dyroneteng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] t3301-notes: check editor isn't invoked for empty notes add
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jul 25, 2024, at 16:41, David Disseldorp wrote:
> 90bc19b3ae ("notes.c: introduce '--separator=3D<paragraph-break>' opti=
on")
> changed note_data.given logic such that it's no longer set if a zero
> length file or blob object is provided.

This project uses the `git show -s --pretty=3Dreference` format:

    90bc19b3ae (notes.c: introduce '--separator=3D<paragraph-break>'
    option, 2023-05-27)

>  t/t3301-notes.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 536bd11ff4..c0dbacc161 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1557,4 +1557,9 @@ test_expect_success 'empty notes are displayed by
> git log' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'empty notes do not invoke the editor' '
> +	test_commit 18th &&
> +	GIT_EDITOR=3D"false" git notes add -C "$empty_blob" --allow-empty
> +'
> +
>  test_done
> --
> 2.43.0

This test fails, obviously. Maybe you can reorder the patches so that
both two patches pass the test suite?

Introducing a regression test in one patch and then fixing the bug (and
making the test pass) in the next patch is a style that some prefer. But
I have received feedback before that it=E2=80=99s best to avoid that.

--=20
Kristoffer Haugsbakk

