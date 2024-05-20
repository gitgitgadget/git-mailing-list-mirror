Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C057DDDA
	for <git@vger.kernel.org>; Mon, 20 May 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224861; cv=none; b=mcu3l/d2yNkZXCOFSj2LsOMYCP/tcK1/UiWw5FCZevH0lUVYBV4SpYbqvBOaMhEefaiW0sf6Z4KiLg5r7+tPV4hetDF9V69a301IScMe7qNY7t4312LRL6y1lsRWt0p9xAoTaDfN6vhXywv6bMfOV2c+2igXXUmn04MTE72BBfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224861; c=relaxed/simple;
	bh=GgI8ySE0MkYfwMVMs/leAK/f35zsg4BI3kDHwIMTZHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgA5a/O1rTi+QYjN2CwfK/hibB2fslf1qWehtVoCBDBqYaCuLsGBodJ9i56bm/OaLJv3aIDX8GSvQ78aFWtlTP51G0hzb7SJL6fGEhi/xM/GDGXlWtvbS3tqE6ekt4aGan+qDZPgKP1GAXszIJ/JA2q7OwyZZDvGGzH2lYoTSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=haMRbMOd; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="haMRbMOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716224843; x=1716829643; i=l.s.r@web.de;
	bh=bJmluayiUlkWDe8/6+SB8w3LEaroTpEIvus+WCa7G9E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=haMRbMOdfSf+5eQnENnVv/P0jUdR8NxZ/QWn0pPHfn0zLxahxf0hYvsykVcSYVM0
	 ZkcuxhzmWy+w9likW65vyAjxCZOBOT6FOHR8rlbuhI6OzPcPGP+bKenmHnNTqcBLN
	 sAOjFHuolr5DG1kaumtN2M6350K620POXEwIF7Sjfk1m+aOsMu6SF5sdUdkjPPsai
	 Fd9c5L2EvuEY5GjS85zWbEpCsglSC1NJ+Bly9APeBA7XnPFNLq93m6unfwoEZvJaU
	 dJlVGRQpx5no81MWBOUG0Qn876UegQrZenB0jRWEr4mJxF1ScTG/rYkqydK3yVBUR
	 M5jBTA/4ZkEY26LVZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxpiO-1sTPaX0JZO-012ZOB; Mon, 20
 May 2024 19:07:23 +0200
Message-ID: <01b21870-b37e-47fe-9bd7-225499ae5eaf@web.de>
Date: Mon, 20 May 2024 19:07:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] archive: make --add-virtual-file honor --prefix
To: Tom Scogland <scogland1@llnl.gov>
Cc: Tom Scogland via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
 <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
 <bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
 <95B94723-BCBF-48B4-A02C-A5C61FB060DA@llnl.gov>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <95B94723-BCBF-48B4-A02C-A5C61FB060DA@llnl.gov>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7j81duCsCeTA97WG2RLQEsrtZYqoLzdbFQ2bfkiSkLpA9NkfD5u
 13UeHn3mqew6+QOFRniH3m1Esny+n9JFZTrJo2ZZPfVUfORS+V7bVwLdNStR9onKVI6gijO
 wsE50OAe+8B2sixqxCpJ/NXE5VutlzQTO/NDavjVXwpGJhyj4W6SrCoAzOSDnaGhK7+RQdM
 EkUHLTB5lzqw+4d2IdAXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o1bS9o3jtfU=;7YcTk7yZaykAv8k7A/zw+aiYBH6
 peO4zDSLJntLsNzgwmLukq/VTtBdSx9E3eXtgWSjlRKltbe2YVK5CCYiDJSgDBvedIZrgSK7m
 Kmxalk0pQtlb32mJMkeLfNUZDknCgq8wMKzoCWgi8942FtTi8bc3LYvcEXfaIgho8+dT82t52
 tLwOUz5kkSOPOHmb5H1ctqvD23A4j+RF23N6Wd22Nyv6KMFPVP26H38MwhI557mbwSUmM7CSi
 rTe4KqMdZHrofwlUpiSlw75zG/1fwHZPLD5bf+RGGBqXhWl5E0Bm01nRhcUdXVXcLhPPUgRbG
 dQ5W84dYsE26e3dNafBH1Y3fot9/HwuN764iWu+SdnaIFTnm7kKUPfvZS9WrViQLair9D4PBd
 JY5Lhb+4yLOoYhEgeKooKzPqpMWM3MX41voBMLZEyrxVYnzMOTr+01S8bb1cvGiSw2nDe6CQ7
 Vd6G0PR8oxMh2qV5oTjMkGmqGlJ4vKkw7Xh6qRHoycEpLYCToTeGSDG1xb6aVVV5RzUzaNE0z
 j41CPpdZNX6nbzC3MUFRg/zfhgT+bYZ8FDawLhU1fpK4yWceO0wv9Ou3CrCjO37amxX0WwdC/
 hl7xTp+buOcJ322UiOJWEHOsRsd2wd1mQ4BJxMvceyl5ONqMJm8zQn2jGQJ+Whuqo4lsJmyrR
 25c2Oho434MHHOBMbROW5TqO8zJbsw2ApRybVI9b32JaTwxLRk/8DArhVT7TNsOUdS6ELyQ12
 QiIzgrLlwaCrQ/wPsfFhUfYdbaMQIKP2IWYB6Bz8r0XqwSaGjemRNrGchDzeEt8PQ53+xIXu1
 Mg8hAMkMt7C4JqvVuNv23JSQ5xId0h62JDjtUgRwagfBQ=

Am 20.05.24 um 18:10 schrieb Tom Scogland:
>
> On 19 May 2024, at 6:25, Ren=C3=A9 Scharfe wrote:
>
>> You can already specify any path you want with --add-virtual-file.
>> What's the advantage of honoring --prefix as well?
>
> I came into this after trying to translate an --add-file to an
> --add-virtual-file and being surprised that the prefix wasn't
> applied.

Understandable, the documentation promised otherwise and the options
have very similar names.

> anything else you add, in the repo or not, it gets the prefix.> I can go=
 back and explicitly add the prefix, but it makes the
> options less naturally composable in my opinion.

True, applying the prefix to all items would be simpler overall.

Speaking of simpler: --add-virtual-file could have been implemented to
only take a single argument -- the content -- and rely on --prefix to
provide the full path.  That's more consistent with other options, as
most of them only take single-valued arguments (or none). :]

> That said, it sounds like both you and Junio prefer updating the docs
> rather than the code, which makes me think I'm in the minority in
> that opinion.

I'm not sure I have an opinion on that topic, yet.  Fixing the
documentation is certainly easier.  Adding the prefix to the path of
virtual files as well is a breaking change.  I feel that the easier
route should at least be mentioned in the commit message and why it
was not taken.

> If that's the case, I can certainly update the docs, and I imagine we
> can backport that easily wherever it makes sense.  I would really
> like to have the option to have the prefix apply though, either
> adding a new flag or an option to the existing one that would be
> invalid given current syntax or similar to provide the option.
You mean like replacing a leading colon in the path with the prefix?

Ren=C3=A9
