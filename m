Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CDDA208CD
	for <e@80x24.org>; Sat, 19 Aug 2017 05:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750853AbdHSFeI (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 01:34:08 -0400
Received: from mout.web.de ([217.72.192.78]:60467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbdHSFeH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 01:34:07 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxfKp-1dWxCM3epP-017Ec7; Sat, 19
 Aug 2017 07:33:53 +0200
Subject: [PATCH 4/4] archive: queue directories for all types of pathspecs
To:     git@vger.kernel.org
Cc:     David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
 <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de>
Date:   Sat, 19 Aug 2017 07:33:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:DZ6fyCyolup69rDNaVnN/mmd3X4vMvDT7AZ2MIjZsmPKu8J4GHQ
 CndH43na0wx4NG+u1ZWM6KgTWra5JAql4AnUIGFVZA/BDXgOfXyg141KoAe2ca+yROs/ohk
 5zyJwYioVE/ms4ulI5l4YwC+k5N7e+ivGLKMWmT+6ETXCBLJ/lfhZ1DRyqVftovxN9s5B41
 Lo8KN2eiYiQqGd89+WnMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ftyytblu0Oo=:NeAPJEmiS+nJ+2tLKpIhs9
 aVbBmxawsRyUVaOa7W36KC3/ODEIwONegaHc43GbKgzmKKQ3sLEeJ3y/AOU68onJN5booGD55
 KyA+6ZfNwM7uDsubR4ItF9KFa2eLLqpiF7p3oV727UoJP+LY7/lmB8qhu35LnllH52U2Qe6Nq
 dQYaWt/cD937JOfAqrgs0g4BiE+kje6H0giA5Y+WXN+fAznJZzMl0/MGG1rWwNqc5OvIqn0Ar
 DdaSzv4c5woDkixQbGcUKLCTp8tcq0lGZk1VIWySC0XMnuSzTwkl2k3meijzwPSzFyiWtnBel
 kK2jy6tmcEzH9T33JUvSIpsl4dGwdsHLospgz+pXVwbG6bIOS5Nu8w8ec2rMitvRF6oTLC7cX
 u9zmhapkQBjnARU6xpJYrA0nP0yoi8O9vDh5cI0nW/Tj8W8mGtW1mYCgGn0k5dwjunQVvILOa
 mypaTLjVwJWC8lUndMptD5E2824mxRltcMJuwNfOntovNeY87jjo2zaZuZezr2efMegFqD5sx
 nY6pQyODe/CR4stoR/13IBHBR3vm6uKLHYwRmItdEQF03ErXKR8mQ84jJmA6uV3cW5U6+1cMh
 on0HwUJLJrL453hpOcpWQXYCT37dijORgB1c3aHV7MTgZ2yJ4a0RcUw0QuhtGylS85t7caTXf
 tKv4MbwofhIRz8JBdqTrsa4QwvzOrORj5bhCWOgMJQFI6mjP7R5jJL13omxjXKO7NvKk30ygx
 6jm1WTEn7gegYKTrtJkJuGS3yyhs+C9ghhebE4zotdiuLnKp5//Cjka96A9oFjhLlHpe0mc7Y
 CxuqW8nhjUm9o6PEqSfr0Jf4XVokAVkapsv3E0KN2g++vR28RA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When read_tree_recursive() encounters a directory excluded by a pathspec
then it enters it anyway because it might contain included entries.  It
calls the callback function before it is able to decide if the directory
is actually needed.

For that reason git archive adds directories to a queue and writes
entries for them only when it encounters the first child item -- but
only if pathspecs with wildcards are used.  Do the same for literal
pathspecs as well, as the reasoning above applies to them, too.  This
prevents git archive from writing entries for excluded directories.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive.c               | 2 +-
 t/t5001-archive-attr.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index 1ab8d3a1d7..174c0555b6 100644
--- a/archive.c
+++ b/archive.c
@@ -123,7 +123,7 @@ static int check_attr_export_subst(const struct attr_check *check)
 
 static int should_queue_directories(const struct archiver_args *args)
 {
-	return args->pathspec.has_wildcard;
+	return args->pathspec.nr;
 }
 
 static int write_archive_entry(const unsigned char *sha1, const char *base,
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 897f6f06d5..e9aa97117a 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -73,7 +73,7 @@ test_expect_missing	archive-pathspec/ignored-by-tree
 test_expect_missing	archive-pathspec/ignored-by-tree.d
 test_expect_missing	archive-pathspec/ignored-by-tree.d/file
 test_expect_exists	archive-pathspec/ignored-by-worktree
-test_expect_missing	archive-pathspec/excluded-by-pathspec.d failure
+test_expect_missing	archive-pathspec/excluded-by-pathspec.d
 test_expect_missing	archive-pathspec/excluded-by-pathspec.d/file
 
 test_expect_success 'git archive with wildcard pathspec' '
-- 
2.14.1
