Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799B78F2E
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737559; cv=none; b=kvsoEggR3nMaCg0JHHnWL5Za1qoaYSWrTAwW5Wky8nkwJkYX37WL0mNoORrpdQO5Cl0dN3XAOuE6taMUy3CDKLkl4haZykOPvM7cdZOlDSfXW20HFY7YSHpaD65SPZASKByI8qKVA9vsH4yDjwHGkBOIBpAUYFRb+3yGM8+0wtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737559; c=relaxed/simple;
	bh=MaaYkqB/QeUbNtCTehDkYfg2qlALnpIMu+5vj97/a/A=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=KuRgN/rprkkYa50AfWfdEvmbuznGVfbm3yMJps7Hb+36dPBRj0TCDbwR9L5YInwGwOvib72gttpC6sAjc/vKQNzV+kwOuwoJl/QbLGZf2r7VeJZC3Jo1+VZIC2v/5s9qQtw01/IALNi2xqLc2pUIpqcKxcazNEtlYMmN8wiATWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=bAMdtVIm; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="bAMdtVIm"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 4jtCu3oksSSpf4jtDu0cMN; Tue, 15 Apr 2025 18:16:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744737364; bh=AVCn+USwSBa0G+hcNGtUQhLU0XqWI0DPbax45Z2XuSM=;
	h=Date:From:To:Cc:Subject;
	b=bAMdtVImQMPGjbm3ObfEApVc3mk1mbGrWmEHFeNtQcpAeWHcgXVzXXl4jezxZ9p9z
	 ++uCuFzmOddIdRnyDI47iA82Qa4HMqLGvQmVZY9rSHdBTlG2sic5YoXbEV3jgc1y+A
	 hauIJsWhj6uSIujg/u1Z/DYDMCcYXwog/sz30MhjxWONoIONqobUMniVO0KIh9Q1b1
	 N63N6oJkYrNuoTAQWSUkibFGykRLdu2y6TQ8CMF/n4D4QR7WB+Whd5YUgm+cEczBse
	 nLIoYTrNDuIjo5faNxUgoYW1L48TWbDVd5sZj31VRggvlgvDaB+6BEMH3PUSZWsCez
	 WvNPnOXxVq9YA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9re0vni c=1 sm=1 tr=0 ts=67fe9454
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=Pg-3dBNDMyySqDWgPwwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <c358c9b7-bd83-407f-8abc-17ce9363618e@ramsayjones.plus.com>
Date: Tue, 15 Apr 2025 18:16:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: meson build failure on 'seen'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHX4If4llJqXIGzpJFSTtX1SLwFc3DqMRcAI9kmxIqMhCXdWSRX9656he66IEfNW7Z8QI/zbI2HAJjJCVrp+bht2Rriip7DkuwthPp0615WseDlnMgIf
 x4l2Jbhi2C/axlxp4Z/2+A5/x7i5N57N5cRQQ2UC+FbQkFeBRX7K6Y95mbNBHO23LjjJudcfXBhx75ULzAkEWI5OH1qIe7ltUY4=

Hi Junio,

Attempting to configure a meson build of the current 'seen'@916e0fb7c0
branch, I find:

  $ meson setup --optimization=2 -Dprefix=$HOME -Dpcre2=disabled build/
  The Meson build system
  ...

  meson.build:769:46: ERROR: Unknown variable "target_shell".

  A full log can be found at /home/ramsay/git/build/meson-logs/meson-log.txt
  $ 

It appears that the tip commit 916e0fb7c0 (Merge branch 'ps/meson-build-perf-bench'
into seen, 2025-04-14) drops the call to 'find_program()' which sets/defines the
'target_shell' variable.

The following diff allows me to configure the build:

  $ git diff
  diff --git a/meson.build b/meson.build
  index 015ead27e6..4d537b7a00 100644
  --- a/meson.build
  +++ b/meson.build
  @@ -237,6 +237,8 @@ shell = find_program('sh', dirs: program_path, native: true)
   tar = find_program('tar', dirs: program_path, native: true)
   time = find_program('time', dirs: program_path, native: true, required: false)
 
  +target_shell = find_program('sh', dirs: program_path, native: false)
  +
   # Sanity-check that programs required for the build exist.
   foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']
     find_program(tool, dirs: program_path, native: true)
  $ 

This allows me to compile the project (I'm still waiting for the test run to
finish).

HTH

ATB,
Ramsay Jones


