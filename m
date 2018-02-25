Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6582D1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 13:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeBYNSX (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 08:18:23 -0500
Received: from mout.web.de ([212.227.15.3]:43443 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbeBYNSW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 08:18:22 -0500
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaIRi-1eS7RJ3ZXy-00m2PK; Sun, 25
 Feb 2018 14:18:15 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] perf: use GIT_PERF_REPEAT_COUNT=3 by default even without
 config file
Message-ID: <d80b51db-a746-e526-5005-141504f087bc@web.de>
Date:   Sun, 25 Feb 2018 14:18:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mA9dFUWOvnEiyqoMev5zG8q0EYOSj2fECUkwYrXWbZIwWB4Hl3f
 OvRejJq4O3tAgo/NTLBj4Cccr1u0dPmNRRqEEGy6Z0dFd5kikArxvXHVMtAfpjaCu3XyA/1
 X7WApQ3nD0frEMR6LzWrBw0SnZyr/e/OceiT9epbR0uM6dl4stAjUDzOANOvmPqTXnUq18i
 HlYUdMGHMxMM/KQF+2vbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3kzgJ56aI/Q=:gNfWTSfq8MHUlOdZW1U8NV
 0VAm8Nsk9jIpGtZDMmwSC8h7AP9ZyupEmNqybnXkdUs+2600oX1hHPRmOCY6k4UYJJsaufhvD
 4WCgDTnCsKm5k5OoWCXMyS2S6jIp3j5jgtoHEiEFBOuSu8raOU4w9VPKo/9qVAfWbSd0TIfFj
 ArPAZWSeMY7RIAPtSiTeyDiuAg6ka4sbiqy7ldoL/iSSkltbG+WCKPgD24Mub0IL82LbQbfsd
 qDALqfjmv7YMvPUUehwWfpk0WND9dv1XeqX9Ra0t5EB/4ZETypRZLIlvbUyhanPb9zm9KOzkz
 FzPoCB8+xiiQBiyHWCe6FaqVUUb/VRjDVwVgN05rhLYxl2BHJ9+MI9DiJt5Dxxu2RBDIjHld/
 NnjWQbWnWkwJ+6nNEOIstXGgP44T5dBn09PGgws4ZT8fftJeNxxv6fJhDWNIFqpExn7PwF2vP
 5JaeByRMTrh16Y0Kf/vmZOLU1bsis6L+vgjZhfnmqHS3RVZs8J63TN6C/WCIGk1vhwf0cNKEw
 JQ+qNKd+D7gLdeExP+f1uSFpJf3s5H5jQOwWrSzDmvYqf8TzK9lApjAmVtKkJ/eWuejDonLSV
 Ug3FcNtm9Passhg7Ji6n6D+/FL3V1KzxIFGdn/cQtRiHl1mB/Gv5yckkpOY7v+GpaofhQhVr6
 XuZX5oJI7U41dTW3tVLdsCzCZUw3bUoG1MhrPUXPgY9OrQCoquwHYXhoMwXJg1vJFoKjiHqt7
 KsnYnOyAJIVzMlSWsTPrJpBKrb390N2KRt1IbvYnF7Y11lWF60oK/9viJgVRXKR2PHSy41LJs
 x8Ydr5eybFA7zLf9LI7lSlc54MZS1XzdCK9GGWrOESlpZtGhz0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

9ba95ed23c (perf/run: update get_var_from_env_or_config() for
subsections) stopped setting a default value for GIT_PERF_REPEAT_COUNT
if no perf config file is present, because get_var_from_env_or_config
returns early in that case.

Fix it by setting the default value after calling this function.  Its
fifth parameter is not used for any other variable, so remove the
associated code.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/perf/run | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/perf/run b/t/perf/run
index 1a100d6134..213da5d6b9 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -106,29 +106,27 @@ get_var_from_env_or_config () {
 	conf_sec="$2"
 	conf_var="$3"
 	conf_opts="$4" # optional
-	# $5 can be set to a default value
 
 	# Do nothing if the env variable is already set
 	eval "test -z \"\${$env_var+x}\"" || return
 
 	test -z "$GIT_PERF_CONFIG_FILE" && return
 
 	# Check if the variable is in the config file
 	if test -n "$GIT_PERF_SUBSECTION"
 	then
 		var="$conf_sec.$GIT_PERF_SUBSECTION.$conf_var"
 		conf_value=$(git config $conf_opts -f "$GIT_PERF_CONFIG_FILE" "$var") &&
 		eval "$env_var=\"$conf_value\"" && return
 	fi
 	var="$conf_sec.$conf_var"
 	conf_value=$(git config $conf_opts -f "$GIT_PERF_CONFIG_FILE" "$var") &&
-	eval "$env_var=\"$conf_value\"" && return
-
-	test -n "${5+x}" && eval "$env_var=\"$5\""
+	eval "$env_var=\"$conf_value\""
 }
 
 run_subsection () {
-	get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf" "repeatCount" "--int" 3
+	get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf" "repeatCount" "--int"
+	: ${GIT_PERF_REPEAT_COUNT:=3}
 	export GIT_PERF_REPEAT_COUNT
 
 	get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf" "dirsOrRevs"
-- 
2.16.2
