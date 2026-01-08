Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE8221FB8
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767835872; cv=none; b=KXGk5vtUwwaqaw/7ytrtrLC3TwN/Uf1MExU+/KDhe9fx6+u33rsQkHImszA/hKIZ+o/pzhkclnWHTUUrCT7hSDHx82cLWqyHfty6OgiEV6Bui4vUhuv8VODjj7C5s7kw5CejY5U8r3dNsoab9m684G+j5P55lOgB3U17qW7msF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767835872; c=relaxed/simple;
	bh=HgB1+w7EMlCzVnMekvtn6dO0lwdTt038ZGJLOKwgslU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M/ng7/0PMv1U9VFD39hQmOEK4byKVYWWFRkmECatMfA4gR3F8Nahl8ltl4gLOGOLPd5jckl8chtKF0EEasxYu6qkrIk0K7uIM7pWA7ubUj0xUSLn+HpZ7IVf7xjeRocBHmXJNJcNzeDRVhKGmLA6VTind9PQvE5t3C7FtkeasE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=V3pZq0tm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K5A5oob4; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="V3pZq0tm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K5A5oob4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id CACB11300031;
	Wed,  7 Jan 2026 20:31:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 07 Jan 2026 20:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767835868; x=1767839468; bh=IUXuV89zif
	57YnoA27bGsM0OsLXfe2o6diawEdLy1SA=; b=V3pZq0tmZIdjrLB9+4mpAWgIdh
	qd4+2he6rMTaXTKGsAyX0DWun1cPM/HYkcgTNhi6Ri8KCBEL5bgelm7WmNUhQg+5
	+HY9Pl21e2MFbCHSLwnzB/PHFjRHZv2jYYEGgBbWbZiiROu4Opw0VX5xyshE3H8A
	e34r4gBiNn8rUwum37iLY/IDtkYdrhgOcZvCEt1OYfk5fajK2lhNQ41KsF1BptUG
	Ooz1IgLTAbFoMD3fMaJla6MRM+1wai/4fbBX2XPJClTm12KPV2ERxtReqnG+wMo8
	s90/xVAOAGVH/pVtg8eqlKBbjLhYL5aJfXhMCUf9YgoEMHII4N7NHVmj21Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767835868; x=1767839468; bh=IUXuV89zif57YnoA27bGsM0OsLXfe2o6dia
	wEdLy1SA=; b=K5A5oob46ddxxXQw0+zwfGWpL6jItHJKiaHf92eHgU/WdU2Fipn
	9rjaTw9Qo2erChPEMuNMGbAUws5WE6kjWbtXTXD4eFl48chz148zwrIVUY6sFl5E
	L9xHd6dQ4x9szkEEolKaRmLTmbC76vOkBDzloOJYtFOt8EYVYo1RIRMQPVXLiWpi
	Dh7S0sMzDnfpUGk5FAVPc02XWWcryvKFGJ46r7UnWD82adzaHkbqgeHSB1XpKjur
	qTxvJXJUGnSCltB6Wqf08AMXaZ2OUiTlE2K7JYTA3nNq9ZuOVuO97ki+x4ngKGTu
	78TAsbRyFibfmSqur0PylqJdUPImPWHre6Q==
X-ME-Sender: <xms:3AhfaQYEeajtOJWZJRuHqowIjS7-XPBPYHaGuQbRFdCKah5nN-E4sg>
    <xme:3AhfaRa6Pzf9Ee6vAylvA-e8--TJMCAtfyZMEliMJyKRtjjjTCrtzhAqIaChBtUKo
    Ie4FzaPWdVDo690mGNgLlFrsSTkEsX1AAb82NpX7seNgaN1m-5f68s9>
X-ME-Received: <xmr:3AhfaYn14pv7Dim1M-GNBYPQLaInhEd3QAlHNhWW5TGHMKLjTKUu662eBaMRobxZCcgJwxvrQc1gOuklS4ZmU1APXX0VUaOv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdegieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfggtgesthdtredttd
    dttdenucfhrhhomheptehnughrvgifucevhhhithgvshhtvghruceorghnuggthhhisehf
    rghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepveeggfellefgueegteejte
    etudehiefhgeelffdvteejjeeigeevgffgvdeklefhnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomheprghnuggthhhisehfrghsthhmrghilhdrtg
    homhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3AhfaVzqYZidQ7JRXiO8HmCs2a9PvGautZYgRF9eQTfYxEhfVgHPgQ>
    <xmx:3AhfaePu1Zgu6gp56O1FQqeGi27Nqx-gDluE_wtrtWdRRuqqY8Sl5Q>
    <xmx:3AhfaRSUkvjMckWTEgADp6DfSTXAExVwNkn_fkL6xeVDeYJVr4P5sg>
    <xmx:3AhfaUa3dz1OdQwQ_WBIJ6y8bn_qNeo5roRcZAdRNjMwbDQqJyDYMw>
    <xmx:3AhfaW2dxzz_A5AJbxurt-W9qiBIEO5whw3SW5pES9VzXSYfl5UB1zv7>
Feedback-ID: i4e2e486a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 20:31:05 -0500 (EST)
From: Andrew Chitester <andchi@fastmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t1420-lost-found.sh: use test_path_is_file for
 error logging
In-Reply-To: <xmqq4ip0n3mm.fsf@gitster.g>
References: <20260104161536.45384-1-andchi@fastmail.com>
 <xmqq4ip0n3mm.fsf@gitster.g>
Date: Wed, 07 Jan 2026 20:30:54 -0500
Message-ID: <87v7hcvqk1.fsf@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Looks correct, but given that what these tests want to ensure is
> that underneath .git/lost-found there are only these two expected
> files, I have to wonder if the output of "ls" here is expected to be
> very stable.  I.e. if we rewrote the whole thing to something like
> ...
>
> 	ls .git/lost-found/*/* >actual &&
> 	cat >expect <<-EOF &&
> 	.git/lost-found/commit/$(cat lost-commit)
> 	.git/lost-found/other/$(cat lost-other)
> 	EOF
> 	test_cmp expect actual
>
> ... would it be a more direct way to say that and is easier to
> understand to our readers.

Thanks for the feedback. This is an elegant solution that I did not
consider. Looking through the other tests, I am seeing this similar
pattern of comparing an expected result with the actual result. It is
much more deliberate and readable this way. I sent a v2, as a reply to
my original message, but I think I forgot to Cc you in that message. I'm
still figuring out the email workflow.
