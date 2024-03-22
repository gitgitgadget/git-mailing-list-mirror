Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224FC67750
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144856; cv=none; b=VDYHZOAmgugvH+Yu2BnO5d/8a1oawyHI9+ADSwBPhGZofpJIhY8kcuelQsuPs7164RXEj2TxL3ZBA1QdxrtbqQBrb/bgJ4wMrLs9XNAGq+j68BuyvnARiCnPlX4HS/A7C8Kb2my4jae8O2SWWdvk+taxCJSIb2rl9xoP/cTubfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144856; c=relaxed/simple;
	bh=HaykHxBOpUIgNhrp+bAdpVnGOmlemUTrjuI8L1BCflw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=R4/mKYOOWhJJgVV8Qvq9qAif+BmF4CPQoJHqTjk/nTt8erpWHaNIEdxwDlg05yhwUm+nRJ4I02dq+hYjW6LHAHaMh4w86MJE0msTOtV8yJ4mXWJuUCgHy8A4HPYj7FYiNrxIBpnTXwDxv5vsj07HamgZAK83+wN9TqdvuHW3Dbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=IOUitmPq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OAXavQX4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="IOUitmPq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OAXavQX4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1C21913800F8;
	Fri, 22 Mar 2024 18:00:53 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 18:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1711144853; x=
	1711231253; bh=zEm8ZsevYAw3LLO/Dcg5zYt8sx80w0y753FwkwKK83o=; b=I
	OUitmPqYVskLgjGo9AuRbM7N8XHzeUqlr9L5pF+ICe7tfWzv2ep6HxJjTfvSYZ5R
	EwKTWgJWaqBFGj3p3pncDjWoUF7HmlXi+tqONCRMWS5Wl+txkVIFXtshKZpS/VaS
	3s0z//eY3DdlM/1YplZmS4IMHot+UqHahuh2qqIFUc2JRpjfRllZa5DbTcLJUBmt
	Vbba9hL82F/W+P59jIhSTMp7L6XQRdJrtZLFI0jjztMsSsMIyRGUDL73KlWEmndc
	OWVvsmn8zWvmhNWXA9+0tkgywbXpj+3S0r1TLLhP8PvQ7M+Bk/mSNu9Zq+nqsYQH
	SuCst5wxmXPPHq1/C36Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711144853; x=1711231253; bh=zEm8ZsevYAw3LLO/Dcg5zYt8sx80
	w0y753FwkwKK83o=; b=OAXavQX4WkunsxtDHKE4ZxvqBP7WVc50qw5YgswX62ZP
	MJU/xzMRxq61ylOEot77+nTXypj735xQHh9HlINH2rMoRPTKVApA/65+AmJah1XV
	db4QTQgLAXjjjw8keGKjJcB/xBs+lwRTNj7iAOoBXKyGVU3ZvMehTRZtCJCMw5Z6
	BjhKFp2pOCHCBiw33CWR9+9wEsuZ6m5+UVUI4oeyfaqT88fWEta0AO10K2W2vZK1
	KEUzq+rzsEtNKuN7U6a4fvdmqxic9I7a8kWw9VSjWO2nx+HIr3pzIamluelo/ibF
	WtitYlfl+tRri6Irg7qlSYvLfgvuIEsP+UsurunPtQ==
X-ME-Sender: <xms:lP_9ZbCrld3mveU1B8XMjcyBAaz07ERI81txu8Z_KoXLhrFV41ET4pE>
    <xme:lP_9ZRhWMP9h6E-FgYDrZlFLXlUeDz4y22SyBqfIwnWCw95Wwnpb1tKuya8gixKOl
    5PRrpdyhCLxppMWbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:lP_9ZWmQbjrWTj5UuyJ_lag3WCLel12MUkB8K0IWDaokCI7qbn0Scg>
    <xmx:lP_9Zdw-gaqtjrFY8695es5Mp7GoHnIe304BzaucirUewpdlNApLAQ>
    <xmx:lP_9ZQQwla69Tw8ZftMBw99elLfv_OXWnxsfvzb5jU-2MQnOwYxezQ>
    <xmx:lP_9ZQamP5vuSRiWDByEHn0g4BZWO0QotZnaPbY8SoOOAZ4VKNMkiw>
    <xmx:lf_9Zbe5bFMdbZENIqjaCMlpGEfIiFjKmvI-5e58UTn31VYCAcwPug>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8F81B15A0092; Fri, 22 Mar 2024 18:00:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <69904aaf-7830-4b2a-8fd9-7f6fe55b45fe@app.fastmail.com>
In-Reply-To: <20240320002851.GB904136@coredump.intra.peff.net>
References: <20240320002555.GB903718@coredump.intra.peff.net>
 <20240320002851.GB904136@coredump.intra.peff.net>
Date: Fri, 22 Mar 2024 23:00:32 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] pretty: split oneline and email subject printing
Content-Type: text/plain

On Wed, Mar 20, 2024, at 01:28, Jeff King wrote:
> The pp_title_line() function is used for two formats: the oneline format
> and the subject line of the email format. But most of the logic in the
> function does not make any sense for oneline; it is about special
> formatting of email headers.
>
> Lumping the two formats together made sense long ago in 4234a76167
> (Extend --pretty=oneline to cover the first paragraph, 2007-06-11), when
> there was a lot of manual logic to paste lines together. But later,
> 88c44735ab (pretty: factor out format_subject(), 2008-12-27) pulled that
> logic into its own function.
>
> We can implement the oneline format by just calling that one function.
> This makes the intention of the code much more clear, as we know we only
> need to worry about those extra email options when dealing with actual
> email.
>
> While the intent here is cleanup, it is possible to trigger these cases
> in practice by running format-patch with an explicit --oneline option.
> But if you did, the results are basically nonsense. For example, with
> the preserve_subject flag:
>
>   $ printf "%s\n" one two three | git commit --allow-empty -F -
>   $ git format-patch -1 --stdout -k | grep ^Subject
>   Subject: =?UTF-8?q?one=0Atwo=0Athree?=
>   $ git format-patch -1 --stdout -k --oneline --no-signature
>   2af7fbe one
>   two
>   three
>
> Or with extra headers:
>
>   $ git format-patch -1 --stdout --cc=me --oneline --no-signature
>   2af7fbe one two three
>   Cc: me
>
> So I'd actually consider this to be an improvement, though you are
> probably crazy to use other formats with format-patch in the first place
> (arguably it should forbid non-email formats entirely, but that's a
> bigger change).

Makes sense. This make the code more focused.

> As a bonus, it eliminates some pointless extra allocations for the
> oneline output. The email code, since it has to deal with wrapping,
> formats into an extra auxiliary buffer. The speedup is tiny, though like
> "rev-list --no-abbrev --format=oneline" seems to improve by a consistent
> 1-2% for me.

Nice. That could add up when formatting a moderate amount of patches.

-- 
Kristoffer Haugsbakk

