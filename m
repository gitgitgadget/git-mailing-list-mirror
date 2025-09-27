Received: from cache69.mydevil.net (cache69.mydevil.net [213.189.54.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02C32512FF
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.189.54.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981853; cv=none; b=Ifqywm5o+iardzH+edjayxSfGzzDoYNsBO6LEwyxaJqFSgz+gpx57dytmS5B590HSvvYtim+xMNd0+3dlT7KQnuaGuDbGBIftkXXU67XlGL0ASgC3vDjCOXFu+we8nYtEshnyXAnDTps/rt05vwaNfH8JU3B9lfVUArBHHk0+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981853; c=relaxed/simple;
	bh=PFwG/5RMmqewW8pb3WroZv/GpSX+wCPkM6uHEDtMgYo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=L9h9S3GWR5oeeH+LHsQqb/ihE7NIi52oC/6BOEbE1VjtZ/ocAW5xH8qYFqgRzhqEE3Dh7bqn1Tsj28UiwyIIT+b/PiiAt7SU/9SWGjGjJ5dDaDo66qPiLm8wJEgf3k9Ea892qqjjKnCrwBqNQYALL929f9PVEyM7Ig8ZyoQLfzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jcubic.pl; spf=pass smtp.mailfrom=jcubic.pl; arc=none smtp.client-ip=213.189.54.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jcubic.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jcubic.pl
Date: Sat, 27 Sep 2025 15:28:24 +0200
From: "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
To: git@vger.kernel.org
Subject: What is the reason behind not hiding git worktrees from git?
Message-ID: <20250927152824.3132af88@jcubic>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-System-Sender: jcubic@jcubic.pl
X-System-UID: 1444

Hi,

I use git since 2010, but I've discovered git work trees recently.

Why git work trees are are not automatically ignored by git?

It would kind if silly to add the whole project on different branch to the
main repo.

This is an example:

git worktree add base
git status


On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        base/

nothing added to commit but untracked files present (use "git add" to track)

What is the rationale for this. Why base/ is not automatically ignored and
you need to add it to the .gitignore by hand?

I use git 2.51.0 from Fedora default repo.

--
Jakub T. Jankiewicz, Senior Front-End Developer
https://jakub.jankiewicz.org
https://lips.js.org
https://koduj.org
