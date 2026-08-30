Received: from mta202a-ord.mtasv.net (mta202a-ord.mtasv.net [104.245.209.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28358352C35
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.209.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788110691; cv=none; b=icdUch29aVh3Y+N31DDe3Y69v7vQJkiFXY0Yq7QHkvOk5mw8WEnxo+taW/btJnRzpJDcTi43fNYJFqySUkMNNqEIKiU6SeenrmtzpsLl/zs9yApMq9BotYDFfKoEcYh9iv7r2Qew68gzgipT9zjovWyVB31Hw2tVPyZLw1dUgpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788110691; c=relaxed/simple;
	bh=wv4D1mokWkGEYfmEElVgDIeUQh7sKpWqAzAniCV2T6o=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTyyFB4BT9yUZo8Xg+On1wqD6nCtzDbrrWPYA/cBb9Cajtor/zL+Y4nPSoEuYcqOz/w9iZQTmGcxJ63l8OyjpE5+WIZQu/LvseCjT4ZYg4NWktgpuAZO+8+WVFHjW0uSu3DIhNYm5LLP928Ipq+pJEH6Aou4VuLYckh9vDgOixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=XuYfHnWA; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=i4vsm0Fc; arc=none smtp.client-ip=104.245.209.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="XuYfHnWA";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="i4vsm0Fc"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=qI7FCk2VdyYyQBgyRIxt+CbzQ8qIV5yDXB7499EsjLQ=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1788110501; x=1788715301;
	b=XuYfHnWAu3cjuPIK3i/713OTAnFRHSXL2vvXMQOvtl2CIKhZJ0N9TXRoroVr+TqvY/B+gVqJf
	VQocg53z6fqyoV/W2wnJ53Xi8v+qnCp2CkdiDQ1WMgx2LP6STE65rN0kp2dB09gOFTbgeuI8Np6
	cRbdC7nIhty6kVTU6JVnYv7rPFofBMrpjX1ETsDI7DIAXeU3L24+Iggx7jxwvzzlEqKaQneTNxy
	7NJ+ugaNDi2kE/AGPlra7gC8S3CR+Gj22+0Miome1/FwBarbtkOcA+UcloGCAbuuHyVHJnKDNP1
	R+vTeT47oCdNAvahNzLc0h+hmzJyB2NYoUUbgJmaGdsw==;
Received: from ip-172-26-13-170.us-east-2.compute.internal (172.26.13.170)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.243.36) 
  with ESMTP id 4447b7cba49711f193a1029a3bbaa975 for <git@vger.kernel.org>;
  Sun, 30 Aug 2026 17:21:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1788110501; x=1788283301;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=qI7FCk2VdyYyQBgyRIxt+CbzQ8qIV5yDXB7499EsjLQ=;
	b=i4vsm0FcpeA4ri4zFDOZ6ClAQL6lga1/YewwKFBcq33sWzsmRT8QmZD0CHJCizbKmrMI+MbdNzK
	3QJ6fJ9neRMdn5ezXNmgs3HpOiKfzShmSwvyw90vBvq5u83sURccCm5N1p7/OG2ozWMLm/2+JY4Ud
	E2kKjT7t3e8hwKA241Q=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Sun, 30 Aug 2026 17:21:41 +0000
Subject: Re: [PATCH v2 0/4] worktree: add lifecycle hooks
Message-Id: <8bd3a684-51a0-4a2a-b70d-3981cfe10e9a@mtasv.net>
Reply-To: domen@cachix.org
To: Junio C Hamano <gitster@pobox.com>
Cc: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>, git@vger.kernel.org,
 Caleb White <cdwhite3@pm.me>, Phillip Wood <phillip.wood123@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 avarab@gmail.com, "Alexander G . Riccio" <test35965@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqtsp9tyu0.fsf@gitster.g>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net> <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net> <DKGE5DORETW5.1S9NXEX8KMQHH@pm.me> <xmqqtsp9tyu0.fsf@gitster.g>
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: 8bd3a684-51a0-4a2a-b70d-3981cfe10e9a
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.cRnaWGnmpQ5u6990_zuUsQ.6P8l_nGLTB1m57Y00ryMK8b1ojp4vIZsnRlzAIPabmswVIsCxIDGxJxMtPsZFb0N9_Ajbqk3pViGKX7TccH6L2ny26fGO11o4sItYjkn_nqrODlZJg4Lxo6Z-fWFaxc4_d1IRGRcgRh7xn-HFBBm77sK6KFV117fXGseVDdYgH0NQ9IqoeRQvxPFgEYIjwfT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: ord-104-245-209-202
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thanks for laying out the criteria for adding hooks.

> But for the hooks proposed in this topic, I do not think such an
> exception applies.

I agree that a wrapper is sufficient when all callers are under the
user's control. The problem I am trying to solve is that the component
which needs the notification does not control the component invoking
Git.

For example, devenv may register lifecycle handling for a repository,
but worktrees can subsequently be created or removed by an IDE, a
coding agent, another worktree tool, a script, or the user directly.
Requiring each of those callers to discover and use the same wrapper
makes the notification optional in practice. A repository hook provides
one place where that lifecycle behavior can be registered regardless of
which caller invokes Git.

"git worktree prune" is also difficult to reproduce reliably in a
wrapper. One invocation can remove zero or many administrative entries,
and Git knows exactly which entries it actually removes. A wrapper could
compare "git worktree list" before and after the command, but that is
not an authoritative event stream, can race another worktree operation,
and has limited information when an entry is already damaged.

Alexander provided another concrete example later in the thread: Xcode
and several related tools keep substantial path-keyed state outside the
worktree. Agents invoking "git worktree remove" or "git worktree prune"
directly leave many gigabytes of state behind even though a cleanup
wrapper exists. Phillip also mentioned having an unpublished add-hook
patch for copying per-worktree files such as config.mak.

That said, I take the point about avoiding a proliferation of hooks.
Instead of adding three separate hook names, would a single
"post-worktree" hook address that concern? It could use a fixed
interface such as:

    post-worktree add    <id> ""         <new-path>
    post-worktree move   <id> <old-path> <new-path>
    post-worktree remove <id> <old-path> ""

All paths would be absolute. Pruning would issue one "remove" event for
each entry actually pruned, and none under --dry-run. As with the
current series, the hook would only report an operation that has taken
effect and could not undo it.

This would also address Caleb's comment about passing information Git
already has rather than requiring the hook to query it, and it avoids
using the argument count to distinguish events.

Would that narrower interface, together with the need to observe
operations from callers that cannot be required to use a wrapper, meet
the bar for a native hook? If not, I would appreciate guidance before
spending time on a reroll.

Thanks,
Domen
