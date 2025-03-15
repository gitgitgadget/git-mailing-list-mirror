Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAACF9E8
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006955; cv=none; b=BiY72mLn+m1aJYGXxMvs3I0TvlpNzBAgleQEzp7MIsy7BTYH6NBraN16dIT5lQTr6jnOalQkP5Q03UgGzgak3oeo/beLVHALeKmL3jAonAAZP7QEcivHG6FXXC0MP92h83M3ECMi6pPPi6zl0Yvq8Ip0Ems9Vazw5GsY+tw6zyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006955; c=relaxed/simple;
	bh=HdkF8kBRF8s5drMdjgzOGvLXwYuWN6SyDXRv4fsijrA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kCipbenuYgRuEN81d5sCVBkR2d9qRGDpRkI+Rle2IK8/gWaK1C7kosF41VCGN8aJ524fBgG0N8JSoyjhuMC9T+IP6xY2GBRHFTvqqrADZymEr+r9VJs3eAqhtn19HXK259t4eH+CnJHppQXLY+X79LVCjK9NHweIqfu8+psZM9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=O1QDJ6GU; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="O1QDJ6GU"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHXGtGMm6vxWAtHXHteQBW; Sat, 15 Mar 2025 02:46:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006765; bh=33p4CZa3HV9PR8SsfzuHh+vNRgsmpc9tVzqIc5sYJnY=;
	h=Date:To:Cc:From:Subject;
	b=O1QDJ6GUR7NBLXgCslHyqviZWT266x7/YRiUEnZaPkPQT5I3wwJ0hv43FAFvYyhrA
	 8L8GAmaI5Vbq1Mc/Y03y7uBXUfnnrFbJcPfEPF+iVHfsOHA613fygKKd8Xkrnv4tdE
	 VCHlfCw0fKNzlNurEnTU5gF0dTUSbxTHdjwUF7nHEmxE5Y7O1KT2AE0Z+/qhQRpxod
	 f41OYQY8X/rDbbd3zjXNs4WTu8H7It26/sOftUEuA72uA3KCAb1yzR71R3AJFKVZxF
	 7s01s9n+cxKtLgAo1vR4+0fs6hHJd/AJRfrhTDvEyRoqksKa/2W8mplumii+I9A1OY
	 UjXl4ev/Zyikg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4e9ed
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=k1GtkNw_urPMITQtFusA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:46:01 +0000
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
Subject: [PATCH 00/12] miscellaneous build mods (part 1)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPf9xwFpSetBw+47AS9ihaJb+lPgfJWDo6fwIB7Z6o2YIXpprHX7CpjtqN5DknA0X/UuCij4AUa76kBF0WgtfDV7yVQBOxiUozR7hz/orFIFHsAUEVOt
 m7JP7IcUgz+LwT9gtmG5Fg9WCwY7ZOU+fCKQBKHr+JqEbjZrlZPDJS/Y3BzcIZJiCSTwo/Q6Db5dBlRovW8BWw4OdbXlraEnwi8=


This series contains some miscellaneous changes to the make, meson and
autoconf build systems. These are only the patches I have managed to
write a commit message for; I have some others with no commit message,
some need more testing and others are yet to be written. (So, there will
be a 'part #2' series later... :) ).

(I have notes from a couple of months ago - as an example, I have a note
that the meson build incorrectly sets ETC_GITATTRIBUTES and ETC_GITCONFIG
to e.g. '/etc/gitattributes' rather than 'etc/gitattributes').

This series is based on the master branch at commit 683c54c999 ("Git 2.49",
2025-03-14).

As a simple means for comparing the build products, we can compare the
symbols exported by git. So, starting at current master:

  $ git checkout master
  Switched to branch 'master'
  Your branch is up-to-date with 'origin/master'.
  $ git describe
  v2.49.0
  $ 

  $ make >out 2>&1
  $ 

  $ meson setup build/
  The Meson build system
  ...
  Found ninja-1.11.1 at /usr/bin/ninja
  $ 

  $ cd build
  $ meson compile
  INFO: autodetecting backend as ninja
  INFO: calculating backend command to run: /usr/bin/ninja
  [661/661] Copying file contrib/completion/git-completion.zsh
  $ cd ..
  $ 

  $ rm *.syms
  $ ./syms.pl git >git.syms 2>/dev/null
  $ ./syms.pl build/git >mgit.syms 2>/dev/null
  $ 

  $ diff git.syms mgit.syms
  88a89
  > U -- arc4random_buf@GLIBC_2.36
  98a100,101
  > U -- atoi@GLIBC_2.2.5
  > U -- atol@GLIBC_2.2.5
  195a199
  > U -- bsearch@GLIBC_2.2.5
  586,587d589
  < U -- dcgettext@GLIBC_2.2.5
  < U -- dcngettext@GLIBC_2.2.5
  746,747c748,749
  < B -- __environ@GLIBC_2.2.5
  < V -- environ@GLIBC_2.2.5
  ---
  > U -- __environ@GLIBC_2.2.5
  > U -- environ@GLIBC_2.2.5
  909c911
  < U -- __fprintf_chk@GLIBC_2.3.4
  ---
  > U -- fprintf@GLIBC_2.2.5
  914d915
  < U -- __fread_chk@GLIBC_2.7
  1007c1008
  < U -- getc@GLIBC_2.2.5
  ---
  > U -- getchar@GLIBC_2.2.5
  1018a1020
  > U -- getc_unlocked@GLIBC_2.2.5
  1107a1110
  > U -- gettext@GLIBC_2.2.5
  1253d1255
  < T -- gitstrlcpy
  1355a1358
  > U -- htons@GLIBC_2.2.5
  1666d1668
  < U -- __memcpy_chk@GLIBC_2.3.4
  1673d1674
  < U -- __memmove_chk@GLIBC_2.3.4
  1684d1684
  < U -- __memset_chk@GLIBC_2.3.4
  1737a1738
  > U -- ngettext@GLIBC_2.2.5
  1759a1761
  > U -- ntohs@GLIBC_2.2.5
  1819d1820
  < U -- __open64_2@GLIBC_2.7
  1988a1990,2007
  > U -- pcre2_code_free_8
  > U -- pcre2_compile_8
  > U -- pcre2_compile_context_create_8
  > U -- pcre2_compile_context_free_8
  > U -- pcre2_config_8
  > U -- pcre2_general_context_create_8
  > U -- pcre2_general_context_free_8
  > U -- pcre2_get_error_message_8
  > U -- pcre2_get_ovector_pointer_8
  > U -- pcre2_jit_compile_8
  > U -- pcre2_jit_match_8
  > U -- pcre2_maketables_8
  > U -- pcre2_maketables_free_8
  > U -- pcre2_match_8
  > U -- pcre2_match_data_create_from_pattern_8
  > U -- pcre2_match_data_free_8
  > U -- pcre2_pattern_info_8
  > U -- pcre2_set_character_tables_8
  2045c2064
  < U -- __printf_chk@GLIBC_2.3.4
  ---
  > U -- printf@GLIBC_2.2.5
  2080a2100
  > U -- pthread_equal@GLIBC_2.2.5
  2767c2787
  < U -- __snprintf_chk@GLIBC_2.3.4
  ---
  > U -- snprintf@GLIBC_2.2.5
  2925a2946
  > U -- strlcpy@GLIBC_2.38
  3185d3205
  < U -- __uflow@GLIBC_2.2.5
  3289,3290c3309,3311
  < U -- __vfprintf_chk@GLIBC_2.3.4
  < U -- __vsnprintf_chk@GLIBC_2.3.4
  ---
  > U -- vfprintf@GLIBC_2.2.5
  > U -- vprintf@GLIBC_2.2.5
  > U -- vsnprintf@GLIBC_2.2.5
  $ 

Looking at the above, you can see that quite a few differences relate to
symbols which differ due to the level of optimization during compilation.
This reflects, among other things, the different 'default' settings between
the Makefile and the meson build; e.g. prefix=$HOME vs. /usr/local, initial
CFLAGS='-g -O2 -Wall' vs. '-g -O0 -Wall'. Also, note that the make build
does not include the (optional) pcre2 library, even if it is installed on
the system.

[On cygwin the diff is slightly different, but also contains more symbols,
such as all symbols relating to the compat regex routines, clock_gettime,
getdelim, sysinfo and so on ... ;) ]

If we change the meson setup, thus:

  $ meson setup --optimization=2 -Dprefix=$HOME -Dpcre2=disabled build/

After we re-build and repeat the above symbol generation, we find:

  $ diff git.syms mgit.syms
  88a89
  > U -- arc4random_buf@GLIBC_2.36
  746,747c747,748
  < B -- __environ@GLIBC_2.2.5
  < V -- environ@GLIBC_2.2.5
  ---
  > U -- __environ@GLIBC_2.2.5
  > U -- environ@GLIBC_2.2.5
  1253d1253
  < T -- gitstrlcpy
  2925a2926
  > U -- strlcpy@GLIBC_2.38
  $ 

After applying these patches and adding settings to the config.mak file: 

  $ vim config.mak # add NO_STRLCPY and CSPRNG_METHOD
  $ 
  $ cat config.mak
  DEFAULT_TEST_TARGET=prove
  GIT_PROVE_OPTS='--timer'
  PYTHON_PATH=/usr/bin/python3
  GIT_TEST_HTTPD=false
  export GIT_TEST_HTTPD
  #DEVELOPER=1
  SPARSE_FLAGS += -D__STDC_NO_VLA__
  NO_STRLCPY=
  CSPRNG_METHOD=arc4random
  $ 

[Note that I commented out DEVELOPER=1. I'm not entirely sure why I did
that. :) Maybe it was one less variable? ]

  $ make >out 2>&1
  $ 

  $ meson setup --optimization=2 -Dprefix=$HOME -Dpcre2=disabled build/
  The Meson build system
  ...
    User defined options
      optimization: 2
      prefix      : /home/ramsay
      pcre2       : disabled
  
  Found ninja-1.11.1 at /usr/bin/ninja
  $ 

  $ cd build
  $ meson compile
  INFO: autodetecting backend as ninja
  INFO: calculating backend command to run: /usr/bin/ninja
  [661/661] Copying file contrib/completion/git-prompt.sh
  $ cd ..
  $ 

  $ rm *.syms
  $ ./syms.pl git >git.syms 2>/dev/null
  $ ./syms.pl build/git >mgit.syms 2>/dev/null
  $ 

  $ diff git.syms mgit.syms
  747,748c747,748
  < B -- __environ@GLIBC_2.2.5
  < V -- environ@GLIBC_2.2.5
  ---
  > U -- __environ@GLIBC_2.2.5
  > U -- environ@GLIBC_2.2.5
  $ 
 
On cygwin, this diff is now empty. ;)

The above diff seems to imply a difference in the linking of main() and
the C library startup routines (or something similar). However, I happened
to notice that the meson build included '-fPIC' in the build flags, so I
thought it was worth a punt:

  $ make CFLAGS='-g -O2 -Wall -fPIC' >out 2>&1

[with the advent of ASLR, I thought -fPIC/-fPIE was the default anyway!]

  $ diff git.syms mgit.syms
  2809,2811c2809,2811
  < U -- stderr@GLIBC_2.2.5
  < U -- stdin@GLIBC_2.2.5
  < U -- stdout@GLIBC_2.2.5
  ---
  > B -- stderr@GLIBC_2.2.5
  > B -- stdin@GLIBC_2.2.5
  > B -- stdout@GLIBC_2.2.5
  $ 

Hmm, so one step forward, one step back! (or is it 2 steps forward, 3 steps
back? ;) ). So, something for another day.

Note that both test suite runs ('make test' and 'meson test') pass all
tests (excluding the http, cvs, svn, and p4 tests) on Linux. (I am still
waiting for the v2.49.0 test run to finish on cygwin! :( ).

Also, patches #5 and #12 only add/modify a comment, so they could be
dropped, if people feel that they are not appropriate.

[Just in case you want to reproduce the above, I have appended the syms.pl
script below.]

ATB,
Ramsay Jones

Ramsay Jones (12):
  meson.build: remove -DCURL_DISABLE_TYPECHECK
  Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
  meson.build: only set build variables for non-default values
  Makefile: remove NEEDS_LIBRT build variable
  config.mak.uname: add a note about NO_STRLCPY for Linux
  config.mak.uname: only set NO_REGEX on cygwin for v1.7
  config.mak.uname: add HAVE_GETDELIM to the cygwin section
  config.mak.uname: add clock_gettime() to the cygwin build
  builtin/gc.c: correct RAM calculation when using sysinfo
  config.mak.uname: add sysinfo() configuration for cygwin
  config.mak.uname; add arc4random to the cygwin build
  config.mak.uname: add a note about CSPRNG_METHOD for Linux

 Makefile         | 45 +++++++++++++++++++++++----------------------
 builtin/gc.c     |  9 +++++++--
 config.mak.uname | 16 ++++++++++++----
 configure.ac     |  8 ++++++++
 meson.build      | 14 ++++++++++----
 5 files changed, 60 insertions(+), 32 deletions(-)

-- 
2.49.0

----------------- >8 ------------------ [syms.pl]
#!/usr/bin/perl -w

open(I, "-|", qw(nm -g), $ARGV[0]) or die;
while (<I>) {
	unless (/^[0-9a-f ]+ ([A-Z]) (\S*)$/) {
		print STDERR "? $_";
		next;
	}
	next if ($2 =~ /^\.refptr\./);
	print "$1 -- $2\n";
}
close I;

