Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0EFB1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 07:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeKBQ2F (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 12:28:05 -0400
Received: from mail-oln040092002065.outbound.protection.outlook.com ([40.92.2.65]:5792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728380AbeKBQ2E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 12:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/syTz8NA2aHJCs6g25cqfiVGBa8cXAwcz+wh0bocN8=;
 b=Pih8tcMTt8mBYaqQLT9TERLRXnfVKY6S1E6W1i/YAvAYaFpTXtvTZgXwEYmWoEJGFzlvxzg7Ah+eCU1vxtEdmSJKOsZsgw/O4MRTnl4chxwRp6PoyK2TPt7WbGYcUL6KdojcoxhE51bM7m9VQY/5gS9Lb03FRnbc5JJy1SI0R1WMWQYs6ikAcEx3WVIy+RbIlfFszKidrm98jGQguj1v0isBDpxOscc6wk2pBWY8odH+cxBJkbnWQOQNPDI56pu3jDVlgiJPVe16VJMHDzx9RBNOzi6wNMuCocfU0RElwIt68KTU8yYx9coYYipk1++fYosoH/y3i7gHkh7Qp+iLcg==
Received: from SN1NAM01FT057.eop-nam01.prod.protection.outlook.com
 (10.152.64.58) by SN1NAM01HT192.eop-nam01.prod.protection.outlook.com
 (10.152.64.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.14; Fri, 2 Nov
 2018 07:21:51 +0000
Received: from SN4PR0701MB3679.namprd07.prod.outlook.com (10.152.64.51) by
 SN1NAM01FT057.mail.protection.outlook.com (10.152.65.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Fri, 2 Nov 2018 07:21:51 +0000
Received: from SN4PR0701MB3679.namprd07.prod.outlook.com
 ([fe80::8dfb:896:ad73:e7c5]) by SN4PR0701MB3679.namprd07.prod.outlook.com
 ([fe80::8dfb:896:ad73:e7c5%3]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 07:21:51 +0000
From:   James Knight <james.d.knight@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     James Knight <james.d.knight@live.com>
Subject: [PATCH] build: link with curl-defined linker flags
Thread-Topic: [PATCH] build: link with curl-defined linker flags
Thread-Index: AQHUcny5RzjySI7zs0q1uhbPH9C7cg==
Date:   Fri, 2 Nov 2018 07:21:51 +0000
Message-ID: <SN4PR0701MB3679BA798ABD874D34A595DDA0CF0@SN4PR0701MB3679.namprd07.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::39) To SN4PR0701MB3679.namprd07.prod.outlook.com
 (2603:10b6:803:4d::21)
x-incomingtopheadermarker: OriginalChecksum:B45FD582399EE06BF3F27855828E747CA739EF3AFBD3139899D94AE6762D184A;UpperCasedChecksum:1AB8D4A59D90C693298319BBF1036AE264CD74ECDD713BE46074D3CB0C03C304;SizeAsReceived:7363;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [E6ld6UvdLEmrR02h5G8r8aY3PqiQm2Kx]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1NAM01HT192;6:pAB/2jnSVeoJWhMXVFbUBE3N/fZOPr7P0c9zukojco4N3IGZsjpRDwp/LVDCkn7cVZ8gB6uTt+89eltUJ7zQ6ZF6cq/HjmHk/2guCDzpKWWsJ6S/XgoQxJgUwtkSCHuk54yMn0mCf7ZCaJp/CzvgTFGxUHlLgHr4BtAP+eCNR94WbPsvATHtQzA0lbnY7QjkuUR29HWr/06etDdTX3bShIUX4QTAyGynadeqfP21zYrjhLBZNvGDqEHQx2O60AeNYXHGQsZ8sgNkKW33hWw5fLhKQPpNhK5UB4BU7KWuPiguH9YmVlcn2LIqcubSEqKdF70fGxJZjmPxJW2l9THZOvQAOQd+11M0Jp4n1XcKrAx6T71ZveRilxM7KUIVyFROpx/MWwlRrjZk34NXCHYyd+YgVPH/q/NM5xU6CDWP5SuLhJiZPWoQx1QumV9sVtyfAqmBvhq37Va5+dD/b66BIg==;5:V09aHz48Oikagt/+786yiFqA3KMkQ/kMYR9hebd1m4fPBQTTqUOO6tBxpPHffGEpeJVGsuttQ0FwwSL1iSIwh6bGPIUzXVupiX/GZcN8KbwOtUygZFmeV/90HUgeKubEhgwWFJ6Sazp2rixfsMrAkhG70oGKHkPI6hzZWPYfYpw=;7:2FoSw0sw8NA8+/RHsYBt7drDdM+RgBfkpkwvvdJj49oU2RlZit9OGkqcdBJBAtD5XWAVt4jhDOSTGGTaucql6bK23VEKDbY9S5+xu0SSYy27RiKPjTpGjnbjNQTncrM6A+8o8nvaOUWvE0omVtRVjA==
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: 7MJMDUNTCtyBcmgjSco5D94Qxzmatv5+Td/D+VmOkb7doFwYEpBGvHyQJUQW1iowkJqJuMbhsAl4X5k1MEcWEsE5CqDIKf+77yFj+AlDHCjeWQ1+t+nZDLx1EshpS6ImJtthq8Ha5g2HMuXZKQZJB+qKIJQt6h1SouWgOtlmp4Tg5HSLc+6k/EEHSFmJJiniRmFZVhN2m8ZAb72pNCpXCWIk5sABUFpHFnBKylcP4YYdHTBZd6/iW2GNVBiNxYvMnrvnTZZsjC948Dz7P52/JMkBV+BuJnc2d5wd3M1SrOuMQRJZGxY713nN7MDMslQjfnxDcVMHwVy5AZCSj4aMU2p1Skdrv2EB57OdhRaKrz5i2XlSUKiV0xshf8T41p2dUTk0dSF68YoxZIyUHomteU6eIoCfe8keEqs+Qcwpfnfu6qhK5inI+6yorj76EHLbu58V/Z0t/Nti7vUNKoR9ey6oHRgLz5REt4oUgrdhmm6Kw9pfl3N3WUWkwS9bll1Be8BhsmhPl0X9mKgdmiifJ98i/OcLt0YeYvx/WOz7xlpSuRa70gfRUo6XSac+XGVKkkpPA3dQxPpgzDCNyIyDWnuHgAWkqEwiG6NRts2V1D8glWOpKXB0B++nHmm5rdOZaZmqhAtyMDvkDBZPbrdRv/SeXZ1evT70rbukOKC5Tb/UEqpunTaVQn+4dlBpRklCSyHIKN9nuoNw6+y0YHCE+c/BKBLUrVu9ZRNxPLsaH+Xs8ukZpOLBLQ==
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(201702181274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:SN1NAM01HT192;
x-ms-traffictypediagnostic: SN1NAM01HT192:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:SN1NAM01HT192;BCL:0;PCL:0;RULEID:;SRVR:SN1NAM01HT192;
x-microsoft-antispam-message-info: p7TVq0ts15R3vsugQ9JKxZ+Re2mf0JIK3owY/pgs1h8wKDp95TXL3ASrUsQBZVid
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-Network-Message-Id: d081b61e-185e-4f5b-9852-08d64093dba6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 07:21:51.6033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM01HT192
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the autotools configuration to populate libcurl-related linker
flags from curl-config instead of manually populating flags based off
detected features.

Originally, the configuration would check for SSL-support in the target
curl library. If enabled, NEEDS_SSL_WITH_CURL would be set and used in
the Makefile to append additional libraries to link against. Since the
process is already depending on a curl-config utility to provide
curl-related build information, adjusting the build to track the linker
flags in CURL_LIBCURL and pass the configuration option into the
Makefile.

Signed-off-by: James Knight <james.d.knight@live.com>
---
 Makefile         | 21 +++++++--------------
 config.mak.uname |  5 ++---
 configure.ac     | 17 +++++++----------
 3 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index b08d5ea25..c3be87b0e 100644
--- a/Makefile
+++ b/Makefile
@@ -183,10 +183,6 @@ all::
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
@@ -1305,18 +1301,15 @@ else
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
+		CURL_LIBCURL =3D
 	endif
-	ifdef NEEDS_IDN_WITH_CURL
-		CURL_LIBCURL +=3D -lidn
+
+	ifdef CURL_LDFLAGS
+		CURL_LIBCURL +=3D $(CURL_LDFLAGS)
+	else
+		CURL_LIBCURL +=3D -lcurl
 	endif
=20
 	REMOTE_CURL_PRIMARY =3D git-remote-http$X
diff --git a/config.mak.uname b/config.mak.uname
index 8acdeb71f..923b8fa09 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -431,8 +431,7 @@ ifeq ($(uname_S),Minix)
 	NO_NSEC =3D YesPlease
 	NEEDS_LIBGEN =3D
 	NEEDS_CRYPTO_WITH_SSL =3D YesPlease
-	NEEDS_IDN_WITH_CURL =3D YesPlease
-	NEEDS_SSL_WITH_CURL =3D YesPlease
+	CURL_LDFLAGS =3D -lssl -lcrypto -lidn
 	NEEDS_RESOLV =3D
 	NO_HSTRERROR =3D YesPlease
 	NO_MMAP =3D YesPlease
@@ -458,7 +457,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# Missdetected, hence commented out, see below.
 	#NO_CURL =3D YesPlease
 	# Added manually, see above.
-	NEEDS_SSL_WITH_CURL =3D YesPlease
+	CURL_LDFLAGS =3D -lssl -lcrypto
 	HAVE_LIBCHARSET_H =3D YesPlease
 	HAVE_STRINGS_H =3D YesPlease
 	NEEDS_LIBICONV =3D YesPlease
diff --git a/configure.ac b/configure.ac
index e11b7976a..44e8c036b 100644
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

