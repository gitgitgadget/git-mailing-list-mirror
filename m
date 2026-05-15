Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992934BA5B
	for <git@vger.kernel.org>; Fri, 15 May 2026 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846564; cv=none; b=BhEuvwVj+2UEPdmYWnOP7m4GYGWjPiaGxw8lXGWWQ3P5QWX0blGHdTCZzPiB/RTEukegx+Lr6mgL8lCxkOji6JqWsVttKsDrr5tVeTW5sz/61Xk6x6Ea8lkiuealh3OTdrY9dxBObaiH1/eDtL+ox3PCnXVjg4a65V7+FR7pj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846564; c=relaxed/simple;
	bh=YU8cuwWAymK1dSkch4D3Oa8QHO55wSIUQHJg8d7CRwg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V2OSDB4iufk8iyxRshgSZcendwAYvwCLKVCN9x/h7rM/Sb5INMcNjrkEEJw40RddTOw2HmvuEwzeiwjHDxEVxO1yoKdUga43GQDkcvMRqRsrxh7JLU3MD9bmhO3LOGb7DbSJw3IYU5AZX1n2KYBPj8ub58KhlG2AcZUR9mxWNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IurI5JOb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eiZbxmnK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IurI5JOb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eiZbxmnK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5728AEC0047;
	Fri, 15 May 2026 08:02:42 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Fri, 15 May 2026 08:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778846562;
	 x=1778932962; bh=kvg4eQu9utVWCCJQ0mBQy7IK7FUUrFVte6nWXfpgRaE=; b=
	IurI5JObrjGLy/7F8b3IgxKkjwa9f1ggV18qh5ScqZsZFP/HShbeKiKBSQYEQtmF
	y8sUu/k9a6QaGB/bgkFkjOIvaMQF+Sh4DQMoV7KeQzmNaEzbU102AtBOa8AvCCly
	OqwrGdjwx2u/hzDZLNoooEY7s686MFn2WjkGIuYj+zz4Kky3ovIfouEzQoTCuvaZ
	oSuV5OiI75otQDwKlAOGCM4mxr+4akI9SEd04ZQ1vphA44v4rlHKimF6cQjcn+Oi
	lp2UqwEgHgVHV30jClBC3UZflU+NGSzf+BXlfE8s8+1i/JIC9qk8N6GJHRlmu2RE
	eaUDwcV24nt+79ceq+y9AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778846562; x=
	1778932962; bh=kvg4eQu9utVWCCJQ0mBQy7IK7FUUrFVte6nWXfpgRaE=; b=e
	iZbxmnKCO+DbmZgvREwQ44so2bhrx0UNs9A3QsRI3b3jv2M0L9blIOBf/TuVGWlg
	6L8AoP5GKA9sbFVXP9K/O4G7203XcJ8LuY7gvG6TShl9c9cgenHlwGeDFpMgmaVj
	ZY5j6zLRReaWCixBE9ruf42m182JFa/bojAHB9EdnKPd/yk+zyTSZ69mOKx5gsgN
	HgARTmxTeIYDi2ZVcgYKzIozEDFtRZTK7wnbv3SbGs3qNrEMgPny1c00Z9niCAWW
	vHgHjqL+ucpy58nvTsll2A0Xsu0RpvSQtj3U1/Q6jWn5Of7Ek09ensSudNBYZyeO
	bOf2u2L8BfjJc3y/gTHCQ==
X-ME-Sender: <xms:YgsHalhosMqGeeCXx8m0cbgp-3_45PuXKtHVQiqpUfA_whrRXyYX45w>
    <xme:YgsHak1RiicOajkQKEevzPhmkPLK70OUmYXYgWdqBoWJkaJL9_vPXd1znODwzh-6S
    pKNFYmYE4FzS23FoXmyEADiQdPNrU_G159JPZzKXQgyfqOjsnWayQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffeuueeiheeh
    ffejgedtveefhedthfevvdegudeltdffheejvdfhjeduffehgeelnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrrh
    grlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:YgsHaoI0f3RilZYA385tLKAy2qQMRsGWMOzg1wjM_XVQJKOzrn_qZg>
    <xmx:YgsHal81TuBOiepciZOGpg2eIt2W3MykrGidS8IP1Pagbfsr7J6NbA>
    <xmx:YgsHajJJFQgVa9zhYto80151fQnNdLEuCLay713w5FPtGBoXY3zXKA>
    <xmx:YgsHailkgbWeF3fDBf6ByIjrrJa9zkyPuqKUAWmNZwVz_EGnc-TYWA>
    <xmx:YgsHanuxJxOZt8RRvMX1aAKhr7mDQ9JNuneqfJWwnqoolYZzv7LWSw1T>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2E6F6C4006E; Fri, 15 May 2026 08:02:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 May 2026 14:02:21 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Koji Nakamaru" <gitgitgadget@gmail.com>
Message-Id: <f1421148-dcae-49ee-aff0-a98731558d51@app.fastmail.com>
In-Reply-To: <20260515075611.59535-1-haraldnordgren@gmail.com>
References: <xmqqecjdea13.fsf@gitster.g>
 <20260515075611.59535-1-haraldnordgren@gmail.com>
Subject: Re: Email issues
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 15, 2026, at 09:56, Harald Nordgren wrote:
>> Why do I get the above, which apparently is a response to my review
>> for
>> 
>>     [PATCH] config: suggest the correct form when key contains "="
>> 
>> under this thread?  Am I dealing with some sort of mechanical slop?
>
> I think the problem here is my email sending process is not good. I edit
> all the emails in Sublime text, where I keep the same file for all
> different threads.
>
> I have the subject line as the first line of the file and like you notice I
> forget to change it sometimes.
>
> I keep each of the topics bookmarked like this, 
> https://lore.kernel.org/git/xmqqecjdea13.fsf@gitster.g/, and then utilize
> that like to send the email
>
> ```
>   git send-email \
>     --in-reply-to=xmqqecjdea13.fsf@gitster.g \
>     --to=gitster@pobox.com \
>     --cc=git@vger.kernel.org \
>     --cc=gitgitgadget@gmail.com \
>     --cc=haraldnordgren@gmail.com \
>     /path/to/YOUR_REPLY
> ```
>
> I tried playing with neomutt and and email client replacement, but that
> adds the complexity of downloading a new mbox file for each reply, it
> didn't seem easier, but maybe it is.
>
> How do you handle emails?

I use the Fastmail webmail client for
regular non-patch emails. The only
things it messes up so far is long lines
in replies to patches.

I edit the emails in a text editor. And sometimes
I have left multiple drafts before sending them
and switched them around. Only to see my mistake on the Lore archive later. :)

But by and large it works just fine. I haven't had
the need for a more ergonomic setup.

-- 
Sent from mobile
