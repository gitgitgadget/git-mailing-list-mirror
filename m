Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3DB2EC09D
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765651376; cv=none; b=ZGjG7OyedsDiFv7hZJjHqhC2hixy9C0iWb1+/+sqm8khpS8NIyGY/iIdQms7SSMeQqIPFI4OAjAFzgc+dZMEiIER3p4jOvgctMo37UGPEqMwgP/ChlLPWdZEWDEaCxSk4foDc/Ep4J9Ol6WgliEt5rw4ovrYVH862FXUH2p9YJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765651376; c=relaxed/simple;
	bh=KfFKfAJORqyDiqJ0oI54DithKMxvM+jb+eJpfSQDPJE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=uNUm3kTo82Hap6f42VdXLSyYj+iUxDGfZO2Mc3QIHJ0VSj/XCCwgdmW+J4dLHneynoYimZFCl1I9Q7tiVfpG9y5J/Y2HaN61jHXXWYp0nPxgYlDeJ5tinAMDfXx2pze1l+iiaYlL4fZaZHNK5vJlEQo7r/UK3CohSJO1+nsW56E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Sfu/VqUV; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Sfu/VqUV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765651359; x=1766256159; i=l.s.r@web.de;
	bh=Ac0PVA4ZW1Azmx2CQX9GzavNFT8qZeceuCseOHVGjr8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Sfu/VqUVmaOkzIQmiNpJ9cuICryDMCm3A+nGNifPZwfMypUE1v6oVSD6P5V89RZj
	 xIGhBxK+o2GuWmlYgjuvRKdko9CC9fFUj5E5Umam1P+2zSuFrWbm19YtbCLi35WtX
	 hVcPrmqDHDVPgOHwQyUG3ijJiPzruhE93sCXh9j7YilHHuSxtFkvg88fLZuuo/B4t
	 8svTrKOYD3Qq08qAIZEm0XdyG38+3GxBgg6bNZTBNbsIapbikXwyaEZjZwv+Cu5k/
	 uAata1F+5c04Gsqj25SWN06xTQYNY/KpVzxIWovrc8VK4QZzcgZaCKNxgvFTay9U6
	 ceL/LQtW/mwWmb3GDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1vTOe31MmK-00CqzN; Sat, 13
 Dec 2025 19:42:39 +0100
Message-ID: <fe00aa37-e929-4ca6-ac23-84a693a48bc6@web.de>
Date: Sat, 13 Dec 2025 19:42:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/2] Makefile: add NO_HOMEBREW
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Language: en-US
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Junio C Hamano <gitster@pobox.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Koji Nakamaru <koji.nakamaru@gree.net>,
 Yee Cheng Chin <ychin.macvim@gmail.com>
In-Reply-To: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:exlAv/Rq598cqVStDOSwvzxdYjA3SzK7wbeRjBPO2OQnt+XNZVA
 VVBrkcE3XugoK59yughEvGSInpo/A2LBaASddv3n6IvHumZbQMvRGpb3N8598+eAx0Balqu
 yfL/4ZELW8uhM0GPXrSImItTP3CAY6B0vdvA1hBTBDXtD1VbUh5vJFFtVyA97w1tJ1Ljc6I
 6gspe8NbCdmnNNvdaYhpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1auf2umWjgA=;MLDXyMBHGmizpg6x7467uu/En5P
 SRmN3ILToa6pfUUO+f8A9RSNXoEbvE6IhHaRkZXuy5j9iYkCRi3vwr7CcVu5+X83tiEyPpEBn
 EvnGAR2iR8S/RQBQlgiiMCylv17mHG5u3UeD5naDdb9IzDpbEEWGmhkoSFvzFV8a3kf5vGuoA
 fH15dhxZ9962CXgpIkAchvdJi51EwpDzPZ4/90F1I2afMIpNnbunw13oten7fN+XR4MCASoGj
 pOO+Aa0hXIcmJgJR6FxQqypnXhG2lCaRWYwuiy+FRLogMCgOEhyhZ+sdNSNSTYf54VatjVtR8
 CYrnFMExhY9ih/3ZP54faYaAEc+VaNGc+E20IoHGibKeTsvYQv32xVT3um2EtjuNfZKOlroKv
 m6moVUmbKcszsmK29rjSrBz4GieXNPaXdGtb6e/ldL4dYkWoJKno0Cal3xgbvApKjrRZg4RuI
 fbf/eOghWt40KYbno9+ifWyBFr/Bq3kSYjh99BF3zOvL4GYPr00YOj+n91E9NR87E9UrullYm
 g9GxLSGRASl1kuGgaatrBXxJg5nZCP6sJpqcJHHnLKMQPlNfEAz/+xFwrxtGmY8feOGJhiyou
 Az4Qbz5gVRH12SYMdPahVA9rNcxabJyTrVSmRIsTCBgVhdGGtJ2D9GPQQxeViA+KS3z+vqvSJ
 eFJRt4kW+eDsTkSb/3zfmtPgCZSozR2gZO7XC5kwijSNH8UzUTHCiVdu3W2S5Py33ubtkb4xB
 8QGzuVTv5lofiHvIiAPwAMDSkVLLf4ukd/dssgbwuIQoE1PCMv1Qdaw+jE2gMkokSd5KrB9Gg
 MeW4HUCrHtkZYl74Ubrn9RIHUz3dP5cKNLrPP+FaUB7Sdu5gzwUYD8YrQonfI8PtNgJrnn0Td
 AhvgNmX4edXXcuBZt1ajc0P7KwpRFogmDbQQJa3u8YGhl0gSuRWV4RNMq48BD8yysN2gcBM6I
 b/4MRE4jsEfYULm+Y/JCKYFS+le7kh2guPoUeGtz9HXfCYo/4TCVFfLiricurKUDNp8yth7fg
 bayUn5154c2Tfb4sW6vqqiqmzGw5Bc2J3c+MGNOtE0XmvEunF4QkRDkdceLSqLza8SMNulnZ5
 FBnoDE6QyQorPv3CjWbcof5rgOzkvMVVlQmcdONcU0N1Q9WJSn/6HWn5tBmnWxkmqT6qENynJ
 JmrT64dB9RNR9Y+/AtjKziFMsJOMM2nZz3ap3HmT9sdyg4kGQvLcNliws0nPBTFuAYKKxCqnj
 BFJv46OleRhdNa7RVNVdr0m+ta4+zZhnRNHKdI60F2Rj/rzDojT/Nob+TEFVjPDcGBb6o/JsD
 idzQIF4FTOXgeN7N/B2q1BJXYSemI4Kzc6DjxRSQU7vtOLBC5eGGpZBUsBOLJY+oqYNbjCb8/
 CvfWB/zemrfq0W3t4CObM9ufja40j1NkVMHKwb3PwAJKN7fOcqhF41xZa+zDraP9gij6DJAHO
 Ia1Od1sXNkLqALLAvvW2JNJaWh/wJS6RZGi9/kZRhXGbxZoYBVT4/KduvlvaTE9EyjThGAEXS
 Fk0/ue9hjMG9aDpveAos/hH4FUlwZktHsc9i3h1pvguyCKQW8BnKt9rdUPCq2xKtr+VRpdDH7
 wqKjDtb8bEJpBtEVjHP2iJWwmdtVUTeU5kW6FrTcL9HOvwmQkFVlcs1cH27Dit3giOzqrr+zb
 qilfHej7LfPq0NGeXtRL3GoSLgvst5JAONebttRmmbvY6nkfSFbS2Wi1dF8fuXBnBgcMQkKAH
 bjCa/W72ajDOsMPGklOKitcVreT+J/N91gMoi376p/MlHQ0rBChX77YFr6QMZXfVYGmOUp1aR
 QAPUavQi91thCPoOG8nnGeaOnJI+dnKbOvWXyEAgfWomslszTU3BxaAO7dkT4P5conw4mXlo4
 REXfgC8u6CAizyFSNJ/KJ9+euXTQknEMJ/fem17qRt2Cn/vEyFbUCKCVbhdtHkupSdbBs//hs
 NsepwBuNx0nVQo14Bt8pJ1yR8cmm+1LZoIiRPk9WSnisV9nJS6MPabJLeA3sjkym7DROuUF9g
 Vvls+GVrYkWXKs4tMv7RWQt56wb8nJS1b0CQFsmMMYWxSKVH/9L8HNkgiY1sxfR1BkZbA6Ii0
 u2MidlOEfGg34io22ziTDPKQMqWyUduHzv4XG+jhjFlapumhSyyLtvx8Usz9WZ/vnk6iuySyw
 vHvZKsBstUDWuN32IHnfQ2Hqc0CnRcglKihAfIVcTvNaISIZi0IiXdvNEjmEZpg2pGr9fcmEf
 UJ681PIb69rs09WV2PobNf96hVTL2azR1edQKb5NP/UDuXRyLImSoAdHDN58TnR/V23TzfkDA
 vOOSEriU3geklckA841+GXnapKjcipQBQ3oaICj4IeRJz3Dz4IuWW29/NPKBPMaCg2gkemznV
 sR9/60LB+DdPzzZ/VdSpQ8oFKlfnmwNhjOffZX4K/IY9VSdSCREwUgy15WBLfNhtCS2Hr5cKj
 LGRGk6qqNWajqkWHE66hYsYE2V/aC+J9o+kHB6x7MUzdkX6HFHl2uyW+0ctInXyCbOB2vy3mn
 5KRIHz5o3gHoaSckFc+QvnrJlJep9mDDDcDBdyFhSwmzZNxYxYay45APJgVQlXxn3pHxQ9g+0
 96LBR5TGGcyNOL9wXc19q694xlAuysm7ZeYNEvMRLs0QpumuLprKm0JmA/QLivMdk4Y85WQDL
 n8iE7864kmyB1k5LtKWxUCuxQwn3VubHlpjL23wB1mR6Aqvk+XbdfkuCjpYgBvwfJjiukY6Uy
 W5Sk9asluL+Ppnn+rtGR51Vus6V+eYtf26//xkGKuVSZ6MEYtafySzahx7zbZzaQcDkkGhxqp
 cbYOqU2A0unFctoGp74U6co3FKN1dWC7BIbMMLCd2WBLMBy/EY4ZfV89T3azrmAJ+WNXA5k32
 Vk2TprohBiYqs/BnCvQ+Qe6/sQx0qnRVyh7wABKjVfes0YJSdsiWg4gZTDyEPFg8TY8SwIQ6w
 OZv1rMjsqCVhZzc88eIif/SG9+JePfpHnCuGRRQPSJ9k/Vaq94Qc19T8+4vfLc1ywcDn9yhw+
 kQn97qzDa7g+WhGPOYv8RtCSnLoUz4DRMsG4qvM0z0om76q/5yFQ6rqMRYqRqMyQ9lsawrQH7
 DYpfN0D2hTNkEPt8o+54azZ1sJll6TTCg0u3dXJVUG6ppkN+464KwoK16jlNMDDaK1XmRBs/9
 b2j1QEU0fsKE3kox0gve/XrVlkqMq5TmhLTgJ1hY/AAkHCIItdOMv89qMXHiGRPC/y/9go42N
 uSQc3XMQmUSIWACDqIi8/aCaij84041vWn1PZL0AiKdbs8u/MnYXNRWFyUCg6XnDnB7vQZkPb
 yshTRlK08f//x+jw+mpNaQ8Ng2OsCbsUePfXLNWERQaU1oOc2JnUXkJlG4bSZqMlaICFE9Eeh
 8q9XVJjZBXiCiNOE9l1wHpBAunZ3AizDrchEoEJWV9IJhg24PIEoNSaYWXy2UZr2BDdgd+nmM
 TIINt/atlDj47CDEHkMEQo1lt1NVBvx/nKShsd3fGfimTM0H5UQSo6L7FUvB3NTxm7wNx+GNv
 Wo8fgadbxDScR5myKc2VYYirV39NbNDLMeFC6JHqPFPMKZEukn9hfxKwKw0E8EbtNLModXQY0
 lNmg9kyQh/nh4yW31tIq6Nj6/PV2NVAnQP39GEHV6f75HIBSTzMQWbxiAEGgejLzxYJ6m1rrV
 Se6K6pGrzajYlaz/I1HvSbqrHk1e0jtmcCOlbHJ3/1e1O+sSpgbg21CTXRzQ/5Z5LxRuKZpB3
 WYocQPxdHb12LUQM8dU3ox+OzNziY2+KswrqA1vfgWLjYii897zenPfIoC/aEMnaJEEBsa5a/
 yybaQtEXc998srxY3iBbzkkcbw2Ml03a07hVqoP4YdAGYBdrs6YSqJ9dcsAASuv6VsEfssrib
 K+xWwTjGi0QFvigP2EXJgsRP2CZZRpgjSehW2spifkQKRfyOKoeFQMEudZIXQ9cHfh4By7C+s
 Msil6TcpFkAnybnunasOVdWRs5mq7o1bLaUdSOsBmrGovvfcEnGkGwj2x2C7ayeK83NE8DasX
 drePPw8LCPldGC925sRiMq0/GQZ9BFHO30gUO91T0W+0jRIp+ppeuz93yyYygh9vkGJVr6XSO
 DLoaK/2CQakIesiePX4dsLeIRblqlq9vuwZTVGtK/4xfaE37CxMrUfxNsfxsPF6Fa7UjngE4T
 ifhPt10qtANH5bO39P6pv1iyVY4KkqBZ3CZ32nPKgbEzEdVe+aVFhz3IFrYfvZ++2nDQR4mHs
 g8qD3uU8zOQyvW2KIy9DT6BGUBpx79ouwGvfRfDi38YuwCFRHVGoXGi+bHSvSIptKjUz4Bwns
 1p2IzzkCRVaZojZ3ifLnSqiE1gwU8xFgKxbF3rEzTXggUD5K/eEHm9OEN+DnCr/qG1UqVEOKC
 I6t5kxXwQjOf4aChRW4dHEtgJSpaxm8aFyiIbHRJbCTOlQwykfZggozvAs+oyFbBqy/l4kebE
 tZoHkgIiKHE+kHAqoVgWX3N3SuOfe//GmsmLY6Rbw0GsWlje3ugQkaNk4M6ospy27jOQKvboH
 ccAbo19pP9l+HjEH1cZlPMEiSBFyXKAaZqsz+9d49qCNqofW9/fkwUb4jcvQTGO8c3dx/R/F0
 DjERYbKG0xcOzisaECkiqHNG7+HYFwKyM4ipufOhyhLaysGpTjtV12qEOvqFWHb8Fjx9KhT1D
 q7WFYBIx7hVtf9eHTbsPvB8b6keAUPB1sX0d955S8UplVYqkj0h66jSb8SbNlZO/Rx1xboLz5
 +LZ83Djbqf4U8ja6qhUlu10XgxmukUGMCr9bD4JS5zg7JY03yITtGh6UKsbVx/hPPbfLTaAiv
 ciltb6ao7yIiV8h8rwTi+agcuyBKLgRgef9yJLfCyaOx9jlDWg3+BzDQqrum0lYx2S/7BVGqV
 NVEzJi90QzTk1MFfn5dpJ/wzRNk4iCRO2sS2Lam+DuCiNo7hplh9649VNXxLE4Iby/zJmE0El
 rArF3jEJ9sVUEcL7pPT+lr60Ld0FKEEAwb0k2Drs8g9D5XvsVlFAPpx7FyslnfDRVjamCG03u
 uwgfCnEsKJnWBcHZvszkVM3YmYKymt2Ht1Ah2DPN/PZ8HXfyuhu4yiWlwC8lrdIuIGEZbImpN
 TnkAPqEKmQ4rpST7Z6inFPXJoRoC7RsKhMr9r+

Allow disabling the use of Homebrew on macOS, or Linux for that matter,
like we already do for other package sources, MacPorts and Fink in
particular.  This is useful for packagers, or anyone else who wants to
control dependencies.

Suggested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile         | 17 +++++++++++++++++
 config.mak.uname | 11 +++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 6fc322ff88..dbd2760d18 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -100,6 +100,9 @@ include shared.mak
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
+# Define NO_HOMEBREW if you have Homebrew and don't want Git to link
+# against libraries installed by it.
+#
 # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
 # and do not want to use Apple's CommonCrypto library.  This allows you
 # to provide your own OpenSSL library, for example from MacPorts.
@@ -1692,6 +1695,20 @@ ifeq ($(uname_S),Darwin)
 	PTHREAD_LIBS =3D
 endif
=20
+ifndef NO_HOMEBREW
+        ifdef HOMEBREW_PREFIX
+		BASIC_CFLAGS +=3D -I$(HOMEBREW_PREFIX)/include
+		BASIC_LDFLAGS +=3D -L$(HOMEBREW_PREFIX)/lib
+        endif
+        ifdef HOMEBREW_GETTEXT_PREFIX
+		BASIC_CFLAGS +=3D -I$(HOMEBREW_GETTEXT_PREFIX)/include
+		BASIC_LDFLAGS +=3D -L$(HOMEBREW_GETTEXT_PREFIX)/lib
+        endif
+        ifdef HOMEBREW_MSGFMT
+		MSGFMT =3D $(HOMEBREW_MSGFMT)
+        endif
+endif
+
 ifdef NO_LIBGEN_H
 	COMPAT_CFLAGS +=3D -DNO_LIBGEN_H
 	COMPAT_OBJS +=3D compat/basename.o
diff --git a/config.mak.uname b/config.mak.uname
index 1691c6ae6e..a6521575ee 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -153,10 +153,10 @@ ifeq ($(uname_S),Darwin)
 	# `brew link --force gettext`, should be obsolete as of
 	# https://github.com/Homebrew/homebrew-core/pull/53489
         ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
-		BASIC_CFLAGS +=3D -I/usr/local/include -I/usr/local/opt/gettext/include
-		BASIC_LDFLAGS +=3D -L/usr/local/lib -L/usr/local/opt/gettext/lib
+		HOMEBREW_PREFIX =3D /usr/local
+		HOMEBREW_GETTEXT_PREFIX =3D /usr/local/opt/gettext
                 ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt &=
& echo y),y)
-			MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
+			HOMEBREW_MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
                 endif
 	# On newer ARM-based machines the default installation path has changed =
to
 	# /opt/homebrew. Include it in our search paths so that the user does no=
t
@@ -166,10 +166,9 @@ ifeq ($(uname_S),Darwin)
 	# add gettext. The issue was fixed more than three years ago by now, and=
 at
 	# that point there haven't been any ARM-based Macs yet.
         else ifeq ($(shell test -d /opt/homebrew/ && echo y),y)
-		BASIC_CFLAGS +=3D -I/opt/homebrew/include
-		BASIC_LDFLAGS +=3D -L/opt/homebrew/lib
+		HOMEBREW_PREFIX =3D /opt/homebrew
                 ifeq ($(shell test -x /opt/homebrew/bin/msgfmt && echo y)=
,y)
-			MSGFMT =3D /opt/homebrew/bin/msgfmt
+			HOMEBREW_MSGFMT =3D /opt/homebrew/bin/msgfmt
                 endif
         endif
=20
=2D-=20
2.52.0
