Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAD1C2327
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925338; cv=none; b=jenmB2mlKqKyjv1xPjCyxbHO360b04lsdAev+fy3Cj8MKpv7bM1gaKbQ+w0kKuoZSWnhZMpdn3pF7FoE8np9LHessFyIFqaJjChd910JQ72lVJUCB9eQhDs8cAB35eOcjkM+mY14ij0djUqQ2ieBha41wwDpx/KnrCwZmnonfJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925338; c=relaxed/simple;
	bh=t93Q5XpSlkCLefcX/Sk63MYT9zXsXbywkF8s02QLVgo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ae2tcCBKbKoFeXvwzwacx7WbhRQ37RamIC5J4SqNOLmXkAO3dicuQYej5tZl4K6da3OSVujtBNGtcuCthhGiWvgxNfB1D8bA2CtM7TeoGwS26Ot4E6+9CZFPXpH8k8dbLE4HTICqAq+1fpGfT10HJRCWjUvYi3FtcTqhO7MLYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=S0psA/n8; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="S0psA/n8"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 0OPPtZcBdxile0OPRt8Y6j; Mon, 14 Oct 2024 17:59:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1728925145; bh=B3ddF20wIHigd9wM7JoLxZqWt372GLMWhkNCts11rJE=;
	h=Date:To:Cc:From:Subject;
	b=S0psA/n8wLa6cwbraZGGoQv67T6Yp6P4rrv/SjREuYZ20w8lJaR+d3jE2oh7KDZ43
	 GQ416SXhEdA0J+kpZ6l9sYo7WPlVS2gkYOpb9Boy7cueVNSTixB/Fxk76c0cKYB7b9
	 J4NT07lgfkS0tW2ZJvqb3Y6Q5tmVDFDvuvr9+um6uGsn3fWTbk4YSqJb1g3PeqfySk
	 HJWO8drjIXk4ukF4yY3qEauWH41RW8HIJwVIopva2YhKsetH9mnHWcRLMgG8fKXsqb
	 IYF5dpJkIAOHXiS2L6w5CJs3+lmQx9xCm7SAouDe19jBSsVJXJofXgDMEsvH4eImAp
	 w+CRcVeGIBEvg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VaJUP0p9 c=1 sm=1 tr=0 ts=670d4dd9
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=IdNtSy1A9SiqmdPCT3cA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <28e13e74-d4a4-4be5-8555-27a69c5c5787@ramsayjones.plus.com>
Date: Mon, 14 Oct 2024 17:59:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Modernize the build system v2 problem
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfO4SOdipDSMLGPo+ZY7KFEQ6h8llH6Nb9YefD/XietOCakjeZGlB+Hl8M6oW2Vn/J62Ie9DPSdGKF6XOVfTS3Vl6zhlVsA55WkiE/IbKQLi21oExaTIR
 9/G5E4klmYBUv+62v9NZHYYu52Tb5IVSTcGzr6QH+0HV6yXyjIwAe7c4RNvwsB1MhDrfeSpXu+2WVRX4hMGf1I51MXt6rXLSssU=

Hi Patrick,

I took your 'Modernize the build system' v2 series, from 2024-10-09, as patches
from the mailing list and put them on top of master@ef8ce8f3d4 ("Start the 2.48
cycle", 2024-10-10). I had to hand edit the 14th patch to change the version
number from DEF_VER=v2.47.0 to DEF_VER=v2.47.GIT, because of the change of base.
(It would probably have been easier to just base it on v2.47.0, but what would
be the fun in that! :) ).

In order to fix the 'dependency loop' error/warning from make, I applied the
following change:

    diff --git a/Makefile b/Makefile
    index dc60b2581d..c7b28975ac 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -3219,7 +3219,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
     
     all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
     
    -bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
    +$(test_bindir_programs): bin-wrappers/wrap-for-bin.sh
     	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
     	     -e 's|@GIT_TEXTDOMAINDIR@|$(shell pwd)/po/build/locale|' \

There are several ways to fix it, but this seemed like the easiest. I suspect
that you have already fixed this.

Having determined that the 'make' build procedure seemed to be unaffected,
I now tried the meson build. I had to install meson at this point (ninja
came along for the ride). I have never used meson or ninja before.

At this point I had to fix another fallout from changing the base:

    diff --git a/meson.build b/meson.build
    index 338d472bc6..54557eee03 100644
    --- a/meson.build
    +++ b/meson.build
    @@ -194,7 +194,6 @@ libgit_sources = [
       'reftable/block.c',
       'reftable/blocksource.c',
       'reftable/iter.c',
    -  'reftable/publicbasics.c',
       'reftable/merged.c',
       'reftable/pq.c',
       'reftable/reader.c',

Everything seemed to go without a hitch after that, as far as the build is
concerned, but when I did a 'ninja test' I ended up with three failures:

  Summary of Failures:
  
   979/1028 t9500-gitweb-standalone-no-errors              FAIL           12.36s   exit status 1
   980/1028 t9501-gitweb-standalone-http-status            FAIL            2.19s   exit status 1
   981/1028 t9502-gitweb-standalone-parse-output           FAIL            2.22s   exit status 1
  
  Ok:                 1025
  Expected Fail:      0   
  Fail:               3   
  Unexpected Pass:    0   
  Skipped:            0   
  Timeout:            0   
  
  Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
  FAILED: meson-internal__test 
  /usr/bin/meson test --no-rebuild --print-errorlogs
  ninja: build stopped: subcommand failed.

The failure is caused by an (apparently) mangled 'gitweb.cgi' file. Since I
still had the make build file, I could directly compare the files:

  $ diff ../gitweb/gitweb.cgi gitweb/gitweb.cgi | wc -l
  160
  $ 

I won't bore you with the whole diff, but it begins like so:

  $ diff ../gitweb/gitweb.cgi gitweb/gitweb.cgi
  83c83
  < our $GIT = "/home/ramsay/bin/git";
  ---
  > our $GIT = "/usr/local/bin/git";
  91c91
  < our $project_maxdepth = 2007;
  ---
  > our $project_maxdepth = "2007";
  2497c2497
  < 		{ regexp => qr/^\@\@{$num_sign} /, class => "chunk_header"},
  ---
  > 		{ regexp => qr/^@@{$num_sign} /, class => "chunk_header"},
  2521c2521
  < 		$line =~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2}(.*)$/;
  ---
  > 		$line =~ m/^@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) @{2}(.*)$/;

  ...

  $ 

Note that, after the 'template variables' have been substituted, many (all?)
character pairs \@ are replaced with @ (ie the backslashes have gone walkabout).
This results in compilation errors in the 'gitweb.log' file, for example the
log file for the t9500-*.sh test, looks like:

  $ cat gitweb.log
  [Mon Oct 14 15:12:33 2024] gitweb.cgi: Possible unintended interpolation of @2 in string at /home/ramsay/git/build/gitweb/gitweb.cgi line 2521.
  [Mon Oct 14 15:12:33 2024] gitweb.cgi: Possible unintended interpolation of @3 in string at /home/ramsay/git/build/gitweb/gitweb.cgi line 2593.
  [Mon Oct 14 15:12:33 2024] gitweb.cgi: Possible unintended interpolation of @vrfy in string at /home/ramsay/git/build/gitweb/gitweb.cgi line 4212.
  [Mon Oct 14 15:12:33 2024] gitweb.cgi: Global symbol "@vrfy" requires explicit package name (did you forget to declare "my @vrfy"?) at /home/ramsay/git/build/gitweb/gitweb.cgi line 4212.
  [Mon Oct 14 15:12:33 2024] gitweb.cgi: Execution of /home/ramsay/git/build/gitweb/gitweb.cgi aborted due to compilation errors.
  $ 
 
So, keeping in mind that I know absolutely nothing about meson, it seems that
the 'configure_file' function is mangling the 'gitweb.perl' file. I assume
that you are not seeing this, so I suspect that you are using a newer (fixed)
version than me. :(

  $ meson --version
  1.3.2
  $ ninja --version
  1.11.1
  $ 

This is on Linux Mint 22.1, which is based on Ubuntu LTS, so not that old!

I am about to try converting the Makefile 'procedure' into a shell script
to use in both the Makefile and in the meson.build file (I see that the
'configure_file' procedure can take a 'command' to generate the file).

Note that '$project_maxdepth' is a snowflake in the make procedure! :)

Any thoughts?

Thanks.

ATB,
Ramsay Jones

 
