Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E01C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 15:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355908AbiELP0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbiELP0m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 11:26:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1353541304
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652369181;
        bh=pHlSFfqKQedHxfijD+RCF3zeBlal1E+b9Etc6YkttBU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Cg1KfTXW00CagZ26U/hyAp9h0p13DH0N72zcrJadVtSwMTc1YimGDfnC1QUqnNeA1
         lz6J8XoIG5XZV2+WDma7mcMA8+axcfRXoYuBiAZ+C2YZqf3GLdj4K0XrJ82v/7rt4l
         e7uTmHrKFtBFmlHaeijsN1djLbFrAejXt/0s9Qpw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([213.196.213.50]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDywo-1nfEYT0BOe-00A27v; Thu, 12
 May 2022 17:26:21 +0200
Date:   Thu, 12 May 2022 17:26:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 26/28] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
In-Reply-To: <8278f32c4d894d4930b9f1f70f3aa01679e2011e.1650662994.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205121711300.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <8278f32c4d894d4930b9f1f70f3aa01679e2011e.1650662994.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:V2RHv27imo/o4OzyHFL15MEmZOv7Ki4IdiO0RTWT5OxAAkAd+ps
 LXiFFkgUx4n55YVHVXUqZhxVPfWQvp4WITQ67La0AVtcLwycvAwtnho6ISWIGYU/DfOPlhr
 Ap82QoAnGEvObgid9QkRC/jMhUfM147Cf+J5wECk5O+IzibrHrxDxVPgiQ+sunrGnnLmO45
 SklY5nQ80ZaUxQjmuEbDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R2ludOm58K8=:/9N/gQmwj7h0jE29NpQVQw
 1eqNuL9xkNyKekZDdIZft2cnDyW43WrjWjHKm1tgwlAWRFQU1MDF3ulr1+bMFFt+Jz3lnz0sK
 BjG92WIlrZCw/ftXFUUUG/JIF6D99rF+dtU5qwrFL/xZd73KPWypdrCMk/tyni/CTWzqAcS5p
 qAnD1yEbM/c/yBXQ5u9BUsF5sSADHRuD2IGklLKHwyTGyzhtZmOAygkZzR0qJzNIb5vTehwD6
 QD/nxd5hax9tWfnaB+/91CZo+/WF1YkL9wnYUpjpDJ8FNK6dNuO6RvLP8TskJ0bjmV3nUjoxV
 4Ivv6uYFMZRF6Lq/yrlTQe8zcscoCjs/aIqDktw7Prf74+sJj0F0bNlbViB7V3soqW6QzUB8w
 y+6P1vNX6ppi8JJkGvaBlqJCRawiho6XM4UYt2RFDdkQ+p/8gvLA9HxOOg58RzjVY/KzuZFO8
 9QYhAQHToaeXexfi/iX2YgL36Gi1uOiIXIcsp8SHsN2CB9GyJuQJKnBWJZxLV+12ItR3CGQ6A
 BZgR+tUhZoV6yAvlsu4DPA5FqyWnsrU2wr6H4fRQofdInN0g0qToUkW8sR7zu7IjzLlXUO4vP
 4wuigJnr2HE2Mo38Uu+6yKLFxcqKdfdOOfCrMmaBLJFIbweNeoFKX3u1bvVF4/1NtRD8uu0vi
 1bt+UEVyMD+79EPCOKH6QUC9dkrHYodUkEeHn6B/uoFtFmEi01wzJTHqPth3hOnDHrpPenKiE
 d68kLNuUNbF62Y1YMg9zIkA7fT+tL8L8O9/nnagIBpnkj8E47lGWdHwhgZ7RZn5oAv81x6rwt
 NXSvXgMNLgw2Vz6db14hvjYXpv/ktX6snygBIX8/NYcSWUzTAzrfNswbWQqtZKJunGqI5U3Lb
 QSgRx7IyRBUpomittfG/r89IZ6Fk8tL0Gfx9Z7fBCaBjBKWlqdABcOU1diTZGf09rxhTI8A5u
 zC5L8otxovtH0SfWWJw62ml35bVp5yYCtA3UqL/ukiHgxcS3roTUZ0HkQF/RwMSUPOn4p0KrL
 rOXKfQRwyb83uO2Z4z9iO/0cl2GVsvXM+SZwFlG5gXaK5vIox8PswlDHBIKOL4kmlowdQN5F+
 g2smz5cCaaB1j4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create a set of prereqs to help understand how file names
> are handled by the filesystem when they contain NFC and NFD
> Unicode characters.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/lib-unicode-nfc-nfd.sh | 167 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100755 t/lib-unicode-nfc-nfd.sh
>
> diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
> new file mode 100755
> index 00000000000..cf9c26d1e22
> --- /dev/null
> +++ b/t/lib-unicode-nfc-nfd.sh
> @@ -0,0 +1,167 @@
> +# Help detect how Unicode NFC and NFD are handled on the filesystem.
> +
> +# A simple character that has a NFD form.
> +#
> +# NFC:       U+00e9 LATIN SMALL LETTER E WITH ACUTE
> +# UTF8(NFC): \xc3 \xa9
> +#
> +# NFD:       U+0065 LATIN SMALL LETTER E
> +#            U+0301 COMBINING ACUTE ACCENT
> +# UTF8(NFD): \x65  +  \xcc \x81
> +#
> +utf8_nfc=3D$(printf "\xc3\xa9")
> +utf8_nfd=3D$(printf "\x65\xcc\x81")
> +
> +# Is the OS or the filesystem "Unicode composition sensitive"?
> +#
> +# That is, does the OS or the filesystem allow files to exist with
> +# both the NFC and NFD spellings?  Or, does the OS/FS lie to us and
> +# tell us that the NFC and NFD forms are equivalent.
> +#
> +# This is or may be independent of what type of filesystem we have,
> +# since it might be handled by the OS at a layer above the FS.
> +# Testing shows on MacOS using APFS, HFS+, and FAT32 reports a
> +# collision, for example.
> +#
> +# This does not tell us how the Unicode pathname will be spelled
> +# on disk, but rather only that the two spelling "collide".  We
> +# will examine the actual on disk spelling in a later prereq.
> +#
> +test_lazy_prereq UNICODE_COMPOSITION_SENSITIVE '
> +	mkdir trial_${utf8_nfc} &&
> +	mkdir trial_${utf8_nfd}
> +'
> +
> +# Is the spelling of an NFC pathname preserved on disk?
> +#
> +# On MacOS with HFS+ and FAT32, NFC paths are converted into NFD
> +# and on APFS, NFC paths are preserved.  As we have established
> +# above, this is independent of "composition sensitivity".
> +#
> +# 0000000 63 5f c3 a9
> +#
> +# (/usr/bin/od output contains different amount of whitespace
> +# on different platforms, so we need the wildcards here.)
> +#
> +test_lazy_prereq UNICODE_NFC_PRESERVED '
> +	mkdir c_${utf8_nfc} &&
> +	ls | od -t x1 | grep "63 *5f *c3 *a9"

As far as I can see, this would be the first usage of `od` in the test
suite. I'd actually like to reduce our dependency on Unix-y tools, not
increase it.

One thing we could do would be to imitate t4030, and introduce a shell
function that calls Perl, something like:

	bin2hex () {
		perl -e '
			$/ =3D undef;
			$_ =3D <>;
			s/./sprintf("%02x ", ord($&))/ge;
			print $_
		'
	}

But it is a thorn in my side for quite a few years already that we
_require_ Perl, even in NO_PERL builds.

So maybe a much better idea would be to introduce a small helper in
`t/helper/` that converts binary data on stdin to hex on stdout? Something
like this:

=2D- snip --
=46rom bee2a3c43c90683b3e86e1739361570cce76d382 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 12 May 2022 17:24:50 +0200
Subject: [PATCH] tests: add a helped to print a hexdump

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 Makefile                |  1 +
 t/helper/test-hexdump.c | 24 ++++++++++++++++++++++++
 t/helper/test-tool.c    |  1 +
 t/helper/test-tool.h    |  1 +
 4 files changed, 27 insertions(+)
 create mode 100644 t/helper/test-hexdump.c

diff --git a/Makefile b/Makefile
index 4a23508d16f..fc262f99a1f 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -708,6 +708,7 @@ TEST_BUILTINS_OBJS +=3D test-getcwd.o
 TEST_BUILTINS_OBJS +=3D test-hash-speed.o
 TEST_BUILTINS_OBJS +=3D test-hash.o
 TEST_BUILTINS_OBJS +=3D test-hashmap.o
+TEST_BUILTINS_OBJS +=3D test-hexdump.o
 TEST_BUILTINS_OBJS +=3D test-index-version.o
 TEST_BUILTINS_OBJS +=3D test-json-writer.o
 TEST_BUILTINS_OBJS +=3D test-lazy-init-name-hash.o
diff --git a/t/helper/test-hexdump.c b/t/helper/test-hexdump.c
new file mode 100644
index 00000000000..13f154d9fa7
=2D-- /dev/null
+++ b/t/helper/test-hexdump.c
@@ -0,0 +1,24 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+
+/*
+ * Read stdin and print a hexdump to stdout.
+ */
+int cmd__hexdump(int argc, const char **argv)
+{
+	char buf[1024];
+	ssize_t i, len;
+
+	for (;;) {
+		len =3D xread(0, buf, sizeof(buf));
+		if (len < 0)
+			die_errno("failure reading stdin");
+		if (!len)
+			break;
+
+		for (i =3D 0; i < len; i++)
+			printf("%02x ", buf[i]);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 3ce5585e53a..44bd8269a07 100644
=2D-- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -35,6 +35,7 @@ static struct test_cmd cmds[] =3D {
 	{ "genzeros", cmd__genzeros },
 	{ "getcwd", cmd__getcwd },
 	{ "hashmap", cmd__hashmap },
+	{ "hexdump", cmd__hexdump },
 	{ "hash-speed", cmd__hash_speed },
 	{ "index-version", cmd__index_version },
 	{ "json-writer", cmd__json_writer },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 9f0f5228508..8ec30136913 100644
=2D-- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -25,6 +25,7 @@ int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
+int cmd__hexdump(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
=2D- snap --

Other than the `od` usage, this patch looks good to me.

Thank you very much for driving FSMonitor forward!
Dscho

> +'
> +
> +# Is the spelling of an NFD pathname preserved on disk?
> +#
> +# 0000000 64 5f 65 cc 81
> +#
> +test_lazy_prereq UNICODE_NFD_PRESERVED '
> +	mkdir d_${utf8_nfd} &&
> +	ls | od -t x1 | grep "64 *5f *65 *cc *81"
> +'
> +	mkdir c_${utf8_nfc} &&
> +	mkdir d_${utf8_nfd} &&
> +
> +# The following _DOUBLE_ forms are more for my curiosity,
> +# but there may be quirks lurking when there are multiple
> +# combining characters in non-canonical order.
> +
> +# Unicode also allows multiple combining characters
> +# that can be decomposed in pieces.
> +#
> +# NFC:        U+1f67 GREEK SMALL LETTER OMEGA WITH DASIA AND PERISPOMEN=
I
> +# UTF8(NFC):  \xe1 \xbd \xa7
> +#
> +# NFD1:       U+1f61 GREEK SMALL LETTER OMEGA WITH DASIA
> +#             U+0342 COMBINING GREEK PERISPOMENI
> +# UTF8(NFD1): \xe1 \xbd \xa1  +  \xcd \x82
> +#
> +# But U+1f61 decomposes into
> +# NFD2:       U+03c9 GREEK SMALL LETTER OMEGA
> +#             U+0314 COMBINING REVERSED COMMA ABOVE
> +# UTF8(NFD2): \xcf \x89  +  \xcc \x94
> +#
> +# Yielding:   \xcf \x89  +  \xcc \x94  +  \xcd \x82
> +#
> +# Note that I've used the canonical ordering of the
> +# combinining characters.  It is also possible to
> +# swap them.  My testing shows that that non-standard
> +# ordering also causes a collision in mkdir.  However,
> +# the resulting names don't draw correctly on the
> +# terminal (implying that the on-disk format also has
> +# them out of order).
> +#
> +greek_nfc=3D$(printf "\xe1\xbd\xa7")
> +greek_nfd1=3D$(printf "\xe1\xbd\xa1\xcd\x82")
> +greek_nfd2=3D$(printf "\xcf\x89\xcc\x94\xcd\x82")
> +
> +# See if a double decomposition also collides.
> +#
> +test_lazy_prereq UNICODE_DOUBLE_COMPOSITION_SENSITIVE '
> +	mkdir trial_${greek_nfc} &&
> +	mkdir trial_${greek_nfd2}
> +'
> +
> +# See if the NFC spelling appears on the disk.
> +#
> +test_lazy_prereq UNICODE_DOUBLE_NFC_PRESERVED '
> +	mkdir c_${greek_nfc} &&
> +	ls | od -t x1 | grep "63 *5f *e1 *bd *a7"
> +'
> +
> +# See if the NFD spelling appears on the disk.
> +#
> +test_lazy_prereq UNICODE_DOUBLE_NFD_PRESERVED '
> +	mkdir d_${greek_nfd2} &&
> +	ls | od -t x1 | grep "64 *5f *cf *89 *cc *94 *cd *82"
> +'
> +
> +# The following is for debugging. I found it useful when
> +# trying to understand the various (OS, FS) quirks WRT
> +# Unicode and how composition/decomposition is handled.
> +# For example, when trying to understand how (macOS, APFS)
> +# and (macOS, HFS) and (macOS, FAT32) compare.
> +#
> +# It is rather noisy, so it is disabled by default.
> +#
> +if test "$unicode_debug" =3D "true"
> +then
> +	if test_have_prereq UNICODE_COMPOSITION_SENSITIVE
> +	then
> +		echo NFC and NFD are distinct on this OS/filesystem.
> +	else
> +		echo NFC and NFD are aliases on this OS/filesystem.
> +	fi
> +
> +	if test_have_prereq UNICODE_NFC_PRESERVED
> +	then
> +		echo NFC maintains original spelling.
> +	else
> +		echo NFC is modified.
> +	fi
> +
> +	if test_have_prereq UNICODE_NFD_PRESERVED
> +	then
> +		echo NFD maintains original spelling.
> +	else
> +		echo NFD is modified.
> +	fi
> +
> +	if test_have_prereq UNICODE_DOUBLE_COMPOSITION_SENSITIVE
> +	then
> +		echo DOUBLE NFC and NFD are distinct on this OS/filesystem.
> +	else
> +		echo DOUBLE NFC and NFD are aliases on this OS/filesystem.
> +	fi
> +
> +	if test_have_prereq UNICODE_DOUBLE_NFC_PRESERVED
> +	then
> +		echo Double NFC maintains original spelling.
> +	else
> +		echo Double NFC is modified.
> +	fi
> +
> +	if test_have_prereq UNICODE_DOUBLE_NFD_PRESERVED
> +	then
> +		echo Double NFD maintains original spelling.
> +	else
> +		echo Double NFD is modified.
> +	fi
> +fi
> --
> gitgitgadget
>
>
