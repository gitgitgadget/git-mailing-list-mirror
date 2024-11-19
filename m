Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567D1C173C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010411; cv=none; b=lv03o3nhjLa+z6xuhowi6nx9Smew04OaQxAZZNIEP69d8vKoY19W118alSQB4p95EQGCY3g4YJ+xEGoSrB9REkiHe2N4zfW6wk8OxnPzcyZm/PDfr5eEFZ794OrdzsmO7gJ/dU/5/uWrUJjJIG/eP6FWmlVi/CVmSKhQP8CcmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010411; c=relaxed/simple;
	bh=BFAMOqQbndw8vaVLHQUt8jITXoEUYfdZNXob4LWXJkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKJm9DFf7JMuaDTD7hNw6JeeOYHKhznDo0L9Lqgep/Aoecxe+BW+N1r+EyHMipqyIdLBvj4shq62JYInFThW8vKjltynu6/Nk90OPdBVOpMhigTVeUf9oxdXXjzu8gCP/nTsKX7u53h+SG7L8SxuOn4Kc0rbflVyvacO8HpPsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=AAZE+/Lg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="AAZE+/Lg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1732010401;
	bh=091goaxQSzoooK+Yfteuoii371U3C7mGyiosJx1hcW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAZE+/Lg/HxzztMsvz4T1O0Of2p8Tw0XFB0UiZCpIK/d69eZLyFUz0Dz0uvE0RzsE
	 t3iNJdkBd1086ENOL3bObPLWiQ1IAmdNkGQym1HlT8Ly0rslxyjfywurz/ltqQUdXu
	 eoELtWOCf+OaHtosoxQgJawN8TD5XhYZkgmAj9pgpGs02gErupOwsmIdgDhNv7DJZ4
	 8jodJ3JYGYyVjLg/aKTOH5Ilpsd/Acb/flw5G9W8jz+t3KAJd9DJniF+ChWSSN8E6f
	 UJnPWBOuYL7nsz7fW3aN53m0ttjoBmPO64f4DgjH3YfYiPF57alHt9xxU4IYJAC/V5
	 9bnRtRD8QD4Yw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
	id 4Xt0NK5P74z4xqN; Tue, 19 Nov 2024 21:00:01 +1100 (AEDT)
Date: Tue, 19 Nov 2024 20:59:59 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Beat Bolli <dev+git@drbeat.li>,
	Tobias Pietzsch <tobias.pietzsch@gmail.com>
Subject: Re: Gitk maintainership, was Re: The health of gitk
Message-ID: <Zzxhn64xeQv6ItXm@thinks.paulus.ozlabs.org>
References: <pull.944.git.git.1610234771966.gitgitgadget@gmail.com>
 <bdaab72b-37f4-658a-716a-d6a958b6f709@drbeat.li>
 <ddee92a7-3d1e-f869-9cc4-72b70eee0dd5@gmx.de>
 <ZzWkgblaoWehC0kY@thinks.paulus.ozlabs.org>
 <5ccc1943-c2a3-4896-a858-aa5fd6cdd426@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ccc1943-c2a3-4896-a858-aa5fd6cdd426@kdbg.org>

On Sun, Nov 17, 2024 at 04:26:41PM +0100, Johannes Sixt wrote:

> I have given the idea to take maintainership of Gitk ample
> consideration, and I would accept the task. Paul, let me know how to
> proceed.

That's great!  Thanks for taking that on.

> Regarding whether to have a separate tree or not, I would prefer a
> separate tree at this time, but only for the reason that it is known
> ground for me, and not that it has some (technical) advantage.

I think you want to clone my tree at git://git.ozlabs.org/~paulus/gitk
and work out what to do about the commits that it lacks.  Then it's a
matter of the usual maintainership process (e.g., apply patches,
publish your tree somewhere, and ask Junio to pull from it).

In the current upstream git tree, I see two commits that were applied
to a clone of my tree, then pulled into the git tree:

bb5cb23daf751790950ff9f761f8884e21c88d00
7dd272eca153058da2e8d5b9960bbbf0b4f0cbaa

I assume you can pull them into your clone of my tree using suitable
git commands (I guess you would create a branch with 7dd272eca153 as
its head and do git pull --ff from that).

There are three commits that touch the gitk-git directory in the git
tree directly:

65175d9ea26bebeb9d69977d0e75efc0e88dbced
d05b08cd52cfda627f1d865bdfe6040a2c9521b5
728b9ac0c3b93aaa4ea80280c591deb198051785

I assume you want to make the same changes in your gitk tree, so as to
avoid conflicts in future.  I expect git would merge commits in the
gitk tree making the same changes as are already in the git repo
without fuss.

There is also b117cee32259acf923c3ada52b4dd89f2ea6a454 which touches
gitk-git in the 'seen' branch of the git tree.  I don't know what you
would need to do about that, if anything.

I hope that helps.

Regards,
Paul.

