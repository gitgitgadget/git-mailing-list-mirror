Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C899038B7B4
	for <git@vger.kernel.org>; Sat, 23 May 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779537004; cv=none; b=uDMDy6SkONECt6HV7TwMKx0wgU3lcDp2jCMAXCGvz4s+Y6B0PpPNN4Sa8kiMuqruVS5mHDEEjtO0zjToj4nfgKyzse9d+JNrGGfHGZt57wcDm2VLfXWkDBEc8+pNOcvuFPsawGa+o8HKI/nOes2PPEPM3i++r3EJkapd1EYnRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779537004; c=relaxed/simple;
	bh=ifP33bNpW0F9gtOOsRWziXZm07FkCKvEc+IHDu7Ws+0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=F9fqvAOa42l1MGVxvfkJfyUGi9FMag5Hew8rOKaDNTcqCckO6KXQjj/1QcrUUDmeXtpSlp16liuBXxwfyvkchtSeI8v9cTEGmyu4unPAGFhEjBjF89GpZATK6AYfP6LCkvCTRWmFF+rdBk8UyeICIcgalan/gXxCupmRKk+olvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=qjqVU3cv; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="qjqVU3cv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779536994;
	bh=Glx+AOmN0OmFyAXNo1eE5BncZkVIfI8OGiec4htJlWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qjqVU3cvXjYhzOP3wAwG1Pb+dTK0bJe+7waDVCtcusYkqdJdZrW1Bfv4J+GcMLfvX
	 w3dyc4mzvlqvPDUZXqgGgD5BXu6Db5sGNdfkW3lzoO09JXKnf88W6UWTuKwR3xeDym
	 lXM8Q3G3eis5rRYSfsTC44ImNeKheSWnUn9Cero8=
Received: from DESKTOP-31CF0TC ([121.224.209.33])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C5FB42EA; Sat, 23 May 2026 19:49:31 +0800
X-QQ-mid: xmsmtpt1779536971tpnp15bbd
Message-ID: <tencent_6D48318C367E3E0A7D54C684DB701F6F590A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe5iyCepqW3CJxJQIoinKQnUNhMmaJnFDbu4tYgEwyqwfR7uJzpo
	 2pL+l42Y+LO9EEZT8Py1geAJXd9jjmCFfyxazhHinZYNW4UFGlCWMftke2hoSjzsQBfEBZyPdr+d
	 uRkkBLfSt5jD88oH6J9dJ6lMnJtIUyNZ0NAL2Pw4qHLT6aQVDYUQ7aBlKADPqiB656g7G9100658
	 PVk4nIAo1Mwn4cf86nUtZedwUKWi+3GZnqj+r+KbFMnoe0Ebhz+ZNH2hLZ4sbmpMm3vlUqJJ9FFf
	 3KVgDQ0l/rMIwOizC4F/S+uj6GKgxruEPQ2pTZ0LjT7uBO9IbeSAq1rDusOegS84ZjykOisRYsHt
	 R6R44eV01I2I07Glad7cSsvHKVtBDHYwCRfRa1OxbGtqEndlhmQ2Sz+Bg5Mlp3+YUQRVRA3sY8nJ
	 y53weXcpTCn9tIM6L3ivILW1UCEtjbwtHuvve3pgbR8y19GQk6HBsvvsZiOCo4GAZHMIGsr6Q6Xp
	 l9YZvvV2l/rjJCtJZiYBzDKrikYmhfT2tq0jfX58Z6+M57/HOju3fgJLmvIdPwa3hFVJzPxXp2Sf
	 DV/ExlsFvHRNVkFjpi8Zrx+qExMesziDgzEwSCVOTkLbPXnRkxUc2OXVkRn+2+tFVuZYQbTx4uyx
	 ZGUC9zfzDe6f8xDyGQYsrh6AATdmmFLJ2qwzjfCNgU0i6CK77w2zDnqfkRg4CMadEbH6EHIfo3CJ
	 qzYndjLqn58sBYygfwJ36BSA/Z8Rt9nyMVdJT34KNg/5O4b47xUWMQVW89MbHvkExCDCIcEM8Zf9
	 vtibOHj7Mff+lU5B+bcwAg8w45f2Xya18gaPgd8XCrjMjAUVyOzzs0Q0F69FYRU+3mnbLBo+8zqn
	 wWLtaObGjtSvp21pNe2WHqkDLzeEuY9O9gJrOexpSeNQW7Rus1n3p6LXFmFeFg2mlVGxBmfwn2XF
	 7Gk4QursQQdt5M+unWOkr3m+1l/3NwXOdPski6cRiArQ5AEr+X3IQdlnXKA6cg4EQYf1bzptJjga
	 CmWkhn7g==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org,
	Aina Boot <bootaina702@gmail.com>
Subject: Re: [PATCH v2 07/11] git-gui: try harder to find worktree from gitdir
Date: Sat, 23 May 2026 19:47:44 +0800
X-OQ-MSGID: <20260523114747.1414-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <c8d1ab1e-e0cb-44e2-afcd-728b7b43774c@kdbg.org>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 5/23/26 4:01 PM, Johannes Sixt wrote:
> Am 21.05.26 um 06:55 schrieb Shroom Moo:
>> On 5/21/26 4:24 AM, Mark Levedahl wrote:
>>> +	} elseif [file exists {gitdir}] {
>>> +		if {[catch {
>>> +			set fd_gitdir [open {gitdir} {r}]
>>> +			set gitlink_parent [file dirname [read $fd_gitdir]]
>>> +			catch {close $fd_gitdir}
>>> +			set worktree [git -C $gitlink_parent rev-parse --show-toplevel]
>>> +			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
>>> +			if {$::_gitdir ne $parent_gitdir} {
>>> +				set worktree {}
>>> +			}
>>> +		}]} {
>>> +			catch {close $fd_gitdir}
>>> +			set worktree {}
>>> +		}
>>> +	}

>> Additionally, [file exists {gitdir}] checks for the gitdir file in 
>> the current working directory. Since the function has not yet 
>> switched to $_gitdir when this check runs, it is almost impossible 
>> to find the file. Consequently, this logic never triggers, preventing 
>> linked worktrees from being recognized. 

> I think you are misunderstanding which use-case this code is addressing.
> The case can be triggered very easily.

> First, the code before the part we see above is intended for the special
> case where we start in a .git, where `--show-toplevel` bails out and we
> define the worktree to be the directory containing .git.
> However, if we start in .git/worktrees/feature, then the code cited
> above kicks in, because `--show-toplevel` still bails out,
> `--absolute-git-dir` does not end in '.git', but now we have a file
> named 'gitdir' in the current directory. In this case, we define (and
> this is new with this patch) that the worktree is the one where the
> 'gitdir' points.
> 
> -- Hannes

I see. The condition is unrelated to this patch. Users should handle 
this case as assigning manually by rule. Indeed we don't need to 
modify it. 

Shroom

