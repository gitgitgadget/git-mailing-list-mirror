Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03F1E51E0
	for <git@vger.kernel.org>; Thu, 21 May 2026 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339809; cv=none; b=eI9hS3XTAG7W0vqd6R/Qrl85qNP0dpFkkMZg4uTRvOa7mSHfYKly5vU9HwLqcLhme9vSewU7lLQySho3Gq2SKKE6fOon/RtLOzYzvpbkDxYgcs2FDNuKm6WpnpqqhkGObcYlP3t/kvGIE911MzjIY+11FkgTRjxZUsr9LzQrOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339809; c=relaxed/simple;
	bh=hHDcFVZcaBJaoy3mjnAmp912IrmoCyCOhMukPRAS68Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nbhKMNiJ9OUVjBFP4CrwklhuBeB5JVTqp7dLGtWCbMTml9uQLzMyTI1fgfpyAW+eZTx91cXdJCk0uaN7Z+YC4ig0y1Q4xdyCDFI+2VbQhTjTwaOp5ScjcoS9YJLBKbMsWejPDLIocXkeBLf33oymMcl6Ruuez5X251vW3aM7S8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=EELX+8qG; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="EELX+8qG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779339797;
	bh=VVr5ZOVHSOkI0QLfjhVsyqpKAR2mbm9dT1EebpkxsP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EELX+8qG0F+OsLTLUni2PpW36wHVavigVUrAye1zXAPYaDPPpuGfYYZuKODVaQkS8
	 vltp5sY5mVD4nLsA2cwM7/TZ7G4mfE8zBe9KSI90Wid7b5EUbLN0WjZEocS2dtYKGG
	 yJG1iEDEhRXa7b/CkfQcBEvM5erumzF1Yvi0JFz8=
Received: from DESKTOP-31CF0TC ([121.224.209.33])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id C5916B9; Thu, 21 May 2026 13:03:05 +0800
X-QQ-mid: xmsmtpt1779339785tp9jsalur
Message-ID: <tencent_407FE60B6954528497709B6CAD49018D120A@qq.com>
X-QQ-XMAILINFO: ODafEzNm5ExjZ7/PfdhL2VQE6BkIpvVIexujCtcM0VNjOPVZ7Qc5zc3HSdrLs6
	 xHerWGQedHOzBe+6c+2FSglFujiub4jBPKsDjL3b+mHLfqOexJ5GsGvJgfu0isD/SH849zhvW24i
	 E+knc1AGJGXnstxCjuoEmGuER3USHDCoRoCUJXpDqQhopBGAD2qG5UgtNpcqemeK3fXmLLq/IhRz
	 EBCs21qPNE2vbSnEofyvPvCrUMUA7+K9Ta540RMfgGZPzZ3hq6ZBscjorPINpUKshpQVd65l/Hym
	 rToZYIvdwZ2DRceIZ/i7t2k8OX9PO8Ci1jzJ5Pu2muJNcuuBM89vcll3qSo7ArvzqIP4IHfysH55
	 SdMEEEpEx1bJzWHv0hn4OzkPsFf4yH17oq/JyXzgRobR+iPS7HYgpk5c0JFZ2FTf6Ir2u/v6U7Cc
	 Lj5gMiSYOtYIZQOHBEWZVbm0isiNDPIwlBRuzG8bUXvrkQ2BMUuzXj/htyO9SxRHj0NDVm+KvLP6
	 F4ixjTr5RL35ZP9cnUpixZMK+KUxIrk97eq3SISWJ8vNGUcovumREBdPKe4ZDp816syRk8p2HJA2
	 z1nRctsahdtuAzRskWZELuJni7J45kuAOVZdPvcdlFvwwMZmVh2jw7a3j1nDjRfAZ48QViS7dBfR
	 NMRTUeqRQhq4d5V5yrE1jZs25ovkf4goE4IvRinBUD6Ud499XFa76JYH8Fvn7TcJRrB8BiD99wrR
	 0aVv221An1O9Lc3mbjs92wGQWMRix3FAuLdzZeHgzNwZH0EYnJOUhQMmQwSPB9xuDcLaBMu+N5AK
	 7ZDz64vom/o5CMQm9vKokBudhF+cTg3PYZvIpMsOPfdrWReDI+bhvNLl7kUL4ewhwCTzAspzM+H4
	 jLgcbegUauqPKot33O+ueaf1YFqk9JJ7G/NrKeMhampV/axKbxmy8l+a5awmYNeBPdfYoS1YcKcK
	 32mPj6X/lI+J7CIrEl2C60udOOaIbPbrXiWftw8jd3QtS7x9T9jgoTc+trkSfoby9ZWxb7nBiPbq
	 ZHeIHM1EyqYpR0Y528SZDGqz/jycU=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Aina Boot <bootaina702@gmail.com>
Subject: Re: [PATCH v2 10/11] git-gui: adapt blame/browser parsing for bare operation
Date: Thu, 21 May 2026 13:02:59 +0800
X-OQ-MSGID: <20260521050301.174-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260520202411.108764-11-mlevedahl@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 5/21/26 4:24 AM, Mark Levedahl wrote: 
> +proc find_path_type {head path} {
> +	if {$path eq {./}} {
> +		# the root-tree exists in every rev, ls-tree gives data on the contents,
> +		# not the type of tree itself. So, if the rev exists, return {tree}
> +		if {[catch {set objtype [git ls-tree $head]}]} {
> +			set objtype {}
> +		} else {
> +			set objtype {tree}
> +		}
> +	} else {
> +		# test that the path exists in head, ls-tree gives info on the path only
> +		if {[catch {set objtype [git ls-tree {--format=%(objecttype)} $head $path]}]} {
> +			set objtype {}
> +		}
> +	}
> +	return $objtype
> +}

In v1, argument parsing relied on file exists within the worktree to 
determine if a path existed, without using ls-tree. In v2, the use of 
git ls-tree seems to actually be intended to list directory contents, 
rather than querying the type of the path itself. 

If $path is a directory (a tree object), git ls-tree outputs the 
object type for every entry within that directory, one per line. 

The variable objtype is assigned a multi-line string. When compared 
against "tree", the match fails, causing the function to return an 
empty string, which subsequently leads to an error. We can change to 
"git cat-file -t" or similiar approaches. 

Shroom

