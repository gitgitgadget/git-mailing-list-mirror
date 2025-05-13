Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0831CD0C
	for <git@vger.kernel.org>; Tue, 13 May 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164080; cv=none; b=t8obpmir19jP0QpQisKYs0BY+Ym9OBThyXlOiD0jcMoLFYOskCgIMEhfPPuUeeDIEDL9Yv2t4RQfa8eE24/H2MhdCJQqOUqrcih7Un0qyenJtqClmcJ3e1DIGkBotpgckB8DhdIfZ3b2Rgi+YjZYLJaNaxBzCHnNwwjQajx0r1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164080; c=relaxed/simple;
	bh=FKgv+dAqKPkstWj03N7XKpt0aSGXZrmiMR2CrIFR5Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xwes0NFkCMtQSV7/R3G+RqlJzhwncr9iSbRIl5ky233Av5RSa4I8IQTKZZ3qXm0ymPBtLK8mdbobP1lMHMXrLyziWdGxKq7ua3BTKxWQNwdm1Xida9mZ+irCa8q83OMIeKg/rg5Rwt55bvI4WlTeLqH9gyyv/YawJdhx0Pv3qIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=kDvIerft; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="kDvIerft"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id Ev8Rub969aTZGEv8cuZHrg; Tue, 13 May 2025 20:18:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747163888; bh=CJWAlPHE8T6343HDi5KkwlwuIegR+y9HFgf1IOmMSpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kDvIerft6o0yJrpeBVpS0aShvsaIuiGForNPJKdHfaVaUIau3DlP7Ndr+Pqz3lx08
	 3LYCz9UJWQHnqqU+Wp+GTyC8PAC5OZGXvZM2GKJgEJP8Vf21XHvgkSUsmM6/wJNbsa
	 KwtqdmFiSOWJ6XURhVxrjHeo7uOack09qcugquKu7qfnjHiwIfzRv6WTIaaUpGjF0T
	 U3bF6RlL7zuZQkIElswRYlol3h4vt4K7eToQUoSqMrwMs/Bu9Ck+WltG2/QukZKwCR
	 G9ecS1UXiGVQwSo22tbm2akgevAUrKauyc3t0uNBLucQjAfVrpYGakGwMgUF1vwrBc
	 ruIDgFo7KTEmQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9ne0vni c=1 sm=1 tr=0 ts=68239af0
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=VwQbUJbxAAAA:8
 a=7mOBRU54AAAA:8 a=5nwpKwuPa9Lko4x6fsUA:9 a=wa9RWnbW_A1YIeRBVszw:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: 'GIT Mailing-list ' <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v2 0/5] miscellaneous build mods (part 2)
Date: Tue, 13 May 2025 20:17:21 +0100
Message-ID: <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMmQNZot5DiROWagN5v/o25gM8RPz86U9EWXNO9cSOtLJIyJaVTSE49ilEb8g3dnQF2b1GdcMQgnLJumJCEn+Z8up+0w1+QkXW+UaPSmXNKSVJ9Oq90t
 OPQU9/cAd/ZRqKDbomHU4bJg0Y3MKPG/fA3egqu+RFHzq+ULmCadmU0CbF/prS4Gc1KOcXFdvxnTrDk2fakx76GrZXq3Wa98vpg=


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
 meson_options.txt                |  4 ++--
 perl/Git/SVN/Memoize/meson.build |  2 +-
 4 files changed, 50 insertions(+), 11 deletions(-)

range-diff against v1:

1:  d5847ef791 = 1:  1f3d34eafd meson.build: quote the GITWEBDIR build configuration
2:  49e2ec6fd2 = 2:  1b7751914a meson: correct install location of YAML.pm
3:  fece809f11 ! 3:  a385bbed83 meson: correct path to system config/attribute files
    @@ meson.build: libgit_c_args = [
     +else
     +  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') + '/gitattributes"'
     +endif
    ++
     +system_config = get_option('gitconfig')
     +if system_config != ''
     +  libgit_c_args += '-DETC_GITCONFIG="' + system_config + '"'
     +else
     +  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') + '/gitconfig"'
     +endif
    ++
      editor_opt = get_option('default_editor')
      if editor_opt != '' and editor_opt != 'vi'
        libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
    @@ meson_options.txt: option('default_pager', type: 'string', value: 'less',
      option('default_editor', type: 'string', value: 'vi',
        description: 'Fall-back editor.')
     -option('gitconfig', type: 'string', value: '/etc/gitconfig',
    -+option('gitconfig', type: 'string',
    ++option('gitconfig', type: 'string', # default 'etc/gitconfig'
        description: 'Path to the global git configuration file.')
     -option('gitattributes', type: 'string', value: '/etc/gitattributes',
    -+option('gitattributes', type: 'string',
    ++option('gitattributes', type: 'string', # default 'etc/gitattributes'
        description: 'Path to the global git attributes file.')
      option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
        description: 'Environment used when spawning the pager')
4:  d49afaedf3 = 4:  0d00951475 meson.build: correct setting of GIT_EXEC_PATH
5:  69848e557f = 5:  150e4110d2 configure.ac: upgrade to a compilation check for sysinfo
-- 
2.49.0

