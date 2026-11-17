Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933429;
	b=a+zg980tHG8vEr+WbMMHNpzKSie3/AXH3dohwGNcGWYwEH73q1Tg/RnnusQbYY7rctxU
	 Yt/3KSbQG5Bh3kdcSSjmATaaJXAc+QDgun+S1E8BSmrvtn7ZIf/bwjE9eU1mpeL8m7JcX
	 fNI1Kmb/+Uy95KG57SvRcqm79uRy+dxJsuoz87r2javgQ8OY7MiCh2G0VJjPYJkuQXb9r
	 six37CrcGIKuxfuTBjcHl/niqx7GzCG9et3BJJTF2XVrf9rIZUPwKvJmo+SdbHq0z7gj0
	 lE4Zc9PYn7+h4B0O4XZVqY59ZW1LCd6+UB4b7/oOUho0IWbvxYU8OEwakI6YxCRy6/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933429;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=57Tkr3GehHjVRUC9yEcRk3EB7otxvOge2aC1EP1Dal4=;
	b=zz55FBbb/ydhotYSoZ80OQWyi5b0sE9iEmvnH/AeSon+5dvlT6g6gjr/a048w8VyCTP7
	 aqu/abLj7TFNMNYdbGEsBLx0iy+Jghh575a3n/gLbg1c7D9cDrvX7Ba30knYSpCu9+Et5
	 j9A+qQyBBaFxhVwgGtIwe+l+9J9OEOppZRQ99GfY+bvVvU9ArNhDVtMVy+YHckB4hmXti
	 ISpGFeFhfIOJ8jqMMqJA3khmFMNCQoVuP3ezNEXhOmCuKOQF1W3D8Dxfep0uFMphd63px
	 kZ38gglAvBQPAj/G0g0ObL5E8VTPGY+oZ9fBfOH1NMMGz+wstiMlhkYh7YtkvYs5jkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=c+CsWrdG;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB20606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 16:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EB20606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=c+CsWrdG
DKIM2-Signature:  i=1; m=1; t=1794933419;
 mf=PHRib2VnaUB3ZWIuZGU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:MYVeB1KPg4UTZ9pkBer1m8WBPKra
   xLoVXFzWws7lvFoeuUfG5CT9abaex0lk8rKdsRqlMQfK5Yasylx6DIg8KzDOFOL5eagTarc98Ye
   5Yy/aIeF3v1WOoO1PppQ9Vj4qKazyzc6VCTHNhJhGS342qkyUaovY91Wb5ZAgwzbN5XMSnqTB/r
   ApXloLmSXeQ8FyXn8WHtsccOQCVggYZMQRXjJp4itXn+COWAvcBB8bPBtxobYrFofuSj14/rXqL
   /e1+eSvKQ0e3JaDmXtYXp0WE5v/oOM0uCnvAv/g8DDeUSLNNNzsYHm9GElPRdZ0DCFVaBm+nJwQ
   tlQiJrtyxiZrsw==;
Message-Instance:  m=1;
 h=sha256:
   iOcoMUbhEiP6yB0OcL+Q0nP8p00J93wedqjl0GAkTEw=:
   57Tkr3GehHjVRUC9yEcRk3EB7otxvOge2aC1EP1Dal4=,
  sha512:
   lZA6GNix14mrwsSsBXtAAaVN210Cf9ANp4QCw0nQgzsLrB2TaJ2/1rOqyGJyuV3IZyaFrXvON82W1Q0MCGIcWg==:
   SSAA8YETsMVVla4ycBO45xuKKSgsYwzmjcPoryhELV/GBX7ycToeZBTgZX7XRi7aIwli+K21dWmqSYx2ryaEdg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794933419; x=1795538219; i=tboegi@web.de;
	bh=57Tkr3GehHjVRUC9yEcRk3EB7otxvOge2aC1EP1Dal4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c+CsWrdGywy3uMfvEXI1deMJnV4OTpPL+39gHNbZdmOixbiwfP82fU9Up4YcUrQq
	 DSsHUK7Q67vF3XxgvWMnxqPXg1nAg5Bxht2tCyZhOzGQjDSsX0R3j8FRL4Kpo9hic
	 CrnNOL4WNVlGT1MWw7zse3CJrsUgJP/psMEcbTHqd+qCfNRJy2PlXtVe85yQi5Iy7
	 rFmIAZB2zJe4lhrb/1Nt6dsuSuyjdzhtg6LX3tNmKHpBF4BBTKrQkP9vefj+ub4g7
	 qvyDYuUelV3zMqG6rTOS9pyNgbpAf+3a4MSc9/Ej8iD7tg4jx7+JL5LQQF5kxmYYf
	 WbOIYLQyIbXvTmouIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1u6d-1wRoJu27OD-012hvm; Tue, 17
 Nov 2026 17:36:59 +0100
Date: Tue, 17 Nov 2026 17:36:58 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Alexander Meshcheryakov <alexander.s.m@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/4] diff: use uintmax_t for diffstat totals and graph
 scaling
Message-ID: <20261117163658.GA17353@tb-raspi4>
References: <cover.1793546752.git.gitter.spiros@gmail.com>
 <cover.1794909894.git.gitter.spiros@gmail.com>
 <692c503e97d9841def6e0429ef52a963ab93eec0.1794909894.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692c503e97d9841def6e0429ef52a963ab93eec0.1794909894.git.gitter.spiros@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:CaTGv1fNmOINwYH+GUrFEqh/v5v7noFJyc7wmwc4FAXWWfhY59F
 Dvg3iPT9JSUhpFJVYSO97kTm7xJQonxQh2OdfU/DdqXbFmAxBEBUATB8fEwTsjOGmsgqnuk
 733pX0Ak0jEhM/PKE530wkELuycGdmwdwLVE4bIz3qkOQOTBgjArhIcwmM5YhnPW+X2HS2s
 5fnAoXzweKKrTMc7k6DaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s26paflX8kg=;eVIWtmmW1k58jXV90Tcd5+KYa8X
 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

Looks good to me.
Test case passed under MacOs.
