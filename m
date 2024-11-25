Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9954C6E
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732494242; cv=none; b=HJIrBZ6wvYBd2ORZMcHpb3WFObxi3t0iQUQXJN3nnRaMKKiZ3xRtPDtdMkUN+Ec99XGZWUCr/PckRiHf6ovxLTnDy9sPeEQhnaRiT1ZG1Rtt+X0sYCRUyV0qh5vQQJmne/9hLUNdYhp6Zj6Zk3kzy0mSw2iX/OhtW4SsBAcldyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732494242; c=relaxed/simple;
	bh=fFbiYTmK5SHIpJGFMjv4r26FQVt5aeZTJmMOMM/ySuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WF3ifA/yL36SBKmChyR/ZJU77JWf4ufjNvfX9cue/zFJD5dTXDJB8ePsCijjyGPLyXsWiftufQ49ZuaWjNcdMGH67PshRr38kaXUnr3h106aCnL5ac1CftE2sJvW7JGrALgQYCuqNJ5DDqLA0noJBDcFZG/Diqzsj3Pu3OAFy3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ONXIoOc+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONXIoOc+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B80D1114012F;
	Sun, 24 Nov 2024 19:23:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 24 Nov 2024 19:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732494239; x=
	1732580639; bh=d6GgtgcjaEnSpGDohfJzGAspPdGcP0DWgT/17GO+wJc=; b=O
	NXIoOc+F8mSTEMQq2E6ALsViloKLZmotoJJFeuPVeR8t/19FAon8ztqHBX77oxLk
	8PG83Pw/PCYrt7a4kmrMLdPWoud+dJrudLyzt8qbCK2W0+vYYFWcIx6eW2Efkl5P
	14ytqvn7EQUoqYLVD28J78TC28poeWGFjlgBtZQOSAMkQAlwx0w8ZHRUtg6ilKZb
	irNT6wIcZ7htUjMAZ73PpqZ5luj2wjaQFzuP8dpLZ71I46OxVVouvaZIRrvdVVcD
	Bqyan1RjNIJqhfNNxOs3c5QsdJEE7s4cNJPDFZso2uHtnov/7JFubYeS98vuK9Ho
	PRfke0pjAYwltqFKJ8PzQ==
X-ME-Sender: <xms:n8NDZxjBtEw06b9DGJiL8SSOUKqiIghhGLkhf-ROtYptp9jmD0kpTw>
    <xme:n8NDZ2DjhygzKX0pCjyx6CvqNBK-UgOBiTpakdysT0T6UhwvasnTNyTE4fyiThs32
    6xrKT-7tXFcybQ91Q>
X-ME-Received: <xmr:n8NDZxFoBCzW_HkydB7VucHbLhzfP7zbtnwagQ0b0SVxSsZ1Jjw4pI_-XHwfxl1w0eNXlDM6CfWv21bsUZdYXLqgTFJUEQaLRsUaO08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvvhhrrghiphhhih
    hlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:n8NDZ2QB76UzbxKr47GOfCY6GmxTLGxOKyFRlGaxe5MFGfu1cCd87w>
    <xmx:n8NDZ-wzd55xptZXEx3NLpDXteAmLbSnpOcJdehN4YcqKtb8KouRtA>
    <xmx:n8NDZ86_3ZeOsh6SX4k9KWUVt9OTLjEgYJn40ChjQnPBsRjYWoA-9w>
    <xmx:n8NDZzxQQ8x89S4sxE2_vPQNJBz38q_8EtgBs3OhM5hm9bOGQKcfZQ>
    <xmx:n8NDZy8RJd5vPtnhyUCwtNgjibpMuR5Ip-kL1lSITDS9FXf_9YlD_tfK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 19:23:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #08; Fri, 22)
In-Reply-To: <558f7192-6dd6-8434-c07a-921e2e55754a@gmail.com> (Philippe
	Blain's message of "Fri, 22 Nov 2024 14:10:09 -0500")
References: <xmqqy11bshme.fsf@gitster.g>
	<558f7192-6dd6-8434-c07a-921e2e55754a@gmail.com>
Date: Mon, 25 Nov 2024 09:23:58 +0900
Message-ID: <xmqqzflo88kh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Le 2024-11-22 à 05:11, Junio C Hamano a écrit :
>
>> 
>> * pb/mergetool-errors (2024-11-13) 5 commits
>>  - git-difftool--helper.sh: exit upon initialize_merge_tool errors
>>  - git-mergetool--lib.sh: add error message for unknown tool variant
>>  - git-mergetool--lib.sh: add error message in 'setup_user_tool'
>>  - git-mergetool--lib.sh: use TOOL_MODE when erroring about unknown tool
>>  - completion: complete '--tool-help' in 'git mergetool'
>> 
>>  End-user experience of "git mergetool" when the command errors out
>>  has been improved.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
>
> I'll send a v2 with some enhancements you suggested, so maybe wait a bit.

Thanks, will do.
