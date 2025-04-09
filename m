Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37EA1C5F18
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227097; cv=pass; b=MuASfcq9BD4UpuglDPEVtAbBGMr5Ht41qWQSTKtEnJeXc1D7dlcaPZCSslSNtRmV0EZEly3LmoKcB+xwluyFzDLtT2oh8771mZ4qXVolUiFM5uIubbaLNMZGIQcpSscY7BaWv0sPyn9Zbd7J+UBhjrVG+2/lsdl+JwOtNrk86Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227097; c=relaxed/simple;
	bh=pqDjEUltLNDS9dF4+3wvIQ6rc+RpBLMntDZ5J9vaPPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP1CDKMucva5jm0tVfISgFCanMPiZjA+rpetutK9f2gxQQZShRz7cQrZD0oNVXRoFkITGiMRDn7o1/ow3P2p+8cEF5rVy5m0GfZF08O3/j0DLJ/IQAFK3i97U7d5s9UW5o1a/bHdgv16xTcSvCPJMKxBPGZeLGOt+R6e/LHOP2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=bjfcAJqA; arc=pass smtp.client-ip=23.83.212.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="bjfcAJqA"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DB2252C440B;
	Wed,  9 Apr 2025 19:31:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.97.44.91])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 517B62C439C;
	Wed,  9 Apr 2025 19:31:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744227094; a=rsa-sha256;
	cv=none;
	b=MO1+QdzfnOJckfTxZainRhdgqL3n6qSg4bOfkCLPJTF/v+SJebELMwMoJ+ENGIS70WHQge
	wk65V59DZyVgan1oof++G1Pvgy7z+MFjkkBowSZDx+J25/moFvjSYrr2BiSMXFXQXrwmbn
	w++VwB4PyBS1sRi6ucz2s91WVjEngwkbZy3sqMphMfVTQCN2v6/ZsY1l2jVYCPmICg+JIL
	SVS1tAzyMm/0o3LD98Hjphp9AalWj0/oBfLupA1k7/R0BCzs2eiwQ+m/KmJIUGF3jdTcEF
	ZLTBd8qmT9iYkYL8S71kUbk1g7jibaiCgEPYpI15qWvf971SwzFTKWMF2LYa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744227094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hS9UNOmJdyn6gOIjKSk5SgOUUVeOej/jaOl/czblJo4=;
	b=5y2znV4bZ9jSXlU2bgFykP4ogrjqxLkGle1NrOqwC/yo+dGCOhi0oa8loDIH8cnxf4MbX0
	p0kqdcbv9KkFMtFfhcSOQjWY2XuM8B8FhhdavJvlZ7DbAEw/1O2lnVwKzoixNq2Dgu1gON
	JadbS11k7jko58z3QZ/NX4KP0rAimbslbSSWLx4PJZLipqm1YlPp+X0VP1k3d5u6Lr2+O+
	EhfzkUPa51xHNNJyqoAhXhAER17pc5+klNO4wAnlYNKHTmKgI/wQe8Hh/FVvzXJGqYIdu8
	1eu4djwP48wvpxEKk79yOriBmlwSJMSdZV/0JHmfAgZUHB58U4aEIKAnyvxW1g==
ARC-Authentication-Results: i=1;
	rspamd-6c89d5bdcb-tc69x;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Lettuce: 1d408af107cf0e46_1744227094749_1009804327
X-MC-Loop-Signature: 1744227094749:3070339915
X-MC-Ingress-Time: 1744227094749
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.44.91 (trex/7.0.3);
	Wed, 09 Apr 2025 19:31:34 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4ZXtNj19d7zR3;
	Wed,  9 Apr 2025 12:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1744227094;
	bh=hS9UNOmJdyn6gOIjKSk5SgOUUVeOej/jaOl/czblJo4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=bjfcAJqApxFiniuUVePUV6E6xqe6/MqDle0Bxqe9T9U4Mxgxx1tKQ6sjlonwjQna7
	 YqAACb2V0jzrw9aKR6KVSZ3l84jqm8gv0aCW8vmYx0Cbj1APPgID/PgJA8Svg71gTo
	 j2Ymx+IdGqc3NDshwcpB5ouiZM9pNYlbetawKY6fwGsARrGHfv7TskreF6t/sajcWi
	 +IYeyhnRvEM+d5h5GbA2pgpYbDabIf/w7p58sDGnXVlucvQlQ6vVk6DCBz0XaDojye
	 MbeZp/RxPUSARSeeQkh2jFh4LgJ4GxNEtAb+i+fcggBl9lGdnWEhFYIK6k0u2V/JgC
	 KU9rTG4LJnNoA==
Date: Wed, 9 Apr 2025 14:31:30 -0500
From: Nico Williams <nico@cryptonector.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Ts'o <tytso@mit.edu>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <Z/bLEtQRUYEIzSne@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
 <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <xmqqv7rdqkla.fsf@gitster.g>
 <Z/a+AVopz+HLa1eL@ubby>
 <CAPig+cSN97oyYbF=mRijbgxUtED2q=u2PFAV+gPP3qM6Vm0OPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSN97oyYbF=mRijbgxUtED2q=u2PFAV+gPP3qM6Vm0OPg@mail.gmail.com>

On Wed, Apr 09, 2025 at 03:14:46PM -0400, Eric Sunshine wrote:
> Contrary to your suspicion, what Junio describes above was a conscious
> and deliberate design decision by Linus[*].

Fair enough.  Please look past that.

Nico
-- 
