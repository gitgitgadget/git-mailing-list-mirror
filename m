Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C01DE2A8
	for <git@vger.kernel.org>; Mon, 19 May 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672140; cv=none; b=bcIPPxl7zcvrpFuQgjQDb8LR0NPF6QbC8cxv/el40rJUTP52j+D8wGczNwmfTqf3oCQ7mLgJn345ksbleOaYqJsIaqel3nI8bbQaeghXXviMhJq7GqkIDNjEEiRBcANSxpySbzWJAXLanW3xkYhw82hxIaQLisfKBdIBR2sjzpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672140; c=relaxed/simple;
	bh=cH1huF35d5ZsTtC+RXnYHXo5tCKdhYFXMDSXoPwEpt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWUhXbjPU22Q1JCgMEogx0nopAcLgZMCKKDBaLbk1vJsuaXJe5qzOes1B9+PPWk/L/FnmlkWZdqfLngRNZYTl24f0UtIQb7Tq/vKKroDmd31EQeZeIdUn50crTqaRGDrf5fRvVnqY91t7N3u8zK7nnoqfkqSGSFub2b7vSxRrek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Le+PGVNY; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Le+PGVNY"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id H3J4um35fEe7cH3JDuD0Ai; Mon, 19 May 2025 17:25:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747671948; bh=+9sfbGijUVDO9BdYNvcECGQvR54Fq5rfFTpplG6AQKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Le+PGVNYQSlIDerdqyC/EMutnWL8J59KuiTGomH3TFxa+XnQVfpgaOKZolZbFyO7p
	 NDh+I08U75NjnAKc7MVYjriCJQz5gYBpzNS0PJB87+2n6Kg5vMQZyOlPVDOc6xiVZG
	 g1/R7i33mbuVbjvrSakN/p6qGzvHO669v0N/8x+oB6kRh3QnVcwy9SQ1GJSNNYVbgc
	 zVAPsf6dBVqKOLnGRfYO7MAx/iOWhxS3TTlDw9GiSKWetCS/2ln/XzL/Z0LzziA8bs
	 C4vjwusE3zMklP7y61ve4oCLn8SrnrFIVNsSU4xScY1hEFI0NCNFo2aRFZUbSwGrin
	 CA+uyLYyhnNRQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=BeN70at2 c=1 sm=1 tr=0 ts=682b5b8c
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=VwQbUJbxAAAA:8
 a=7mOBRU54AAAA:8 a=ULiA1pgHx28NhbirEBkA:9 a=wa9RWnbW_A1YIeRBVszw:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v4 0/5] miscellaneous build mods (part 2)
Date: Mon, 19 May 2025 17:25:18 +0100
Message-ID: <20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
References: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOUJdj8gIIzEU57G9ks6Hxx87fEGPbIJ4556wAQuEiuyLPv+TRBZHMPdei7Ba3368Ll1Sppvl6zuQ1oZntClNWmWErSKzvHTXQxBWRARb7iI8TmzlrtL
 aJuHoERD8dWbgQvg8nBBrLAHfM4R8H58jl42xkA/LB3M6UYkJoSQGGBjtxgUyX10PD1ah6y39+uxEJRn+GCldD2rhAYrZcg6g40=

Changes in v4:

Patch #3 changed as a result of Patricks review [+]:

 - remove comment showing the default option values for
   'gitattributes' and 'gitconfig', since this now appears
   in the description field (ie remove duplicate info).

Again, I did a test merge to master@cb96e1697a, next@a128411c76
and seen@df1b4f9cf9. The conflict which showed up in v1 against
the 'seen' branch now appears in the 'master' branch and has the
same resolution as v1.

Note: the test-suite passes for both 'make test' and 'meson test'
on Linux and 'meson test' on cygwin. (I have already had to wait
3.5 hours for 'meson test' to run on cygwin, so I will run the
'make test' later [it takes 6+ hours] and let you know if it fails.
Given that the only change from last time is the removal of a comment
in the 'meson_options.txt' file, the chances of 'make test' failing
seem to be rather remote - famous last words! ;) ).

A range-diff against v3 is given below.

[+] https://lore.kernel.org/git/aCrekcz6onTFgEWw@pks.im/

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

range-diff against v3:

1:  ac97fdc76e = 1:  247bc82c01 meson.build: quote the GITWEBDIR build configuration
2:  181738d371 = 2:  a87f683a95 meson: correct install location of YAML.pm
3:  1f4c74973c ! 3:  40ea59efca meson: correct path to system config/attribute files
    @@ meson_options.txt: option('default_pager', type: 'string', value: 'less',
     -  description: 'Path to the global git configuration file.')
     -option('gitattributes', type: 'string', value: '/etc/gitattributes',
     -  description: 'Path to the global git attributes file.')
    -+option('gitconfig', type: 'string', # default 'etc/gitconfig'
    ++option('gitconfig', type: 'string',
     +  description: 'Path to the global git configuration file. (default: etc/gitconfig)')
    -+option('gitattributes', type: 'string', # default 'etc/gitattributes'
    ++option('gitattributes', type: 'string',
     +  description: 'Path to the global git attributes file. (default: etc/gitattributes)')
      option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
        description: 'Environment used when spawning the pager')
4:  97ff1613f5 = 4:  a7d2f1e132 meson.build: correct setting of GIT_EXEC_PATH
5:  983488fe4e = 5:  a45b9dc650 configure.ac: upgrade to a compilation check for sysinfo

-- 
2.49.0

