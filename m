Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055919CD13
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748853516; cv=none; b=kPEOpe4g9xm5mUZ8yxH5Cz6cyOIsabq+Jk6ePPAsVUFuvmGZBzD+xYVCPUm3UOinepbtpHdNn/zT246Wbs+sKtyzJ/RAXGKa5jTCbyQExmS3do4F4Y8MpYZBBkI+65te9ZVRpvysN7JXegkQ53BCtR8uJr5T/QJAPBmcC7EJTWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748853516; c=relaxed/simple;
	bh=1hdglX8PofH3LXGTOkGgli8PjHZBydAzVHrCK8uOmCA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MIf8sTTkNqsnjVo6sHwVQnsJNCxcaqvvCksjZNDsIPVTsJMMm4EQyc2ijz1+GkI8f1/y1O5MP+78VYUmAa4eDwZaM5zI+L8LJUbDmOWkMibdQpkHlzVy0t+nU6R4b1ZrfoHsWMhSRRKCPgQIlSiTz1Gf2nsaS4j3KrK9WLbuVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Bhg5NU5D; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Bhg5NU5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1748853509; x=1749458309;
	i=johannes.schindelin@gmx.de;
	bh=1hdglX8PofH3LXGTOkGgli8PjHZBydAzVHrCK8uOmCA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bhg5NU5Du7AWnPYMUW7ZyaCaQ9vmukAkn9CHPdo80gAz3lg8D3YMNIISRcdtk+9m
	 q3IZl0IO5pAnf7Vcst6/5tW1yZKbNA7IlV/DT7XSwNEfPA/wh59ChgVFTVJuXW2+S
	 ExramEra1smT9GhUadWamCuSgE3g2dKjZRLOoZQrH5H1fFnUffvJGhkc5GJ0ftOHe
	 z4JFDZJPGvvseGffG2n6UN3uvOb3iuke8C6YwlIxhZACoAssufEURSwtxiyLf0n4T
	 LFqjH/MB8iMAmerEtAV7/Zeaa8wfZxKKLkkTMRF/blqL+cjg6SPx7THFhFaXfkgPY
	 hsD6SW0fiRh+1OAlIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.83]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1v5Tju0kLH-00siJX; Mon, 02
 Jun 2025 10:38:29 +0200
Date: Mon, 2 Jun 2025 10:38:27 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] contrib/buildsystems: drop support for building
 .vcproj/.vcxproj files
In-Reply-To: <1ec2a4bb1d58ea8cfa6abb2a0e625ef3e0db2a1f.1746430790.git.gitgitgadget@gmail.com>
Message-ID: <c3273a46-aab4-8dda-1634-9de233290f55@gmx.de>
References: <pull.1916.git.1746430790.gitgitgadget@gmail.com> <1ec2a4bb1d58ea8cfa6abb2a0e625ef3e0db2a1f.1746430790.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j4TBpkOvUZF0bj+LPHKXWKT2q8WauDoTU3N7g9c0nhpG8yN5ECs
 LRjOo7j2p1C8saAoHKC4FlFtApuWwoAXzt+9IKPTFK372aCNcOPZQt5Ja6JqNS+OFyaXzjR
 mk5fuLgppmuWe8KXrfU5PGu7E6gwfPM0hCUQaYQPb5HN8C3GTPMDhelBp4j614YkERUqy0l
 MjsEQNCqXIDS5b6VUDzkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xPM/b8Pp698=;YQMF2vRBaDBlM85QVI6WAtLuOYL
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 5 May 2025, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> Before we had CMake support, the only way to build Git in Visual Studio
> was via this hacky `generate` script.
>=20
> For a while I tried to fix whenever things got broken, in particular to
> allow building confidence in embargoed releases by running the CI builds
> in Azure Pipelines in a private Azure DevOps project. I even carried the
> patches in Git for Windows with the intention of upstreaming them,
> eventually.
>=20
> However, it is a lot of work with too little benefit. CMake is much
> better supported by Visual Studio. So let's drop this hacky script (plus
> support code).

I just noticed that you applied this patch as dc5e178f608f
(contrib/buildsystems: drop support for building . vcproj/.vcxproj files,
2025-05-05). Notice the incorrect space between "." and "vcproj". Any idea
where that came from?

Ciao,
Johannes
