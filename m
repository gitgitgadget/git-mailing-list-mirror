Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F51A38C9
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711164466; cv=none; b=EjS+67R1J6CksdEQdJ2GvWyKEW6NEvnGnLse2TFmZ4/BA9pwnTPydpr69kKBqWDDvscwJbjuK0Se7GAOU47qgA4YzduZnJOBwpnYCGqf9kYLz0hFfu73upavoH3Rlbka4LPc0Jk7qF01ftqMK4uv1gnRT6ea9x1xREzBUbw4YI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711164466; c=relaxed/simple;
	bh=LjT3T1URpw6gcMHUhJ7hCm/ll802UIM+5PJ9vHtsNVI=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=a40/8NTvtSDvJGBmiTX8D6RV5CFZlBYjLEe3M8AqM7u5mvAXDYW3n+lglUEojw+qT25jLAkDgSYrgkZjKS5/2On3Y/GdKqd8JLhRKcuWcInplSgFm0CXZaacHVlPk3nTn/YRcFgOELmcqY9TMB5wRPQfBQ657msOZ1O6U2OnuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOdRWEJ1; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOdRWEJ1"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d46c44dcc0so32700921fa.2
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 20:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711164462; x=1711769262; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bD5OsuWuCklzf31mHs71Mv3lpSVtmayZZbP0RowYCeI=;
        b=AOdRWEJ1FvpDzAq82cuaqne48jbT6OBstTWXQc0bwe04w+hOqtR9pxW2vZ/nUGA/on
         9gF3mEqXdartbTSEukT5p82xWoTx2KIuF7qWPlqt05us6VvvY08LrooAN738u9eKEvi1
         KmkUrIY4nJbAp0Es/ZkBZIw34gClcuv/CrZH46niSAzATj7ZLO+K3Ej+BraDIm1I+xHR
         S4Zi05LXIRO4PHCq40sCCbuvcblgi5vX9yAf6JxxT4MUnh2lifpOuUGIB3Y2RFgeiauN
         p/Q1BA14SJJer7xTWUVeZjFFfpBp0rnMxuqX4JgjOW5bYIhPaClWVRrWESHjLYPXGLei
         xKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711164462; x=1711769262;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bD5OsuWuCklzf31mHs71Mv3lpSVtmayZZbP0RowYCeI=;
        b=lgexKH951GAMfrXdoRASs+CQV8EUl3I+ICg46BnKBhioY55BL+D7uOhDK3KVLQ3JT2
         jfy/tM0k6Z5CQqNpv1f0r5RWeHx9ZKduKiDsSQiytrJuGJppGpZ+jVlalCEiYVoUZ9Z+
         OZ2FzA4zEqbwAA6h/zk9mGvQNT1UqLP00C4vWE/O6XXez19nrggfAsXbRQdT1Uuei4OB
         4k5PO/i9Y5hBUhHfnvYUQoqX1aLXyaNZDsIxkUgDyKo6dqbfRRr9Ornj4e3LaabZ8qeV
         mJRmzRZrVPGETLWraDiGW2W7Ix5hYY6NBAjQeFo51ix6e2oBFSOxg1cLKIhidCJ1jnId
         28Nw==
X-Gm-Message-State: AOJu0YyZEOaRANVjhd3uGW4275sVpKiZ3F6co12yAIJHqr4XfRGnk9xf
	niVGciqIDzDNRnwiqK0UoT7IyzE7iRbxBO1AqUaIUDIJ9DcJcT5kQiSd5YrW
X-Google-Smtp-Source: AGHT+IG63UQQLwvY/auYklkOUlc+J02sDqsmrX6MP6x8Ly5xq1fBeUqbcKAfUzJnXo75/OxnZEjGMA==
X-Received: by 2002:a2e:9087:0:b0:2d4:484c:41d3 with SMTP id l7-20020a2e9087000000b002d4484c41d3mr753911ljg.14.1711164461761;
        Fri, 22 Mar 2024 20:27:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b004140c161e8dsm1209390wmb.43.2024.03.22.20.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 20:27:41 -0700 (PDT)
Message-ID: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Mar 2024 03:27:40 +0000
Subject: [PATCH] RFC: add MAINTAINERS file
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This patch is designed to spur discussion about adding an official
MAINTAINERS file to our project. The hope is that it could be used as a
reference in (at least) the following scenarios:

  (1) [CC list] patch authors want to know who to CC on their
      submissions, without resorting to git-blame-level of precision;

  (2) [escalation path] patch authors have been waiting 1+ weeks for
      review comments, but are not sure who to escalate to (other than
      Junio);

  (3) [status tracking] record former maintainers/reviewers who are now
      inactive.

In addition having a MAINTAINERS file could give a more official sense
of ownership in the codebase.

The MAINTAINERS file here is stolen from the one used in the Linux
Kernel. We do not have to follow its format at all; it is merely added
here as a reference for comparison and prior art.

Signed-off-by: Linus Arver <linusa@google.com>
---
    RFC: add MAINTAINERS file

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1694%2Flistx%2Fmaintainers-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1694/listx/maintainers-v1
Pull-Request: https://github.com/git/git/pull/1694

 MAINTAINERS | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 MAINTAINERS

diff --git a/MAINTAINERS b/MAINTAINERS
new file mode 100644
index 00000000000..34fa3baf3a5
--- /dev/null
+++ b/MAINTAINERS
@@ -0,0 +1,85 @@
+List of maintainers
+===================
+
+Descriptions of section entries and preferred order
+---------------------------------------------------
+
+	M: *Mail* patches to: FullName <address@domain>
+	R: Designated *Reviewer*: FullName <address@domain>
+	   These reviewers should be CCed on patches.
+	L: *Mailing list* that is relevant to this area
+	S: *Status*, one of the following:
+	   Supported:	Someone is actually paid to look after this.
+	   Maintained:	Someone actually looks after it.
+	   Odd Fixes:	It has a maintainer but they don't have time to do
+			much other than throw the odd patch in. See below..
+	   Orphan:	No current maintainer [but maybe you could take the
+			role as you write your new code].
+	   Obsolete:	Old code. Something tagged obsolete generally means
+			it has been replaced by a better system and you
+			should be using that.
+	W: *Web-page* with status/info
+	Q: *Patchwork* web based patch tracking system site
+	B: URI for where to file *bugs*. A web-page with detailed bug
+	   filing info, a direct bug tracker link, or a mailto: URI.
+	C: URI for *chat* protocol, server and channel where developers
+	   usually hang out, for example irc://server/channel.
+	P: *Subsystem Profile* document for more details submitting
+	   patches to the given subsystem. This is either an in-tree file,
+	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
+	   for details.
+	T: *SCM* tree type and location.
+	   Type is one of: git, hg, quilt, stgit, topgit
+	F: *Files* and directories wildcard patterns.
+	   A trailing slash includes all files and subdirectory files.
+	   F:	drivers/net/	all files in and below drivers/net
+	   F:	drivers/net/*	all files in drivers/net, but not below
+	   F:	*/net/*		all files in "any top level directory"/net
+	   One pattern per line.  Multiple F: lines acceptable.
+	X: *Excluded* files and directories that are NOT maintained, same
+	   rules as F:. Files exclusions are tested before file matches.
+	   Can be useful for excluding a specific subdirectory, for instance:
+	   F:	net/
+	   X:	net/ipv6/
+	   matches all files in and below net excluding net/ipv6/
+	N: Files and directories *Regex* patterns.
+	   N:	[^a-z]tegra	all files whose path contains tegra
+	                        (not including files like integrator)
+	   One pattern per line.  Multiple N: lines acceptable.
+	   scripts/get_maintainer.pl has different behavior for files that
+	   match F: pattern and matches of N: patterns.  By default,
+	   get_maintainer will not look at git log history when an F: pattern
+	   match occurs.  When an N: match occurs, git log history is used
+	   to also notify the people that have git commit signatures.
+	K: *Content regex* (perl extended) pattern match in a patch or file.
+	   For instance:
+	   K: of_get_profile
+	      matches patches or files that contain "of_get_profile"
+	   K: \b(printk|pr_(info|err))\b
+	      matches patches or files that contain one or more of the words
+	      printk, pr_info or pr_err
+	   One regex pattern per line.  Multiple K: lines acceptable.
+
+Maintainers List
+----------------
+
+.. note:: When reading this list, please look for the most precise areas
+          first. When adding to this list, please keep the entries in
+          alphabetical order.
+
+3C59X NETWORK DRIVER
+M:	Steffen Klassert <klassert@kernel.org>
+L:	netdev@vger.kernel.org
+S:	Odd Fixes
+F:	Documentation/networking/device_drivers/ethernet/3com/vortex.rst
+F:	drivers/net/ethernet/3com/3c59x.c
+
+...
+
+THE REST
+M:	Linus Torvalds <torvalds@linux-foundation.org>
+L:	linux-kernel@vger.kernel.org
+S:	Buried alive in reporters
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+F:	*
+F:	*/

base-commit: 11c821f2f2a31e70fb5cc449f9a29401c333aad2
-- 
gitgitgadget
