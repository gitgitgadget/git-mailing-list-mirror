Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F079312814
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764791298; cv=none; b=bCvQA8Y49rqzbNeFLehTHkQ9dC+6695aplGybnn2r8kgL1mdeMX0t8OMCBybvgTlhbiQSY8ZwZLl9mnIoyMCs0/Q6VUfozguuQvRdgcdvOhzA1A4JUm9CzKDoa3497RbW0+U667Uw5qXM3T8ywRUz+1Ol2kE2NqrkBaEU8e7Y3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764791298; c=relaxed/simple;
	bh=brV9zfr0ubUbIfFeg00OMcBDJthp6lxNjZAdD1EI3oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py/DJ38qLcHxMt/V0LyH9JJ+4EcXQRK9GAt2h4RkFeRsOOXnZquQTX69Mdw9OXqj8bC9RGMGgEQDUeYbIC4XwuNJMrgHQbECPE7yxR8t8NQJ/fBhnhWzl1MuNMFsi/NmhmHiWXr8hS+jPICk8btGH2BsFNfV92hLhRK2KfS82VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=gIl0UfSk; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="gIl0UfSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764791290; x=1765396090; i=tboegi@web.de;
	bh=kfStmea7LIKI0L9QmDgz59gziwWpMJEvNYeeOeKvg28=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gIl0UfSkEGEHszihPbPUWSSwRo59aByn4wVtbHcDsIdrfafJIVTe862nS6KylExs
	 W06H3nYEoeFELYWT503boexscd9rDOiFIDFG/nhAc3iSwKpsrydtbZ5XCcyjtT+6Q
	 g7Zmfbpkrb8ELnHHq7A8qRmSEKQ4WFQBJf3nd2LWQMMDkYLXDG1TnT4M3UQaPcm+o
	 iKVB0sqbCfYw1OzRM/VvZtaeKuMTJWuuigoxXmh7rSDbaB/GNxcBtXrVqNaZJhB+2
	 fwm2jIRNjCLl1CBAgEEKKN51zJXnViu/F6Ag6iAJtVoLWZIjlq1GiENjFbLIqjUK2
	 utZ0XOGgtJkiZgdwnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidDH-1vxS5m3Vbz-00q14Z; Wed, 03
 Dec 2025 20:48:09 +0100
Date: Wed, 3 Dec 2025 20:48:09 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH] lockfile: add PID file for debugging stale locks
Message-ID: <20251203194809.GA13919@tb-raspi4>
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:iOWLO3G56dld0ljrIKPbuKtsCX/jQW5dJCFBXiHmqqRZUUr3ZX/
 ksoUCrL/DMZeH8YYvFp0k3F1TuI1n08y2y+jdOrgmaCfqqHuuA9tW9GDI159tzmiWQCjz7q
 0gFc1UvCLKWkyIoLXPrWT2pwxKDtFu6uRdozln39dEatccQkBr1xDwDeiN5TwoorbRcXy4G
 PIinmEFX9q8XvywbhI5sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dLYEla3A/ms=;hWWqU/MYgE5eFf6TzQZbtOK2lMg
 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
 mcWlrb+XdmY486SEc=
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 03:07:27PM +0000, Paulo Casaretto via GitGitGadget=
 wrote:
> From: Paulo Casaretto <pcasaretto@gmail.com>
>=20
> When a lock file is held, it can be helpful to know which process owns
> it, especially when debugging stale locks left behind by crashed
> processes. Add an optional feature that creates a companion .lock.pid
> file alongside each lock file, containing the PID of the lock holder.
>=20
> The .lock.pid file is created when a lock is acquired (if enabled), and
> automatically cleaned up when the lock is released (via commit or
> rollback). The file is registered as a tempfile so it gets cleaned up
> by signal and atexit handlers if the process terminates abnormally.
>=20
> When a lock conflict occurs, the code checks if the PID from the .pid
> file is still running using kill(pid, 0). This allows providing
> context-aware error messages. With PID info enabled:
>=20
>   Lock is held by process 12345. Wait for it to finish, or remove
>   the lock file to continue.
>=20
> Or for a stale lock:
>=20
>   Lock was held by process 12345, which is no longer running.
>   Remove the stale lock file to continue.
>=20
> Without PID info (default):
>=20
>   Another git process seems to be running in this repository.
>   Wait for it to finish, or remove the lock file to continue.
>=20
> The feature is opt-in via GIT_LOCK_PID_INFO=3D1 environment variable.
[]

I think that this makes sense.
However, as a frequent user of Git repos hosted on an NFS server
(without any problems in my setup):

Does it make sense to add the hostname here ?
We already have xgethostname() in Git, so that we can diagnose
who/which machine really left a lock.

[]
