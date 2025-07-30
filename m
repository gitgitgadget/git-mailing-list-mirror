Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784928FFE1
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861138; cv=none; b=gPDOxqgLhiRWK8S+/skS45jeqcLvYd1I7jJDXuoYyxvUdczkRSv7+kkD31Ipx0clcoD7U9It0/MhRk9kA7bgRhjDQ8WODN2cQATFJbNJHYFLTzU36VkQUFtv0dD9vNEOZ59uSYTfpGgKVFPvBLv9UCl47KIfrjOgEdXS8Td74Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861138; c=relaxed/simple;
	bh=9BrlaOhgHNCQp861sqTAXzq61gtMhyg+gUrfrLANRyI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SFx1fcpzNDw6cBsRxQr7WUayf7TQADuEcX0lx3TkS1N0dk9kzkat+h7UJt60BlDc+YBJ5vtL7qAeXjxVgAXebS9CBSmEC4UWV6FvLB5k3u0ephU0U0EgcNmxGnC1yCG4U5it2I3t/AQWs5Igif0D0mW3N7+kxEeX2TGbCaqUk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=g4nVqg9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HO0QXjJM; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="g4nVqg9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HO0QXjJM"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 159941D02397;
	Wed, 30 Jul 2025 03:38:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 30 Jul 2025 03:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753861134;
	 x=1753947534; bh=kWCs1k/WRd4xHdA+ra2h3q1sDoPZ6dNDB1Q/iA/c7Nc=; b=
	g4nVqg9st3EQ2BfEkmCmX12wwqFS9jeZbBiA43awgqyndqaD+NfBCy6QmeLCHBre
	X1zUfv5dAFESSaAI6tDpAoKyNRofkYOX2kWZiUIH4aEVIWDrTSGsAD6GGDbElNre
	vchsCyp92CYH3ydFRnatwDWo/4kVF9nguHV/OVUiqo3cC7kVv1rp/RPE7SJGuUec
	4Y3jK1wMQXiRoGHP8IDtsLxkN7NC7cSlsYrCl9eI63RevaDKX7h30dLIoKvcNlP5
	HF7591X2P7zTGJR3Gzs+U9iPEKD8dynDRAh/eumPRtkJjz5aiB27O+QGZIqnmIpt
	96MLhU3nv3f5cHqrcuvkhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753861134; x=
	1753947534; bh=kWCs1k/WRd4xHdA+ra2h3q1sDoPZ6dNDB1Q/iA/c7Nc=; b=H
	O0QXjJMJkdbpHq6YKuE27edWR6ABW182vK4DnoJc1Zad6wBNIr9Z/YjVuFujxXqb
	D/Xx+wc3BgQzvOeFjzFrY8K49xLTPcE93XhMrTqFKDUxMdHbJgqLkop3k6PYba2B
	IaxSokQBRuxypkNWFp9dqhYB5TcHYya52hucjylB2ur9/o1iuZQJTp4A77AlwsnO
	likAO6WegpnsIKO1J/zVRW5hGeAh4rL0z0MBX5l3REn4njyswmf0GPwYKjuCe/S1
	flpFR2b8eIvIzRlwSvnCdpO/dj/ykYBYRxBXwuS/CNAwja5WzL51R5tPudPw1liZ
	dR0aZ9f2He0/avo1XPtgQ==
X-ME-Sender: <xms:DcyJaP3FRTJZUB_32-rv0EXF1xQasGootaud2vsRjWhea_z2P0CmtYU>
    <xme:DcyJaOG2yEoPg2oWrjwiSSHwbNwQ3acMJCUE1l78nkWDJrChlEuKrvrT8g1r9kPhb
    puAtRZu0wACQkc-BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefg
    iefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeduke
    dvfedtvddvvdefjeelseduieefrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhvghnjhhirghnhhhusehkhihlih
    hnohhsrdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DcyJaA9X_0MXdPlKV_qEzyeXIRJZXLio7kUWl7xpEZL0R4AZX-P0Tg>
    <xmx:DcyJaCLBBE2CtYE1dct-6kU859BVEM0yAxV43OVcwIVGMFjvFkcNaQ>
    <xmx:DcyJaFkVeeYywhJAg1gBQqLcEGi0YZG457Ym7ryG-1NuyGnfBcHoLA>
    <xmx:DcyJaGMgs05GEeo9MGmNkHGJuRiofq-kD3IwLImrdBdEsXKEnrcQug>
    <xmx:DsyJaKy6SypvqpefDputIS6Tklomb4pdgSarltj3zBxvKM9R21_Gf-tQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C84521EA0066; Wed, 30 Jul 2025 03:38:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7f8cd6ef53ee6ea6
Date: Wed, 30 Jul 2025 09:38:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?=E9=99=88=E5=BB=BA=E8=99=8E?= <18230222379@163.com>,
 =?UTF-8?Q?=E9=99=88=E5=BB=BA=E8=99=8E?= <chenjianhu@kylinos.cn>
Message-Id: <096f8beb-8156-49da-b905-3615bb6116c8@app.fastmail.com>
In-Reply-To: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
References: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
Subject: =?UTF-8?Q?Re:_[PATCH]_modify_the_=E2=80=9Cfoo"_file_path_to_"$PWD/bad-cl?=
 =?UTF-8?Q?one/sub/foo".?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025, at 09:25, On Wed, Jul 30, 2025, at 09:25, =E9=99=88=
=E5=BB=BA=E8=99=8E via GitGitGadget wrote:
> From: =3D?UTF-8?q?=3DE9=3D99=3D88=3DE5=3DBB=3DBA=3DE8=3D99=3D8E?=3D <c=
henjianhu@kylinos.cn>
> ...
> Signed-off-by: chenjianhu <chenjianhu@kylinos.cn>

The author name and signoff name should match.  Either =E2=80=9C=E9=99=88=
=E5=BB=BA=E8=99=8E=E2=80=9D or the
(I=E2=80=99m guessing) romanization =E2=80=9Cchenjianhu=E2=80=9D for bot=
h.

--=20
Kristoffer Haugsbakk

