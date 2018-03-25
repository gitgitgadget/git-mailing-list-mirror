Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478B11F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 10:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeCYK5m (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 06:57:42 -0400
Received: from mout.web.de ([212.227.17.11]:33297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752213AbeCYK5l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 06:57:41 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ltnmz-1eYFax2Ii5-0118WU; Sun, 25
 Mar 2018 12:57:30 +0200
Subject: Re: Null pointer dereference in git-submodule
To:     Jeremy Feusi <jeremy@feusi.co>
Cc:     git@vger.kernel.org, Prathamesh Chavan <pc44800@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180325095046.GA687@feusi.co>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de>
Date:   Sun, 25 Mar 2018 12:57:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180325095046.GA687@feusi.co>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:MCxD1cTCbF6ZD/9Y7kKLR8MiBBVp8wDjvlFXkUyvJ2DNimmk0yT
 iUWqVQPSz8rGZW4VZgrECyqRLp+JCKTRh8g2g8g5vONYFFiQkWF2mF8wofhs1P+4iwYL1jS
 gW8zD/K8NoxhtTqK5fIADI9HKXc7IMfk6d+KH8safhrfh1TD/we8N9tnSw10YyO88povic2
 046ui8gO1Fe6m3Wt3n+5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:39VJOFPDN/c=:WW8LROE1wPvKNxci4FBpvG
 QY4q1dHmU5S3q3EyIF6dOwMykTbmxtefjlsCiWUc5xnVthi+7gQp2cxTCm9cMhdHoThmIfpDb
 XTBzDozkHxRoyZExWBdpJBMqFGnZNywkHHVjP9M0nUOCtJA9t9jzG+PSHjKWM9zxmja56S+p7
 B3YXe4XMOoMcpNSLXet1lsa5noP2YJ1tSDgAHvuSIVZ+/P8gs09rNccvB6nKM2TDn1BbxBNY0
 77N3z/z3jRXXynRxgml2HIy9yjnSp8z0PEYyjv3mzvKGH0SbJm/xnA8fa++z43lg6r/K/CTpQ
 CmFb0EQND8aZLPRhHYCZOimqYwbivyLq9lWQ8e3V52roghx6CvwVPYMHk4f3j0blBBto95WP+
 2KQ4+epz5Y1P92V0VwH6xvZ44tWnWPP5dJSipXnL7WB4gSY7AsoQ3GpVcWQ7sn/8Mgr9Z009K
 naY0aMZD1F/qItH8CW46S/8GDOnon9MzaB7qKYAxqgMkfDHhfH2y5KZxsE5nf29o8u1Jy7ghf
 Ne593bXhpTrfJbpgU5SOPXo+YhSAV9D4h8ZfGZYutJ9m4ejT7AG8PulV0/NbW//lh3D7xIWkk
 3W13EN76Nn44pjHeLod42ZjrOEeZA+t6OAbpONF/a882Layz6QlHPI2WPk6Auvft2md/8BT6B
 fJIC76TzRTXpkqzgZhJmkR6DDvEcjqwt+cb7rvoe7bImkUqb+47IkeWDlv+L8KTip3kD2yauJ
 bppRcx2RxDCKxOmt12FAl3JM3RlKsLxVZxRIEyOUWJ8/fIlNYuDoKtACrXwgYqrEM2aRs9lcE
 +1wCY0uYQhYoM+3ndVuox4MaD9cZ6Pzk/L8I8HUOL9EwXrmjtE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.03.2018 um 11:50 schrieb Jeremy Feusi:
> 
> Hmm... That's weird. I can reproduce it on 3 independant systems with
> versions 2.16.2 up, although it does not work with version 2.11.0.
> Anyway, I figured out how to reproduce this bug. It is caused when a
> submodule is added and then the directory it resides in is moved or
> deleted without commiting. For example:
> 
> git init
> git submodule add https://github.com/git/git git
> mv git git.BAK
> git submodule status #this command segfaults

With the patch I sent in my first reply the last command reports:

	fatal: no ref store in submodule 'git'

That may not be the most helpful message -- not just the ref store is
missing, the whole submodule is gone!

Come to think about it, this removal may be intended.  How about
showing the submodule as not being initialized at that point?

-- >8 --
Subject: [PATCH v2] submodule: check for NULL return of get_submodule_ref_store()

If we can't find a ref store for a submodule then assume it the latter
is not initialized (or was removed).  Print a status line accordingly
instead of causing a segmentation fault by passing NULL as the first
parameter of refs_head_ref().

Reported-by: Jeremy Feusi <jeremy@feusi.co>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Test missing..

 builtin/submodule--helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ee020d4749..ae3014ac5a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -654,9 +654,13 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			     displaypath);
 	} else if (!(flags & OPT_CACHED)) {
 		struct object_id oid;
+		struct ref_store *refs = get_submodule_ref_store(path);
 
-		if (refs_head_ref(get_submodule_ref_store(path),
-				  handle_submodule_head_ref, &oid))
+		if (!refs) {
+			print_status(flags, '-', path, ce_oid, displaypath);
+			goto cleanup;
+		}
+		if (refs_head_ref(refs, handle_submodule_head_ref, &oid))
 			die(_("could not resolve HEAD ref inside the "
 			      "submodule '%s'"), path);
 
-- 
2.17.0.rc1.38.g7c51fd80b8
