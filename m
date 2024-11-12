Received: from 1.mo582.mail-out.ovh.net (1.mo582.mail-out.ovh.net [46.105.56.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52C9218927
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.56.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408187; cv=none; b=AXvu9h5p8e0jpBGZpWotDbubyki6Hk5E8O9dNOM99LDHZZAStkotJ1D2y/UAPf3nJgIZNRgpOhd/S3x+EN2WRw0iqHjbdxt+I2q9T8k6IRz+WtTmNGdCBRae+bcXYzvB9fIiWHGn6zbLGkZRM87WIbgZpuaMh3EnWqCBo0wcCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408187; c=relaxed/simple;
	bh=fs0+XjPDv9ODAUl1/89U7D4kofHTCuFXr6O6jOfSL1U=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=SfOm7bsjgJwsaMjvFUA1X5gxBnr34GFicGypUfJqjDi2MDBkd3J2VWtz0sEwFdu+jZgrl3C74YXyQuBdwcveXkHg1/nffk7AOIJBrrS6Etk1Go42CAq/olVGerKtQLUdhnUl59TXguPAF6HDhKtrmUHZdQR2lggsXvPRmLAG590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scantech.com; spf=pass smtp.mailfrom=scantech.com; arc=none smtp.client-ip=46.105.56.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scantech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scantech.com
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.139.40])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4XngxS3b4Nz1PM7
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 09:25:16 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-wqvsq (unknown [10.110.188.65])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 014EF1FEB2;
	Tue, 12 Nov 2024 09:25:15 +0000 (UTC)
Received: from scantech.com ([37.59.142.105])
	by ghost-submission-5b5ff79f4f-wqvsq with ESMTPSA
	id 4DouMfseM2cGMwAAruYUIA
	(envelope-from <jean-noel.avila@scantech.com>); Tue, 12 Nov 2024 09:25:15 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-105G006796b9148-b60c-4bb2-a8f4-e1178ecdd9be,
                    DF86D393C21BE984CC250B19F8FDB4784127F9C2) smtp.auth=jean-noel.avila@scantech.com
X-OVh-ClientIp:92.173.128.58
Content-Type: multipart/mixed; boundary="------------B2yik8nqYQwtS02CZu0Jvl29"
Message-ID: <0882542f-8424-4dfc-8358-f5c982aafbd4@scantech.com>
Date: Tue, 12 Nov 2024 10:25:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: git-add.txt: convert to new style convention
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1826.git.1731348891108.gitgitgadget@gmail.com>
 <xmqqserx8ewu.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jean-noel.avila@scantech.com>
Content-Language: fr
In-Reply-To: <xmqqserx8ewu.fsf@gitster.g>
X-Ovh-Tracer-Id: 2232659518096858875
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgfkffggfgfuvfevfhfhjgesmhdtreertddvjeenucfhrhhomheplfgvrghnqdfpohotlhcutehvihhlrgcuoehjvggrnhdqnhhovghlrdgrvhhilhgrsehstggrnhhtvggthhdrtghomheqnecuggftrfgrthhtvghrnhepkedvueefvdeitedvfefgieekueeukedvkeffgedvhfegveekvedvudeuteduhfetnecukfhppeduvdejrddtrddtrddupdelvddrudejfedruddvkedrheekpdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehjvggrnhdqnhhovghlrdgrvhhilhgrsehstggrnhhtvggthhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedvmgdpmhhouggvpehsmhhtphhouhht

This is a multi-part message in MIME format.
--------------B2yik8nqYQwtS02CZu0Jvl29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/11/2024 à 01:38, Junio C Hamano a écrit :
> "Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>>
>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>> ---
>>     doc: git-add.txt: convert to new style convention
> 
> This does slightly more than converting to new style, though,
> doesn't it?  Is it so annoying to see a link that points at the same
> page you are reading right now to warrant duplicating some docs with
> conditional inclusion?
> 
>> +`add.ignoreErrors`::
>> +`add.ignore-errors` (deprecated)::
>> +	Tells `git add` to continue adding files when some files cannot be
>> +	added due to indexing errors.
>> +ifdef::git-add[]
>> +	Equivalent to the `--ignore-errors` option.
>> +endif::git-add[]
>> +ifndef::git-add[]
>> +	Equivalent to the `--ignore-errors` option of linkgit:git-add[1].
>> +endif::git-add[]
> 

This was already performed for git-clone (ebb55042a4) and git-init
(e7b3a7683c). Should it be separated in a dedicated commit?


If the link is not to a specific anchor in the doc (which is the aim in
html output), it is considered bad practice (against the "Make your
visitor confident that the link they're following will take them where
they want to go" principle). To create a sensible link, we would have to
bring the visitor to the corresponding option description. This is
doable, but would require an enhanced linkgit macro and additional anchors.



--------------B2yik8nqYQwtS02CZu0Jvl29
Content-Type: text/vcard; charset=UTF-8; name="jean-noel_avila.vcf"
Content-Disposition: attachment; filename="jean-noel_avila.vcf"
Content-Transfer-Encoding: base64

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6SmVhbi1Obz1DMz1BQmwgQXZpbGEN
Cm47cXVvdGVkLXByaW50YWJsZTpBdmlsYTtKZWFuLU5vPUMzPUFCbA0Kb3JnOlNjYW50ZWNo
IFMuQS4NCmFkcjtxdW90ZWQtcHJpbnRhYmxlOlNhdm9pZSBUZWNobm9sYWMgQlAgMjQ0OztC
PUMzPUEydGltZW50IEFuZHJvbT1DMz1BOGRlIC0gMTA4IEF2ZW51ZSBkdSBMYWMgTD1DMz1B
OW1hbiA7IExBIE1PVFRFIFNFUlZPTEVYOzs3MzI5MDtGcmFuY2UNCmVtYWlsO2ludGVybmV0
OmplYW4tbm9lbC5hdmlsYUBzY2FudGVjaC5jb20NCnRpdGxlOkVtYmVkZGVkIHN5c3RlbXMg
bWFuYWdlcg0KdGVsO3dvcms6KzMzIDQ3OSAyNSA1NCA1MA0KdGVsO2NlbGw6KzMzIDYzMyAw
NCA2NCAxOA0KeC1tb3ppbGxhLWh0bWw6RkFMU0UNCnVybDpodHRwOi8vd3d3LnNjYW50ZWNo
LmNvbQ0KdmVyc2lvbjoyLjENCmVuZDp2Y2FyZA0KDQo=

--------------B2yik8nqYQwtS02CZu0Jvl29--
