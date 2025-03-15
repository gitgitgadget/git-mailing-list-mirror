Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA35F9E8
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007018; cv=none; b=INDLk2ktvGLPHFzsHhqXYY6cMFJja3O8wrVVrhRRHQlBpHsr+l3BF3irtp8oV6zEPr4rzvk7NgRqZzhqFyOcElUY7kNtwt7UIzbtB3EjHHd7nSr1+s047DVn3XEmqB/aE8xDfT0aMVFXxcMLbUZjBHTJDA2UZSE3Ve5eb+3Xl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007018; c=relaxed/simple;
	bh=rwk4RMpBukACJ4FMA8mh3F9GyzerP/fqoWEIWHpI8/w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=izmzkR3dZF17MD+VOVIhI76ZI6rHlnDrCxd2KBAWw7wS5OjpH7mxr5ZS/vuUJx3mB1VHGszkdnYXPnAcG/bmx351yEFgFrpu2Tas6sWOgsr1lpKOHcVXBmStd0ExdTp2ExAJRlbyMgLQld2Qpo0I7NDaVqS1iEJv0gWoUjafqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=AzQsF72q; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="AzQsF72q"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHYQtGMsLvxWAtHYRteQBq; Sat, 15 Mar 2025 02:47:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006836; bh=cvvI1RTQ0Bci1xzTnR1YWCIhBbWNU3wRMrNfr2qUpvQ=;
	h=Date:To:Cc:From:Subject;
	b=AzQsF72qi/VtL++y5YWb9hS+x0LdvAGCJZkpGbnPKt1x0AG9OlekmqvNyTqrXVDcl
	 yikoSEwcQwSGEh5O1whnRMYvzvuSHBjJ7Tu4nauyfj8Obb/7DdqJKMtVFBb9I1BQwW
	 +i8oyUpS9zYDHAjBEjM0HWmyO1Vxq+Of9O7JF2CMhvcC1MNdyYRGFIodMsHfV/kcMc
	 pFF8NjJSyyEe9yp//O3L4/X/jf/ZarbRVjBCaWmhHlc/8zeogjqDimSB1IPrVZG4Ud
	 d0XqChDk3q9D58GmXePjsXDdPPJPkW7Pau05KnM9tHoI8LgAZvzBSmQzVgZ/3ePO3z
	 py93W1nQa7BBQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4ea34
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=MwKkaEpK1oP1WH10rxgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <bb895671-ad11-4ddd-b8f3-ec6479bf4da4@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:47:14 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 04/12] Makefile: remove NEEDS_LIBRT build variable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfO+PQvxmE5aQ/k0C0hVg2d8r2CN3hxMetS8IPMXWe+Iyee9YGOQYmOH8RtTdZja4Rx/UT3Fi/i/KRxOOR1wSV5PfBxmXUSK6fUWsoI3XizG7fUEhggff
 wJJUhRKGxQ+ZlZJgAJfYRDAPR8OzWT1nL7znc/Vdv0mDJvW8ZIlaSiTGd/acmtfxSOpZxArFH2Ca72nAQSQAonhhgnWBWyqHDFk=


Commit d19e3a5b21 ("Makefile: add NEEDS_LIBRT to optionally link with
librt", 2016-07-07) introduced the NEEDS_LIBRT build variable to
disassociate the HAVE_CLOCK_GETTIME variable with the unconditional
linking of the librt library. At one time, the clock_gettime() function
was not available as part of the libc library and (on some unix systems)
required linking with librt.

Commit 52fcec75ce ("config.mak.uname: define NEEDS_LIBRT under Linux, for
now", 2016-07-10) set the NEEDS_LIBRT variable in the Linux section of
the config.mak.uname file, since Debian 7 (wheezy) was one of the few
remaining distributions, with glibc 2.13, that required linking with
librt for clock_gettime(). Note that from glibc version 2.17, this is no
longer necessary.

Note that Debian 7.0 was released on May 4th, 2013 and benefited from
long term support until May 2018 when it went end-of-life. Since that
time, Linux distributions use a more up-to-date library, for example:

    Distribution   version  end of support

    Debian 8       2.19     30th June 2020
    RHEL   8       2.28     31st May  2024 *
    Ubuntu 16.04   2.23     30th Apr  2021

* paid 'Maintenance support' ends 31st May 2029

Since it is no longer required, remove NEEDS_LIBRT from the Makefile and
config.mak.uname.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile         | 7 -------
 config.mak.uname | 2 --
 2 files changed, 9 deletions(-)

diff --git a/Makefile b/Makefile
index 818dde32a9..8fa4d2664e 100644
--- a/Makefile
+++ b/Makefile
@@ -340,9 +340,6 @@ include shared.mak
 #
 # Define HAVE_SYNC_FILE_RANGE if your platform has sync_file_range.
 #
-# Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
-# before 2.17) for clock_gettime and CLOCK_MONOTONIC.
-#
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
@@ -2171,10 +2168,6 @@ ifdef HAVE_SYNC_FILE_RANGE
 	BASIC_CFLAGS += -DHAVE_SYNC_FILE_RANGE
 endif
 
-ifdef NEEDS_LIBRT
-	EXTLIBS += -lrt
-endif
-
 ifdef HAVE_BSD_SYSCTL
 	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
 endif
diff --git a/config.mak.uname b/config.mak.uname
index b12d4e168a..88007c4f13 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -54,8 +54,6 @@ ifeq ($(uname_S),Linux)
 	HAVE_DEV_TTY = YesPlease
 	HAVE_CLOCK_GETTIME = YesPlease
 	HAVE_CLOCK_MONOTONIC = YesPlease
-	# -lrt is needed for clock_gettime on glibc <= 2.16
-	NEEDS_LIBRT = YesPlease
 	HAVE_SYNC_FILE_RANGE = YesPlease
 	HAVE_GETDELIM = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
-- 
2.49.0
