Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49516D9B9
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851660; cv=none; b=oizt10xxxTa/i1NBWges/o3mYIXAVWZt4+4CYUgp/V3mQ3qDLpqa4UcBrWXdLhL9z3LJOulfpsK1U2dXoLj/i2ZuBcGTTldyLeKE5O4Cxk3dnkNxqbfOTctFatqbqtF9gEX+DEh+SYkHE80+U7Byy1Gv78gosxz3Cip4oC5sBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851660; c=relaxed/simple;
	bh=JKmB6GJH2dFMKlW7xzA2krzIWtEZtV3BZrmL2Z8xjZ4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PQ7bUtGx5VmUnJCpLv1An86oG5UJn8YLvPnwl/jMbtywJ+yHunwRUZYRjfdgjC+eWP7CH+5BR/UnidAMlRDK9JrmM+DTZkfNjvpXgDD3C/d7etbaCyad49kCfvsW/ynfgxsa/j2OmNXWIaFE2KnPU/RPkM6NF8/F1DH67YG72zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=aDnEzL2t; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="aDnEzL2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719851651; x=1720456451;
	i=johannes.schindelin@gmx.de;
	bh=WxhlFSZaZcn4rbzIrHzpoj/bwd63OFgEHqUp4e2BOKU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aDnEzL2tj3n4faPkNqW4I/2CJBW9iDlmCFuBSj8o+Q9ta/C7gaifRTBRrSA69/Wd
	 YpydZNaE8PbeWv6X0IIS/l56YfU1kro5PRq8En3DAhAyNEArDG+0Bo6Iqysh6H5wh
	 cuOILCI9SPRkXG7ePkWjQ7LaRvm6HELxCnFIKL/IrMUqYoP88XI0ER77gJU6pwz3J
	 9JzCOo5Sb41YJ3RhVtj9rC0kwadGYt5pSPo0dKZ/pJ+fPMxAhKdXdH/G7PU7vQlMd
	 rYj+sBr0C/YweTgeLjCvR8EEH7FjtS77P2cMn9ffqc2bIxPB7zTar8tZqdXp6UE34
	 f3Fa1ID0JJtmCAHl7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.58]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1sR44S47ji-00DLQd; Mon, 01
 Jul 2024 18:34:11 +0200
Date: Mon, 1 Jul 2024 18:34:10 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: phillip.wood@dunelm.org.uk
cc: Florian Schmaus <flo@geekplace.eu>, git@vger.kernel.org, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
In-Reply-To: <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
Message-ID: <ae658244-877f-c5cf-8947-83b87b66d01f@gmx.de>
References: <20240626123358.420292-1-flo@geekplace.eu> <20240626123358.420292-2-flo@geekplace.eu> <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com> <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bsCp5t3kTT29kvJTokfz1RaRjrLZyu+kz3mgc5IZleM0U5T3ukA
 5Jm4jbLpQuNS4V8PLzrX1OH2jThYmylYpDZJuzt9Xf6M0Qj8/If67pq7LLbzzAeDQCJfj10
 nmPSASy4wxtNU+uulM4pFEA6xpev/zVc8127KoX9DvoSWQg2PeklXEyisQI9j81wvGhQ4vh
 z3rtUCRedkXV/54jrrVQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E5mUpqo5eJM=;sc716aoCB7dGTkJfj/L2UK46ax4
 lje6hUD5lRzZGRgIT5fbJQX0nHt4EZg+Upev8UVgQsM2MdV2TEPYt3O8U3EKkS7PsyIEe6sdJ
 0stL1ujRwIs3+KvlJRtSvDfBvCiDyjrn9+mU/H2+y/IKnOTWqFXvjD3ipVV0eadEKnfSHDmvv
 4HBS/un1QhkWiMGP3uo5qKUFG6XpISjXLEKBbyshHhNS9TLOw/hky0wVL+IL7BFKPACZ5nm6e
 K84Y7WTQleCL6pMnDcDANhtRWzftJeJeHQSEOYGGXjHs3yRMrjAx937K9R8FRLFUg5Ns/LjQH
 Kn5/Au6lZcqETYGaJXHk0Q00xEJVRlrsxMqFs+nDgP15Sbxfu9FD8jqU0EymUUWdw2RUCZrLb
 SoDJVABMwlutF+1pwZJ5r+lWpKGBuhL5P47x1tagjw0LwCp4z2UNC213Pyue4krHXjKs5YJmw
 QjcfScvsQY+yJr8zgKfMZSzca1EG6srDt6lrqUhAGrLHTtexjYqqK9uy9IHH860MaIU0ZNPLJ
 DgJ5ZYoIsojaaGvBA7k4r6/S4M7akTWd4UVGWaw8EAQq6w3bHN5y+uawRrTc9/n51XdSCKY/b
 NMeUODIyPvEMApxpshmXigiNBY4HClvUclbyRuFTTQgKN9JSMb/7qlcMdn8x/zzQXaDflBM14
 jofxbESmgCWUPkctHxwV7ue2PNOTYYxOBsUBRpYvlLafljzjXU2THoYQOGsr2epbxPAAp9PnI
 +T5Oxo4JfUzRYn7UIoWETGDdyMXRHIubwgGTFFCS3BP4mPAbsXvUIMj8IV2Q4OesLaSCHjY3P
 4ST8/f+yXqTg28jDVsh+SVgtqaHu4MsZPo0xmV7YDDwC0=
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, 26 Jun 2024, Phillip Wood wrote:

> On 26/06/2024 14:11, Phillip Wood wrote:
> > Hi Florian
> >
> > On 26/06/2024 13:33, Florian Schmaus wrote:
> > > Sometimes more flexibility to disable/ignore the ownership check, be=
sides
> > > the safe.directory configuration option, is required.
> > >
> > > For example, git-daemon running as nobody user, which typically has =
no
> > > home directory. Therefore, we can not add the path to a user-global
> > > configuration and adding the path to the system-wide configuration c=
ould
> > > have negative security implications.
> > >
> > > Therefore, make the check configurable via an environment variable.
> >
> > An alternative would be to allow safe.directory to be specified on the
> > command line with "git -c safe.directory=3D'*' daemon ..." rather than=
 adding
> > a dedicated environment variable.
>
> To expand an this a little - a couple of times I've wanted to checkout a=
 bare
> repository that is owned by a different user. It is a pain to have to ad=
d a
> new config setting just for a one-off checkout. Being able to adjust the
> config on the command line would be very useful in that case.

It is somewhat surprising that this `-c safe.directory=3D*` method does
_not_ work for local clones. To verify, I ran this:

  git init --bare other-user.git &&
  sudo chown -R 9999.9999 other-user.git/ &&
  git -c safe.directory=3D\* clone other-user.git/

This will complain about the dubious ownership and suggest to add the
`safe.directory` setting to the user-wide config, ignoring the
command-line config altogether.

The reason is to be found in
https://github.com/git/git/blob/v2.45.2/connect.c#L1462-L1464:

		/* remove repo-local variables from the environment */
		for (var =3D local_repo_env; *var; var++)
			strvec_push(&conn->env, *var);

The `local_repo_env` array _specifically_ lists `GIT_CONFIG_PARAMETERS` in
https://github.com/git/git/blob/v2.45.2/environment.c#L129 to be removed
from the environment when spawning the `git upload-pack` process.

It was not originally listed, but added via
https://lore.kernel.org/git/20100824064114.GA20724@burratino/, where the
commit message does not really shed light into the question why this was
desirable, and there is no discussion in that mail thread about this
aspect of the patch, but at least the added test case reveals the
intention in some sort of way: The `-c` option allows to specify
`receive.denyDeletes`, and in the described scenario the idea was that it
would only apply to the client side of a local `receive-pack` but not the
"remote" one. As the example above illustrates, that patch might have
been overly focused on one specific, particular scenario.

Ciao,
Johannes
