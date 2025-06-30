Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4D21D3FD
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280516; cv=none; b=Vt0/hOxo4272wLDk5FrM3oFxy7aiXa60AXiI094d5gETttmm2qTlJ297XewZfLpB1BytEF8djZmVrNM/3O6H2xCPmlT2SBA/gdRwWRj6SH47jQjdrSqQJmSqbSnoEEOnVowtDY4vOe3hS67YVA/60Mif9fBt0mhaB5Zgpef5WvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280516; c=relaxed/simple;
	bh=SfpgW022Qi9GeSdyE3d07LYANbeBzuE1DQPv44flgBY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WLe5V+Tq86snYHb4z3Y8KZ/yfTL8OdJLh7O5N+cTwmyammojG6r6zgVPbB1kQ1U3qzT8fpXiWAF6fN4FYWUzO3ZTVJW02kKnVyrhX4wtI8072Rf+SOpdxCs3fEQ5TPgwsdmLvmt/RaAA6xGIZWr9cJxOlV6pFhoOp8MizpcnMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=j2AsfkPB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="j2AsfkPB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751280511; x=1751885311;
	i=johannes.schindelin@gmx.de;
	bh=SfpgW022Qi9GeSdyE3d07LYANbeBzuE1DQPv44flgBY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j2AsfkPBWTHDnz9fTI+Yj9w0Eo/IVQnDTWWSL1hUViQLCXv95UrvoGfPBlie138+
	 qc/+vsu8qVWcnrvhA8y2CcKohBTzEdNt0htFpWKyJT+/IHIt9LIHjOCIwDZmj9BcY
	 xqQ3T5YsgOh+xRAuhjVupUQj0SOqaS1/db01GUgEtbXbwhWqwqAAa+k2hfeg+tuMJ
	 Oeh5m4wf0pEHsYtZ/B+hFFCJt5ITJY803W11xd1qXRX/UgVBUQBFcVyV+4GhO+cQ3
	 ELLUUeawthRuj9mBr6J0MK+a+HfM6TyhYuQ98Tbg8tUg+Sn9I+tIYDedhAy5FX2p7
	 G+QGzIcUfUoD6JNPpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.85]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRR0-1u8zGV1NPA-00S4OB; Mon, 30
 Jun 2025 12:48:31 +0200
Date: Mon, 30 Jun 2025 12:48:29 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Erwan Leroy <erwan@erwanleroy.com>
cc: git@vger.kernel.org
Subject: Re: Git "Permission Denied" errors on DFS path only with newer
 versions
In-Reply-To: <CADT1yYmQGG5mQnWk=+19UOEvcDyiUQmWsib9jUJsPDc=A27vMw@mail.gmail.com>
Message-ID: <3bb920aa-5bb9-b9ca-64ed-cd8b3aecdce2@gmx.de>
References: <CADT1yYmQGG5mQnWk=+19UOEvcDyiUQmWsib9jUJsPDc=A27vMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GJp0bVgWN2Rm9tOqtPbIOP7BnpQ3yFwsc2meHCsl7F1IqAk4J1z
 aXUNtwiLXBbptoFS205HSK9ZrfiFaeq7YfKLxdlONHNUGRHGSc+j12eVk3Q+1aOIu8fMP5o
 f8gQs/M8jjygV/NB/2GIXekeFPqtlQCWR5lDx/jDNKAYeXjkUgpsCbusYtghp3IQuo3sDWL
 9etch6vyABJMiKtepiv5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:biNdoHFtNNY=;Sni/RpYCuFjUFpvzp7sjq85zqiW
 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
 2eqjyJJI08w==
Content-Transfer-Encoding: quoted-printable

Hi Erwan,

On Thu, 26 Jun 2025, Erwan Leroy wrote:

> I'm writing to see if maybe this is a known issue, or if there is a
> possible known workaround. I've not been part of this mailing list
> before so I hope the format I'm using for reporting is going to be
> correct/helpful (this is attempt #2, I did not set plain text the
> first time).
>=20
> A bit of context:
> At work, we are fully Windows-based, and mount our network drives
> through DFS. We are fully cut-off from the internet so everything we
> run is local to the internal network, which makes certain tests a bit
> more time-consuming than they should be.
> We have been working for years with Git and a self-hosted gitlab
> server, and have had no issues.
> Recently, some of the new hires started reporting lots of Git errors,
> mostly apparent permission denied errors.
>=20
> One of the errors:
> PS Y:\Users\xx\Public\dev\test_for_it> git remote add origin
> git@gitlab.xx.local:xx/test.git
> Rename from '//atl-xx/Basecamp_Atl/Users/xx/Public/dev/test_for_it/.git/=
config.lock'
> to '//atl-xx/Basecamp_Atl/Users/xx/Public/dev/test_for_it/.git/config'
> failed. Should I try again? (y/n) n
> error: could not write config file .git/config: Permission denied
> fatal: could not set 'remote.origin.url' to 'git@gitlab.xx.local:xx/test=
.git'

Interesting. I would have expected a different type of error message than
"Permission denied", as I had initially expected Git's new `rename()`
emulation that uses POSIX semantics on Windows to be the culprit. But Git
v2.36 pre-dates that feature, and you said below that even that Git
version is affected.

> What we found out:
> - The first thing we found out was that only network drives were affecte=
d.
> - The second thing we noticed was that not only new employees after a
> certain date were getting issues, but also longer employees getting
> new workstations. This started to make an actual permission issue less
> likely, as there was no change to their user permissions.
> - Then we noticed that the delimiting factor was the Git version:
> Users on Git 2.21 and older had no problems. Users on Git 2.36 and
> newer (we also had some users on 2.47, and today downloaded and tested
> the latest 2.50). I would have tested every version in the range 2.21
> to 2.36 to help narrow exactly where it breaks, but I can't find
> pre-compiled versions for old versions and I'm not currently set up
> for compiling from source.

There is a _huge_ list of pre-compiled versions, ordered chronologically,
at https://gitforwindows.org/git-snapshots/. It is admittedly a bit
cumbersome to find a particular version by version number; I have been
meaning to add something there but keep being "distracted" by more
pressing problems like the one you reported.

> - We also recently found out it only breaks when accessing through
> DFS, if we directly access the corresponding UNC path (what DFS
> resolves to), we do not get the same error.

Could you describe this in a bit more detail? I see in the quoted text
above that you were accessing the worktree via `Y:\` and that its error
message references `\\atl-xx\Basecamp` instead, are you referring to the
latter as UNC path and the former as the DFS path?

> It's not excluded that there is something wrong with our network, but
> the fact that it works with older git versions and not with newer ones
> makes me think git has a role to play in our issues.
> I wasn't able to find a changelog, if nobody is able to look into our
> issue closer I'd love to at least be pointed in the right direction to
> see the changes that happened between 2.21 and 2.36.

The ChangeLog is rather huge, Git's changes are described in
https://github.com/git/git/tree/HEAD/Documentation/RelNotes and Git for
Windows' (substantially fewer) changes are described at
https://github.com/git-for-windows/build-extra/blob/HEAD/ReleaseNotes.md.

Hopefully we can figure this out soon,
Johannes
