Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6EFC207F8
	for <e@80x24.org>; Thu,  4 May 2017 09:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbdEDJvG (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:51:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:63555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752434AbdEDJvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:51:06 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcVOE-1dob3M13yQ-00jqDy; Thu, 04
 May 2017 11:50:58 +0200
Date:   Thu, 4 May 2017 11:50:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 7/7] t4051: mark supporting files as requiring LF-only
 line endings
In-Reply-To: <cover.1493891336.git.johannes.schindelin@gmx.de>
Message-ID: <f648bb03c7fe3945042480f05b9ac229350412b3.1493891336.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <cover.1493891336.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/NSy5TEwTbwb7fuRbvFekJ4LdqU6uqpfWOEmMJJmvMUdb1FOp/Z
 LnFWIs+ABQZtEbci7ly33HBjmwt7qRXVafvr2we4NYyJBluq0Jwa7DuMyljSOhChzLZSaqt
 IEn2a6sUmAiKhd6gmVdsaJN3nvh26jt+0j7fWS3VZviZf1o94HvcWtOx2L8+dT85zmRS4w2
 7qQ0MZNwx7n4eMDWCNVQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t6utraY0/RQ=:O9Sw9vqaHR76AJYR4AmiFE
 CVwIAhJmDrR0TIpEIMDUOkkWx9JjyfqM4SuOYTBK6idEA0Dn/1xZ4ag127QKzqcl+SkgswaTh
 M5WvkaHwRoVusEBUKF4SzTEyIY11d4usFqP1kVTxyPNBuHUw3H9op++BUF+hbQT166Bnv/iLv
 lP/qlT36zjZtL9OqOJVLOgRz+RHFTtjnBUZltGM5ogDTMjb1m4VCSTHgF6juzaVKU5wLilpBU
 y3EyG6RJJR9wHzJbYIe7UiYrZhfrLGY04jRC7PK4czqzuCs6gs6EfTwR7CSmbLqll9L6pVY2G
 b1YWBvtJ2AsO5PGfktPzdNpaj/CTctmEG2hCq9SvNJ5zl6HoAQ35yUh5RB6qvb93/3nshYVaB
 QnG1KeoH3YX2WPQBotXP1Xiy8/Awl6dq3NmKJvmAEKhmuVRpQlS+fHuTSHNAsASnEtho4TODg
 Q1hjPxTF9YSB7R5YoyK6PuK6KwPl7KCa3AJE21SDwrjRXpN5/SOCZXQ9ZBYU9kzsdZ6N4f1oO
 9bSpseVOXf4tX0V7zHT4ayYXvepZ2XwqWCyR5PgQfi1DsunEe2qlO7ZmWKjMeVkubVomg52ND
 xzrgiaPII1QxaeQ46/1KMIlltEk1ROm60z3bZvOEwWkfeeBlyLmsQl7aj08Cs35xFlNYJ9xDn
 DlpQloJam3LWVm4ELCw9eibCT6deT8S+x0/cxQW3aSdQA58zQy0dwziOX0zqTN0L3nB+l+MEg
 2yc2ihEpGgBu4GM4kjKreAtPls7FRKnNE59UJoIchQmT8pFOhE2D1cHVJnfhnHioU0I/f8UK6
 efGw53N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test t4051-diff-function-context.sh passes on Linux when
core.autocrlf=true even without marking its support files as LF-only,
but they fail when core.autocrlf=true in Git for Windows' SDK.

The reason is that `grep ... >file.c.new` will keep CR/LF line endings
on Linux (obviously treating CRs as if they were regular characters),
but will be converted to LF-only line endings with MSYS2's grep that is
used in Git for Windows.

As we do not want to validate the way the available `grep` works, let's
just mark the input as LF-only and move on.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/.gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/.gitattributes b/t/.gitattributes
index 3525ca43f30..bdd82cf31f7 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -5,6 +5,7 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t4034/*/* eol=lf
 /t4013/* eol=lf
 /t4018/* eol=lf
+/t4051/* eol=lf
 /t4100/* eol=lf
 /t4101/* eol=lf
 /t4109/* eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06
