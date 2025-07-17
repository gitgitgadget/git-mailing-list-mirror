Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB811F30CC
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770715; cv=none; b=qEeyR2m26bAAxiA5SaBspQMX8i0I0gH9XHW8nxoWBhrwCFVqMxOBI0/3OlsLrhCfUQrXNW8idKSz7slkg1KoaoY+QdBHLtVsQIrR3dCZheWdVPSxDboHQC3IPHm5rojHd6IXNri37mr9mpeyCYhQL1z18Emx3VPwf+V9/NZ8Euk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770715; c=relaxed/simple;
	bh=IzKfVjltfctfg/kfVleu12Z3TevnZB7z1vQU3es3BrA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WPE6JiAsG3sO3fjznqbymB2tBT0yQHmzWGTYEfeHejodJVX1TiJnx45sV88IqMismdafWoRaEY1A6YQ0uZBAzdcts7rdzRJW66KMHuS2kg2HD/AqiEJXWzI/qNEikoFJK6IguU3dMmi4o88cjFKFnUMrqvQYvji+bbW6gWbbPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=czvcshlT; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="czvcshlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752770711; x=1753375511;
	i=johannes.schindelin@gmx.de;
	bh=IzKfVjltfctfg/kfVleu12Z3TevnZB7z1vQU3es3BrA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=czvcshlT50LPLCcUul20CFfrfqjaIMbXP8mRnR1ku/qwecsBLHWOP0dAP8DE4cMb
	 d6cwWWuGbrVyrXRkaSI1tQVjUf0BspFwoPmsIupaO7luWKnQGVQJMI+NvL6n6r4im
	 AQWXHria2vZqMO/ruKYnKls1TFJKGnX/HuEXe3vjZQV9A1OFxmZt/m8SfdA1a3PqC
	 HB7UyFmYvSB73mdeijTiF5zzcC4TDiQ3FgHlynewJTgSxsu1vNOON7Ikcegnvbqv+
	 DgZrazSGd6byoE1tTF058sjQPq4Hg1rC5GjTeRan+8i9hfS0t9KYAmjUeAoro0kHW
	 Hq3dj1ekaVB5kS2Iag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1uN1Oo3ntw-003CuP; Thu, 17
 Jul 2025 18:45:10 +0200
Date: Thu, 17 Jul 2025 18:45:09 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Initialize a few uninitialized variables
In-Reply-To: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
Message-ID: <819d0360-5e99-b2ac-5bc3-50bf9bf95662@gmx.de>
References: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UCKBh6Ha4jbuuADu9zQhoBcICZydSrwzUdkWcReVG+VOqDbBBj9
 3paANVT9BsgpalBiU1Ympk7nvuEhAbcAB6H4MYdhcF+8tEAVAaYPmOglQEAs0+uv1SRzYvt
 lxoNOM0XR1lxDS9X9fVcJpzbDM7+Hnd+ABSejQCEleABMOsq1PBwYJup7AEGw/XrBHU6wv/
 khJgHuResRSIHNhMGIcuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eKPDy1pfV0Q=;LHaNRh7nItZT/bf2anxHpwAI9EQ
 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

Hi,

On Thu, 27 Mar 2025, Johannes Schindelin via GitGitGadget wrote:

> When I ran CodeQL on Git's source code, it said that that variables might be
> uninitialized in a few places.

For the record, I am abandoning my efforts to upstream this. I was never
interested in the actual changes, I was interested in getting CodeQL to
run on Git's code base without reporting false positives, so that I could
compare the quality of the reports against Coverity's. Therefore, I was
not really prepared to polish these patches as if they were something
important: They are not, and I cannot justify spending any more time on
these patches. I will carry them as-are in microsoft/git, under the label
'uninitialized-variables', as long as they apply without major merge
conflict headaches.

Ciao,
Johannes
