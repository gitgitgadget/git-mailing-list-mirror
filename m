Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602131C5F13;
	Tue,  8 Jul 2025 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006528; cv=none; b=fUmbRL3922mb+XTAt5pIZmyw5D0mJFMIAhqiYDWvUSxfZ4dZLR+QDPPSYPX7qHIO/SaEkAdoL1AYbQqAtPoPvoHz/7SQpH67H+o07DeGwRxYMCvy6JXfC2ujaatwvqTaexv/7NRV/BNznb2VfgbGJIGUXDiMShoCFXvBRlpwYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006528; c=relaxed/simple;
	bh=t0FMENktUYI3ALJlwiGKpoPYCo95RQSgYjfDCvjrMwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BURJur8Se5aqxqBhej3AcbORHT97ljbGOKXpRXhrfyj4Rz4F4kzwcn3xt6lqf1HT6FvaBbLlSNwS0Q1pc7w92eCUYc1hHNmbDdj70O6xpYnddB6jgPpSv/Bim5N7ssLoxfuvRov0ZkHcjf3o0ngHQw0rii0o42Gx5k4j4Y+mSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mlOl4E2E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Am47XWZM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mlOl4E2E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Am47XWZM"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A7BE140022F;
	Tue,  8 Jul 2025 16:28:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 16:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752006524; x=1752092924; bh=0h9PIoOaAP
	JIFd+VASzLwF7NVax4XlGpdJzBNxmavcU=; b=mlOl4E2EvmBIHpnBTToiBpVL7d
	/LWZDc41nV+byQvpmApbSIx0l0Em07zzCYn1Np/U4l6z412OM8W2TudhcZ7U06cY
	CO+wT8bQ4wanAaM9KpPOu63xd1MBVD6mI70j+xmCVFhHmSsaEMaunmXO+cvvTzkU
	d+dQwRIPR8tbu9C+3N1CJ6618SgoxSlLSwn3hnksjyMUNDNaK1qpdvQqO6E5cx3b
	ChDKE9KhO1EIJdrNJevo0WrTR68F4I2ZpT2lGB6O88GVR6MHX5611XwFjiHdd63y
	hOX/XAailkCSF//HshkUOe+/dokaPjqA0IfFS9beqiVDRI50z1M7Da2hyXLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752006524; x=1752092924; bh=0h9PIoOaAPJIFd+VASzLwF7NVax4XlGpdJz
	BNxmavcU=; b=Am47XWZMmrqT0lq2Wo3Qx8mgb8BV4YUGB+QX3VnIo6e44zKzNHR
	1yYL8h9B+mMKU5R33MEUYXqR1UvrdSB6VU08vggO24f/67+tGpp9XxsBHqOIklSm
	n99EIUtSwE6Q2saoRdNpZAits9tPXy5kf391dhny5FG6Zhz6OX/BuIqh74bnKM2q
	Qk42lqlvuOpZdhNDprpjDBOS+WZhLZw1tOGpOL7hY5vtnREmjtpDY8qMSsXKlxtr
	4IJJY8M63EU54v1Vd4zGt/iliBKidmJZnq7UdAuYnYdGDnqTtO+OWTpeVzPsmEg3
	cznuQv1IX4Me4BvshVFEMkWTu5qJYlB9hOg==
X-ME-Sender: <xms:fH9taB4gFND0ogTxmKlU-BcsTrZeK0D5yzMMuwXmiIO3TTbsIvlHLw>
    <xme:fH9taMBdKoLsoqwu1QLSGT1oXf9U1o0GOaigx1X_Sj1ZqTkMsjC530QPhBcMWnNuj
    SvJwsIVaTXWouIc5w>
X-ME-Received: <xmr:fH9taHfEQG2jalLDufeEm56nbSk-UOb58sdDfjm3klQeoqUcVYM3Atm-tIZwe0rByZJHo31JtehEy23M8YizRaNkpk0U0bkx11og7jzVo9ZijkDPZ20n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvohguugcukghu
    lhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    fgveefveeihfehhefhgeethfdvffehfeehueelheeiffeuvddvuefhveffiefgueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtqdhprggtkhgrghgvrhhssehgohhoghhlvghg
    rhhouhhpshdrtghomh
X-ME-Proxy: <xmx:fH9taLLYA1vsNWKbtRzWVcYLnN4WSHTBwJHNhMtzlB-BvVjOlGKfwg>
    <xmx:fH9taC1x3EyrJsb42TCWHsdHtPqIv4rZOAImlbKbcEIBsk_ZehUQAg>
    <xmx:fH9taNj4yWuwSLCOTRdZvqRL5UuGYp5Ou75kmCvF24llfGyd8RillA>
    <xmx:fH9taLVznvXmt0RzIALA84_4kgniPkxHhD67nplOOs4DZtfKqsBQzQ>
    <xmx:fH9taJRm6zNpRX58tnzX49e1KBGDtsFe5rpQPkuT0RyjRpFKSqG99uoM>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 16:28:44 -0400 (EDT)
Date: Tue, 8 Jul 2025 16:28:42 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.50.1 and friends
Message-ID: <aG1_eqSpH46UddZJ@teonanacatl.net>
References: <xmqqzfdevcov.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfdevcov.fsf@gitster.g>

Junio C Hamano wrote:
> A maintenance release Git v2.50.1 and others for older maintenance
> tracks down to maint-2.43 are now available at the usual places.

I was building v2.45.4 on an older system and two tests
failed:

    t1300.237 writing value with trailing CR not stripped on read
    t7450.50  submodule must not checkout into different directory

These both look like they use new git config syntax (get,
set, unset) which is not available in the older releases.

I haven't done enough digging to determine when the syntax
changed to prepare a proper patch, but I thought I'd mention
it, in case anyone else runs into a similar issue or is
highly motivated to work up a patch against which ever older
releases need it.

The fix looks something like this, I believe:

-- >8 --
diff --git i/t/t1300-config.sh w/t/t1300-config.sh
index 00f34c5a01..3ed4a0b1ce 100755
--- i/t/t1300-config.sh
+++ w/t/t1300-config.sh
@@ -2743,8 +2743,8 @@ test_expect_success 'writing value with trailing CR not stripped on read' '
 
 	printf "bar\r\n" >expect &&
 	git init cr-test &&
-	git -C cr-test config set core.foo $(printf "bar\r") &&
-	git -C cr-test config get core.foo >actual &&
+	git -C cr-test config core.foo $(printf "bar\r") &&
+	git -C cr-test config --get core.foo >actual &&
 
 	test_cmp expect actual
 '
diff --git i/t/t7450-bad-git-dotfiles.sh w/t/t7450-bad-git-dotfiles.sh
index ff63c05652..38b9db85cd 100755
--- i/t/t7450-bad-git-dotfiles.sh
+++ w/t/t7450-bad-git-dotfiles.sh
@@ -388,10 +388,10 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
 	git -C repo mv sub $(printf "sub\r") &&
 
 	# Ensure config values containing CR are wrapped in quotes.
-	git config unset -f repo/.gitmodules submodule.sub.path &&
+	git config --unset -f repo/.gitmodules submodule.sub.path &&
 	printf "\tpath = \"sub\r\"\n" >>repo/.gitmodules &&
 
-	git config unset -f repo/.git/modules/sub/config core.worktree &&
+	git config --unset -f repo/.git/modules/sub/config core.worktree &&
 	{
 		printf "[core]\n" &&
 		printf "\tworktree = \"../../../sub\r\"\n"

-- 
Todd
