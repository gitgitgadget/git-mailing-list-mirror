Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19AA31F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbdLYRr7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:47:59 -0500
Received: from mout.web.de ([217.72.192.78]:56700 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752670AbdLYRr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:47:58 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQNiS-1eO3jJ1K8q-00Thsq; Mon, 25
 Dec 2017 18:47:53 +0100
Subject: [PATCH v2 8/9] revision: remove the unused flag leak_pending
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <369e1e1b-2889-13f1-d9b0-5f0bf72a3d5e@web.de>
Date:   Mon, 25 Dec 2017 18:47:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bBQTzJAapmhwdqvv0fkTuHOmtDXe9ApX33w9hPyr1fEddAM1Zfs
 zc6AAk87hs9Nyc+nuTUvvbVYKmj4ESw8dobw1c7zyo9ILVCW+p0FSfWEmXvZLdjPJNqURrx
 oQRAHt1xTRaaF1Va6uQOgH3NPGgt33aEw59fbYLargod1yavrZhpGB1vgZYkQyrgjdRsAXC
 S+xmL/UcaG/g41Lx9elFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6XuveC89DvA=:zA5QNxy2n4g8Mvgean6Cjk
 lmgk0WbL/dDa2WDWTkkcWNXjZvvNmMu+6+7dtlnCJ2/GoVVrQmmjeB4cAEZQmUzGewYWUh3lb
 AF63ZjB8OSmP5eEdgdDw+iFoyj+5L0Pol5GdRM0jX9KmDC8hBpaAzSmUvcw69U8naw0S+WprM
 lc2KF82zhjeL6XAsOvacVG2mCx6HgGquaIDEzEqKgvMnogPj7gpcBrWxUFa3A8vXHAc/shUYk
 2KOBXrF4yhSJkxPaQ6AH7NrequXk/3d0oficEM2H0Id36tqXIaKFpW6yAjx6VYP2SnZfyml+9
 1YsJzWasMuwa9ngWCjalsiMpW4PMWahT0nI9LkxWWXU2fW0DPPw7X0oc9xc3hCjYlhfoUgHPb
 c/0pmGnE9chn2Y6B3huuG2aqvYiW8aqd+4FOo0pIMfYi0I2IKlVFD40autowpzAVXnA77sURq
 VWN9EtNMqibgdo1cjMia85oKGf7NVly5DrQv2ZJMmv6xvwiLgsKDHTyUWVTmHt099vRKO+coM
 VSLBGqkEcH6r2uCxM+hlCXvbUbTBmxMCVf7tIAPx+mCJisQSF5nxZUWMfdDuWGNamOAFnOFw3
 /8KmFezXR40jl5gHKZZDZJAZWg7Hb9X+hKEhp5wQU9JCnSnAZOH7o+uk9ni2oTVXwA9/kIZS8
 SCKHdCDKOOzawZE3ajuLy6jqXaXQsqYL63pYrZp/LkAaFP5K5qpEUmA55yDnJf7Yp0mgT3sHR
 ZipY96F9r5twDM9HfrDySUisKvLPlHrkCa9HXPZYB9Y4S6dYD5asjnsdblM3P4RN9C3hqbNeo
 i7Yg8T23E3daCDpyefkfboVdXi4dfSkmME33Y1pspjMN8q0RrM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 revision.c |  3 +--
 revision.h | 12 ------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/revision.c b/revision.c
index f6a3da5cd9..7239315de9 100644
--- a/revision.c
+++ b/revision.c
@@ -2860,8 +2860,7 @@ int prepare_revision_walk(struct rev_info *revs)
 			}
 		}
 	}
-	if (!revs->leak_pending)
-		object_array_clear(&old_pending);
+	object_array_clear(&old_pending);
 
 	/* Signal whether we need per-parent treesame decoration */
 	if (revs->simplify_merges ||
diff --git a/revision.h b/revision.h
index 54761200ad..27be70e75c 100644
--- a/revision.h
+++ b/revision.h
@@ -150,18 +150,6 @@ struct rev_info {
 			date_mode_explicit:1,
 			preserve_subject:1;
 	unsigned int	disable_stdin:1;
-	/*
-	 * Set `leak_pending` to prevent `prepare_revision_walk()` from clearing
-	 * the array of pending objects (`pending`). It will still forget about
-	 * the array and its entries, so they really are leaked. This can be
-	 * useful if the `struct object_array` `pending` is copied before
-	 * calling `prepare_revision_walk()`. By setting `leak_pending`, you
-	 * effectively claim ownership of the old array, so you should most
-	 * likely call `object_array_clear(&pending_copy)` once you are done.
-	 * Observe that this is about ownership of the array and its entries,
-	 * not the commits referenced by those entries.
-	 */
-	unsigned int	leak_pending:1;
 	/* --show-linear-break */
 	unsigned int	track_linear:1,
 			track_first_time:1,
-- 
2.15.1
