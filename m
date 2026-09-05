Received: from gorki.wkraft.org (gorki.wkraft.org [78.47.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315D38B158
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.65.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788639972; cv=none; b=JbsiB0Zq24TVCpVHs/tkNBSAi57W8e1blcdu6K+t9ET/NGj3qPWyyJOURrA58tPFwAXvHJSu7Ql8VK7CoQLmGLei8Cbwmy4oOT0ye+hvXtpqdhNhvV0DMJ7pBnYNbTl+gun43yHp2YeCMaqiZrDuGoP+6WT+u6cNFEy9VhrDLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788639972; c=relaxed/simple;
	bh=WrtNJ3ig8pyvfgRx2sO0C4I/Nzb4hZxG4oK1vAoWKMY=;
	h=Date:From:Message-ID:To:Subject:MIME-Version:Content-Type; b=d+QzuH8k1sxPEBnJ5catt/pPz0GAKQpfdCo9joSgCdda4hVA37gcru3j5QYSAqpKaPRjQelD0TxlTDgcPDlSIgvg7Hf2wW1AIPkXj1ohOZl16Yjjl/RqZ/v31KpnC+ZfYCKfEyTVWuo8ONbVwhx5qw5RQaKVkgzrN8peV1t9FLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=erdmul.de; spf=pass smtp.mailfrom=erdmul.de; dkim=permerror (0-bit key) header.d=erdmul.de header.i=@erdmul.de header.b=cDLQomIK; dkim=pass (2048-bit key) header.d=erdmul.de header.i=@erdmul.de header.b=VRADEy8g; arc=none smtp.client-ip=78.47.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=erdmul.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erdmul.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=erdmul.de header.i=@erdmul.de header.b="cDLQomIK";
	dkim=pass (2048-bit key) header.d=erdmul.de header.i=@erdmul.de header.b="VRADEy8g"
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=erdmul.de; s=42; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:To:Message-ID:From:Date;
	bh=drBg6ZZHnxxq5IHLrs1wXMIUY1iQD07VKqeHsrUT82E=; b=cDLQomIKrgptRRjmwys/Kzw+z4
	AkwTLnWHMBduM0XpgTD3glpmE+XG5JoaBsPhsWR7K8HEMTSORDwJ559XdZCQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=erdmul.de;
	s=11; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:
	Message-ID:From:Date; bh=drBg6ZZHnxxq5IHLrs1wXMIUY1iQD07VKqeHsrUT82E=; b=VRAD
	Ey8gGeqXNTUNrwSL4cPxgXU0P/ikvREiEa1YqtMW9G1kLelqWCLw5oXIlWBfmvWw+P+8dYjAyhteE
	zLU2Lew2+smf3gXiLVQUmtsCz9+FYgrgDhDH8NRh+TV8ArS6FRx8ATUot3d9xhLcPJhz8o36B/y9f
	teVlBzKHc9FBUIIDR6xyxZyEyX+jlqMzh6qmahPqvA5ceatlg2xZo0PhB7Y1L2647OoA4dJAkBz0d
	y+02CzCEDgs0okKyg1hTBBUd9bJbIOQV9ptGviAlXz+v8jAwpP+vXNdYspm+XmNG/jIwilNmkAboE
	KbgxrOI8neuZuV5QywRyVqGXaNSraw==;
Received: from trusted_sender@trusted_host
	by gorki.wkraft.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
	(Exim)
	(envelope-from <mailinglist-git@erdmul.de>)
	id 1x2wxi-0003c4-17
	for git@vger.kernel.org;
	Sat, 05 Sep 2026 22:26:06 +0200
Date: Sat, 5 Sep 2026 22:26:04 +0200
From: Erdhoernchen <mailinglist-git@erdmul.de>
Message-ID: <1710398737.20260905222604@WKraft.org>
To: git@vger.kernel.org
Subject: Solution searched how to rebase/merge an existing commit to the reference of an Github PR
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hello to all,

I hope, that this list is the right place for my question.

I have set up a 3-Layer Git infrastructure, with Github as the topmost repo=
sitory.

Below is a local dispatch-repository from where I will pull PRs from Github=
 and=20
push all local changes up to github. No code changes are done here, this is=
 transitory only.

The lowest tier is the development repository, where daily changes are happ=
ening.
Here I have several branches for new functionality or some older code as re=
ference.

As the main branch is a high volume repo, with autocommit on succesful comp=
iles
there is a separate branch for pushing fixes and new functions to.=20
This is an orphan branch, which gets updated from time to time, when new fu=
nctions=20
or fixes should be deployed to the upper repos. Here I create the commits, =
which should
be finally arrive in Github. Using Conventional Commits Information about w=
hat the commit
is good for, is included.
This works already perfect. Once a new version or a fix should be deployed,=
 all
changed files are checked out into the release repo, and a single new commi=
t is
issued.

This branch gets pulled from dispatch-repository and from there it will be =
pushed=20
to Github.

So this direction is works just perfect.=20

My problem are now PRs coming from Github.

My workflow is here the following:
From=20the dispatch-repo I pull a patchfile with all changes from the PR an=
d store this
patchfile in a directory, which can be accessed by the development repo.=20
In the development repo I use the patchfile to make the needed changes and =
bring them
to a new commit in the release branch.

This commit has no reference to the Github-PR besides the information in th=
e commit
message: "fix: merged (#123) to solve ...."

Now I need a way, to integrated this release commit into the dispatch-repos=
itory=20
and finally to Github with just a single commit.
I need to integrate it in the PR branch, I have fetched with:=20

`-git fetch origin +refs/pull/*/head:refs/heads/pr/*`

How can I make a three way merge or a rebase, so that the PR in the pr/xxx =
branch
is used as the reference for Github, to close the PR as solved and merged, =
even
when my local repository is some commits ahead to the PR.

This is the usual situation, but I my goal is, to get this done in one sing=
le commit,
which has the ID from my development:release branch, so that the next commi=
t from
there, will fit into the chain, without the need to merge ghost commits bac=
k.

So the picture looks like:

          +------------------+
-->PR/x-> |   GitHub         |
          +------------------+
             |        ^  ^
             |        |  |
             v        |  +----how to manage this
          +------------------+    ??????           << here is my problem
          | Dispatch  |      |-->pr/x branch
          +------------------+           ^
             |        ^                  |
       patchfile x    |                  |
             |     new version<---+      |
             v                    |      |
          +------------------+    |      |
   main <-|  development     |--> release branch
          +------------------+         =20
            |   |   |
            v   v   v
            different
            development=20
            branches

The direction from release for new versions/fixes not releated to an PR are=
 working flawless!
Only the direction, how I can handle the commit from release, so that is ba=
sed on the PR
that Github will merge and close the PR is my problem.
My goal is, to solve this in my repo without media disruption, by changing =
for single actions
to the Browser window.

Thanks for useful hints. My goal is, to solve this with pure git functional=
ity
without gh or other helpers.

If this is not the right list for such questions, I would be very glad, to =
get
some informations, where I can discuss this problem with real git experts/e=
nthusiats.



Kind regards

  e.

