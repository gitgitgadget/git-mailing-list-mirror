Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007AA1367
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339415; cv=none; b=pqtJiFqtji2/yYRoLHpLSxAxKLYKWBBf8Vthd4Lzhy16husVH+V+eon1ioF4Bx7T+s/J6DaqwCTfGl2i9F1UcNha5lL5SzD4MbVwmLcgLv+p7mhw7aEAsqMab/k+uC6Ail64AmmhuG/8SVp8HKMiAklfP5irdDxyRSgrexFwIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339415; c=relaxed/simple;
	bh=XsIImo8L1HQtPuVl+MxawzxDnIw6Iuvy3fQqIPlmGP0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NhZwFiY8PTKhmA/16qmxDTLLJJfTHP6zvQXy63HHTTYNMyYxeDnSeWiJxxiUFxaO6+xhFKZT1xRxZmCdCGYMUkuQUpNPdzzP1mDW6O2ARwSO7ffBIOx4iILMyJEOiVBuhxyBzHfDVuXaDLwUNuah2zIItj7j8aMEFIpb/YnIZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MAxM3f1o; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MAxM3f1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779339404;
	bh=HH46zLUJu4Yf2M1h07QJWC1KogcfuglWRAJ4XMX236U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MAxM3f1oecrlpw2djboRbnYWUcxKWy2ve9+CrKCdbhvoZKazd+Ia1U3eZ0N4fouAM
	 8nQ9iS7I19a6SyIgQ5P0eBJumo00e8Am7DwCs3UkSeQ+xYG9qkWnF+NhCH4sIzcJUP
	 Gtk314tJFYXpbTZiQbj7FeE6iZhDe6RdMobqNEpo=
Received: from DESKTOP-31CF0TC ([121.224.209.33])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E0137A2C; Thu, 21 May 2026 12:56:01 +0800
X-QQ-mid: xmsmtpt1779339361teunvln69
Message-ID: <tencent_E13EB585242AD7C263B8B3B732A428465D09@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJn/wbpYvQR1Rrek622IfmJB8cIT5VrhPMVREUVH79xEFu58B1vo
	 DvJcPluyku507yKX8PECS60QdpXGTK8kVAj7Zip0HKyt6vX17ECenJlkIpb2kS2gFthYXocdiYxZ
	 vnOUlwSYqvhb+8hbUO1mXx+YwMFDEi1cxJwAKOLkZZgcYkEY3Y0GDGDD0FrxPBRhhkhIL2ppdCGG
	 4o4P/rB9lCf2gQuQV2BNggMHuAifNEZQ672Q45w+MqXVfVDfYiEbmmculn6J3K1oUFg+OgSRRkDp
	 PmnkmB7uJKTaAbO8gtVv1qHTT8m0v93B7siZjxJ8LGOBrHxYcP8EbklE4tr6BhuevCaMO9wayhb8
	 JAgfdgisEkfeMxw0gx7ZGdI3Xh4XqDbzD/s/UendymWiVgivvKjyqwFb6edmezw6kyiCiI//hiP+
	 JhJFptJ2YLHRj14jQeMRqXYkjYXCkw78asAOcteKL3IDPJHMXSy/RDGviJQbhPOD955nuxYPsOGH
	 zOQnPmx5SqR6ZUgUlnlltnBwxQHqZXTnFUmTEBQijOOwY99xeXb7GFaFwONsQjO1RvCegGoaoDpl
	 cCpsTW88v0ajEjddvjmZu5eyYPinOWAq2A92Ivdz8n6RMKY6rLl21d4gAIdL8LVhc1B163cmlkJA
	 OCrsaTCSD3CXP5UHIQoSFE7+T8BCkJDlhixjtHG1cYrCN7eiqxVjAdNHkao3cX58JakpYegDO18Q
	 tz+E/LvbF3Dx49nf3d1C6ofMXtQlc4upELcFrxyTmcTD35vcUugCHgjPHnEAsFDPtu16bXtC8aUC
	 0lfLfXyvaJ0oLlHoClwV4JWFcOnAynXVgK9fDx+ftfqRR0oNAZI7dSU8ZPhhnO7fSOGMsi3yt2zH
	 nk6voLEYLp5wF4CCMbCKTvg3wu9LrfikmUYYXx9HQy6ARIeY6dxXis/EyCHfenuE7CdAnZI7eF+/
	 5i2fwE0b4LIIJYlpRZxmq9KWkr7F1JpJCQAQquWYUm/bgIa2g4ag==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Aina Boot <bootaina702@gmail.com>
Subject: Re: [PATCH v2 07/11] git-gui: try harder to find worktree from gitdir
Date: Thu, 21 May 2026 12:55:27 +0800
X-OQ-MSGID: <20260521045530.115-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260520202411.108764-8-mlevedahl@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 5/21/26 4:24 AM, Mark Levedahl wrote:
> +	} elseif [file exists {gitdir}] {
> +		if {[catch {
> +			set fd_gitdir [open {gitdir} {r}]
> +			set gitlink_parent [file dirname [read $fd_gitdir]]
> +			catch {close $fd_gitdir}
> +			set worktree [git -C $gitlink_parent rev-parse --show-toplevel]
> +			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
> +			if {$::_gitdir ne $parent_gitdir} {
> +				set worktree {}
> +			}
> +		}]} {
> +			catch {close $fd_gitdir}
> +			set worktree {}
> +		}
> +	}

There is also an unaddressed issue: 
In [file exists {gitdir}] and [open {gitdir} r], {gitdir} is a 
literal string referring to a file named gitdir in the current 
working directory. However, in the context of a linked worktree 
(created via git worktree add), the actual file path is 
$_gitdir/gitdir (e.g., .git/worktrees/<name>/gitdir). While the 
current working directory could be anywhere (even inside the .git 
directory), $_gitdir is an absolute path pointing to that worktree's 
gitdir (e.g., /path/to/main/.git/worktrees/branch). The gitdir file 
resides within the $_gitdir directory and contains a relative path 
like ../../.git/worktrees/branch. The current code logic will never 
locate this file. 

Additionally, [file exists {gitdir}] checks for the gitdir file in 
the current working directory. Since the function has not yet 
switched to $_gitdir when this check runs, it is almost impossible 
to find the file. Consequently, this logic never triggers, preventing 
linked worktrees from being recognized. 

Maybe the identification of linked worktree should not directly look 
for the gitdir file, but should check whether there is a.git file and 
its content points to... /.git/worktrees/... ? Anyways, using the 
literal {gitdir} to search in the current directory lead to risks. 

Shroom

