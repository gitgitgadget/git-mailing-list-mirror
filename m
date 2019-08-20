Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A561F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfHTStP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:49:15 -0400
Received: from mout.web.de ([212.227.17.12]:44785 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfHTStP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566326950;
        bh=Og80N+Ad7uRHhySFkoIsOMrUSM0MA1F8+wrUlhgXf4U=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=pXBAFvBjj2uV1DCJrTo12iKHL6Il+VVWU6/pzAnUxZDUyfbfTlyYcDwIR4pY93bDL
         5Dx+MgUkWwgOllFQk/U5o3xIX97sPcPBFmONnPwcpXc0PcTQo6wDy7BKpBhABi8Sj9
         M724PXTtFAGdoUSUaJ77WAtFNdXIcqD7rQZYKQu8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MddFQ-1haoJe1ypQ-00PJM1; Tue, 20
 Aug 2019 20:49:10 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] parseopt: move definition of enum parse_opt_result up
Message-ID: <58e5dd7b-d577-a1d9-c704-44642f553323@web.de>
Date:   Tue, 20 Aug 2019 20:49:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V/CWpWz7Wx2rtM8p+PoczLd23+mDZePG3L77LqFCPu/H00yU9J+
 mI+EIHAOLOUI02u812fb/by3doJHH1fjwhJ8l5C+ifnILw7J7HSsrvmar9V83HcX1bSJKer
 iJqHjYMWQhuHPkEoqLgK9ZSuRqBQoZ+9uJqhOE6lH3C4t3QxqlAl0ezUIOgHNqNMgSHY1mV
 MfRK54aXjvyTRJgwNWvzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CqHWHH/zUhQ=:WUj///VIUV3YqUEl/EQpwJ
 25Wr7B3OAIAy+3cJVzLoX8dfKYsECbZgx9gftofDfYF4yJmxgOxl2KGzRvVk+W6UGFTE9NlH5
 m3ysXAtfZmGqjrXuClxeSW1lRoHGZcT9bIT3/E3IvT5dMBMbSkmAjDSp73qcrbEs0cxnQf3uA
 qfEEAWDLpu8k0s5+E9go0m4d2CA2qXm/YWCIndD+/Vo2ET2SHFxeb+gqzdH5//RPxrUpUA/hS
 tB4ZGCQU0rUt/pudslGGrHH66MI7Fn+KazR0se/fc2fHkv4BWbSi9E6KGtOdpgIbv9bUG3SGy
 L3d0tcPKTGkvWCqlo+xzHIa4+GJUuIcaES5pXpdWZxrwofns3cuh+xCIkNkpD2BUbDZC6M4fX
 YJ22zp6/Fy9knYG8Ah+Qdg+VrzZoECUk6dO4dln7fuPBlZq45YzAL9PhTEY7ExJgrECqwfCv5
 l+A1+ZGGcURy5NomkjFJNG9dCnpyQ4nViL87Zj7cgMLcfegO74ra3CtWxv6Oq33s2IHkjjqL6
 1TvpbTpbtG3W8Ji3riWyMunFVqvLpHuuy4dnV+n+pfw5+9hAP88PvVIuQuv8Nyv5CV4Lgs6ky
 l/6OaBYoxVUu039qYyjk5W3N6TKn0c5QB76AfgWvAN9w7vNFjix76UKhjqSIUnIdCcZYR/yKx
 hAzPO50DiWwLNf7TYLvyQbvw4tKCwxS+RqXReJpF89aoPQV901EcPqXUqc/L+MVaBCKfNJP2m
 vuziJWwmWTu8HH8RQDdshhXZxNHVV1TpNAcqyKvn75o9dgJUv4aN1falO4mKqsLWai224cyls
 6chuO44L+A2yVjty+KMSIZOfPJzdHM0WZUnw6sBbgymII+C5EEONCbXVONQDwRWLmh+PAQ9Rv
 jm1Gc2x64P/sydH9/greW7S4D6KEEYdyf4S5VCwdlemSFse4+m8aayzK9dzO+4PrrkBQvqFg6
 UE3KapK7LL9VQZR3whS8S3unHuAJLUo0ZBGw7FgvwCISsBxy+9VAVa56T+pIBggv8KlHyPnOJ
 EUANB4BrAGnYeNqE9TKaguy+1c1eI4wZsE25oiTl29PtLkC3fEAjIELVJY871Mpn0dhmj/LCL
 e3CnxulxHqAuWeKq0QT7Zvbs3QD50oK2IYEe9aVwfbHrsmEqGX8YgVX4BCDLRoz75mWCfMKh1
 ZQUDA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define enum parse_opt_result before using it in a typedef.  This avoids
the following compiler warning:

   ./parse-options.h:53:14: error: ISO C forbids forward references to 'en=
um' types [-Werror,-Wpedantic]
   typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *c=
tx,
                ^

While GCC and Clang both accept such a forward reference by default,
other compilers might be less forgiving.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index a4bd40bb6a..38a33a087e 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -46,6 +46,15 @@ enum parse_opt_option_flags {
 	PARSE_OPT_COMP_ARG =3D 1024
 };

+enum parse_opt_result {
+	PARSE_OPT_COMPLETE =3D -3,
+	PARSE_OPT_HELP =3D -2,
+	PARSE_OPT_ERROR =3D -1,	/* must be the same as error() */
+	PARSE_OPT_DONE =3D 0,	/* fixed so that "return 0" works */
+	PARSE_OPT_NON_OPTION,
+	PARSE_OPT_UNKNOWN
+};
+
 struct option;
 typedef int parse_opt_cb(const struct option *, const char *arg, int unse=
t);

@@ -241,15 +250,6 @@ const char *optname(const struct option *opt, int fla=
gs);

 /*----- incremental advanced APIs -----*/

-enum parse_opt_result {
-	PARSE_OPT_COMPLETE =3D -3,
-	PARSE_OPT_HELP =3D -2,
-	PARSE_OPT_ERROR =3D -1,	/* must be the same as error() */
-	PARSE_OPT_DONE =3D 0,	/* fixed so that "return 0" works */
-	PARSE_OPT_NON_OPTION,
-	PARSE_OPT_UNKNOWN
-};
-
 /*
  * It's okay for the caller to consume argv/argc in the usual way.
  * Other fields of that structure are private to parse-options and should=
 not
=2D-
2.23.0
