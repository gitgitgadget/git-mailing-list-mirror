Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221EA1C8638
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421348; cv=none; b=q9HwrjEEJGndXW41Pf1UA0Q0Z2b7JK5JJppFhAlQlXQih2aZVPQ39bnzbVB/7iacuPsYKujl9TMXH+Elm+39xlz4Yu1q7fc6BNAJyrb1TGSaq1ETeN6QS94EtZUyTM6riXNedR7ZyVor23h2LPP2LD7Fb+Xh8EppugvvGzVtXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421348; c=relaxed/simple;
	bh=lLScpCosH0JFoWUe8AA6Ly+jkpEZdwfqeobqsQJD4zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjihCQrO3vjr1zYGKXEjxm2/Sw5qopUfMKgZ+C9CCx/djsakV7kxNHo99jbjM974XB4TPpL5O2N6es5q5ULNX+yhQ6UrRZ+OfEqVk1NEJHXsCVbvGVCBaocHILP7WT/nP01ix/4P194RhKrQDLNUKSmnG2T4bfIdAoyZi2vXw/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=qKBUmwYF; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="qKBUmwYF"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id G071uFdJgJGekG07AuP0hJ; Fri, 16 May 2025 19:49:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747421342; bh=c38Nc6ZMO0wCsDxafJFEeTuI5Mgu1VhbICgChcn2JD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qKBUmwYFMDPIDLOmNDfx+A7R3S4xfmmPbVPAWsiAE3sWSTZKbczyRGEIW8Ddv9eg2
	 EMx9yPB+oxi9+MLeNvJq08Y11IENLT7jOzckeuN+DVY/4D0xYgZoDOO4BmOu+X5qga
	 uy1KYEDXQIkaVc2/HDSg71Up2WPGF4AL6bSU6kBJZYzehBTaK9N6aiOzBtSZKWbkYD
	 ZehRp/ZOcF+pfPSY7o94vGO12fuzNK9yNDGeva1nCesquhUqR/XDTjo8ghg1+7hELF
	 5T+/IFn3Py5foFP8z1dZd/EDZKc8eWfLGCtG34eY5DBqjeeAPQuIYzBei6GEjnKqHz
	 GwHY9ePz4Nyew==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FoOm/Hrq c=1 sm=1 tr=0 ts=6827889e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=VwQbUJbxAAAA:8
 a=7mOBRU54AAAA:8 a=Mbj0Mp_t1QGgR0Hm3zoA:9 a=wa9RWnbW_A1YIeRBVszw:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v3 0/5] miscellaneous build mods (part 2)
Date: Fri, 16 May 2025 19:48:38 +0100
Message-ID: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
References: <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfI7uaS7Xh+S0pjmKzBmsoVFEagflxk1nDh24OMZvuaJVYyhN8kgzBp/5vmnOOBnDkFDmJpKketmpdC8BLuDi1gFU1F+RkyEXM1zu0s0btJfuiT9nuHGo
 1k5PnMGrq3aMdiqDN9jBoeio5ZiL5DotwqvgxaHn8YAzlkpWrEc+q7bEeLe9XD8PHHKPvvTxtq8z+hpg6WW/YDcZuRx8shB3FLU=

Changes in v3:

Patch #3 changed as a result of Patrick's review [*]:

 - use the '/' magic string operator when setting the
   ETC_GIT{CONFIG,ATTRIBUTES} build options.
 - add the default values to the 'description' fields
   for the 'gitconfig' and 'gitattributes' option
   definitions

Also, Junio, the range-diff below shows the typo fixup, but
you should find that it doesn't show for you this time. ;)

[yes, I did fix it up locally, but then overwrote it from
my cygwin repo ... Ahem! ;) ]

Again, I did a test merge to master@1a8a4971cc without issue and 
to next@0be31eac6b and seen@d36a872499. The conflict which showed
up in v1 against the 'seen' branch now appears in 'next' and has
the same resolution as v1.

A range-diff against v2 is given below.

[*] https://lore.kernel.org/git/aCbQ9OX2vqF82au8@pks.im/


Changes in v2:

Patch #3 is the only one changed (as a result of Patrick's review [0]):

 - add some blank lines to make the option handling blocks
   easier to see.
 - add a comment to 'gitconfig' and 'gitattributes' options
   to indicate the default values.

Note: The indicated defaults for the 'gitconfig' and 'gitattributes'
are only valid when the 'prefix' option is defaulted (or not /usr).
Indicating the 'correct' value when -Dprefix=/usr in the comment
would consume too much space. Is this acceptable, or is it too
confusing/misleading?

Also, thanks to Eli for testing patch #5 on Solaris and confirming
that it fixes the regression [1].

Note that I did a test merge to master@38af977b81 without issue and
to next@889b7c5bd8 and seen@d8088176ab. The conflict which showed
up in v1 against the 'seen' branch now appears in 'next' and has
the same resolution as v1.

A range-diff against v1 is given below.

[0] https://lore.kernel.org/git/aB3CDOljn9zJsVwt@pks.im/
[1] https://lore.kernel.org/git/9baad29d-a5bf-443d-98a1-36d7020e5835@gentoo.org/

v1 cover letter follows:

This series (part 2) continues the miscellaneous changes to the make,
meson and autoconf build systems. I am sending this part a little
earlier than I expected, so there will now be a part 3!

The reason for the early posting is to try and avoid an regression in
the autoconf build system (see patch #5). Hopefully, we still have time
in this cycle to get patch #5 included.

This series is based on commit 6f84262c44 ("The eleventh batch", 2025-05-05)

I did a test merge to 'next'@629a3ecd64 without issue, but 'seen'@71cfd25022
had a small conflict with commit 1a2929c851 ("meson: allow customize perl
installation path", 2025-04-24) on the 'dd/meson-perl-custom-path' branch.
(I note that a new version of that patch was posted to the list today).

The fixup looks like:

    diff --cc perl/Git/SVN/Memoize/meson.build
    index 4c589b30c3,8c2e80d2d2..d6209dc3bf
    --- a/perl/Git/SVN/Memoize/meson.build
    +++ b/perl/Git/SVN/Memoize/meson.build
    @@@ -3,6 -3,6 +3,6 @@@ test_dependencies += custom_target
        output: 'YAML.pm',
        command: generate_perl_command,
        install: true,
    -   install_dir: perllibdir / 'Git/SVN',
     -  install_dir: get_option('datadir') / 'perl5/Git/SVN/Memoize',
    ++  install_dir: perllibdir / 'Git/SVN/Memoize',
        depends: [git_version_file],
      )

ATB,
Ramsay Jones

Ramsay Jones (5):
  meson.build: quote the GITWEBDIR build configuration
  meson: correct install location of YAML.pm
  meson: correct path to system config/attribute files
  meson.build: correct setting of GIT_EXEC_PATH
  configure.ac: upgrade to a compilation check for sysinfo

 configure.ac                     | 25 ++++++++++++++++++++++---
 meson.build                      | 30 +++++++++++++++++++++++++-----
 meson_options.txt                |  8 ++++----
 perl/Git/SVN/Memoize/meson.build |  2 +-
 4 files changed, 52 insertions(+), 13 deletions(-)

range-diff against v2:

1:  1f3d34eafd = 1:  ac97fdc76e meson.build: quote the GITWEBDIR build configuration
2:  1b7751914a = 2:  181738d371 meson: correct install location of YAML.pm
3:  a385bbed83 ! 3:  1f4c74973c meson: correct path to system config/attribute files
    @@ meson.build: libgit_c_args = [
     +if system_attributes != ''
     +  libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
     +else
    -+  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') + '/gitattributes"'
    ++  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') / 'gitattributes"'
     +endif
     +
     +system_config = get_option('gitconfig')
     +if system_config != ''
     +  libgit_c_args += '-DETC_GITCONFIG="' + system_config + '"'
     +else
    -+  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') + '/gitconfig"'
    ++  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') / 'gitconfig"'
     +endif
     +
      editor_opt = get_option('default_editor')
    @@ meson_options.txt: option('default_pager', type: 'string', value: 'less',
      option('default_editor', type: 'string', value: 'vi',
        description: 'Fall-back editor.')
     -option('gitconfig', type: 'string', value: '/etc/gitconfig',
    -+option('gitconfig', type: 'string', # default 'etc/gitconfig'
    -   description: 'Path to the global git configuration file.')
    +-  description: 'Path to the global git configuration file.')
     -option('gitattributes', type: 'string', value: '/etc/gitattributes',
    +-  description: 'Path to the global git attributes file.')
    ++option('gitconfig', type: 'string', # default 'etc/gitconfig'
    ++  description: 'Path to the global git configuration file. (default: etc/gitconfig)')
     +option('gitattributes', type: 'string', # default 'etc/gitattributes'
    -   description: 'Path to the global git attributes file.')
    ++  description: 'Path to the global git attributes file. (default: etc/gitattributes)')
      option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
        description: 'Environment used when spawning the pager')
    + option('perl_cpan_fallback', type: 'boolean', value: true,
4:  0d00951475 = 4:  97ff1613f5 meson.build: correct setting of GIT_EXEC_PATH
5:  150e4110d2 ! 5:  983488fe4e configure.ac: upgrade to a compilation check for sysinfo
    @@ Commit message
         Commit 50dec7c566 ("config.mak.uname: add sysinfo() configuration for
         cygwin", 2025-04-17) added a similar 'sysinfo()' check to the autoconf
         build. This check looked for the 'sysinfo()' function itself, rather
    -    that just the header, but it will fail (incorrectly set HAVE_SYSINFO)
    +    than just the header, but it will fail (incorrectly set HAVE_SYSINFO)
         for the same reason.
     
         In order to correctly identify the 'sysinfo()' function we require as
-- 
2.49.0

