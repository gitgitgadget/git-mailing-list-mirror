Received: from sender-of-o54.zoho.eu (sender-of-o54.zoho.eu [136.143.169.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553F15A8
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676208; cv=pass; b=DZ+JRQQMCqiSVskB6iDVOp79u5hd96QzaVb/3tZ8t3pVhYTQpkjJF38w50MJcidHZ6pvriWwyioGfjjxLsVLUyQ/P8ifQM4acue4qeMYU3X3AqIvrl2CKfxa76Q3qgMUtBWUSao9EeiKB5WItkRbs0+5OUxNP3LOA3unZChChZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676208; c=relaxed/simple;
	bh=cbVP2Y9ICw1JUk3VuNq0UAmd9QyyV6hwNDzfXtXOLz8=;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=QjbmrpHrLLZdpwFRf1opsRepKYQ/p2Zo24ZRg7eWbrd6n7tko9eHXLo1JdnnhIQTyeniTIXbvcSeNO8Ni5psUGgryog+mUEupMJcVj2/zF9qHxOvNr5KhL2QthHi12G1pjykkZKZnbj4aYJjQsW+udu6dutHhjJnlJGwfeAufaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (1024-bit key) header.d=orca.pet header.i=marcos@orca.pet header.b=PbdTjrW/; arc=pass smtp.client-ip=136.143.169.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=orca.pet header.i=marcos@orca.pet header.b="PbdTjrW/"
ARC-Seal: i=1; a=rsa-sha256; t=1726676188; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RZoVvhsLWHD0MdMqfh3axn/KfnfHscH35+7h067SQ4CXxD49YhPpH8qwiUxS9RBslcA9BTgo7JekemS+ZUDSnVCQEnFE3lGYtejm5Sd3D+vaMJW6qnDCdlzGbWULAdsZ6Dx/qDx5yHMPnQQ9aokHVkLdTgtG7sdF01EDde59gvQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1726676188; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=2O4riIo33BZ9Dgs17as1lQeXD+u/fc91uhuPmtGr3Og=; 
	b=I5QordgxH/nf2XNzAu7XUQ4tZw18NlQMJCwerfFpPInsu2CohEjDbQd7TNZFQA/6D+sxpTYnzpEySM5qMJeUVVmaovhrL6lpiU77XSOr1g0kJjPw+4plzJFxW9lN0/byv6iMACeus4XKl4Do3xYDTyaPAY58gQENiEFf3G6pO8c=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=orca.pet;
	spf=pass  smtp.mailfrom=marcos@orca.pet;
	dmarc=pass header.from=<marcos@orca.pet>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726676188;
	s=zmail; d=orca.pet; i=marcos@orca.pet;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=2O4riIo33BZ9Dgs17as1lQeXD+u/fc91uhuPmtGr3Og=;
	b=PbdTjrW/0ULUc+v3Xp2odmY4OyrMBiJgjQ3tdgO8o0f6RKULufirBhEFGAKMGbMM
	fudjaKPkDZblCM07esYhCdmlE6zSJ3xWT4hxqKH5L0r2j139/f3spuL63gBP+JCkJya
	DFILHHANNVV7zEj3ZWrtxfpQ2/uEqfJK+fjqukMc=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 172667618633136.35839296647714; Wed, 18 Sep 2024 18:16:26 +0200 (CEST)
Date: Wed, 18 Sep 2024 18:16:26 +0200
From: Marcos Del Sol Vives <marcos@orca.pet>
To: "git" <git@vger.kernel.org>
Message-ID: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet>
In-Reply-To: 
Subject: Permission issue in Git in DrvFs-mounted network drives
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

Under WSL1 (Windows Subsystem for Linux), when using a network share
mounted via DrvFs, Git fails to add any files to a new or an existing
repository.

The reason is that Git tries to open a temporary file as with RW
permissions but mode 0444, which causes WSL1 (or Samba, unsure who's here
to blame) to create first an file empty with the read-only DOS attribute set
that prevents any writes, and then actually trying to opening it in write
mode, which of course fails.

Seems to be a pretty common issue that nobody has yet reported officially,
judging by the amount of posts on Stackoverflow, impacting not only WSL
but also CIFS under Linux (hence why sending to this mailing list and not
the Windows-specific one):

 - https://superuser.com/questions/681196/debugging-git-repo-permissions-on-samba-share
 - https://superuser.com/questions/1450094/git-on-wsl-commands-fail-despite-permissions-seeming-fine
 - https://superuser.com/questions/1491499/use-git-on-a-shared-drive-within-wsl

As a workaround, opening the file with permissions 0600 and then using a
fchmod with the final desired mode works, which is a very small change that
should cause no issues under neither real Linux nor WSL:

--- git-2.39.5.orig/wrapper.c
+++ git-2.39.5/wrapper.c
@@ -484,9 +484,11 @@ int git_mkstemps_mode(char *pattern, int
 			v /= num_letters;
 		}
 
-		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
-		if (fd >= 0)
+		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, 0600);
+		if (fd >= 0) {
+			fchmod(fd, mode);
 			return fd;
+		}
 		/*
 		 * Fatal error (EPERM, ENOSPC etc).
 		 * It doesn't make sense to loop.

The WSL team at Microsoft has been already informed as well:
https://github.com/microsoft/WSL/issues/12051

