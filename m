Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D843F1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 05:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeKCOZT (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 10:25:19 -0400
Received: from mail-oln040092003051.outbound.protection.outlook.com ([40.92.3.51]:47712
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbeKCOZS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 10:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqfqFNGl2kueUtfGGtvBuuyQnUxrSQZKJ3OlxcmGsvM=;
 b=hnROKwdgDys2CPXjfgMzcBrmvdah9LlFAh+1xuk47KcxKDpQaxjE98T2JakDeh/L0bwc/ohqNuj7lpXmdOP+Qh9SomwsvK3sOY/PyzKcbjhSfP4S2BAqSKp2mXJG0t9SFR0pI2zVh/BFMPkwUvKGc4HIozx4PmAjMLJsIHBsM6aoIashhOka02LEQpXpwI1wYmkdbasOm8lERYZA6y1Quvw8x2RJmEVOY6WuZpop92TJEPJsLU+LJA/WEfx+l8NNZOtCLfi3tFHiIQXzKJ48jUqPZkmVx7SZURWhCXCiPaJ6Wyq9o5URZwOGUO0Q1VnIxhFjb0UswZb18S7sJIZPOw==
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (10.152.76.56) by BL2NAM02HT180.eop-nam02.prod.protection.outlook.com
 (10.152.77.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.14; Sat, 3 Nov
 2018 05:12:11 +0000
Received: from SN4PR0701MB3679.namprd07.prod.outlook.com (10.152.76.58) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Sat, 3 Nov 2018 05:12:11 +0000
Received: from SN4PR0701MB3679.namprd07.prod.outlook.com
 ([fe80::8dfb:896:ad73:e7c5]) by SN4PR0701MB3679.namprd07.prod.outlook.com
 ([fe80::8dfb:896:ad73:e7c5%3]) with mapi id 15.20.1273.030; Sat, 3 Nov 2018
 05:12:11 +0000
From:   James Knight <james.d.knight@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     James Knight <james.d.knight@live.com>
Subject: [PATCH v2] build: link with curl-defined linker flags
Thread-Topic: [PATCH v2] build: link with curl-defined linker flags
Thread-Index: AQHUczPGjPTFGywXZk2wjIn3pqjeEg==
Date:   Sat, 3 Nov 2018 05:12:11 +0000
Message-ID: <SN4PR0701MB3679953BCD417500EC2A267BA0C80@SN4PR0701MB3679.namprd07.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::46) To SN4PR0701MB3679.namprd07.prod.outlook.com
 (2603:10b6:803:4d::21)
x-incomingtopheadermarker: OriginalChecksum:F696792184CAFF2383DD36785BD2AEF3E270A2F8AEF9CA84152503AAFC895AC2;UpperCasedChecksum:B1586A256A6E9FB5319B0AFB7ECB860C11F351EC7A40FFE908C0F6DD3DA46BAB;SizeAsReceived:7366;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [cWjLvxtAW3E8s5xK/FmswHsiNQamiP+1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL2NAM02HT180;6:5pMzCjO3mOnl3qpmrNG5RILIaEwd+0STcjV3tLxOBIC/QHOrQl8efbt3rj/t4mAnCS5eOpIk5KnrNJpnqtbB9+SkG/Sx5poWaE2gUxTSe445DbmMGkc2Z5s3M4ibmKJivR3qNjCFBZmj+3S+BXArLoFoOUk6MMj+XX+ABuwmnI+w3yUue85rkwYhT9UE28O0939K3hyKM3Hk5+JKxvV4tKHIvMhqM1wGqv5ZSgcCqLWM8TdnZbWRrxUS3w4ICOmc4wrPGf/cVbHdHfCbPv39xYTdt4O/sq7V3rqqzijQhM/RgMGRQ4HlWfDpWgO8nJ5/LZmBB89fOQLhct0YzMMvMWIGXGnds5sG3ZeTZRxzkZ9pEzXoIdZKW4xz4GbbfpNj7TIhgDjeOA7fz3yLpRnb5Mazgc3f3haQiI8UVI1hARPAFiBbFDlL8zu/VE8ptQ5JKeoIbY+HsvbKNEy3mtC1nw==;5:xvLaJxTewgZCB6QEYk7MlFJRqZPmzHrLeaYt9+OQySX78KFA/P3bHOyIAIYGC4DtcEQxUhXKnkdsTN5AKQdPVyD5C6TbAyXLLmL8GkIAAhQIGm8tfXFQIvZC5M+U+/Dj+ILSuTiCX6nmT8xu30m2ob9T2WF2niD+9pLwZDfO4g4=;7:U5vQZ7nnD2kYatND/iDrwPVuZm9z6AWdK6GU7gCN5j6xDulVGyG0WVvcwSGBTg8zwB5ne30kyQbPhjtZ8Fou5TPoIf1Fs40iXGzegGNHmaYa/xWgKyFPWLYSTVcw2PaTK79LyTZGZhCe/NZgqgmgWQ==
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: gjx25WM8ZNUPHJiP61NwvuWW7nOZ7i2AWIyOVVBxf7c1oH+YHn/N2ekzKAPba34JdP1Fjl+5I8KlkZLWZnwlp1fzC+W3E3Sa16Cn7ey8oIUMb7ktFa6scMfnmqpF81alAQYvh6t2uW4UaA8BHzYSkq6jIrTDDjAM29Eky6HyOl1ZsdjVIPpNEK98YBSE/DxBjF9q0Q4qAsAQDE+yFvwGr5ltF20DRjoqixyPQcBKex0Qdx/ctskQ68JtPknwYrFmqV1g3e6w+vpp56LcOPQJD7sKqi33U6Kd0n/oNOcNU9QYJ3uiwe6G4l8P2cVLyEjY0rvJXxRF6cW62EMpqIEY2bxiSMvHuuh1AoVhFisvIgvhKWPvKX0kMl6cQ+cQFNG9XCsTgRRt0Fx89Wdwtf+5nvLt2O7mSPSmETKKfCY0amdyUOauuEy2HpXcFgtGHmGWYn5q4DX3067alC330wroT941WO5CE+Uk2+bbpqZDuoMkrNRBtl1xNvM9VfeyvrSVtPsFcTbM56Dqc8YTZFzT7AmSDiHrSwWNtLBtC/ZFQBZhKKmsQN+sP6HGtN9njl1u89DBAurnKNzBrOhq6o9v+OMzAGq/8Fb+4fhuQudkWtAsd2bnUwyel9BmVRNsEeLIIDhPggZvNwc+Ogf3qdAodK+CygD9wQDuQmk2QZolXu8Zb8fox6h04rbQrd+yCCms5Ho49/h/sT0PoXiuuObdE+ICZ+mYYlVORsuG0WkWcmk=
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(201702181274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:BL2NAM02HT180;
x-ms-traffictypediagnostic: BL2NAM02HT180:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BL2NAM02HT180;BCL:0;PCL:0;RULEID:;SRVR:BL2NAM02HT180;
x-microsoft-antispam-message-info: f6Th/WStWFp1crLZbXWFPuw7pdSpbTTofpe+2txMDgtSnLy//wstNrF7ko9oS6+D
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-Network-Message-Id: 758750ff-45a2-4bfc-2ed6-08d6414ae89c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 05:12:11.1845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT180
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjusting the build process to rely more on curl-config to populate
linker flags instead of manually populating flags based off detected
features.

Originally, a configure-invoked build would check for SSL-support in the
target curl library. If enabled, NEEDS_SSL_WITH_CURL would be set and
used in the Makefile to append additional libraries to link against. As
for systems building solely with make, the defines NEEDS_IDN_WITH_CURL
and NEEDS_SSL_WITH_CURL could be set to indirectly enable respective
linker flags. Since both configure.ac and Makefile already rely on
curl-config utility to provide curl-related build information, adjusting
the respective assets to populate required linker flags using the
utility (unless explicitly configured).

Signed-off-by: James Knight <james.d.knight@live.com>
---
Changes v1 -> v2:
 - Improved support for detecting curl linker flags when not using a
    configure-based build (mentioned by Junio C Hamano).
 - Adding a description on how to explicitly use the CURL_LDFLAGS
    define when not using configure (suggested by Junio C Hamano).

The original patch made a (bad) assumption that builds would always
invoke ./configure before attempting to build Git. To support a
make-invoked build, CURL_LDFLAGS can also be populated using the defined
curl-config utility. This change also comes with the assumption that
since both ./configure and Makefile are using curl-config to determine
aspects of the build, it should be also fine to use the same utility to
provide the linker flags to compile against (please indicate so if this
is another bad assumption). With this change, the explicit configuration
of CURL_LDFLAGS inside config.mak.uname for Minix and NONSTOP_KERNEL
have been dropped.
---
 Makefile         | 30 +++++++++++++++---------------
 config.mak.uname |  3 ---
 configure.ac     | 17 +++++++----------
 3 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index b08d5ea258c69a78745dfa73fe698c11d021858a..36da17dc1f9b1a70c9142604afe=
989f1eb8ee87f 100644
--- a/Makefile
+++ b/Makefile
@@ -59,6 +59,13 @@ all::
 # Define CURL_CONFIG to curl's configuration program that prints informati=
on
 # about the library (e.g., its version number).  The default is 'curl-conf=
ig'.
 #
+# Define CURL_LDFLAGS to specify flags that you need to link when using li=
bcurl,
+# if you do not want to rely on the libraries provided by CURL_CONFIG.  Th=
e
+# default value is a result of `curl-config --libs`.  An example value for
+# CURL_LDFLAGS is as follows:
+#
+#     CURL_LDFLAGS=3D-lcurl
+#
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports (du=
mb).
 #
@@ -183,10 +190,6 @@ all::
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darw=
in).
 #
-# Define NEEDS_SSL_WITH_CURL if you need -lssl with -lcurl (Minix).
-#
-# Define NEEDS_IDN_WITH_CURL if you need -lidn when using -lcurl (Minix).
-#
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 #
 # Define NEEDS_LIBINTL_BEFORE_LIBICONV if you need libintl before libiconv=
.
@@ -1305,20 +1308,17 @@ else
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=3D$(CURLDIR)/$(lib)" in such a case.
 		BASIC_CFLAGS +=3D -I$(CURLDIR)/include
-		CURL_LIBCURL =3D -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -=
lcurl
+		CURL_LIBCURL =3D -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib)
 	else
-		CURL_LIBCURL =3D -lcurl
-	endif
-	ifdef NEEDS_SSL_WITH_CURL
-		CURL_LIBCURL +=3D -lssl
-		ifdef NEEDS_CRYPTO_WITH_SSL
-			CURL_LIBCURL +=3D -lcrypto
-		endif
-	endif
-	ifdef NEEDS_IDN_WITH_CURL
-		CURL_LIBCURL +=3D -lidn
+		CURL_LIBCURL =3D
 	endif
=20
+ifdef CURL_LDFLAGS
+	CURL_LIBCURL +=3D $(CURL_LDFLAGS)
+else
+	CURL_LIBCURL +=3D $(shell $(CURL_CONFIG) --libs)
+endif
+
 	REMOTE_CURL_PRIMARY =3D git-remote-http$X
 	REMOTE_CURL_ALIASES =3D git-remote-https$X git-remote-ftp$X git-remote-ft=
ps$X
 	REMOTE_CURL_NAMES =3D $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
diff --git a/config.mak.uname b/config.mak.uname
index 8acdeb71fdab3b3e8e3c536110eb6de13f14e8ff..19e6633040b1db4a148d7b33c4e=
9d374fe7f87ba 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -431,8 +431,6 @@ ifeq ($(uname_S),Minix)
 	NO_NSEC =3D YesPlease
 	NEEDS_LIBGEN =3D
 	NEEDS_CRYPTO_WITH_SSL =3D YesPlease
-	NEEDS_IDN_WITH_CURL =3D YesPlease
-	NEEDS_SSL_WITH_CURL =3D YesPlease
 	NEEDS_RESOLV =3D
 	NO_HSTRERROR =3D YesPlease
 	NO_MMAP =3D YesPlease
@@ -458,7 +456,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# Missdetected, hence commented out, see below.
 	#NO_CURL =3D YesPlease
 	# Added manually, see above.
-	NEEDS_SSL_WITH_CURL =3D YesPlease
 	HAVE_LIBCHARSET_H =3D YesPlease
 	HAVE_STRINGS_H =3D YesPlease
 	NEEDS_LIBICONV =3D YesPlease
diff --git a/configure.ac b/configure.ac
index e11b7976ab1c93d8ccec2e499d0093db42551059..44e8c036b6ec417e95ca4e5c286=
1785900d8634c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -600,17 +600,14 @@ AC_CHECK_PROG([CURL_CONFIG], [curl-config],
=20
 if test $CURL_CONFIG !=3D no; then
     GIT_CONF_SUBST([CURL_CONFIG])
-    if test -z "${NO_OPENSSL}"; then
-      AC_MSG_CHECKING([if Curl supports SSL])
-      if test $(curl-config --features|grep SSL) =3D SSL; then
-         NEEDS_SSL_WITH_CURL=3DYesPlease
-         AC_MSG_RESULT([yes])
-      else
-         NEEDS_SSL_WITH_CURL=3D
-         AC_MSG_RESULT([no])
-      fi
-      GIT_CONF_SUBST([NEEDS_SSL_WITH_CURL])
+
+    if test -z "$CURL_CONFIG_OPTS"; then
+        CURL_CONFIG_OPTS=3D"--libs"
     fi
+
+    CURL_LDFLAGS=3D$($CURL_CONFIG $CURL_CONFIG_OPTS)
+    AC_MSG_NOTICE([Setting CURL_LDFLAGS to '$CURL_LDFLAGS'])
+    GIT_CONF_SUBST([CURL_LDFLAGS], [$CURL_LDFLAGS])
 fi
=20
 fi
--=20
2.19.1
