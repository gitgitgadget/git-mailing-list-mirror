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
	by dcvr.yhbt.net (Postfix) with ESMTP id 846C91F461
	for <e@80x24.org>; Thu, 29 Aug 2019 19:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfH2TNV (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 15:13:21 -0400
Received: from mout.web.de ([212.227.15.4]:37267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbfH2TNV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 15:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567105997;
        bh=5y3R95V4VP/Bqrlb9nA4M3x2Sc/njhBChxCeClETBN4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=q31tiwRjmYtoCqPs6S301/Z2fMkcL49JNSnRj1j/TSLJMS8no/gurNGR4wZsFOm0z
         g6xMzuTC49EI/jh172Oq8oU/YAnoFVzAI+k0AvxsDZZBRuc8wlq/AaaVX8oWlO4tDA
         BuLPuddMsIljZXXHfu5sc6l45bMoAzxuOrEu0McA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8iaa-1htUlk3aBA-00C9LY; Thu, 29
 Aug 2019 21:13:16 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] help: make help_unknown_ref() NORETURN
Message-ID: <d0606d19-0900-3908-2962-ceb24015f753@web.de>
Date:   Thu, 29 Aug 2019 21:13:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s1kt5/2myjtDV5ZDgYbxMVEwlSpOB15j9ZRUhY0joy+qCWL9AuE
 TAEWU8U5DuqbJOI4LdBl9Of/se/Q0pBjTUyz4hRADY/go9MGxQibqyM8KTWoY9ooENsuNkl
 QRBxJM3vnWENYImFdaE3k3WKaf4uZAnSbgsWHihNqkOKV4HlUO1iqy4n+R4XOlnHT6VJrsN
 LvJfoKrfv/bveyftq+57Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NqS5Fym3S3I=:5UyVhi1bolqyRc/OXUyFwI
 AJh9//Kq7BDiK2HQTMLTmlqaGQcXZ+3P8w8XjT7HY6jKACT48nfu7T7JpOwlptnNQug7wXueo
 mc/gmaq/IDjR/kGNB10Yn71KOPAj1s/9z3HiuXx0km93GOkzEpYhvIiXipBSD66h68y9RPYZE
 sVg0ahkZ/73eZ6q9QO0T48+1kIHknIYBauZhkYZxoiuDNxqve9ZgNYgN3yuphW+/YaB8uLavH
 revXxEagz0RnBwRDYEjsJYCYm3Qwjo1kBAmrYfNRNS/8m6d+/cP6im+ENTA930i+ozbA25ujT
 dRHxMRr49tOD1KW912t+XbMyAnybeIemQCF1oj7nPC2n7yWALCZFy8Y0aq9v/Ur4vm2haimEi
 p+sOjVbO+/zIJU94IhxZOCW0JFmGjb3lN+zwkMp88+wvgd504nSLZSOHLODjeofUgO9j0WbGA
 ig4oIK3lNR2lWJeVsdMmqzNi/+lpnPG/g4//VBxqhwahxxEiEJxAT8hRtYtbAH45Z5s19POu9
 FNOU320XAzyHUGh3cymNn/4kwX0mhKPRU5MEEiOklelWQQTmDbhWOLeNb41+lmwLiBzwQNFAc
 hY2aQDtfhLqhBik5gXRRvlIwbvZqcsXf86ZNB/vBVV1s3f6g1AG1lNiiyNHoVXBo9hP5DtxVL
 0bVI4WytLeCvlHigRZdidVaJOX1Gyn04TsetMKwj9YkIK60y8qXfprO7rgI3PpCjss/ivy6H/
 S4sqBjI5cTqBJ6phsI5PWLsKm5pap8lZpGSJtjH4bMu5TH5pGIeHCgb/dpPeW4v6WiAc5dHw6
 bYwQ46gU/t7veaPl+eyzUElENNi+mfhUpQ8e/+RffLqfiAmEKOpawPFcpJEkqtxKxTqM4dozU
 Xn7d+MbzPF7/2CtyWMKiNn8omrYfqBm+2X7W5uSNbMr4BZULAUzL89/OjEAi200Xa3T17TLIr
 GQjxjweumLfT/4biIrvy8TR2oyZJ1A+xS04dd52MO1a3J5R6MLHZwAWMf3ao6gc3Lt4iY8+au
 Ybny9zr0GQowYhvDce/YLsL+IYbUKbIrLlTstEPbKCKW1560TLo0348RpJC39m1HWgHyepBc9
 MMp5/mDFlWebjouQ2jfxISQgKBrt9LocsQt0uV+kq6TUAchwgbaQAs20ptDC6WxbGg0wvZb54
 VdoqXCoZhobmGn1hvcnAqabHHFSzTCyEcqGlMa31SSvqqMBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Announce that calling help_unknown_ref() exits the program.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch generated with --function-context for easier review.

 help.c | 3 ++-
 help.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 5261d83ecf..9ff2be6b18 100644
=2D-- a/help.c
+++ b/help.c
@@ -774,22 +774,23 @@ static struct string_list guess_refs(const char *ref=
)
 	return similar_refs;
 }

-void help_unknown_ref(const char *ref, const char *cmd, const char *error=
)
+NORETURN void help_unknown_ref(const char *ref, const char *cmd,
+			       const char *error)
 {
 	int i;
 	struct string_list suggested_refs =3D guess_refs(ref);

 	fprintf_ln(stderr, _("%s: %s - %s"), cmd, ref, error);

 	if (suggested_refs.nr > 0) {
 		fprintf_ln(stderr,
 			   Q_("\nDid you mean this?",
 			      "\nDid you mean one of these?",
 			      suggested_refs.nr));
 		for (i =3D 0; i < suggested_refs.nr; i++)
 			fprintf(stderr, "\t%s\n", suggested_refs.items[i].string);
 	}

 	string_list_clear(&suggested_refs, 0);
 	exit(1);
 }
diff --git a/help.h b/help.h
index b8780fbd0f..7a455beeb7 100644
=2D-- a/help.h
+++ b/help.h
@@ -42,8 +42,8 @@ void list_commands(unsigned int colopts, struct cmdnames=
 *main_cmds, struct cmdn
 /*
  * call this to die(), when it is suspected that the user mistyped a
  * ref to the command, to give suggested "correct" refs.
  */
-void help_unknown_ref(const char *ref, const char *cmd, const char *error=
);
+NORETURN void help_unknown_ref(const char *ref, const char *cmd, const ch=
ar *error);

 static inline void list_config_item(struct string_list *list,
 				    const char *prefix,
=2D-
2.23.0
