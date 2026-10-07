Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98354379EE0
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405895; cv=none; b=Npu++ewep9UNLnDrnCOU0edoeqGvQocs+GS0FhBxZ5RvpwlGQxuru2kmq0h5t3XvQlchciqtNE5EM0WfltQG+9NGAw5fcKQyfxkC9j7/MikmgEiR2Ms2NzuYLFpBqWeBiKSHzdSswWS83GRAfqKn0qN5n3/QmcQvh2aX8VRFrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405895; c=relaxed/simple;
	bh=KDxyqFPlnSmrfg4LiMz/gbuoTR3uGfCCbHFTtfr6c1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtiIApwq0XuDPkl1KuGo2vf27FOPUIQn5X8DNiDaMWW1dtPrxqXjoGj+IGTuPr8ZiqkvZv5QHpcPTavgZkdSuQbFOGCtukMhBO/81RZ1TFYPoexNleVcX8sebI2CBBVhT7Mzd5fphLXgWOJG0OS9fzEIB+DtZCrYrM2oh6QKfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=gSruUSch; arc=none smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="gSruUSch"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D9720160FDD;
	Wed, 07 Oct 2026 20:26:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (100-96-11-196.trex-nlb.outbound.svc.cluster.local [100.96.11.196])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8F074162AD8;
	Wed, 07 Oct 2026 20:26:32 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Share: 2941735a2282b5c1_1791404792725_880058077
X-MC-Loop-Signature: 1791404792725:2863480831
X-MC-Ingress-Time: 1791404792725
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.11.196 (trex/8.0.2);
	Wed, 07 Oct 2026 20:26:32 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4j0Pm73KdTz2S;
	Wed,  7 Oct 2026 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1791404791;
	bh=xt75cXG7eCxXnQKLUCMN25fxI+1nx3cHqJTl/9m/MQI=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=gSruUSchuMDbyu3XWXPbWfadh53Mmf7K8yeCkJ8uXRCno5scMC5jMg8G27cBgISPn
	 MEpa1iuanZafQ7nycA2VzfJL/x7uecgZcdOCBVKNksWQ6W4hYJTO+sV9Q5hH2PLtRp
	 xgTfb6c5lbnOlRaK6zwkkV04RIgXvcMf18ckG6MdRgjIIjJ36ilsFB4oNwI2Qu98xF
	 M/QVPs4dGZudAy5QLoRCOzHYOpTZK+nd9yi/h2Ha7PQlQbCf8+HOPQcaAnhpvmiHmo
	 31XghFuHkujENhlnKnF9rNiKdRsOAqfm/qTEdoTbmObeMh8Tvd4IZ9F5uT/SscHybk
	 mFBWuxaQeWPCQ==
Date: Wed, 7 Oct 2026 15:26:28 -0500
From: Nico Williams <nico@cryptonector.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Luca Di Carlo <luca@dicarlo.email>, git@vger.kernel.org
Subject: Re: git non-intrusive clone
Message-ID: <asaq9MaTvtuFyrpm@ubby>
References: <e30c5b13-5ca3-43d1-a87a-d807b71bad7b@app.fastmail.com>
 <CALnO6CCTbWLn2rO9ASr+5K07vqkaWCx+H8NsCxaAMgHUYR=z5g@mail.gmail.com>
 <d6dc70f6-f155-4a5a-b647-ac24b2b1ed37@app.fastmail.com>
 <CALnO6CA5tY5Ebw5JyA8c-e00PqLcXMAijA5VF6DrPJNDCX=raA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CA5tY5Ebw5JyA8c-e00PqLcXMAijA5VF6DrPJNDCX=raA@mail.gmail.com>

On Wed, Oct 07, 2026 at 03:50:43PM -0400, D. Ben Knoble wrote:
> Still, definitely worth having the conversation, and I'm glad we
> figured it out together. I'm still somewhat interested in what we can
> do besides "try to tell folks not to blindly trust downloaded files"…
> but that's never going to stop being bad advice :)

There have been horror stories about phishing via fake interviews.
There is no easy way to ascertain the trustworthiness of such code.
Just don't run that code.  Use a hosted VM service for this or insist
that they use a code pad type web application -- that they don't use
those is a red flag.

Nico
-- 
