Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC517588
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928189; cv=none; b=UDWJiIoI0k3T+M1ev6xd6BzDgMIjtMQ/Sz2OOflBdr+gtRXpuN9PdW/AMdQaFTNo4f6Kb5QPVNeNmGrffQZ6ziFnw5KKUuiJATE7Ebx2gqgfVURB14SaTpZyO82/ff0dXq2OqTlgAFOVWmVLUl1ruv1ZzC5ZLv7xtO0Eg4rPZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928189; c=relaxed/simple;
	bh=V2cZGIy2ajpJJSr7vZ5864OUBU4ruyIGp0unIfocnag=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=n/csim8BBQaEYB9SywTgotkXmu7Qm5YVyuuLZJmFWUQumZSgtZ92sExiJlNoqz+k4FA+UsMqNW+vVzvfcRrjLbN0INKj4h7hKZHfvp8HlzI1hRmU2yLxh7eW76kdzKLS9Geh447Z/QxSabQywG+odz9iXniyvq3iku/hBpkqMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ZVDBId7U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ecIO/VFx; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ZVDBId7U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ecIO/VFx"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1934E138016F;
	Thu, 25 Jul 2024 13:23:05 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute4.internal (MEProxy); Thu, 25 Jul 2024 13:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1721928185; x=1722014585; bh=oHtBOgawyQeLLX9svhTLizehZwnMF8NI
	vRtqoc0CdbM=; b=ZVDBId7UceQ5EIULlTqIJJLOye9VxFrDF9w54RohRds31v67
	VxoiRxSJVQ9f9QzKhfF8cmDfs7FH9fofy31U43g+dzhA48LupltOBUibEPd3WJL+
	ZIb8ZvTA7ISJQv7jHEhRVR9lVI2G6T41/T81amTrCGdaO2+jz0be5yn5dJX4eeH8
	9Djoo5pjE/itGTNVZ2kg08Y5fAGuxwKbqdLrEosigvxQQB4GKefVpvU1XI/eIYrt
	cYtQbl9TwyF/+p3HuDXWBVu+e0UY+fmcyGGLlKDNcYig2szxj9s1ZBpWRw0rjWtL
	4RCOyNBvGvqUiptkiRFrhntMltYALMo6RUfo2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721928185; x=
	1722014585; bh=oHtBOgawyQeLLX9svhTLizehZwnMF8NIvRtqoc0CdbM=; b=e
	cIO/VFx8rAQWixkm+YaqpNffiPthZB6t550gzfsO9qA2thP9kY5wF5RvaBN4e6Kn
	Gyt9O0g7NWc1ip/RfZitcgUrPhdcds60nXyM1xLk6gff1hCIIW1S1W19qRYOL/0A
	aZB4a/AwkffN624GoxGs0hmHUfGu5A0od/pbuCnyYEEzlWX9Nd9G67LkZ2Gys+X4
	4M0kh3ZaCSYaNsR3jjfQ+ShoNMvGsR/phWbMoTc5tP/rjl9JAASOAnkb8feJuOLo
	2lsaQc6pNXW70oYOlBN1mpuwdZcr2gikge7QnfQ6OxbM7S4G78/fiRerbpC+c9bQ
	7v3IxN2yTQxbN8FOnaW5A==
X-ME-Sender: <xms:-ImiZuGKTVDDlEps87LCHX6PcHpO7l_PFcy5qJnX2RxLl2m0Hcf8lQ0>
    <xme:-ImiZvVjLElZCUemdWQzLWzG1KB3ofeCzVY1_ZQyNiXDjZdKiSWPz_pfM1zJgrs-S
    i6bx253f21yj5Npiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedviedtvdetleetvdetvdeiveehgfei
    ffeujedtudfhtdeigeejheehteehfeehveenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:-ImiZoIF8ZxIp6tryGmIPWcAf1Y_S34eiPOSL0fDmIXwnIr5SuUMMw>
    <xmx:-ImiZoGQTXL5WPh8Tqj238IXFHeepb7OvxhiDmDiJ55BvB5dxmTk4A>
    <xmx:-ImiZkUxCqy51jDxnSvbDMACA52zq4mLgcekROgdtWEwgrJzU79_8A>
    <xmx:-ImiZrOUHSsbepYpA_IXUTpVAH9V59K-0ovVgV5C6gZlbgP-eyEwfQ>
    <xmx:-YmiZrS9sn42TfjFkJsaiTJFd0LJ5XEmyHYpjVEy7lh6APCCE1CpX3A8>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9AC7E15A0092; Thu, 25 Jul 2024 13:23:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ae5dc48b-07df-45ab-a3b7-4d5c27fdbfa2@app.fastmail.com>
In-Reply-To: <xmqqzfq5flfd.fsf@gitster.g>
References: <20240725144548.3434-1-ddiss@suse.de>
 <20240725144548.3434-3-ddiss@suse.de> <xmqqzfq5flfd.fsf@gitster.g>
Date: Thu, 25 Jul 2024 19:22:39 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>, "David Disseldorp" <ddiss@suse.de>
Cc: git@vger.kernel.org, "Teng Long" <dyroneteng@gmail.com>
Subject: Re: [PATCH 2/2] notes: revert note_data.given behavior with empty notes add
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024, at 19:09, Junio C Hamano wrote:
>> Fixes: 90bc19b3ae ("notes.c: introduce '--separator=3D<paragraph-brea=
k>' option")
>> Link: https://github.com/ddiss/icyci/issues/12
>
> We generally refrain from using these two trailers.  Please drop them.
>
> Especially "Fixes" claim can later prove incorrect (we thought this
> was a good fix when committing, but it later turned out to be a bad
> one), and besides you will be referring to the problematic commit in
> your proposed log message already anyway.

David, if you want to mention your downstream issue you can use a
=E2=80=9Cfootnote=E2=80=9D in the commit message:

    With "git notes add -C $blob", the given blob contents are
    to be made into a note without involving an editor.  But
    when "--allow-empty" is given, the editor is invoked.[1]

    <rest of the commit message>

    [1] https://github.com/ddiss/icyci/issues/12

    Signed-off-by: =E2=80=A6

This is widely practiced.

--=20
Kristoffer Haugsbakk

