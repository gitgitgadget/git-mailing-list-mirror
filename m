Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC329215C7D
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840408; cv=none; b=pFyTJxAxwZs8tfUMy+OuaHe0Yi75Gz3jYW0+a26GdbzK4VaBB5yhtTHwmx2z6SfhkBoGC24oGVQ67Ivymg8airJNry4lXLEqRbfNKfpnTisFWk2qdG1WHa6EQH9iejzVOLf++wnNHywC3bLgTWXkuz5dyGBo789nXaw0Ego7Zdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840408; c=relaxed/simple;
	bh=b8oN3qt06t+xK41SS0e2bNDlHI8PW5QpGaTyw8EHNH4=;
	h=Content-type:Date:Message-id:From:Subject:To:MIME-version:
	 References:In-reply-to; b=dnbNQktUE4IjhDikt48kD5nfz6pkaDu2FtNu1E99sHOlHpTDlEjtC3y/yC0OM6KhOSZKZXrJpFX5KwUt74K92QQwyqnVhsjkXdjmrK3xMb1xX2ih7X3w2j79YGfD1z0YOeHYvC86y4maLAZZVikijreFUpd7zL19eyaCztTdGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=lykxk6LG; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="lykxk6LG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=+wp4rHLU02BBZHgvkYTPm+Fhd8gpxrZtGWL5kQJJ56I=;
 b=lykxk6LG3kPn5tVT+nc7IDHNx6LksXXLHp3K6wWcznnPiWywXO9GNbZyk+ImTmWRV4Yshm1ivB/b
   5JgEA/g3BwpHDbm3ZBLldZv6o78sKCYOyHvIBOiBovJGwyzJ2Ystr966SgKG5enyNXs5mDogni0O
   JA5eNW4HSmR/SYAvmZTAook3JdWVO/n4ig3PwMwwLG+UvLAD8MIXtSCbCwZnKR3BcugcH4VOJPb/
   liwKFNUx3K86EysC36rby/gWae/SvlmE3GajApucepAY7cmjuprL2fmhnbWEqQJCGRBRuSQbJCsQ
   SPPAIzT4KPm+pBLaBVx2oBTtZj8HU7h6AZJC/A==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SMH00D9FWRIG1A0@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 05 Nov 2024 20:54:54 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Content-type: text/plain; charset=UTF-8
Date: Tue, 05 Nov 2024 21:54:03 +0100
Message-id: <D5EJL736B135.2ZP7G9GHUY0YL@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: What's cooking in git.git (Nov 2024, #02; Fri, 1)
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
References: <xmqqr07rwsmd.fsf@gitster.g>
In-reply-to: <xmqqr07rwsmd.fsf@gitster.g>
Reporting-Meta:
 AAHNShRwvYy05t7jWIBSV1eK6noDEWlL3BSkgaicuQHVzKGaMXS1n84nm8V/OJiN
 fDZ8QuC52gIxA5BuQs2rvtExWCzp9t3+gE/ekLW9T5HGL7NsGAGKe6IHhVIoVk7S
 bGKq6JUG+YAsryJIch4uGxg9R1uvkcMcqB9CWjUg1cDTnKaP0wiXeKPB9SozJj1Z
 UULDhjIQllTO7urIIVPCimEQHAGZUiXkkQQsxjtXmaStbfLRL6IKHaABLsy8eQhI
 oGZwjgP5ZT/l0aEk8YIDmoloIoHHq+N6dQ4pbOUhMBA98sz5BpEAwoEimHUosDar
 OQag0KgbzJKinTV2dQ5bCKBfYO+8dAtCFbyRUWV9Cf3uS3n9ByRBWxq8fCx4XWEb
 lD2gcoYdVCDvVGLKa4yRph/p5PnrIsidWYSDIFSgobY4nzCPr5YbWep8IQRsSk+c
 8lFVA74gPmb9rpvI0Qf3c2HBdqNKYyd0KuUcmkFH8NoBSuEyOOV0Wzox


On Mon Nov 04, 2024 at 05:05, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen', and
> aren't considered "accepted" at all and may be annotated with an URL
> to a message that raises issues but they are no means exhaustive.  A
> topic without enough support may be discarded after a long period of
> no activity (of course they can be resubmit when new interests
> arise).
>
> Thanks everybody, especially Taylor, for keeping things going while
> I was away.  Unfortunately, we seem to have acquired way too many
> topics that were posted and picked up without getting reviewed.  As
> we discussed a few months ago in <xmqqployf6z5.fsf@gitster.g>, I'll
> start discarding topics that have seen no activities for 3 or more
> weeks.  Interested parties can of course revive these topics.

[snip]

Considering the above,

> * bf/set-head-symref (2024-10-23) 8 commits
>  - fetch set_head: handle mirrored bare repositories
>  - fetch: set remote/HEAD if it does not exist
>  - refs: add create_only option to refs_update_symref_extended
>  - refs: add TRANSACTION_CREATE_EXISTS error
>  - remote set-head: better output for --auto
>  - remote set-head: refactor for readability
>  - refs: atomically record overwritten ref in update_symref
>  - t/t5505-remote: set default branch to main
>
>  When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
>  missing and discovers what branch the other side points with its
>  HEAD, refs/remotes/$remote/HEAD is updated to point to it.
>
>  Needs review.
>  source: <20241023153736.257733-1-bence@ferdinandy.com>

and that this version of the series has been in for two weeks: is there
something I should/can be doing so as not to hit the 3 week mark?

Most of the patches in the series have been reviewed, some multiple times, =
but
v9 did have a bit bigger change due to a review suggestion and there have b=
een
two new patches (the first and the last), that were added to fix some issue=
s
(bugs?) uncovered during testing the series that were related to the topic.

Thanks,
Bence
