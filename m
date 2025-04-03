Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6D2517B5
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743703834; cv=pass; b=eVPt+WLrKZGMobYvpnC8ZAKPNjSQt7PZRy+L4wg7LLJhiqfy9mvcVWVdLAGLYa/lTk2wbUYWYijHHIgMwtBTlIwTjWai0oGq8FsjGucD4VjQqFU8ebbJ+hskg1qW0gba6iTpJ9qx37JbOrfbVZ8upC5JUMk73lmTHvSjhsGpsik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743703834; c=relaxed/simple;
	bh=dkhP726zWo7KGFsYiKtQL5bx00o+zC55dTigCEzFlQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEuakD8MFvkzvUA4jx2lAnqJjTENb1i1W58BgGGhPxEwjV0ZRKy/Y/AjMsEL3ySEKQVjz+eqNhikiu2s6HmSngAQvXeloE2w/gLUrbhOy2clPbaM+RPW6EfNDUkrQrj+5MBphym75S5UeIAaFtCcGH7yEgHBSASQJFSYVQyROnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=R/uIJrwp; arc=pass smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="R/uIJrwp"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C57FB1C330E;
	Thu,  3 Apr 2025 18:10:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a284.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.97.44.91])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0E0321C39D3;
	Thu,  3 Apr 2025 18:10:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743703826; a=rsa-sha256;
	cv=none;
	b=OzCVGZd4quuctwkpSXuWsYnls7PLOmfC2defZCP94ETv4qu4OAkCSo+dSkWcRb82EQVi3d
	0yLlscCS4LBTajYynzjar0gebv+e7A5qxODBK+uYPcpDcY9Lj4rLuMJmIKEHMcLl2DVZMd
	SugGdbOE2Is9VwPpwaHSEB3IMZlEpauw0ZWcPea+vcSeHljYRywoei42VYWOWQba5qqu3p
	z3VJ9tOe+EWf6tB9KPFLFXop4GL2qLFrS1zpjCWIJbuKKTl8nmLsxbzyiAWg8KuBT7t/CI
	lz5bi+AATYlwgsQkGK5W5wBloDwv7vMIvDTmEMLZAp1H1HgYSBmKHZGtByfk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743703826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rDgCCk5zWqfXUEnNZM/FnHdfCk8jQNUdpWZ+YO28zGc=;
	b=c/1hxkGBQCffB5/11ZooA2XfLTWNIwmgaYqC0DjRGqiP2CBqTz2WLm/xefknDMCo5QWtyv
	2PmwfhEZzvubfGfX9/jrOYD6AMHBGDu/+GSILhYHvMVUzMCjQAJNTaWV49cwPpV3fdtz9w
	lm9ixKvsAedMfgowJpJh/NVegkA5NvuWeIoDJazcWjXjXLWk1tHKFr9zjtl8YLbHRAiaL8
	2myPLAFKbJvqfnhLKTT/ZKqcwIgCHZM1q6AVWPez68QyPdpJ5S3cDVGAEQ4a0rRci8/5Hb
	sXyxYN2qArZZ1Sgc3dcOBHkdlg04WnTLa7jtg/FVvGEHXVh8GCs5OLIiiRlOvQ==
ARC-Authentication-Results: i=1;
	rspamd-5c8769d675-bz25l;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Thread-Trouble: 092382676d789acb_1743703826621_2801563415
X-MC-Loop-Signature: 1743703826621:2983062382
X-MC-Ingress-Time: 1743703826621
Received: from pdx1-sub0-mail-a284.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.44.91 (trex/7.0.3);
	Thu, 03 Apr 2025 18:10:26 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a284.dreamhost.com (Postfix) with ESMTPSA id 4ZT8sr6VrYzdd;
	Thu,  3 Apr 2025 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1743703825;
	bh=rDgCCk5zWqfXUEnNZM/FnHdfCk8jQNUdpWZ+YO28zGc=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=R/uIJrwp0v1D2PZUjEGQ6XNhyopnk6g5nogNxKt1pcY0UuuGSi655+uYp2nnYl84d
	 TEFL6olqjtK1DW9KAUQEXaFh5T3I0WCY8kaEsJg2e915/2IXiTJa3h/CZnS3okXpEp
	 fj18zsY6FSgE9e6xMksVGO6fTTnQ5vpYGkdl38OM+aV/mScp4jRbTa+97VSB1yzJyR
	 OLACStNFrjqA1LF1THN1Kc5S8ekUMDXwxUf/F/hAHfhaE9vLQJas+tz2a7rPzcaQnC
	 86j5cBSMXNGv3cVcmPQdggc8JVkne3UFG0j6SfWRVdDHZ+gwqExwJFcyPdoKTLpyk3
	 /WmucgaDJYt/w==
Date: Thu, 3 Apr 2025 13:10:22 -0500
From: Nico Williams <nico@cryptonector.com>
To: Elijah Newren <newren@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z+7PDi5y4wXJBK4r@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>

On Thu, Apr 03, 2025 at 08:39:31AM -0700, Elijah Newren wrote:
> On Wed, Apr 2, 2025 at 11:48 AM Martin von Zweigbergk
> > There are many benefits to having a change id even if it's just
> > local. I mentioned some in my email to this mailing list in [1].
> > For example, it enables
> > `git rebase main <change ID>; git switch <change ID>` without
> > requiring the user to look up the hash of the rewritten commit.
> 
> But <change ID> isn't unique, right?  The whole point of having the
> change ID is to preserve it despite edits (e.g. rebase, commit
> --amend, cherry-pick), meaning that you end up with multiple commits
> with the same <change ID>.
> 
> Why would this work?

I agree that `git rebase main <change ID>; git switch <change ID>` is
not a good UI, and I wouldn't want it even though I want change IDs.

Change IDs are documentary, and they help people understand that various
commits are just edits/rewrites of the same original commit.

> And if it does work, isn't it expensive since you'd need to walk
> history to find it?  Or do you keep an extra lookup table on the side
> somewhere?

Worse: since there can be many commits with the same change ID they
can't be used as refs because Git can't possibly be expected to find
_the one_ you really intend -- how could it?  I suppose Git could let
you pick from a list, but that's not likely going to have enough
context.  Maybe Git could give you a list of named branches in which it
found some change ID's commits to pick one branch from, or maybe one
could `git cherry-pick --from $some_branch $cid` and have Git find the
commit(s) on `$some_branch` that match change ID `$cid`.

Also, maybe commits need to support multiple change IDs.  For example,
one might want one change ID for a set of commits (eg implementing a
feature), and each commit in the set having a second and more unique
change ID for just that commit (and all edits/rewrites of it).

> Yaay, I always hated it as a trailer.

More headers is better.

> cherry-pick & rebase preserve author name, email & time, while
> creating a new committer name, email, & time.  To me, the change-id is
> about the authorship, and since these commands already preserve
> authorship, it'd seem weird to me to have cherry-pick not preserve the
> change-id by default.

+1.  Besides, rebase is just a a bunch of cherry-picks, so cherry-pick
is the fundamental operation here.  If rebase is to preserver change-id
then so is cherry-pick.

Nico
-- 
