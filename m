Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853EB125A0
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974363; cv=none; b=fIwx0+MnfwekxMwyMdtF1Nd31RrDtChQfQK62h8oJzBDNSfiKNvmhPhgTqrBoYdds1KheaDwIL9henuXwo3Mn8D09smi3weWwrVYetQujf6cn9eShMV7p4QN0eRw9p7xKBXMb84qU1QWDB/CwmxfuT7URi0Dvi9dHeGC5EMvJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974363; c=relaxed/simple;
	bh=Nx7RU961H9ZKp2AjuB2krt3vIxMNU0VMycJo3k3OIj4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K3Om8IYlbzzBj+XTBDuCrenMHxb58XlhHkUGosxEaNi8bF6fZwrYQtK7SPIYrkMVNaifvMCXJoVmup+VhnQBhUvEhBcoQnHue4w2c3D3imh5XFl3vXrjYO8IvC5IBOgZsIUHtsAQmov2gWsRVRpCxxzA8mT5FsbCklD1nI6tFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=qqAqXXW4; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="qqAqXXW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789974344; x=1790579144;
	i=johannes.schindelin@gmx.de;
	bh=aNMQy+RRTMcBPDX7ciZZ92CsWM9fsQ8AKmfaV0UqYlk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qqAqXXW4rOP48pWZpWD3veIReCEEfOXWPxG4VQSQ7yJQSulhtfnIAAV29ApNP4ho
	 Hn8XXFHAgM0ZNQrwZUQkrRMmK7L4LFGuIizqqzEgl5O/1Iyp+ofsCNIX95cyzn+kx
	 89+PmxvMuWOJ0DfYceMIEVkarQdhxwi6+ZtyIrgQuDdA/G3qLzNgemyx70zdHJkGJ
	 QLYkTDfinwrbe9dKxwKPSgFAhp5tfGjJ+wK9JK1Vy1v0r43H8pOC4BAqofpbE1CVI
	 YhtfUlTOG467J06107pvXXkgX605SygZ2bpwo1NeG/kCQ3pQcVnmEKHpjzKjaZxqN
	 doYWC0jFreGsAG3//g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1wpMDs3bch-00zHBk; Mon, 21
 Sep 2026 09:05:43 +0200
Date: Mon, 21 Sep 2026 09:05:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
    James Le Cuirot <chewi@gentoo.org>
Subject: Re: [PATCH v4 0/2] Use Rust in the Windows CI jobs
In-Reply-To: <xmqq8q4zosri.fsf@gitster.g>
Message-ID: <ffb1a618-5c6a-871e-c93f-0d4786745635@gmx.de>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com> <pull.2213.v4.git.1789315032.gitgitgadget@gmail.com> <xmqq8q4zosri.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:HwMyOf2ejMrrSI6HKyj2qmRNcZhWyD3BOWImenmLCzWqijJqwyc
 JkGP2a60ASvHmQbi3uTH2Yb+uqPqrmAClTOkIcwlwhflPGAfFcFpG/v//V9La9oEmszktV5
 Ohj6KIvk4nNOMNLKPCRSa4gBfrxdwzLQONH97P+7PkuEIdGgiGcnRqPLHswE2kxY/rXVh1n
 cDvkpf0ceFXamsNr24TEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+02OfX47kFk=;6aGKTQpgFbNuWHUDSGluDcJ9JYR
 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
 E=
Content-Transfer-Encoding: quoted-printable

Hi Junio (and lurkers),

On Mon, 21 Sep 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > GitLab peeps, I still would love to ask for your help: I haven't been =
able
> > to confirm that GitLab's Windows runners come with Rust preinstalled,
> > https://docs.gitlab.com/ci/runners/hosted_runners/windows/#available-r=
untimes
> > did not clarify that for me. Patrick (or anyone else with access to Gi=
tLab
> > CI), could you see whether this patch series builds on
> > saas-windows-medium-amd64 without need for further changes?
>=20
> I rarely look at failures in individual tasks there, but noticed
> that a recent run:
>=20
>   https://gitlab.com/git-scm/git/-/jobs/16576450182#L784
>=20
> failed with "cargo: command not found".

To close the loop: I am trying to address this in this thread:

https://lore.kernel.org/git/6c2bba91-a1a9-3547-4be3-f4f9ce03e696@gmx.de

Ciao,
Johannes
