Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFD2356D1
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845546; cv=none; b=TCVpDEc5R301x5/y/5b0jZUsk6pfROHzSeTndudt1s6ikwVto5cscWJ5b4XXnS2LJm/DSBvLghH3RdshCQRU9+yYShvfwAEv9vf2DqsfF9u/RNJNuGSYnlCJAtHSdxkkJrjbEprDnLF+VehptWOaMILobFrD9CYemgAW+nklaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845546; c=relaxed/simple;
	bh=9byeaOeg5lZuD1bCYq9RKYYvHLBtWrCPS6LdBId+mCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHcNzv3jUOAANgC4Wm4RwFlOpKu1hj6kETdCseMqoR1koy00YAVHEQ+DCSyNp6s+SbSPPpzNRygwyjMhI+h5jUDQzc+hjQyLd2R3pmbJiu3t7pGN0dQ73JhQbjughpai+8hSSMeJQDatN3amks7tl0x+NEyJtjUG3I13D23pyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=OktDkG2b; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="OktDkG2b"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C20u8KP3; Thu, 17 Apr 2025 00:19:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845542; bh=NSZxcSUfyTsO3JC08OplsJIilhzvCbAEa6WzpkZ5Isw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OktDkG2bgnTgogP1qtD3R1wQS8+ozxPtM2VRSyFd1BH/As40UVkj+w91YkyAnq7mT
	 lDD9EsY8I2th2hgytzG/izH+xGQ2+jbOuVybq5FBiDnRyQ9BAnx4VvvmPkFveuBrXz
	 6SB8eUuJPSQNAkRj75hRsRlZ+pCXobc9sSOlGLzxUeTP0kymzZlzqAHCfNfx58s4eL
	 yXSLFf0gVDOFZEBlr7Zr0oSHvrMg9Tp2QxRm63TDAMLEK1Dr3Z7Z35j7rK/GpCCvxK
	 S962pBfV+YQWYzVMxexLHTDPPJtlSB1bt1SsA03Owh3mnNHs9fBBxPqfhxvOOpQNAo
	 W35pij4Bf1ACA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003ae6
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=VwQbUJbxAAAA:8
 a=iKrn8l-KAAAA:8 a=kmWVGoOTbcZIwMfLLxQA:9 a=vz8bQswTWcriz0i0jksL:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 00/13] miscellaneous build mods (part 1)
Date: Thu, 17 Apr 2025 00:18:21 +0100
Message-ID: <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMblcXIkBKfSO+pxWff1c08+XT55FNfdDm46yP9Z5FvyCZboVpNhXn3ycYVDCeB+XGlOx66tLpD332WbwKJMK1xEL50EgPK6GGWxUX6+ZUlO+6P1oUco
 jZy+EZ8UaM4a1HR3ssFA9iJoe/zf2+BODpodypSHieyJ4tvaIBIMCjpQktjO8xVTZUCqLPoXBJfGUKrtSI9V6H5mmdI1Aag8TtQ=

changes in v3:
--------------

- patch #9 adds some whitespace around the '=' sign in the
  assignment to HAVE_CLOCK_GETTIME and HAVE_CLOCK_MONOTONIC
  build variables

The range-diff below was generated with a 'creation-factor'
of 80%, otherwise patches after #9 are shown as complete
re-writes.

I have built and tested both the make and meson builds on Linux,
along with the make build and meson build and test on cygwin.
(A 'make test' on cygwin takes 6 hours, so I will test that
tomorrow and let you know if it fails! ;) Highly unlikely to
fail, since the v2 patches passed just fine).

changes in v2:
--------------

- patch #3 has been split into two (new patches #3,4). The motivation
  for the original patch seems not to have been too obvious. The new
  patch #3 combines the suppressing the -Defines for standard default
  values for editor and pager, with the setting of the missing docs
  attributes. The new patch #4 combines the suppressing of the -Define
  for the default-help-format, with the overriding of the default value
  on the windows platform.

- patch #6 (new #7) updates the commit message along with skipping the
  'failing' test #12 in t7815-grep-binary.sh on cygwin. (With the cygwin
  platform regex library the '.' pattern matches a NUL character).

- patch #11 (new #12) fixes a simple typo in the patch subject.

- patch #12 (new #13) updates the commit message and makes a choice for
  the default CSPRNG_METHOD on Linux; 'getrandom' as advised by Brian
  here [0].

[0] https://lore.kernel.org/git/Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net/

As before, this series is based on commit 683c54c999 ("Git 2.49", 2025-03-14).

Also, I did a test merge to 'master'@5b97a56fa0, 'next'@ff1f9ca942 and
'seen'@1b09671a54 and they all 'auto-merged' without issue.

As an experiment, I am using 'git sendemail' to send this series for the
first time (I have sent single patches before, but not a series), so if
anything goes awry I apologize in advance! :)

A range-diff is given below.


The original v1 cover-letter follows:
-------------------------------------

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

Ramsay Jones (13):
  meson.build: remove -DCURL_DISABLE_TYPECHECK
  Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
  meson.build: only set build variables for non-default values
  meson.build: set default help format to html on windows
  Makefile: remove NEEDS_LIBRT build variable
  config.mak.uname: add a note about NO_STRLCPY for Linux
  config.mak.uname: only set NO_REGEX on cygwin for v1.7
  config.mak.uname: add HAVE_GETDELIM to the cygwin section
  config.mak.uname: add clock_gettime() to the cygwin build
  builtin/gc.c: correct RAM calculation when using sysinfo
  config.mak.uname: add sysinfo() configuration for cygwin
  config.mak.uname: add arc4random to the cygwin build
  config.mak.uname: set CSPRNG_METHOD to getrandom on Linux

 Documentation/meson.build | 20 +++++++++++++++++
 Makefile                  | 45 ++++++++++++++++++++-------------------
 builtin/gc.c              |  9 ++++++--
 config.mak.uname          | 15 +++++++++----
 configure.ac              |  8 +++++++
 meson.build               | 27 +++++++++++++++++++----
 meson_options.txt         |  2 +-
 t/t7815-grep-binary.sh    |  2 +-
 8 files changed, 94 insertions(+), 34 deletions(-)


range-diff between v2 and v3:

 1:  fe969deec0 =  1:  62173d3c48 meson.build: remove -DCURL_DISABLE_TYPECHECK
 2:  8df541634a =  2:  cded8cb86c Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
 3:  280363cd56 =  3:  f6a5e46876 meson.build: only set build variables for non-default values
 4:  34349bf98c =  4:  a39952e29c meson.build: set default help format to html on windows
 5:  e73c2c3219 =  5:  9d4f2736cd Makefile: remove NEEDS_LIBRT build variable
 6:  8c76671f0e =  6:  619bee80a3 config.mak.uname: add a note about NO_STRLCPY for Linux
 7:  324bb21342 =  7:  b0909d3eba config.mak.uname: only set NO_REGEX on cygwin for v1.7
 8:  0a3ce7e80a =  8:  b61bf9ea2e config.mak.uname: add HAVE_GETDELIM to the cygwin section
 9:  3bd6e40cd2 !  9:  b2fcec5b9b config.mak.uname: add clock_gettime() to the cygwin build
    @@ config.mak.uname: ifeq ($(uname_O),Cygwin)
              endif
      	HAVE_DEV_TTY = YesPlease
      	HAVE_GETDELIM = YesPlease
    -+	HAVE_CLOCK_GETTIME=YesPlease
    -+	HAVE_CLOCK_MONOTONIC=YesPlease
    ++	HAVE_CLOCK_GETTIME = YesPlease
    ++	HAVE_CLOCK_MONOTONIC = YesPlease
      	HAVE_ALLOCA_H = YesPlease
      	NEEDS_LIBICONV = YesPlease
      	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
10:  a2eb9ab117 = 10:  7d62945b26 builtin/gc.c: correct RAM calculation when using sysinfo
11:  e45b9df3a4 ! 11:  eff0c2a1a2 config.mak.uname: add sysinfo() configuration for cygwin
    @@ config.mak.uname: ifeq ($(uname_S),Linux)
      	COMPAT_OBJS += compat/linux/procinfo.o
     @@ config.mak.uname: ifeq ($(uname_O),Cygwin)
      	HAVE_GETDELIM = YesPlease
    - 	HAVE_CLOCK_GETTIME=YesPlease
    - 	HAVE_CLOCK_MONOTONIC=YesPlease
    + 	HAVE_CLOCK_GETTIME = YesPlease
    + 	HAVE_CLOCK_MONOTONIC = YesPlease
     +	HAVE_SYSINFO = YesPlease
      	HAVE_ALLOCA_H = YesPlease
      	NEEDS_LIBICONV = YesPlease
12:  422d4b2571 ! 12:  5f8bf7862f config.mak.uname: add arc4random to the cygwin build
    @@ Commit message
     
      ## config.mak.uname ##
     @@ config.mak.uname: ifeq ($(uname_O),Cygwin)
    - 	HAVE_CLOCK_GETTIME=YesPlease
    - 	HAVE_CLOCK_MONOTONIC=YesPlease
    + 	HAVE_CLOCK_GETTIME = YesPlease
    + 	HAVE_CLOCK_MONOTONIC = YesPlease
      	HAVE_SYSINFO = YesPlease
     +	CSPRNG_METHOD = arc4random
      	HAVE_ALLOCA_H = YesPlease
13:  7b133af24b = 13:  07db9583bf config.mak.uname: set CSPRNG_METHOD to getrandom on Linux

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

