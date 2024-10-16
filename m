Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813B18786A
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097494; cv=none; b=tgodwsFwQgvi5+Ea0Ad9SaRTkpw+y+0mvUrJNHCcdkXCUcJAX7/hf56jG1lTNPq4uIyrY1yIEI3j1l/ivT+iTM+VLF+zhmXHQABQcmq4nqF0eGUm3wWGgfukfZRXe/cFzXMgcTwrWfougYdVLlfBrwXOzkSMbM+JLn3lG/OSDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097494; c=relaxed/simple;
	bh=eI19lRTcbldBaW9Q/7+19jpZEfUmZmavfvvl1zjfM8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6WaRjvu30gRBtQ3XHn5X6sEzGBa9G1uDgrT3PuWX21DTlSz0TyuMOIlI+6vFdM9Vn8gk0ZSydtbUDfWRHwltl+Ig2rZGPWRhYWaIEfuauhr75Efmcp7SPVkOET4BXHZCNOnaCZYt4Gm/bN5247YI+I+5ARSm1rG93aJGQb7p8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=N3H1Irfa; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="N3H1Irfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729097485; x=1729702285; i=tboegi@web.de;
	bh=eI19lRTcbldBaW9Q/7+19jpZEfUmZmavfvvl1zjfM8Q=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N3H1Irfa/4Pb71EvudCEmVWj4glV20O5IVcsmx3h2OV1YaxFGL53SaKAD9DGX6le
	 iNMtymMX4qmN5voUVNDsLy+PSED3ScN2vl9ivnPmT8ZcpZnWXr/0dKdss2q1QTrKq
	 n78NYnSXYu8ULj41kAI3mgQ1DOTyzDW/ptsy/Hg8BknnuC6ix2FvLRxJfxprRUhVo
	 k0VLlHThTk9FD0Vldar6InoDDC4ntHmwqiPY3J5Wu4pivOAzdD3SCxdWbtYiA/iI/
	 oWTlaThQZ5ehm9Q9SirsxnvVDToY6ntMKczvAMgAhikHpCfim/nDFe+/jX55ra+t4
	 j8QFxmXCv8znLPaLEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsrdM-1tpUyD1A6q-00tFGG; Wed, 16
 Oct 2024 18:51:25 +0200
Date: Wed, 16 Oct 2024 18:51:24 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?iso-8859-1?Q?S=F6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [PATCH v4] mingw.c: Fix complier warnings for a 64 bit msvc
Message-ID: <20241016165124.GA32387@tb-raspi4>
References: <20241010191939.GA17171@tb-raspi4>
 <20241012062243.3350-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241012062243.3350-1-soekkle@freenet.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:xKpGDJZuAuBZdKC1CByvIw/CRZc5/qWWz9XVWWLmQr5rg5siE55
 BONEThHy0RP6w1NGYQT4QAO1huXivMux+cSymIsvE0xbQgFaj/j+NXTMFkgwPvqLFbLEVL7
 vA+5KG+hl6/E7LgYQ83mnnFIgaLG4wMg/isYJ7ZYzOPHSbMq/9OQyAVsTJquhwnpXGe/rcX
 UY9EGVl6LTRa+2evGAlQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0T49fj66Ds4=;Nvn8+s4PWcjCqLMMm1VqsXoqNYD
 cg1xslV0I4hxGFjVXnbfXVwDcHYD7ensX5HM6OonearZevF+AGT+pZwq5+OO33hfw9JvkCbPk
 gX+xnSw5zWTgWL2+1wVraWeTAOvHA13Ktlzc5ZC3bC2X6sp/jI/Gv0smVApnxIq3zg5dy8yDx
 Kzo9XtASNiJiZ7QUxsrGYqH7+BqJrA5aZ2h283n7LY5TP/M0Zs1BP9FPggmv1eTntohYqT85p
 3lL8rAmldUvMdjJVrX94H8GS4AHmrwFzLWIvAIvKSf/7btfdsErYR7LoUMhATrNgP82RqXDoz
 dXksFI4dddCIiJsf8BkfXwxRNd4D0IbL65mk8ylC+EjDbOUebOjIM2x7O62eM6qyGobk2I0jI
 pL+2ANXkahEPNST4yL+QlpkMmGe/khXkEwu1x3zDOCvPxCcDKG46aVvAnPWiiSjwUD/ggbJ8f
 X/AqwtQr+r3FGw5byWErEFXZ57acSHfVqKViVCpHtAnQH+4KOBCFaOlI1BbgcWgigsatM/V2t
 U3MRFszieqr/cdlFF5oZYDvfweNHLzPJ3u1KntMTkfu5ctusqK4pDPEXa5yAFAzLK6AtfTv0F
 Dm9ANpXAPuWSeXSQjrkNWqeJb3u/0T18x1xW+dtJZ+g6Uzw2N6nCqnc2Fc3aNtZZ0xZ9ypUIu
 WdK/6LjsLyUYTiOJ/42U4L7Yjcn7k97IoaanNVRfx7I+roYvXuORAiwzIUDV31EFABgNFwEHw
 ECXY5CN3EwkRkSNvL7iEMY2n0RVhEKqNMUdra3bshQu76uNI0m9eUZreBOW3uI/33ZuHo0Jsk
 wLWthNHEoIAWL73gEbmYc5SQ==

On Sat, Oct 12, 2024 at 08:22:43AM +0200, S=F6ren Krecker wrote:
> Remove some complier warnings from msvc in compat/mingw.c for value
> truncation from 64 bit to 32 bit integers.

This looks good to me.
