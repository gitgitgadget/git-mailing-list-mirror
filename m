Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF9D1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 10:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751206AbeFCKQ4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 06:16:56 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:33846 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCKQz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 06:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zs1n1PY4zOjBvx5dRLwzqgc7F6fcbk6b9UQAotDDAMk=; b=nJtbgraGoUDKV5JFIxUHeBSS9t
        HviwRy01ibr1D0h7Lok/x46iuBAFLL5SxB8TLcnrDsLS0Zd3krpAGIX+NZlZ6QmN3zxzDUeAqvWQ8
        sAztJjvQCawTjLKKDYvweiIjNyOQk8V1seCMh12p0/+0BTO0Y6/ekvKuggfJK69v5ju9awFeiEj24
        pTKAMvkmp5aPtNKMM2JviPM3cnraLKbLkFblof1j+wi14AjdVIDmf7w8OXsXh/p5Ej7hquV7YMcTI
        QamOJckCFW0jeYv9lBu2WoQVR2G9jc3iZxo2k+XX/1DWk90lYKqopF5U5JQEZ66ipZ3iHqWQUnXea
        1N3Rm48A==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:57594 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fPQ4D-00416i-28
        for git@vger.kernel.org; Sun, 03 Jun 2018 06:16:54 -0400
Date:   Sun, 3 Jun 2018 06:14:44 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH v2] t/perf/run: Use proper "--get-regexp", not
 "--get-regex"
Message-ID: <alpine.LFD.2.21.1806030613080.7681@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Even though "--get-regex" appears to work with "git config", the
clear standard is to spell out the action in full.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

this is the only occurrence i saw of this in the entire code base, so
it seemed worth tweaking just for consistency.

diff --git a/t/perf/run b/t/perf/run
index 9aaa733c7..fb5753ea2 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -110,7 +110,7 @@ run_dirs () {
 get_subsections () {
 	section="$1"
 	test -z "$GIT_PERF_CONFIG_FILE" && return
-	git config -f "$GIT_PERF_CONFIG_FILE" --name-only --get-regex "$section\..*\.[^.]+" |
+	git config -f "$GIT_PERF_CONFIG_FILE" --name-only --get-regexp "$section\..*\.[^.]+" |
 	sed -e "s/$section\.\(.*\)\..*/\1/" | sort | uniq
 }


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
