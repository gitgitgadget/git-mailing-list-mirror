Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6925EFBF
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880823; cv=none; b=blkEig1pDYe6NNyb2nFHwhUG6OmBq8GIW53NzrbNsEmY3AontiTjiPbsDqOQ6ls57KdlJNqzycPLlO+X7eqCg+x/NPJryiMJxq49Yrybts0ST819IshhQET/MsmSxWl7eiwrNw1Lrhnab+fVHAML8NTGBH89zBNCCZTxHjMtXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880823; c=relaxed/simple;
	bh=zrCFcsHAIiTEzgigjYoc3nnrrGSFaVnMVN19sWO/vSI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hbDQUHIvCdB+0cHdW4PX8BAtnLjXKCgViLVLAS1Sa4Dwbkgfpi8tLihoMU5aVhT5/YfN2sy/VFd29ahXvQp2uz+vqtZKg6ieUcxQvYIUT9nornBtPfLr+lhg+NjC/JCnW65dOr08LIJLMH1e9DtaHfLQRqai8QCLSF65NlEf/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Kfv+pSiC; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Kfv+pSiC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758880816; x=1759485616;
	i=johannes.schindelin@gmx.de;
	bh=2KscjyFTMmG3L9La8LzpFJG37UVezj0fH4I6pZ5EgYw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kfv+pSiCKxJqmA9YNeh/H8ctheYIzfvKdS9dnJ0vKhvBZqnlTmErJtRa62kUFyG/
	 40ud/QEGvGGO5tg2hHIiuKON8jeakRRWRpV3Is6igA08tXLRdbsYYztjp+sOaAKFk
	 tWEWjkmM1VjxNxsIIXN0IMXSQ8Tw7Pa6KnvLDMLFScarxTTav8pzWGu3af0PZuv0m
	 ykbE3VUI8M4Qq2MS+q1TSQTvMoUFEifyRIo0O2A/lr11N0nYHEQ2O+JRwP2kw6VR+
	 k14bilYzowB6ItESKZ3sfoySRec1Yfhm7SATdfpxXxKX0yillMekZ+0pKZQtwBfNN
	 JWTD5PyoKakh7It9QA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.228]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1ulFTs3xEN-00Q2xw; Fri, 26
 Sep 2025 12:00:16 +0200
Date: Fri, 26 Sep 2025 12:00:15 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tiago Gomes <tiago.gomes@enclustra.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] Git Bash no longer detaches GUI processes with & in version
 2.51.0
In-Reply-To: <GVAP278MB0582C91C40BC818FD57C59F6F91EA@GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM>
Message-ID: <3dbf6ce2-6aed-8b47-3c8a-ab2844c1dd7f@gmx.de>
References: <GVAP278MB0582C91C40BC818FD57C59F6F91EA@GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yqa+jxGuiLhrwhUqIAXR9G3l+WsM9fENFO0dMWDvRMyWtbIcB89
 phHNS60HgRfY99/05WzK71X1Cx/+NBxe6GsJ38gj2wCLTkVb1fmn3lw0k/C9oXfIun7wZlO
 jOerUCmbTb2cWkUvjJ+wewqOvZMSJPrujrbbKbxQvafZ42VbuaU1/Xx/yS9Fxn9NJCCc+km
 UMBazhf3OF31eQXjA5FQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DMDjDCMccHo=;5C00LzYNCxuvWqmNm1t1vUluaaq
 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
Content-Transfer-Encoding: quoted-printable

Hi Tiago,

On Fri, 26 Sep 2025, Tiago Gomes wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> I installed the version Git-2.51.0-64-bit.exe.
>=20
> What did you expect to happen? (Expected behavior)
> I expected the same behavior as with Git-2.45.2-64-bit.exe. In that vers=
ion, I could use Git Bash to run Makefile targets that launch GUI applicat=
ions (like Vivado) using the command chaining or backgrounding operator (&=
). This allowed the GUI tool to open while the Git Bash console remained r=
esponsive. I could continue typing commands even with the GUI still runnin=
g.
>=20
> What happened instead? (Actual behavior)
> With version 2.51.0, this behavior no longer works. When a GUI tool is l=
aunched using &, the Git Bash console becomes blocked and does not accept =
further input until the GUI application is closed.

I just tried this:

  me@work MINGW64 ~
  $ git version
  git version 2.51.0.windows.1.77.gade1f1c136.20250926063933

  me@work MINGW64 ~
  $ git gui &
  [1] 280

  me@work MINGW64 ~
  $ pwd
  /c/Users/me

I doubt that the behavior difference is due to the different version (I am
using the v2.51.0(2) preview from
https://github.com/git-for-windows/git-for-windows-automation/actions/runs=
/18030062242).

Could you try that preview? You can use the Portable version so that you
do not have to "clobber" your existing installation.

Ciao,
Johannes
