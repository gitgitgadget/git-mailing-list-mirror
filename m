Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB91474A4
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610898; cv=none; b=H0dU19i9lFvNlJ9X5HUwXJJbkgrU7H4XoXiQF0fWjPqKoho/L+ORPMsZqB6oXQHRLC7YllEyXz8bFezAUvQDmDFT5dWHMibm+km4CfVMwlnZpAdHUj9TJw77tJNSQ6iNfiUqKBtVM3BvHgGTAHz8r9K006Z6RgURqZsRE3t4hac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610898; c=relaxed/simple;
	bh=bKlgMn8plCOInGa3fa0Uy3kYIXzTyKSv7V27/+snfGw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a9B5/xiGZury/sUEOmhncvdEli7s6tv3suwFD7WeM5683Opj58asaph3vqDNHRdKuMXTWYwjkguTClHx0SqKi4m7xuj5/1tRn3thRrJnlMbj2HEFk2F0Yctz//JMYgpm+jevVD5Cp+gQLy9XWHZ6GxPFbmRxCyubeZTJ2WMtNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=tj2d2W1Q; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="tj2d2W1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708610890; x=1709215690; i=johannes.schindelin@gmx.de;
	bh=bKlgMn8plCOInGa3fa0Uy3kYIXzTyKSv7V27/+snfGw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=tj2d2W1QgE0QlhjozS+KameXEx5qtgWQXMk/RKw4Nt2tZces9X3HyBIriS7y/PVp
	 6hq7KXyJJLVynMDJ2Yqqa8Hjpng7Y0C7uQNfzS+KwRwVQdKAHZ/EPRZeuJxYOCBSd
	 XRS4s5fPkPTsay2yszN8FexSGQ6lJrUxTRhLYRWy4EeKVhMCLEDFaV8V2w2kSZZuF
	 CoOcea/8k+swbSiGSWhzH0Nm6TKnm1ep7Aw2EvGaroXXqCNqdRvijkHPayvYZzCBO
	 unxiS9Xmk6YS/NxMI2+S0pK402JrSgT37DEYVpEdmi6Z3uomMi4koWIcHPVBbbp3n
	 6OkundGE/8S040XhRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.133]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1rQSgx3OLW-00YkpN; Thu, 22
 Feb 2024 15:08:09 +0100
Date: Thu, 22 Feb 2024 15:08:08 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/5] Always check `parse_tree*()`'s return value
In-Reply-To: <CAPig+cRK_2BWYkcgaZ1pMJJtztepeEJCwuevJNj6gJwRoJgF5g@mail.gmail.com>
Message-ID: <dbde46bc-501e-8433-0b8d-b83d0ca9e759@gmx.de>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com> <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com> <ffd38ad602a53dfe72cdbfe0d098ca43e7443895.1707324462.git.gitgitgadget@gmail.com>
 <CAPig+cRK_2BWYkcgaZ1pMJJtztepeEJCwuevJNj6gJwRoJgF5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-134663887-1708610889=:518"
X-Provags-ID: V03:K1:tcftRpnvpFETbC4QEUItG6oMR2vvhS5ZWhKVgRZz9grOIrr5cr3
 oNkNOnnq1YkPDLnxGgU+uenf/szAnryajKvWgi6WghafDXSPAeNyAqXxlINVJQAoI9HJ1vj
 wnGI6oCZybh4b9KQOkaDXFQQ1Iue1PoopgJGsqf2bEdZIrfI6PNMuukimKDqawpV4hKoy6M
 2WeYkPBnO1wAoeKeko76Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KhftFQpEFZk=;Q45UrEO/8cDD6tG6JvnNRPuXvYU
 +uLF3F84uNdV4R2utOQHjNkCORnG9lSwqJ3s0nddQ66yi92ArkRH7aqZ0DztDdzxctUmxTESg
 aL0WO7JE4E6XEyQKKHHgOl8Z4Am5v9SmtXbLz4hlbwcm0Y+idMYAaiar1MoywBx8oC/aCvB8W
 pxcJW6LGJYSDux6bs7aCsovG36aSpxuM6JRKyZRHbpf2nCFVWoz+pziwc7Ddw4fWt9xYiJuUn
 rfSryr76a95KmsoMG/8c79+YuhlqMC6f0NWo9McSv0gdYkESD7Wa39+59BeAReoPhnVUwPmFd
 7y/zfxwIHSj2YDoopgrVf1qQeTgvIne+prarIRtUWvlmAYkGfwV2jA76alKATMTl87mIDz6T3
 OugsGu/hCl9VHggEP+sbu8QiXl7T14jBl3lA3g5xkmIpVW585E+/PPdVBLx8Jac3VUanD8NGc
 wvYKM5FxDS8r+/3Dm6X58YNEFvk8rg6wAT8BpEw8lTFFXIL7VC6ZWz/KWtMgReFMXcXs3Ntnv
 bvH126873K7ri+dekkRUCF8A2Rnw2mo7Sfl1PWoM4I3u8EnJWXui1/WZHBhmzQhQznI1hFNCy
 sYrFZPlSygArpE+lmrZCyUJ/Wob+m+luK4TdC6BRyxa0bVvuY/+GQpnI4RjuVckeS+Bh2ci+v
 0d2MJM53Tp/1JuDdLNY7ArOCC2lNJdfBctUziHHzS8n7Xv/JLcGeQ+qjzY6h2AmwAVx0blM9O
 sgY/QxeibbKx5xp3TJWK77OhBc7RJ9pEpnDPWSupQIiBV/GAZmTnPo3fsdeMYN9zjeaWP/WDA
 2golS4QkhQr+KEOiNq3XpmSjNxY2LZCjTgxwXOa2kEEiI=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-134663887-1708610889=:518
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Wed, 7 Feb 2024, Eric Sunshine wrote:

> On Wed, Feb 7, 2024 at 11:48=E2=80=AFAM Johannes Schindelin via GitGitGa=
dget
> <gitgitgadget@gmail.com> wrote:
> > Always check `parse_tree*()`'s return value
>
> If you happen to reroll for some reason, perhaps: s/Always/always/

Unless I am missing something we only ask the part of a oneline after an
initial "<something>:" to be downcased.

At least all the "Merge branch [...]" commits are still capitalized and
nobody complains ;-)

Ciao,
Johannes

>
> > Otherwise we may easily run into serious crashes: For example, if we r=
un
> > `init_tree_desc()` directly after a failed `parse_tree()`, we are
> > accessing uninitialized data or trying to dereference `NULL`.
> >
> > Note that the `parse_tree()` function already takes care of showing an
> > error message. The `parse_tree_indirectly()` and
> > `repo_get_commit_tree()` functions do not, therefore those latter call
> > sites need to show a useful error message while the former do not.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>

--8323328-134663887-1708610889=:518--
