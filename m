Received: from mta200a-ord.mtasv.net (mta200a-ord.mtasv.net [104.245.209.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3D3B0ADC
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.209.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791609; cv=none; b=b30XIgIOkUVblPE1n4B+cZmyVtuKv/v91vjMyg5unl34zuSwb7xWpa6WOEpMwg/pVGC+2O9avSCZH//xkdCyLZBg27loJd7o48CQ1i/ImNwpOLikJa78AinQ2EPK1OoB3x1MyuyBqbvSRvBxuHF0eoUErxYJASwd+G1eCBe2kgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791609; c=relaxed/simple;
	bh=8ztjwrUUW8BTAt/db08W0OZ10oMSiILiZcJ6w1SLX9M=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZpSOQYyDSh07OkvnxCMmv74SPO3ptIDl2J6FQ/yVeDgYJK+sg650IY+aOv/QM+xz03UsEwxdqgw94vvn9hO1tYwLbi9QocNWZpqVjQVwTUVCmOKZRe08a3v7kFyGrkzw+xVaVILwmP2C4m5OiLey4Kn7vClg8zCm041JI1Y9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=QK+lR5nF; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=WvlJqNdZ; arc=none smtp.client-ip=104.245.209.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="QK+lR5nF";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="WvlJqNdZ"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=8ztjwrUUW8BTAt/db08W0OZ10oMSiILiZcJ6w1SLX9M=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1788791413; x=1789396213;
	b=QK+lR5nFv/WFVU6t0MoqYv8J9qubhwXPSikYLhDQt4Rpq6q0avflxBkaiNvo/OQYm+H6fnI8K
	S4t3Frtgo3Q1DrDKtUWHWULr4y4PjcFB2XEZU6D3e1mUqvDiw1LbBBQXG4ecK05uyE8sTU4Zpt6
	v4Eqxxrj792qD2kHSg3+9QSfRMsxq6Pgq8Rp5d7oyQQbvqdpEAG/PVnTlb1ICWRgUhRK/UjPMy1
	woIUx1jAVVtHMiKRMx0IMmcQwliLkEXTBo71DxwOMLQQy/8BseP8+Q7KggywxMz+VmTxzNOEqd0
	0B+SNxjv44GvWcftorqeBWntSzQ5bQAQYyl1yL7sUHLA==;
Received: from ip-172-26-13-158.us-east-2.compute.internal (172.26.13.158)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.241.1) 
  with ESMTP id a33acdbcaac811f1bd8e02456597af77 for <git@vger.kernel.org>;
  Mon, 7 Sep 2026 14:30:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1788791413; x=1788964213;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=8ztjwrUUW8BTAt/db08W0OZ10oMSiILiZcJ6w1SLX9M=;
	b=WvlJqNdZciFftAFo7/xr83Mffu8nF3G7ivwZLZsoREUxycQH/ahnNPaTH0JWYAu2DJOnuzzUAlq
	HCQSIdJPk4JNRhkiP0EHtV1AslWqWSAGGuEsuSrAZm0BwVToDSZssKe+cZbUB5z+efhyUnwa1ZDEk
	p4ZHM+Tw8YgRe+JYQdE=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Mon, 07 Sep 2026 14:30:13 +0000
Subject: Re: [PATCH v2 0/4] worktree: add lifecycle hooks
Message-Id: <b10f2706-67bb-4657-8d7c-819a29dff890@mtasv.net>
Reply-To: domen@cachix.org
To: Junio C Hamano <gitster@pobox.com>
Cc: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>, git@vger.kernel.org,
 Caleb White <cdwhite3@pm.me>, Phillip Wood <phillip.wood123@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 avarab@gmail.com, "Alexander G . Riccio" <test35965@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <8bd3a684-51a0-4a2a-b70d-3981cfe10e9a@mtasv.net>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net> <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net> <DKGE5DORETW5.1S9NXEX8KMQHH@pm.me> <xmqqtsp9tyu0.fsf@gitster.g> <8bd3a684-51a0-4a2a-b70d-3981cfe10e9a@mtasv.net>
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: b10f2706-67bb-4657-8d7c-819a29dff890
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.HHt25oooLz-n9jxDa2GHog.euH_wPgFrA6X0tbnuCb4fCFS08nvEUSQ513wR6ka2Qfo35o0TEAeDWZD773UpURtRIcTvKeV3kHD1QnNiQWMIYkV5yA52WPLW3jCOp78JV1-gTQEhvS1oCmPGZsKCpQ-FwR9n6wgyzjg8H26jwjk94owUdN15YjE0c8fpxusq32RvDW6MuAe9-ySUs5R4cVa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: ord-104-245-209-200
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio and everyone,

A gentle ping on the single "post-worktree" hook proposal below.

As coding agents increasingly create and discard worktrees, reliable
lifecycle notifications matter more because tools managing environments
and cleanup cannot control every caller invoking Git.

Would this interface address your concerns? I'm happy to prepare v3 if
we can agree on the direction.

Thanks,
Domen
