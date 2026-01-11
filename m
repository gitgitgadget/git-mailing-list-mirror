Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DFF2222D1
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768146379; cv=none; b=rF0U4gnGVJa1V2scbjXoU+a5opJg5BXXMwh9OuFrwbBWl3RD9JyuTcjAhq3mNWqiIvr50SgVIXQZuV8Ged4lC/GIIKpRSmCiEhtBVwFrcgPZvyGe5NdNnxHAT5bFUjOHp+CvjdvSLHrX0ytyOFam4lplvQOCMWp06RcFfhq9yEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768146379; c=relaxed/simple;
	bh=xqtmIn6lAcaaAR+/rXayIzdiNHfE0h7FDCNhuQTTZSk=;
	h=Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:From; b=Uzx+HnCcLRm/t496kytexzGQBDDGCw7sBD5oyVtNkCmSsjNDh/zOKCHZZVFqKvHA3gDw6sloLG3ZVYXi/RqlzyeNVMasReiyllaQE0jdr02rgi1zR64RDyWBPYoS0IXTu2KGp7wgsx0sWnhSomwq6F4ogC9Fj9N4SJ+uLTB1Kiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 72782 invoked by uid 3782); 11 Jan 2026 16:46:14 +0100
Received: from muc.de (pd953a70b.dip0.t-ipconnect.de [217.83.167.11]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Sun, 11 Jan 2026 16:46:14 +0100
Received: (qmail 7353 invoked by uid 1000); 11 Jan 2026 15:46:13 -0000
Date: Sun, 11 Jan 2026 15:46:13 +0000
To: git@vger.kernel.org
Cc: acm@muc.de
Subject: Difficulties using git rebase.  Help, please!
Message-ID: <aWPFxQloyfx8x0ED@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

Hello, Git.

Some while ago I made some amendments to the Linux kernel for my own use
(at least).  I now want to rebase these changes onto the master branch of
the Linux Stable repository.

When I wrote the changes, I based them off branch linux-6.13.y.  The
command I tried to rebase with was, with PWD being the pertinent copy of
the Linux repository:

    $ git rebase --onto master origin/linux-6.13.y HEAD

..  This didn't work well.  In particular, I got a conflict in a file that
I had never changed.  Why?

Well, I corrected the conflicts in that file, git add'ed it, git rebase
--continue'd, then got another conflict in a file I'd never touched.
Same again.  After the third such conflict, I gave up with git rebase
--abort.

Criticism: there doesn't appear to be a --dry-run option in git rebase,
with which one can see how many files will be conflicted.  Instead they
are notified one at a time, drip, drip, drip, .... to the user.  In my
case there might have been four conflicted files, there might have been a
thousand.  Either I'm missing something, or git rebase is missing
something, hopefully the former.

Incidentally, when I do git status, I get as part of the output:

    Your branch is ahead of 'origin/linux-6.13.y' by 2012 commits.

..  I haven't done 2012 git commits in my life.  What does this number
2012 mean?

So, back to git rebase.  Would somebody please explain why I am seeing
these conflicts at all?  Please also help me make progress.  I'm stuck.

Thanks!

-- 
Alan Mackenzie (Nuremberg, Germany).
