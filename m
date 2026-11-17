Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794937533;
	b=XpLzD7UMs6gip7YpYf74pKtBOjrWpjWSFKgJllQPsZ7zlMLLrOF4/0NRjHXFyIKYTGmJ
	 DxupI/+EQLjluTvXR0jcMd7D0GainQZm9yy2YKhp01P5ssgngQztc1ilxcn12/gngR3An
	 Yhz+DbuUaasSp4SJGxvC0Zhsp/LWsGOpJ8UfIfPCOisKWQbJIJY4WfNuHYFOKlCtPpBVf
	 f+UT4HDxYIy8MC3F+CEVJq4BjwIbG5tXaa+gJmjDz5Ku8XaF4cEFqI5MfyPcwBPe6k0b/
	 vBq15bDPLqFqH1wmqnUBOXySCVSj8YLCmWYxyvqSU9Hzxr2dItg+VP9fyKOmzhgao3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937533;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=PbMAmiGxaMXwNDerF8ykGmehoG71UZZnnTVT9TyjMn0=;
	b=11fxddFbh008AzVSHhF9Fs8NBIP1Ns9Hc4RkWz60ScbL6wCmup+PE2WshYyaZlKgSszi
	 SJ36SXQYI9NehH2uSqleKjIYYUL0jtxmquoLYdFYX+djLkHxI2guYldrGbRTqtZULHQEa
	 gEcYxBssyBhjurW3PMV34bOt2xl96POhYn53FAW1z53+cp41+a3q0JqP3syNfQ0ug85AB
	 kyDM//2w/67G+yAZfx/l3c78ZpSvLKKBy3sIl8zzCkMICldSd2SPY9cz1/uSs3T3mwbLe
	 61FFbdrW6PwYOQS4V4xOgx6y8soiCsOWEqfIGhT7Tw3BR3x5iW/BjbUBuqG0qOj5hGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=b1PgZAH3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5C5606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B5C5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=b1PgZAH3
ARC-Seal: i=1; a=rsa-sha256; t=1794937530; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XqhcHnRdUJI13aE2keLDjDmhz0phyalaGtY6yNoRLJ0n/Fb0sbPd0lYzuxQIpYxoAb1//TEmAwRPCexPsrPMWboSNpUgqaVHWulQ0mjNuVCvrIu2yq9wHj12VE8aZScJCdSb2eHoSRYKcJklLHvl2t9h39XympOie/0XF/0GcoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794937530; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PbMAmiGxaMXwNDerF8ykGmehoG71UZZnnTVT9TyjMn0=; 
	b=e8QowW4FHck+syjr3sabYmNj9yAKJlkcbNT1gBT0dYHwCIR0iD/PCIGtCEzdoBu8YlxkM4GmsqXJmuY4e79zc9M/Lsrmza/BVtj77cnlcL3vkmR7eVnJLpiKr5leFHgw4AilKcdXy53JZ6CydaLU80V1oqK91+oeYy50t2QgFzY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=b1PgZAH31cPhjXrGNUVtF7WKKo55kK1b2bUauGIk9s3MbIxkkRNDSaErMcXFXZJUikIDLWoEGJvIy4NpwrFioc7n+ukUS62oiSRDG+emROdAR6lhScbrFK/BcLn6rVy4TbpJclWdLg+nfXmEFsV9sigYP48oYxYhnXdTdj64pSs=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=PbMAmiGxaMXwNDerF8ykGmehoG71UZZnnTVT9TyjMn0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794937529241716.655719631649;
	Tue, 17 Nov 2026 09:45:29 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Andreas Wendleder <gonsolo@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: submodule: linked-worktree submodule hits BUG() in
 validate_submodule_legacy_git_dir()
In-Reply-To: <avuJBGlB3pRU3JU0@pampelmuse>
References: <avuJBGlB3pRU3JU0@pampelmuse>
Date: Tue, 17 Nov 2026 19:45:24 +0200
Message-ID: <877bibjqrv.fsf@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi Andreas,

On Mon, 16 Nov 2026, Andreas Wendleder <gonsolo@gmail.com> wrote:
> With submodule.recurse=true, switching branches in a superproject worktree
> whose submodule is itself a linked worktree of the submodule repository
> aborts:
>
>   BUG: submodule.c:2414: submodule name 'sub' not a suffix of git dir
>   '.../.git/modules/sub/worktrees/sub1'

Thanks for reporting this and for the reproducer.

The BUG() is older than submodulePathConfig. Users could not reach it
before 9cf8547320 (clone: prevent clashing git dirs when cloning
submodule in parallel, 2024-01-28), which made submodule_move_head()
validate whatever path the submodule's gitfile points to. A path read
from disk can be anything, so it should never hit a BUG().

Your reproducer needs the second worktree because the gitdir ".../sub"
happens to end in the submodule name, so the check passes by accident.

t2405 sets up exactly this layout but never runs a recursvie checkout.

I'll send a fix.

> With extensions.submodulePathConfig enabled (repositoryformatversion 1),
> the same commands no longer crash but die with the "refusing to create/use
> ..." message, which recommends enabling the extension that is already
> enabled.
>
> I would expect a linked worktree of a submodule's repository to be
> accepted as the submodule's git dir. If it is meant to be rejected, the
> legacy path should return an error instead of calling BUG(), and the hint
> should not suggest the extension when it is already on.

Yes, the hint is actually my mistake.

I have a local fix which I need to test a bit more, but makes your
script switch cleanly in both modes and the main submodule checkout
isn't touched.

Will send it in the next few days with you in Reported-by.

Thanks again,
Adrian
