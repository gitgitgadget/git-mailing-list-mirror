Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A5155C97
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968537; cv=none; b=iqjQchgLGDqYbBzIGHtUl8bUT8PebKIyfbM6d3waV9/igHK7f6DzDSgpQtmQlu1q3DqQX0rsurUR0ab8LTLgQ5dqsc9P0TLW+Mo/nuRo3GhcHgm49Y4qtmJf0Xfu+LNLjYerU8QnNcwZKlP8U2mh33cEtGLtETS3XSd3lsl0pDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968537; c=relaxed/simple;
	bh=NEf+W3/MvK2aOr4sw54kQowa1gmaU/Qo0FmNBnKruyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cE/NKH3iLy1jtO2ftJRd4BssGRfxtLqU5h4oZ8/g0RckCWRAAYEtoI216Af2qv3+7S9U7yRsAZ0peS+rMtyi68pPHVix0RwgmUVgmCKFMB9XwvwZ2MI6J9d1BquOcHtya3ebvqI3Cxu0epnoFCXhVY+u63sdJ8G9eptfk8wIjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=J8+DmmjQ; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="J8+DmmjQ"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VpeupkL1; Sun, 06 Apr 2025 20:39:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968345; bh=DPyT7msTLLxWIL5xZqDTGvWK7XehCoP7OOlrkr9Qidk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J8+DmmjQ2MU345qSZ4Qoumafo0zfLAC+W3zm0hOWln+jNhRhvHRYizvmAc/ug28Jp
	 hzjOVqnUaRKf3w2mZJNJMMyUgQn5VwZoBjb9QklHWRsc7sxQo3n5Omm6iice3p6y3s
	 QARVqJC5Q3KaywT3PtAHlHU0Ff5kGMBmVB/bPY8XQbimVMV76ogPyAmG1maWrVXWcC
	 nvnqPc4vdnMhT15Mw4gtv0kGbcWfwvOhnixouBQ74kRsMmRXGr5Iyg1BzqsvAem8Gz
	 K7JJ9/X29uloFfI7jmY6rMrlEn0BMw0kqgOjVU4YWn8Z1Z+aAFN6dYbovwI+wDYzn6
	 RPcsgUi65z9Cw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d859
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=VwQbUJbxAAAA:8
 a=iKrn8l-KAAAA:8 a=EBOSESyhAAAA:8 a=I6Muz1nQikWywNXy6YEA:9
 a=vz8bQswTWcriz0i0jksL:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 00/13] miscellaneous build mods (part 1)
Date: Sun,  6 Apr 2025 20:38:26 +0100
Message-ID: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCSXxvdKedaPVwvcLEdpitgqWUqDiA4tkA0NA5kor0g5XOoyIJdSNddzS43VmgBpLkc92sWLTLZmatJZKQENnMFdl02v4tV8KfxqIkfZxRdOWPZjzrZI
 o2lpOvQp+a5wneQVDN8UJmbNd7Y8sV/CjymW7RzW99iTX516JIfM5zec/xO7yvnl9eDbSlRyULFVzL//HEl697ef0nfgUDPK/JM=


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

range-diff against v1:

 1:  50ce21363e =  1:  fe969deec0 meson.build: remove -DCURL_DISABLE_TYPECHECK
 2:  b7097a71b4 =  2:  8df541634a Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
 3:  85363624b2 <  -:  ---------- meson.build: only set build variables for non-default values
 -:  ---------- >  3:  280363cd56 meson.build: only set build variables for non-default values
 -:  ---------- >  4:  34349bf98c meson.build: set default help format to html on windows
 4:  4bda84bbf2 =  5:  e73c2c3219 Makefile: remove NEEDS_LIBRT build variable
 5:  45d570f6d4 =  6:  8c76671f0e config.mak.uname: add a note about NO_STRLCPY for Linux
 6:  45ef2d4268 !  7:  324bb21342 config.mak.uname: only set NO_REGEX on cygwin for v1.7
    @@ Commit message
         some of the tests (t4018 and t4034), which passed just fine with the
         compat library.
     
    -    After some time (may a year or two), the platform library had been
    +    After some time (maybe a year or two), the platform library had been
         updated (with an import from FreeBSD, I believe) and now passed the full
         test-suite. This would be about the time of the v1.7 -> v2.0 transition
         in 2015. I had a patch ready to send, but just didn't get around to
    @@ Commit message
         NO_REGEX variable to use the platform regex library functions. The new
         meson build system does likewise.
     
    +    The cygwin platform regex library, in addition to now passing the tests
    +    which formerly failed, now passes an 'test_expect_failure' test in the
    +    t7815-grep-binary test file. In particular, test #12 'git grep .fi a'
    +    which determines that the regex pattern '.' matches a NUL character.
    +    The commit f96e56733a ("grep: use REG_STARTEND for all matching if
    +    available", 2010-05-22) added the test in question, but it does not
    +    give any indication as to why the test was framed as an expected fail,
    +    rather than a 'positive' test that the 'git grep' command fails to
    +    match a NUL. Note that the previous test #11 was also originally
    +    marked in that commit as a 'test_expect_failure', but was flipped to
    +    an 'success' test in commit 7e36de5859 ("t/t7008-grep-binary.sh: un-TODO
    +    a test that needs REG_STARTEND", 2010-08-17).
    +
         In order to produce the same NO_REGEX configuration from autoconf, meson
         and make, modify config.mak.uname to only set NO_REGEX for cygwin v1.7.
    +    In addition, skip test t7815.12 on cygwin, by adding the !CYGWIN pre-
    +    requisite to the test header, which (among other things) removes an
    +    '...; please update test(s)' comment.
     
      ## config.mak.uname ##
     @@ config.mak.uname: ifeq ($(uname_O),Cygwin)
    @@ config.mak.uname: ifeq ($(uname_O),Cygwin)
              endif
      	HAVE_DEV_TTY = YesPlease
      	HAVE_ALLOCA_H = YesPlease
    +
    + ## t/t7815-grep-binary.sh ##
    +@@ t/t7815-grep-binary.sh: test_expect_success 'git grep ile a' '
    + 	git grep ile a
    + '
    + 
    +-test_expect_failure 'git grep .fi a' '
    ++test_expect_failure !CYGWIN 'git grep .fi a' '
    + 	git grep .fi a
    + '
    + 
 7:  aa3e298fde =  8:  0a3ce7e80a config.mak.uname: add HAVE_GETDELIM to the cygwin section
 8:  dc30aa5653 =  9:  3bd6e40cd2 config.mak.uname: add clock_gettime() to the cygwin build
 9:  1e92c641a6 = 10:  a2eb9ab117 builtin/gc.c: correct RAM calculation when using sysinfo
10:  6e208c53dd = 11:  e45b9df3a4 config.mak.uname: add sysinfo() configuration for cygwin
11:  990fde71bb ! 12:  422d4b2571 config.mak.uname; add arc4random to the cygwin build
    @@ Metadata
     Author: Ramsay Jones <ramsay@ramsayjones.plus.com>
     
      ## Commit message ##
    -    config.mak.uname; add arc4random to the cygwin build
    +    config.mak.uname: add arc4random to the cygwin build
     
         The arc4random_buf() function has been available in cygwin since
         about 2016 (somewhere in the v2.x branch). Set the CSPRNG_METHOD
12:  847ca6b16c ! 13:  7b133af24b config.mak.uname: add a note about CSPRNG_METHOD for Linux
    @@ Metadata
     Author: Ramsay Jones <ramsay@ramsayjones.plus.com>
     
      ## Commit message ##
    -    config.mak.uname: add a note about CSPRNG_METHOD for Linux
    +    config.mak.uname: set CSPRNG_METHOD to getrandom on Linux
     
         Commit 05cd988dce ("wrapper: add a helper to generate numbers from a
         CSPRNG", 2022-01-17) added a csprng_bytes() function which used one
    @@ Commit message
         Commit 05cd988dce did not set CSPRNG_METHOD in the Linux section of
         the config.mak.uname file, so it defaults to using '/dev/urandom' as
         the source of random bytes. The 'backend' values which could be used
    -    on Linux, in order of preference, are 'arc4random', 'getrandom' or
    -    'getentropy' ('openssl' is an option, but seems to be discouraged).
    +    on Linux are 'arc4random', 'getrandom' or 'getentropy' ('openssl' is
    +    an option, but seems to be discouraged).
     
         The arc4random routines (ar4random_buf() is the one actually used) were
         added to glibc in version 2.36, while both getrandom() and getentropy()
         were included in 2.25. So, some of the more up-to-date distributions of
    -    Linux (eg Debian 12, Ubuntu 24.04) would be able to use the preferred
    -    'arc4random' setting.
    +    Linux (eg Debian 12, Ubuntu 24.04) would be able to use the 'arc4random'
    +    setting. All currently supported distributions have glibc 2.25 or later
    +    (RHEL 8 has v2.28) and, therefore, have support for the 'getrandom' and
    +    'getentropy' settings.
    +
    +    The arc4random routines on the *BSDs (along with cygwin) implement the
    +    ChaCha20 stream cipher algorithm (see RFC8439) in userspace, rather than
    +    as a system call, and are thus somewhat faster (having avoided a context
    +    switch to the kernel). In contrast, on Linux all three functions are
    +    simple wrappers around the same kernel CSPRNG syscall.
     
         If the meson build system is used on a newer platform, then they will be
         configured to use 'arc4random', whereas the make build will currently
    -    default to using '/dev/urandom'. Add a note to the config.mak.uname file,
    -    in the Linux section, to prompt make users to override CSPRNG_METHOD in
    -    the config.mak file, if appropriate.
    +    default to using '/dev/urandom' on Linux. Since there is no advantage,
    +    in terms of performance, to the 'arc4random' setting, the 'getrandom'
    +    setting should be preferred from an availability perspective. (Also, the
    +    current uses of csprng_bytes() are not in any hot path).
    +
    +    In order to set an appropriate default, set the CSPRNG_METHOD build
    +    variable to 'getrandom' in the Linux section of the 'config.mak.uname'
    +    file.
     
      ## config.mak.uname ##
     @@ config.mak.uname: ifeq ($(uname_S),Linux)
      	HAVE_ALLOCA_H = YesPlease
      	# override in config.mak if you have glibc >= 2.38
      	NO_STRLCPY = YesPlease
    -+	# set to arc4random (in config.mak) if you have glibc >= 2.36
    -+	CSPRNG_METHOD =
    ++	CSPRNG_METHOD = getrandom
      	HAVE_PATHS_H = YesPlease
      	LIBC_CONTAINS_LIBINTL = YesPlease
      	HAVE_DEV_TTY = YesPlease
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

