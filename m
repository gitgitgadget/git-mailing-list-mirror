Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F011D54FA
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175922; cv=none; b=mbXkmfLIfHlftbxIYZr7YwxaGm2cYQWasjkUs2CoqywS/k+OEe+J6flVzdxM2Yy5haU268E4Bk4eWpbTbvBz1qBUIFrIDd6IvatbBM01P2URpp4T7SmrsCBDFTrVfiZvdcD9HfhmYv021xoEQE6c8p2piio9nbtneFRk+7GtsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175922; c=relaxed/simple;
	bh=O7CRNnYviYKy7emk7FwQ+F2kZRyOa0+GXMULXhkt5zA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k5dMB+nb1LzVvCMkVVwF9QdWc2S9YbkHxEUf2vEaKMdjCyQEPSsjmpoBSe35Jzlc+zr/jM3d64j+eCKPkyi2rtcjS1IwrffXFpmGTxkYedhEVqErBYYDJhFodDDNdfWeJ6QjnBlcVKJerrtB0itcYFpVR4cMjDKk4zSjcIPps7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=nv1Qop8P; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="nv1Qop8P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743175912; x=1743780712;
	i=johannes.schindelin@gmx.de;
	bh=61p+ZppiIXE71XYgh/8JYNyVIzYa7/4fxjWm0yY2zi4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nv1Qop8PFWHN9BiTeiTxAvFAK0S+jmAXXqr2akPeijw8L5KXYQ3oA3L/YikXQbSf
	 nzhv0XqiS+W8XI3KjL0VPnLVFVAcGv8Ur7hk65W4qaS4VrLmzEUkddswUl+YoxDUD
	 TBlvv5V5XXgMiLFkUJEOXq/gyIbfdUdSmsPYwabFWRxGPPNodUQOh3sCp3EpgJS1h
	 Gyg/EBgSaAsnVq+EWB+RLSkM4RADNmVDjcP1ClN3Qvqed/X0tzsPXRIAloVmSwbxB
	 oRywpNQ/1rqGyWMsQD12hcxx8fhA75dAEkwsNGslsz5JHE/a8qe84b0A0mvyJkzf/
	 37wGhc6da5xkvcoxnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.168.126.83]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9XF-1tphMH0E7t-00DQSB; Fri, 28
 Mar 2025 16:31:52 +0100
Date: Fri, 28 Mar 2025 16:31:51 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ps/reftable-sans-compat-util, was Re: What's cooking in git.git
 (Feb 2025, #09; Fri, 28)
In-Reply-To: <Z-Y1YbE2EVqLZhGO@pks.im>
Message-ID: <44302902-2624-8252-54dc-d4e5ee38ddbe@gmx.de>
References: <xmqq7c591sus.fsf@gitster.g> <Z8aeLc-xelujEjTE@pks.im> <0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de> <9cc294f6-03de-d88f-9734-510a23fc8991@gmx.de> <Z8bL0HUuQqj7LlTp@pks.im> <Z8bQsflIqzZd3AMs@pks.im> <9cd879ed-5366-a7bf-f440-e35222a733d2@gmx.de>
 <xmqq34eyijbx.fsf@gitster.g> <Z-Y1YbE2EVqLZhGO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:66ys1OKHLsH5tV5WgZ9mgyGYdqlRe6OBrXcDOrhi6Tfq6R15ycG
 +kofO+UK73Tq590ZiuC2HDA2i3V7rP5P3h2BXsijywIheY2n2pnTAUstUNN/pNrIMvqQDXe
 BJPwEBkJxDh2httZrfUvdDlbml4V9SVR9IplRcf1SxuqsBXetBPbbT22EuLjaVKO2cwovDu
 LDj1J6k3s2iUrYr50ts/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gupolX2rfsw=;LNGMuyPlbTx0TzgcWq8jM9+BjZh
 bxzv5B0hf/saOJXWiI8Fz5SeNezhcli3AG4sw2ejCA+XPExff8URLGlt34oerYQT0mgIaAO/R
 y6Bv6kxL4Y7EgOTEplN9rPj+yB3CkYuDcX+jD5m7jo3DgkWfnLWWgo/jquR1INSEMPqL0zeJn
 J8snfNGkpUi1M0vRetm1w7AkBKipiE//sVz11ieOv7HrpEELZcAVkiZg5Jib9GD6gv81d2jCb
 I+FiR7qqtd3cEZv+8SjriOr+XZit9vmAIrdNdA+F7CzcaXgYwniCvp33PMTKCo7Vcu+v+/xHb
 VbERYRvbXvITKiM1Ivf5vb7d9OleQTo84aeuGWEgUQM/r42oagRbYj3rZ4cOSuEfwVcx/d1Eh
 v/APzUM52ZDjEnuv1uHPTisLhIs0wVaJStAJvmJn1BtIJUd6K9vJiXCvNwbbJoqbQPIaRtkl7
 s5/37y1PBPUDxAAQp37dgmNFZpMLy4GLcKUP/ethf4BElu5mmJuevSajeqfVSfEtEOOEx04y/
 ++X3wDO1xhrkMTNcjTDf3o4T03bdbsP4iTDOzhTQyHQw55H0TVRQcR6Mw37Jv5vw1bac5FVgw
 J9wfic7Bs3m9FsTwgYHSkGbji+jrj8hk0c6zaRncw44rKn8dewjejhGThqFa+IKBxqB0/hECX
 zCtkeo8nBHJIG9hlWlrgUlJmLCYCKCQucQCGqS0Jenpf1i7q/n+qcMUhRvC2deFY14VErTfl8
 lHjFtLY6+1a1F3iZa5289j7ijN7ByLQMw8aMM2+4ANsO59/ir5lhoE0T20W3Je5NFP6RACtmJ
 VZJsea28QuW4zcrRksH/zab+LiHnpoJQr5y3WoaZwR7/GOFn4urPJzZPB/RRothXWtfQhIvUO
 MhOMu2vXBoPmKqw1sDlGqW/laLnAFsdXZdC9tMLBOR+J3fApTdt8T06q2dK+ZDkflT3prr4Uh
 /UVkTWmNPvREPez1Mnn7EvGkHUnxFwzSH3Ko7kR1tpBNCVw+WtEB8wAJArnxwDQSys6zE+qIn
 JWBfNd0ZPSJV0RUvsxbZ80G3GeO0l20ZT58eBXDOVZauhCvQZ9teTfbyGvW18SRnuFegmuo0U
 9WobZ5bqg91oMucnEz1WpcKPKdioWphRaaQzo2TNb6HmI16DxPTrMo6hskuW6CydF8SeTshl4
 6QZPS2+xCKqlX2SPMOWSyI/MSdd/ABPICSVxDzxQzSMUKEQtzEPP9dSlvPyJcETWd7tvDOoaB
 enowz+IUCotThqcBGCbMrEYOD52Q0piAoRiB/b4hcPat6GMwXJv5cmiMfQxWagZpXBlGVbTc9
 G8TypbKNVDs/hyrAEfrGHX3eOgcV5S1031w9g2cD5vYft1oU66fOhoJNAsw/D34HTpn7lMxFC
 1l+pTFSOgOmRKfdMRkHcjuc3oyYoaDFCgXM/tQD7n69MqmAbPmakG45jvXViquRbJ8P5S6gSf
 n/bk+gCdtoDsrH2b4AkqhCoYaxyzgjJzSOIBlp5fwItdvjajP8SnnCFBFhkBIyYPEpTIYPlJE
 ALES/mfecI7rWRUv5w0=
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 28 Mar 2025, Patrick Steinhardt wrote:

> On Thu, Mar 27, 2025 at 08:28:34AM -0700, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >> Below patch addresses the issue.
> > >>
> > >> Patrick
> > >>
> > >> diff --git a/compat/posix.h b/compat/posix.h
> > >> index b484029f751..5ad3539d55b 100644
> > >> --- a/compat/posix.h
> > >> +++ b/compat/posix.h
> > >> @@ -176,6 +176,16 @@ typedef unsigned long uintptr_t;
> > >>  #define _ALL_SOURCE 1
> > >>  #endif
> > >>
> > >> +#ifdef USE_MIMALLOC
> > >> +#include "mimalloc.h"
> > >> +#define malloc mi_malloc
> > >> +#define calloc mi_calloc
> > >> +#define realloc mi_realloc
> > >> +#define free mi_free
> > >> +#define strdup mi_strdup
> > >> +#define strndup mi_strndup
> > >> +#endif
> > >> +
> > >>  #ifdef MKDIR_WO_TRAILING_SLASH
> > >>  #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
> > >>  int compat_mkdir_wo_trailing_slash(const char*, mode_t);
> > >> diff --git a/git-compat-util.h b/git-compat-util.h
> > >> index 8d2acf86670..a102a365592 100644
> > >> --- a/git-compat-util.h
> > >> +++ b/git-compat-util.h
> > >> @@ -226,16 +226,6 @@ static inline const char *precompose_string_if=
_needed(const char *in)
> > >>  # include <sys/sysinfo.h>
> > >>  #endif
> > >>
> > >> -#ifdef USE_MIMALLOC
> > >> -#include "mimalloc.h"
> > >> -#define malloc mi_malloc
> > >> -#define calloc mi_calloc
> > >> -#define realloc mi_realloc
> > >> -#define free mi_free
> > >> -#define strdup mi_strdup
> > >> -#define strndup mi_strndup
> > >> -#endif
> > >> -
> > >>  #ifndef PATH_SEP
> > >>  #define PATH_SEP ':'
> > >>  #endif
> > >
> > > I integrated this into Git for Windows' `shears/seen` branch (i.e. t=
he
> > > continuously-rebased Git for Windows patches on top of the `seen` br=
anch),
> > > and for the first time in weeks, it passed the CI build:
> > > https://github.com/git-for-windows/git/actions/runs/14087673643
> >
> > Thanks.
> >
> > So we'll see a final reroll with the above changes and the topic
> > will finally be moving?  That's a great news.
>
> The topic can be merged as-is. The relevant MIMALLOC code only exists
> downstream in Git for Windows, so there is nothing that I can do about
> it in this series.

Yes, and I already replied in the thread (which is admittedly challenging
to keep track of, as it is not connected to these "What's cooking?" email
in any way, or to the topic branch) in the affirmative that Patrick's
suggestion worked around the CI failures I observed in Git for Windows.

So yes, this can move forward.

Ciao,
Johannes
