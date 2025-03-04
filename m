Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA218CBF2
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071732; cv=none; b=B1QY6LE8NjR2aeBJhAqF8NPhkrRt5RFAbBYdFPCeQYhQ7FMThkwPa2WoYjluQvUMzO78DPyayUyttYxbRfqAvZ6Bn4nCozVdHWNw5iaBI+9NllhIMW99eCjeuQR6PS3lBuiTvm11E2nxnuSs3GRtKFwbs2wAqFeIBUQysQDD9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071732; c=relaxed/simple;
	bh=Y+EBZ67Sq+GIkUROYlQ5rk23PjW0BcN+Epy//mvvGrU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c5FXvTCxAh+jskARpmhpA72fF5pMoJJ76I3Qows17DqdCiWU3bgTYlzL6nSa1es4yzCdT99id60aFps727VVeG9JQegtR5N6eQ6dI69+AZS2slotU3NqOXXSw5f91mtnwmMJ9BX8Uhr3IdqLKc3q3ImCKQopgFIW3cPA3iqYA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=qHte7ZSY; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="qHte7ZSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741071725; x=1741676525;
	i=johannes.schindelin@gmx.de;
	bh=pw119c7l4T8ukLS7DEYacRuVyroeoVje/xr08d7OCtI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qHte7ZSYt/r2+W/UdHeJSr/PbyzIBiSR9I/z7os6/MTDYvhHsMNJFcscUkmVviyI
	 ABfRQEa1U0yLulaaB1aFr8/0SjOKPKoXyRoxcAWGDjsnnayGC+X/jUbbCIBzB12Qp
	 kZZpG+9WH4AOtF6mgXqnVijPpcxH7l3k72Fd8ahz9tHTfJe/VF6Td+rPDrTelZV4V
	 TtwZTZZSHDMpZgmFKMcjmUDHorgCNqlXl0PExp7RzSZr2EfAAC+mTMJ1ScLgARB+l
	 QtHEDCuaaqqxLbmwhMNdM1kEkQAliRhppe9wFfLYzvne1BtgTVq2UGqYOmglWkALR
	 jgPiM7leKA5FevPsWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.101]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1szs5w0Uov-015V0Z; Tue, 04
 Mar 2025 08:02:05 +0100
Date: Tue, 4 Mar 2025 08:02:04 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: ps/reftable-sans-compat-util, was Re: What's cooking in git.git (Feb
 2025, #09; Fri, 28)
In-Reply-To: <Z8aeLc-xelujEjTE@pks.im>
Message-ID: <0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de>
References: <xmqq7c591sus.fsf@gitster.g> <Z8aeLc-xelujEjTE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MFPdH0n8xnPiS8dwpvAyi7/1ILRessS4hlEteSM+tIwU3dvolqt
 TGLcjRcHZcwPWWJ2ZvAmZL3ALZLItZ324hntuvHsyX3mecdDZGFhM2A4UDSwdJIsXc+g3EH
 6XQtemuNjaYfXD1kKOWfaVlPDqJ/K3zlD8M6Lcr3s1ImZYnRhkthsC+PmQGQJs48vXdqPwG
 0AZV+dI8f1LATop2qok6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OC/WIjRahsY=;7PRM+rB79ClmacikKKXC1u3E5vF
 vPsAeRF85uCyjAD41rUhSAklmH9XkXrOjjCXqQiPpdHI3mQKOUW6HQRoD8wyHdM/Yt7LyMgB/
 loLjhIvgovVwseKb6Tx4bKENvhNUpVlUVjOGCHH8+M1xJ6O1zRNKjDLFdfy5hsgwxQ2It3V1z
 1LhTNbepJ7PtuzSCayZmHhNKW3vyV61mhnI9UZMU+XIAVGIoUNdYpjchjqqwcbir/AanhrKWy
 9Qu50ui3XYYTeU9Y7BjHFPm0UMcy/j8k4JDtimsguEvuwNJao9cgbjN72g5UMhsRXJytntyHU
 LvTI5IUaunh9DYMxrBJ5C9Do0eyIhGE1QaXlUaPdRdE+NOFBhyWbBze2wSmH8EoDDvMQtpkcN
 /jXxCdJAKcrSomjbHur+Cctogdt5cZDU/b2MqVyi3aMj1ughhVefBcUQMib8ntPwjTl0UCeMp
 YLtuYOIrismqulJzg1VWdpzrQHLnekGQByVABQgK/j3nKGs4oyaElJ3NPgsBw+unvYCgaUS/l
 Xe67zYuvSlw83diI+Dk1ZIsitdm8ahdIbeib9iBJcD4o74ymoUs9PheHIEqcTWr9uHBBsqkWY
 QCLLgQUl43wrAbijIsJv/6Np4dlcmAkonSPfiTGBSO3x0FRjuA2tIYjdaQ/NUw+dcwp/7Qwuc
 i5A7sF5bWedLpxnLPKfxZvgTDwfylv8MIV7CcjElTXyepQJQ1LQg4Frp8sW+knmol0yylL+OX
 fVPzHX/oDrO7/FRLtbT7EhtHHLu75plhX/xdj7Q64L42c1IxL7RaFK6SSmUJUVZ98QKkdSfNT
 k690iqaeTDeSP2woqxgSXn3pYGbjOAsXk+NcwAGQIitR9zVqyM0VCIl24z/9QcAg9JhM+jyAK
 Q4Io8XYl/LKNqNTi6S3UxnF/lk0M9XbG3yic+DPts8NzzELjfhwRJ+jW43qqeXW/Bbqj4qLYa
 OixACK6tdrXV7nmTHw22jCv18fUJHyH2vxltAt99R3PsNnfzN9SzVH5XPNHg6+8x0ITUPwrXX
 FjjkCHBXu+yNJAV1aDGsK2bO6fRjT/KDkU939NQP7CvmERsEUUVlA3acvoir22BnBXlJ8FCfV
 MxWGDLzA+v26VLA1G7LCgLqG1WRFQ9jFzIVkgJDV5vZ4Y/fjfCwmzJ3pqbmecOo6SIYiOZXHY
 FCVRR/TfNCBn0FaFTc942vFMhuJTEKAsNzpyWMqmUhu+dxBSt0eckv/nT9AXkLrkfe7vGIwg5
 WrZNterJ1SZsGFd5ezHdCbb+XfMYhZ0y7evE+szMTWtVPK7sbZ4HzJC9DFAXIyCMFdcgxnPWc
 MZkiK/YtF1fDuaXoiaIfxARtzDPFsXZYsrSlcul4A2m3yRMcL+tUKZpXO4QkFvqEboJpabm1q
 oAV7KbOLkPCTVduG3gqvweiA5OjC1T4Em1UjS/kuDMErYvYaWrtLVKS/MqpPx2VX16pWOT5WA
 kwIj58H7UqhYYdSjJhBRaMNjGE55jHSyWEtOfauUNSmlp3hsC
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 4 Mar 2025, Patrick Steinhardt wrote:

> On Fri, Feb 28, 2025 at 04:45:31PM -0800, Junio C Hamano wrote:
> > * ps/reftable-sans-compat-util (2025-02-18) 18 commits
> >  - Makefile: skip reftable library for Coccinelle
> >  - reftable: decouple from Git codebase by pulling in "compat/posix.h"
> >  - git-compat-util.h: split out POSIX-emulating bits
> >  - compat/mingw: split out POSIX-related bits
> >  - reftable/basics: introduce `REFTABLE_UNUSED` annotation
> >  - reftable/basics: stop using `SWAP()` macro
> >  - reftable/stack: stop using `sleep_millisec()`
> >  - reftable/system: introduce `reftable_rand()`
> >  - reftable/reader: stop using `ARRAY_SIZE()` macro
> >  - reftable/basics: provide wrappers for big endian conversion
> >  - reftable/basics: stop using `st_mult()` in array allocators
> >  - reftable: stop using `BUG()` in trivial cases
> >  - reftable/record: don't `BUG()` in `reftable_record_cmp()`
> >  - reftable/record: stop using `BUG()` in `reftable_record_init()`
> >  - reftable/record: stop using `COPY_ARRAY()`
> >  - reftable/blocksource: stop using `xmmap()`
> >  - reftable/stack: stop using `write_in_full()`
> >  - reftable/stack: stop using `read_in_full()`
> >  (this branch is used by ps/reftable-windows-unlink-fix.)
> >
> >  Make the code in reftable library less reliant on the service
> >  routines it used to borrow from Git proper, to make it easier to
> >  use by external users of the library.
> >
> >  Waiting for Acks, especially for Windows bits?
> >  source: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02=
@pks.im>
>
> Johannes, did the new version of this patch series make your life any
> easier? As far as I can see the conflicts in your "shears/seen" branch
> seem to have been fixed, and the failing pipeline seems to be due to
> other issues. If so, we would be able to move ahead with this patch
> series and the dependent fix for Windows below.

Honestly, I cannot say whether it made my life any easier. As you can see
from
https://github.com/git-for-windows/git/actions/workflows/main.yml?query=3D=
branch%3Ashears%2Fseen,
the `shears/seen` branch failed to update automatically since I updated it
manually last Thursday. According to
https://github.com/git/git/activity?ref=3Dseen, there have been 5 updates
that were hence missed.

I'll try to update the `shears/seen` branch now, but I'll time-box it to
half an hour because I really planned on taking care of other issues.

Ciao,
Johannes
