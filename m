Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1E5687
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="XvINhDle";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWegp+Y3"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE239B3
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 03:35:30 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3E5655C02AC;
	Sat, 14 Oct 2023 06:35:27 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sat, 14 Oct 2023 06:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1697279727; x=1697366127; bh=dYcspenoeN6qp7jFGTRt4VUZZ
	NW0w4gliwNmEAkuFH8=; b=XvINhDle78zLUMJxV3JdrnPVCKRQlV+Qp/+11EVln
	IMPwx0qYA0j6WziKVdLdwnqpZfsO14FNQ3toejYOA+ARH1LiGXc6r8Bd3U/SPNyT
	UR0kXut+J9P1PxbBX4awxUiZpmvDQ+msVQqXQYRZjZquIS1LO2wJHAyOC4dgbTmO
	XZ2uPmCGOwZg+rduOIQIaPd6O2VeGXR/i+dxZTblvQoJ4M6S9H2Mt439+etiz7Sp
	2o8gy9xylkDJlYn2xQn8WvI0w9kc0dfgTCkSft+Jsz7lNv85ASEBgLiV06QJYBLM
	r1vQx/YNHCeXx2IO6w5ItLkS576a21SWw5Vix27p6gLsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697279727; x=1697366127; bh=dYcspenoeN6qp7jFGTRt4VUZZNW0w4gliwN
	mEAkuFH8=; b=QWegp+Y3qJFJq1O2+7e0eUyNQSzZ5uY9JpmkbCE6IkGqwxixwlK
	EF9qtCutNAkcLCZz5rw5MaisRVk5UcO2r45j2x0myGXirFF6gP38qCSwzdiuOqDL
	nHULsVkGg8DnOx/tAAu6CvV1ZkFZjkqM7IW6ZRrCuR4kFbE5MMnB/KfVrF8/dFlK
	KLsF3kEU47WaXLCuqS8JZqQCCSWp/PC/dEsc6kn3VKXX4jwASfaHrrU1jKaAXtEc
	mTYfoskarhqfIHRn8UoFO+uoqf3036e5k5Fkn/rBfGUExN2B11+H2kgw/hW1GTAB
	4Z1O+s8Ef8srGMm9pAdLeAvIvta7yhVBhBg==
X-ME-Sender: <xms:724qZeAMh33pcO1NleA-io0jGsjZgfZrUYppjJ8oaunc75NH78jBJFk>
    <xme:724qZYjXhy67CYUeDzSm2GpdsHxwTFyLzFJA0TCjLjnlTefC3JrDcXsP5sU7DyGaq
    jyb_FVSWbhH0K33jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:724qZRlNO3SXENu67rB33uq0N-8bObs7dmr9hAYBu57ZLw58HaWlQQ>
    <xmx:724qZcy1c8qCpsswVogmv35x-TcSBYqJG7kLzjBP9ByGDQmF5bptGw>
    <xmx:724qZTR07eSRcSm0DdxWSTLhIWVP_d5ekQ3jHaCuQB6YW7bOoHYOFw>
    <xmx:724qZWNzzGwejZtKo21PiIKJMDkJTJ4Q9tWq5t3s9ltr4s6MvicRcg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DF44D15A0093; Sat, 14 Oct 2023 06:35:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <90bf6f0e-6061-4670-aa04-9d6e44b1d246@app.fastmail.com>
In-Reply-To: <20231014040101.8333-1-jacob@initialcommit.io>
References: <20231014040101.8333-1-jacob@initialcommit.io>
Date: Sat, 14 Oct 2023 12:35:06 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jacob Stopak" <jacob@initialcommit.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add 'seconds' to default outfile name
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jacob

On Sat, Oct 14, 2023, at 06:01, Jacob Stopak wrote:
> This patch adds the calendar second value to the default bugreport

Nitpick: you can just say =E2=80=9CAdd the calendar=E2=80=9D. =E2=80=9CT=
his patch=E2=80=9D is redundant.

See `Documentation/SubmittingPatches` at `imperative-mood`.

--=20
Kristoffer
