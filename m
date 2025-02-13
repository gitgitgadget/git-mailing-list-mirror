Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6695B201025
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464841; cv=none; b=Ci0H9F6EBNfIzZJ09Q7JRPQ6mX3J1g+rHsWLUX1fAx+yC5VwEjzG18HtB+LpMDq/d6Q/f+Z5GDUJyDtvs0PCpnEzOgHsSvHnGULz7iqd660s3sFO0DMkTCBKqtqRfgrrVZrVXampC112nNzxT1UCGiDfa4XLnng308Zz+jr+t84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464841; c=relaxed/simple;
	bh=besKhs+pxRiY08HWsLjzW3Xozq4E3IMEJmNCRvqoS+g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NStDvqOKt0sPSC518RJCZ5klH2rjZ7+EOLpwuSSwm3TVagLmQ4qbLqTDA6U7jR/12lBRjR41VoHARqwRGS4FZBlUkUGJp0ElTgUqRxM4OeFOx70hgL3BPEl6cF7V8/OOIA1U8ivoxYuw3UzhH+W0Gqdi04vB4hRIMHaOkl8iHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=RW2XXLa9; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="RW2XXLa9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739464836; x=1740069636; i=tboegi@web.de;
	bh=gQW3TIhwSbMMOf4QiBdhxW76n2Ob2XglYVL2QhI+Owk=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RW2XXLa9ADWI8WuXTGlo0yyyxjEg4BmqsRtjGvtctYxSiBhlVyGYm59R2+9egcOW
	 Kdz30VV1BlfeoS1GFC5XV5Tx0dBIBC0yiGnfmj9AV0iYqj53DpDUDywiv8l5Jnojv
	 LcDdQijFnczlKIGHUcI69SV329rCCQDHkaZvuNeH3MzubqZWAoNjvO4sPvtADmeVq
	 l1F5Fsyz6HExP+J0d3gvBTRgAwL+FWfqirw3MAMe17FMMBeA/ecNUqGhwo0hDOwQm
	 hjGqo4S4pAr+g2yAAbm73NEzEg3jUwsOraCKCfcE3DrplkQqYRoZwgQzWLs2W+eZy
	 C/THtOD7dqCtdDuG6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSBQ-1tuDwY0Svu-00YkIo; Thu, 13
 Feb 2025 17:40:36 +0100
Date: Thu, 13 Feb 2025 17:40:35 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Subject: Re: Collisions while cloning (was: Re: renormalize histroy with
 smudge/clean-filter, again)
Message-ID: <20250213164035.GA24612@tb-raspi4>
References: <20250205214726.GA30202@raven.inka.de>
 <20250211235707.GQ30202@raven.inka.de>
 <20250213113614.GS30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213113614.GS30202@raven.inka.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:47pBM2Km9sw1jOTj5vho6NIRGn4G5taAJwBZCDpOdYda/ovDrWP
 sqfDj0hyaiMoKZXyv4XTHEv2WRJ/nD/JZMOtQXbiWZiZUnSSP5I33oypU1tyqseNXSDxLV+
 7evoQhp5xKxBeMenhwaAJhYdCDrpooWKxVC9XcT98FCzFq6TGBvPrhIG1e9M5g6Vp/mgvX2
 34htm2PdQQTkcsLbAVf4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NrbmpW6SW8k=;7S6uHAbhQLvf/DHCkHqo9oAAIpA
 D39VwkIizl7wYKHWkDhFdFOBXVt1vzPOjQQs0JvryjdtbIkP+zSlfhlzBlcJNCjj6gUYiXl2W
 pDhVvOTJ82opCN6S/Jee5nCUlCJHUiWiFGDX0VXYMSPjXVWFol9LcPaH4T04tif9W7TFzfClI
 l7zB/VSOfbPfLehp8YL4rw0YCbPOf2HIE5p4EeZ4pAxjU5BxU9aIzH1qJ6QkjYMifIqdQbUv+
 38Ie0PR/Fm0a5g0hRaFYeslQ+rXPM0VMB64fSxL4SLJXzbUbs9+My0ss685SRQIMwxpICqIZa
 BiOENSqggNgARZL283WcxI9oyiVPqLGYFYJHe7943nhnaXrMLZ80HoFPXsGAbnhfOLFgORHb9
 HbiY02CooNuHe5Ws4Ty6pMLPIWQ8jGpNo5fxkUUDZ52ThSkI8rtVt2I38VMGmS1gmhYaMXChb
 qQZAkypV4Q91Cvg6JTWSqT5N36D6+BqjYwIlQO4p1+KSYKB3vp5oyr9ql7HS+IPEMhbS/f1L3
 1NYbrVlksdA7Q5y36ezL9jhlhUyG9HKqDxXkPfFDD0av4A6/XZfhCyFih+soSBeDALdNmEjxV
 +fVPq4QxIlpa8MpNvhjKhtWeDTAKgOfckqYQW5GBMhed7wlfbn6tGTqaMLDZEFqjFJBbf3/An
 mio4fmFCWmKC52OE/yR+ymf9i8GpXKRhph186qhSP5LR0gJ0KzTam4roxsRRlfTRRt7A5H0iw
 1JlAAim3IyvXbr0kxV9urMxsk4a5y08447/zKRvROmnPaRAILPPcQ2AsW0JRC8wNb8gjzlaG5
 jsI06oPAs8AeWoEZe9zRkyk0XnLYe3v1iP8KkVkgYKeDRj2lUjKHlDmkPpnAzDcoxGvUGxaAC
 +J0cZkO0cX7s9IgeNvk5/36mGCjzJRdjeiPsFh5ded7FIb4Vl6Q+UFpiI5sxWyKMZsH8ku+Kz
 h35DKbDctj4jhaRsjceEEBj81mOJ9YI8/nM3iscSgt8KL8hclWj4bBEbHBZI2dZ72mr+Bp3uX
 MESVtnDowY85CMvFFfgPHKsKzdkEYbSBCg7WGGg0dPIx6kxyidKmOt4/z6Ab15uD4eP2LSKlF
 pJfH6JyPlmnf6hsbSN+x1Sayx1RCYI2emcWZd4Q7i6CuS754kNECBw4yfXvBCwGhQZZcjlnS2
 qXubhBrc+ITefEYyle/PQhvJEYHQbDhsorZc/3E4UIPnpXiR7mMIsPbp9fpE3FQ22ogcS5eFz
 cK/iRyMRBzWI1ov9BartlF3Q5CklMj/X+vrrMP9B4ct3p/48vrMK6B1jun5oAiZsA3edVLhHr
 acm9EtA2KhQmRdKlgphQg4J6iVrNBKZXGufGr72/QxCIYjFX6uQ+606iglV+iP+7x8Z5wKL81
 FBP5xvnUub1RzdD988mJ3CrfMwJf1Q8TQT5E0=
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 12:36:14PM +0100, Josef Wolf wrote:
> Hi folks,
>
> while investigating/recovering my problems with renormalizing with
> clean/smudge filtering, I stumbled on collisions while creating a fresh =
clone
> of the repo from the server:
>
>    $ LANG=3D git clone ssh://gitrepos@my.server/repo
>    smart-home-ets5hashes-removed
>    Cloning into 'smart-home-ets5hashes-removed'...
>    remote: Enumerating objects: 7499, done.
>    remote: Counting objects: 100% (7499/7499), done.
>    remote: Compressing objects: 100% (3263/3263), done.
>    remote: Total 7499 (delta 3955), reused 7109 (delta 3594), pack-reuse=
d 0
>    Receiving objects: 100% (7499/7499), 140.12 MiB | 10.54 MiB/s, done.
>    Resolving deltas: 100% (3955/3955), done.
>    Updating files: 100% (1423/1423), done.
>    warning: the following paths have collided (e.g. case-sensitive paths
>    on a case-insensitive filesystem) and only one from the same
>    colliding group is in the working tree:
>
>   'Projects/P-0113/B.ets5hash'
>   [more files deleted]
>
> This is on linux, so the FS is _not_ case-insensitive.
>

That sounds fishy (tm)
Does 'git ls-files' give any hints ?
