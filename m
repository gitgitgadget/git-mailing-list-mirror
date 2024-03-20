Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68372747F
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924728; cv=none; b=oACuEdo+3feWOZhOxNWVBDsJ16QPfVQHnUq8rv7KPmZpa31Ia6bxO+KMw/paOBgGC5RqDH033aWtM8kK9o4wEWo/WFFgOs80TXYmI3A0j7Kh30a0c/r1Kld+RCjAkilPutT2FY2R7vdoKNSyBELWZ1veXAYdyZgF+zOHFQSiSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924728; c=relaxed/simple;
	bh=UCWWQ5z0jA1/kKCNOSsE6js0Gn/XgzbvRqyW7WtLH1o=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=K8hQL5kGr2kzQKLDAKBRsvSwE4oh+3LoJE0QOB7LGNy/srBYcRXopftt16I0UZqWKIi80PXFOB6nhLzkOstnaMfE7Y6pAycomWBgSh5CXOJc+d0OAFUWHqcgKJhjD9JD0r8NgKA8UUAnPdLFGTXhO70QNxzFCxM+NpDEZcDkyGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=H7KZQ3Jb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GHhP7j/g; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="H7KZQ3Jb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GHhP7j/g"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 5140132000D7;
	Wed, 20 Mar 2024 04:52:05 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 20 Mar 2024 04:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1710924724; x=
	1711011124; bh=xQv262JeM0JllPwybi+0dKfJI/y5FhnSYVVASOGmy0c=; b=H
	7KZQ3JbJ8G2UQhoK26daLpP2TsSbi8hGwW96N2sJsUdKa202WdXY0GdLV0iiNeJB
	YxPWySeoNbnRDxMp6xFN10VV4HYJAPe5ltCHqGJSjiVnyVGr5qyN3YRq2R7A3hiT
	KOEx+kfsKZtuBXGhTf1ZUbqzM+FxVUYIWWP1HhOeqeLvHFlUWhbXLNfEnUSERJwY
	sJpo0mjKM2p6Es9jRY9VcvMp7WrCg0ELYR2611ldRj63LwbYlcffVGXwc0OuQQms
	C90znnOtZS7Ha+5juqqP6rH8VAcRPtd3/8AXoyTsBwfrnR5UnMXmSelR6K2dV6Vz
	At06UpHOMIBJ/l8FYJpCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710924724; x=1711011124; bh=xQv262JeM0JllPwybi+0dKfJI/y5
	FhnSYVVASOGmy0c=; b=GHhP7j/gVwQWWZmXDITR7oK+Y4BwpS6xlXT2SpNMujni
	+lzeFVwRgSG62H5x3nGiNx1owGMhvPzRh6QVXtf4zeHsRRzoBvaqfUX2qQ6DIuXD
	MtrAWSXwT+1UZibOzQESS1Q0IcM5wF6b0DKqAu0O23Xc3acO8GGKxHJteh8bZ48/
	kRfB7LfEGtYP5SiDUoX7kor3T3OjfViGAejmnc09oKyjjLTJJmH7IbSjbqyZqLEa
	pdx+RpDpVmf/vjsybsSFAbg9S0jVdcxcSdnRt5am+lG3O6WhNsYbpvFlnmdgQoIs
	B0YBfDlNL2q/buv6ir0is+pwtQrNPEAPfgAbOxtNZw==
X-ME-Sender: <xms:tKP6ZXldmXkOEHswmUdy7TetXWiA9KiV9KudDL0k14HeBBJE-OLY7WQ>
    <xme:tKP6Za2eyfG0Qq-8nAEAsPksKf2_yikUupEdkltXn-KefG6wCYR8Qf9mvj-KWaaQS
    rqwhdWiI_JdqI7MCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleefgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpefofg
    ggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgv
    rhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqe
    enucggtffrrghtthgvrhhnpeeitdejlefgueeggeeileekleektdeufedvteekhfffgedv
    ieethfejhfekjedtgfenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:tKP6ZdpVRFxtIRwWVb0qO-TtXIh_b62QiPDGwm2RKsmnzn3wMKPP1w>
    <xmx:tKP6ZfnVFSQPxfCqrwSnnOCQUc5JdPWp1oyCImRIPEkUzznRLvmfmg>
    <xmx:tKP6ZV2VWWf7ANFD6mZWPjrDuFPh4Ha6nNtoM7fYn-MF8DRjVSeRaA>
    <xmx:tKP6ZevC-FULX32PUSSK-NeuI5Uek8ClePNXeyFqiZha0M2x8WczYg>
    <xmx:tKP6ZTARjQwooU_VHtKwT82spcAP2HOx4D8EUUK6TH1OVb0noL-m3Q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 444B415A0092; Wed, 20 Mar 2024 04:52:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <911b6647-301b-45a3-9f10-f91ed7482eb7@app.fastmail.com>
In-Reply-To: <6f4d8a42-341b-40e0-97f4-157d053c0ff2@app.fastmail.com>
References: <65fa8d7a469967.62182104.7cc8fd91@m1.mail.sina.com.cn>
 <6f4d8a42-341b-40e0-97f4-157d053c0ff2@app.fastmail.com>
Date: Wed, 20 Mar 2024 09:51:43 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org, jjb8256 <jjb8256@sina.com>
Subject: Re: git push error
Content-Type: text/plain

On Wed, Mar 20, 2024, at 09:45, Kristoffer Haugsbakk wrote:
> On Wed, Mar 20, 2024, at 08:17, jjb8256@sina.com wrote:
>> [snip]
>> https://gitlab.com/gitlab-org/gitaly/issues/1226
>> [snip]
>
> The pre-receive hook on the server failed. That means that whatever you
> pushed is wrong according to that script.
>
> See `man githooks`.
>
> --
> Kristoffer

You should also look at the the message that the remote sent:

    remote: The gitlab-shell hooks have been migrated to Gitaly, see
    https://gitlab.com/gitlab-org/gitaly/issues/1226
