Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8101C3C0D
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806273; cv=pass; b=Rm7SUpU75EBTfQn2yx+52KFWCWOBGSPb8EhNuDasaMPSG8vNhbHCuiuXHtCONlLTsK6dC4j1JCtEu8BNnU5u5z3CmMxQCqsTnYT3cZv+DC3qhSqR/9ZC+VfxEDxVxTFQPZWAUbqlZWSAVnE/ia/v8I5wKkYz6A6RQX+Hx+xymoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806273; c=relaxed/simple;
	bh=kV7RkbnEe4t4EP/5LYzvs84HAs13Pg7jknm5pC6oBJ4=;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=ZsE/BHguSmTVhhlu3pY22M0XD5MUtSDQH6Q9CPOkYtKi5tbfoHtWMzv5FTqQNJRM6CtQvRHtlK5PhH2fdJaczmJjUZThbSVDicNSjy12zW3rtKiE9OzJIFa3TUcjz36TH38MW247j2hwGgtY9vpWF/0Fa6F6fgQuiY1ouJBqGZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=e6UJx5bm; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="e6UJx5bm"
ARC-Seal: i=1; a=rsa-sha256; t=1736806269; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AZ/UYe4tmtqxTVIoaO3sYGVRjsc5FnZug7cP8SI19Dbdh8I/A+1HXXGLBG85R3P1eDCpA/hPG5xW0J8Oo1RWwoj3cUv/3V0plSDCs/lPv3RcSgK+kvgAQ1FLMILnbDq8AoQN6bbBiLZqX8qovTdytKZ1ufrgIfCGVmVzLCM+BO4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736806269; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=kV7RkbnEe4t4EP/5LYzvs84HAs13Pg7jknm5pC6oBJ4=; 
	b=ZUC9FprDNITK8pO4dKk4QfX35lyqnddkYNiw/a9UaukxoCFYeXo4yksYO9JeKuc8kXIRR+u9hMW0J99DPbpc47uGOf9DHU+Wji406LY/EzTc2qf92pC6ubYO/YGtFYsCO+PcHq06TjG0wlfqJ30DLW/lhWOp8rMqo/6JZnveHgg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736806269;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=kV7RkbnEe4t4EP/5LYzvs84HAs13Pg7jknm5pC6oBJ4=;
	b=e6UJx5bmtu/Ga95ZsvTejAmdo1jheX/89NQqLiwTrgH+YJkcWgH6JhtTd77Qr45F
	UmMKwTk91ZzG3UcRoIxspoZL/5zuNt7EAVd28EyTpJNWWdPf5zNN4Bk5YPUoaUhHa/c
	0a9p7FixRY2EE/g1lwNfCNdKeCHXfShN8kjdYLVs=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1736806267541478.8577210426221; Mon, 13 Jan 2025 14:11:07 -0800 (PST)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 13 Jan 2025 14:11:07 -0800 (PST)
Date: Tue, 14 Jan 2025 02:11:07 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "git" <git@vger.kernel.org>
Message-ID: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
In-Reply-To: 
Subject: [bug] "git bisect old v3.0" takes 21 mins on Linux repo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112274d1b6da2582a90b054c0393a0000a31b706075736a67b3f1b703e7357953eb40a0db58eaeb19c6:zu08011227c66071b972718f23813f60e00000b6f941d91cb3b5e48fdbbfed9a09b20a9e1acc77b561573f23:rf0801122b4a9d59bcd1c2f24cb056eae80000a52287da12e0a0bceac1faa8f7d67d7622c12bff86a63f8c819dd2dbb9:ZohoMail

Hi. This is bug report. "git bisect" is unacceptable slow on Linux repo.

Steps to reproduce:

===
d-user@comp:/tmp/t$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
Cloning into 'linux'...
remote: Enumerating objects: 13079335, done.
remote: Counting objects: 100% (153/153), done.
remote: Compressing objects: 100% (108/108), done.
remote: Total 13079335 (delta 84), reused 70 (delta 45), pack-reused 13079182
Receiving objects: 100% (13079335/13079335), 5.18 GiB | 13.72 MiB/s, done.
Resolving deltas: 100% (10454171/10454171), done.
Updating files: 100% (87234/87234), done.
d-user@comp:/tmp/t$ cd linux
d-user@comp:/tmp/t/linux$ git bisect start
status: waiting for both good and bad commits
d-user@comp:/tmp/t/linux$ git bisect new v6.13-rc7
status: waiting for good commit(s), bad commit known
d-user@comp:/tmp/t/linux$ time -p git bisect old v3.0
Bisecting: 535608 revisions left to test after this (roughly 19 steps)
[62606c224d72a98c35d21a849f95cccf95b0a252] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
real 1293.32
user 1291.70
sys 1.41
===

1293.32 s (21 mins) is unacceptably slow. During "git bisect" execution process "git bisect--helper" occupies 100 % of CPU in "htop" output. (This means that "git bisect--helper" is not parallel program, overwise it would occupy significantly more than 100 %).

So, please, make "git bisect" faster. (Maybe it makes sence to make it parallel?)

My OS is Debian 12 Bookworm. Output of "uname -a" is "Linux comp 6.1.0-28-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.119-1 (2024-11-22) x86_64 GNU/Linux".

My git version is 2.39.5.

The above test was performed on tmpfs on real hardware without any kind of virtualization.

I will try to perform the same test with latest git version and will report my findings in the next mail (hopefully today).

--
Askar Safin
https://types.pl/@safinaskar

