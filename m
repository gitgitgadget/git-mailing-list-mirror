Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0C24CEEA
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799971; cv=none; b=Aoatp6f0GcVLo1gF8eEI0KU+0wi9j2HuUttlw8tKNdrid9ka9V39wjWXfosTGodJULhzXJCJgIcfDlC7qOSWprTwhABK0rPQ6R7b0e3nuDfOCZ2l3WkCk6yKCNIW/PwcbxtHLa+bu/jiVHEwVUaXjeRRB9BM4LJiOXG2EzYHELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799971; c=relaxed/simple;
	bh=O9PUjoJDKDld974edsjbqokogWfV4KPmagTL7EMQJAs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ISuRHWb2QAETAVIKbbIRiFUl53bx5OVM0jUrBIdZoraNnVydTMZe64UlS1+Q8yb8P2S1x7ADh41UgoakrZ3kKDwxiqJUk6g47jrRkJHgGVLvTY/3b6VOCw94Vwj3JKa3j3YPR3ucL628YT5CRV4LQkTfhUcU/OnxPLZ0zNrCha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b88fEs0R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGxvRHgR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b88fEs0R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGxvRHgR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BF08EC00E5;
	Mon, 15 Dec 2025 06:59:28 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 06:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765799968;
	 x=1765886368; bh=O9PUjoJDKDld974edsjbqokogWfV4KPmagTL7EMQJAs=; b=
	b88fEs0RNajtx1sb3xx5Stpxv0pAdYyOAl5NkWvlQPcTTFf6MeJFzSECYhjOFV8k
	Up+nuOWcl8/UQ0ur+WI+K84PL3F2UlN3qCKJeqq0vjydBo844RoIifNb9QUO/leX
	gjliHCL3B7FH9UgAvUEU566+sRcAJ57NNv0rQRGO9nP1iwVp+fTABXeswdDggVmE
	icHOE4cdDnjX/+Z1295DvfpGtLm/3XhmoN/aDiVdgwshCSbi/GGJLzeaTf+7tGti
	a1rC3vXipMwvCRPRgJChbxbIj5RDJjkhvbv2/BZPSmKCIhxO/YHHGccvp5OlXz0p
	DkctE8qWulFoqBR75cVCQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765799968; x=
	1765886368; bh=O9PUjoJDKDld974edsjbqokogWfV4KPmagTL7EMQJAs=; b=R
	GxvRHgRomf0+v54Eg1gl8xvLPIYWx73IVMBKEJt5Caa2wpGRMltaCj07FlixHN7v
	66Mp/0Jim6smu3s/GrFLLivw4zwwLV+inSpklwcrvd5sVmBXmdRH6lw0qCbNCAC7
	QAi/L0J/zfpQdu5wYIpEIXAob9uxRd++exr5PmRA9NLW+SvIFhx+S/ski/5YaML+
	Af7RUyTd65C9DKEzpxvlNExxN0QxXflwpKcRtWCmJ4BRydRbkSvnCMYK/ipUCJtQ
	C2ztIkHu4LcyoRcdtyiFaXGOF57FjOLk0pNO2+yVknP93/GpzaxP6ZAE4QBJzvIg
	Sj23Cg2fDSqT+hQ9VvnuQ==
X-ME-Sender: <xms:H_g_aebK89PgLbwzM4Vyszd6g1qj0VGpQuN27eqPay30CmacGtVupaA>
    <xme:H_g_acPbrqJnh6xHnGVdKMo1KK2-mbMZX6BHngvwEfJUtq4XNRvNcVwM-e3tOvUJl
    DEGd_kSPmAD4-KUJBhPYphk7Hr7xUld7tvaBsASjInQ-ACrhTwpDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefieejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:H_g_acA9FvGa0jDGKeeDoTPd_JIKMu7V76EziI5ChVoTvqhlnyuBcg>
    <xmx:H_g_aYkqQGFSung4dp5rzvmcAw4QVRb9CMPjLonFNaLZSA2RS9DohQ>
    <xmx:H_g_afeNr4YP_seBlTcfKnL9mv9io_C3y71XapKLU26f-CG_hskMnw>
    <xmx:H_g_aURXaLLVs4nYWtvh9WZVFi0RgdtqetZAe4OGH1Q_TsVQ4MjsPQ>
    <xmx:IPg_aSgsOwMQJDvs7rnn4nbYaOcM9SNd-VKUBzWxpL9jZJR3XosOKHtg>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC5DB1EA0066; Mon, 15 Dec 2025 06:59:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_-Iu8LU1e_w
Date: Mon, 15 Dec 2025 12:59:07 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <bf3f3633-5d0d-4fa4-9706-d99e32a3f91d@app.fastmail.com>
In-Reply-To: <8fa21ce8-1e02-419f-b82a-0e4a41f7e2d8@gmail.com>
References: <CV_replay_conflict.101@msgid.xyz>
 <V2_CV_replay_conflict.12f@msgid.xyz>
 <8fa21ce8-1e02-419f-b82a-0e4a41f7e2d8@gmail.com>
Subject: Re: [PATCH v2 0/3] doc: replay: improvements like "mention no output on
 conflicts"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025, at 11:13, Phillip Wood wrote:
> On 13/12/2025 13:46, kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Explicitly say that conflicts do not give any output. I found this a =
bit
>> confusing with the current doc since I am used to other commands
>> complaining loudly.
>>
>> =C2=A7 Changes in v2
>>
>> Patch 2/3: improve `--contained` and mention that it requires `--onto=
`.
>
> The new text looks good, I don't really understand the commit message
> but the intent of the change is clear enough.
>
> Thanks for improving the documentation

Thank you. But I=E2=80=99m not glad that the commit message is not clear=
. I
would need some guidance on how to write it because it seems clear to
me. Something with my brain state I guess.
