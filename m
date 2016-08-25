Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF442018E
	for <e@80x24.org>; Thu, 25 Aug 2016 15:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759620AbcHYP2e (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:28:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:61566 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754777AbcHYP1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:27:23 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LrNE4-1b9Tat0Byu-013AEj; Thu, 25 Aug 2016 17:07:19
 +0200
Date:   Thu, 25 Aug 2016 17:07:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] Export also the has_un{staged,committed}_changed()
 functions
In-Reply-To: <cover.1472137582.git.johannes.schindelin@gmx.de>
Message-ID: <f693f6719c44c033fdaab5a6adb3b4b415d0f454.1472137582.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+DBCnKXUj9W2DRlKv5ISChrbqfd7uRCWfOJKSX3sLJ5NmudWD7n
 GPZyiWwXuhLr/KkHPFl01dkkDhwOhIlNSS5ouaP28CUs2GlSTVZrK4abXHzlJ9CxElXPldl
 7uM/A/zo4GJYvDdxwWJJlFEtw8n68m1dbizTCGZozfdQ91KXwAW1rUgD5IH8Ejq4DD1x3K4
 oyRGREVH3EQ3cuWho8sRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1Su7xU2KbiE=:14bPsgSk/EqsIP5JQ6eFLh
 fX4uQ3G67pqMMHVIBineQcvZ5bcKXXWDNnb5aVsoQ4S6o9M2cDT+LAOp4K0yB5BrznQS11frI
 GP5BtKlZemU0ledS/uhd0nubrUSX2zoIdWZ6PUK5b0HM9T/RA1A9okzoIHwsLEp5z4/sbtDAJ
 jcRPiL+mW0nwcFH0K1CmcqxVN7oPHYEzZzP0H56Cs8tWPwJ5oLFemBWHYiQZ27odHN5KmDbij
 t8m9N3XnJa95tzSdVBqqV1L8XyMw/oWcvI9OoFLgEmE+z9hkbKMEtxs6mA7H/zbS/cDNhhYL2
 LDnD2tGqjazIcdnH+lg58qFSesMr7sV1ep/fOMlj8xC4V6u0s/R+nn7F6HaM/Rih3mcVu9JHy
 5NuIFQM10gqnlM4wvxSLs+peCCAF+yX3W0s0Bgn8NJ7+Nvd4dFvHZw3egSdRyR2dWFQZ2+2bd
 oZfntjN8SoAm2SJGGLNp0FpWibjJXYalDTLL3mfkKkFHy67gfV9ur3Ie8S7E9VjGnMlwi1YQz
 5rxCTjqjShBaMdjvJ+7DZSgWtph5OAY78byGy+Yg8HxlAN+JuZ45/KjvfgqYkWXpTSSEjnGOn
 UwxadYj+blP0Hnc56NKZvHbLRWk93Udmc5bnh/0JikWGZlTbyNqHX+6FP7v+I0R1Vm61S7Hms
 PE2K3xPrvPSRFGcHvW5c+5TU3n+9UUQEUOIEfykFc72iXSU7O9U5yZ1rCZ4FrJf2xOezyBmnA
 uD3LS6f7lUQYdV60PaLMLCeynfKaqtVWZgyPoQNQSRsjx+YxgLl1ruQ9lWLoM/4K0NZ5l/Zp1
 8rMGw7g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They will be used in the upcoming rebase helper.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 4 ++--
 wt-status.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 33dd76f..1c3fabf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1762,7 +1762,7 @@ void wt_porcelain_print(struct wt_status *s)
 /**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
-static int has_unstaged_changes(void)
+int has_unstaged_changes(void)
 {
 	struct rev_info rev_info;
 	int result;
@@ -1778,7 +1778,7 @@ static int has_unstaged_changes(void)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-static int has_uncommitted_changes(void)
+int has_uncommitted_changes(void)
 {
 	struct rev_info rev_info;
 	int result;
diff --git a/wt-status.h b/wt-status.h
index cc4e5a3..75833c1 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -115,6 +115,8 @@ void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, .
 __attribute__((format (printf, 3, 4)))
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
+int has_unstaged_changes(void);
+int has_uncommitted_changes(void);
 int require_clean_work_tree(const char *action, const char *hint, int gently);
 
 #endif /* STATUS_H */
-- 
2.10.0.rc1.99.gcd66998


