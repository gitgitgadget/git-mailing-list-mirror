Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E3AC67871
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 09:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjAJJdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 04:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbjAJJdB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 04:33:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E6164B1
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 01:32:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e3so1841808wru.13
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 01:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emZcEVNvsTlWglABaAk4Jbqi4nmaQsGtVv9G4+qXHlI=;
        b=YDEM8uGwOE9apU+7/VWAueVw86xFdvjxlT2j25/2ra7SZfvH7GbNhHi7Vy4oD3SLR/
         dQ1T2yWyBaFhQ0EdWX8aw2RsxmrNPmDH+ixYxpguipSL6MDNcR+0ov81exlWgDgVFv8a
         BFPv0pyB5s9L0M1p+m9DW9DQgxRVPxIMlkdFDPDmMxzBQhCn2XsUR1l7xnuxTmZKsqGb
         DlIJtABpA5H0Sh+j5xB5ZnNXQ6RTC85ab18njbC4f3noBPf7us0BB8aX0JGN1ljb+SZn
         XWyNWfkOpiUpWhWvNKukk7k9djTaNtKStK4aqcWwGMAPPHO8YtKso/qQixbeSW2cfyYI
         9P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emZcEVNvsTlWglABaAk4Jbqi4nmaQsGtVv9G4+qXHlI=;
        b=2CEdAAtGcMurQQQAHw1i3mR8hHYae71bBwFmZr8w0f6eeVZMDrd0u2gxDbg072c1PH
         dexHzm6a2WmvTK5TFuC3i6dF9G9ZU/O06vAVngzVWAYbO0/jSFyAIKGk2YXjsgh0QjJ+
         nfj72Kue14CH+QPwaqsJ8HylhPZsFsmb36PCODnzMlY0cPxKjUYa+bzPKhoeAffTXb/1
         KD1Q7IkkpPKkvPYaRc9M/+svRYACZsrxveMLnozhR7odQqydygK8ELzYMc9cCBCYYeJ0
         J22aSHTsmA1zzP4f/SN/6Kohd6qh/D4NY/emqR5m6QymYLfUmMZg86nahYCqh+2iXG3T
         CyDg==
X-Gm-Message-State: AFqh2kpgULh3Gv0YZfTgRVeHfdfbz4+hTqKzWxZx90ZxsiNb7fUtwr1L
        +hbX9hTCsjiK7pYJHQvA9DCz3DDhf220C5Fq
X-Google-Smtp-Source: AMrXdXsgvOqd6GyMKj/vyws47/wzf45T9Nuo4epF2hKYQ3u+ZEQnDZi4LianBi3Mjapauml7wyMUPQ==
X-Received: by 2002:adf:fdc8:0:b0:292:1fa9:fcee with SMTP id i8-20020adffdc8000000b002921fa9fceemr21551548wrs.31.1673343176544;
        Tue, 10 Jan 2023 01:32:56 -0800 (PST)
Received: from titov.fritz.box ([212.102.57.75])
        by smtp.gmail.com with ESMTPSA id bx9-20020a5d5b09000000b0023662245d3csm10729071wrb.95.2023.01.10.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:32:55 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] git-bisect-lk2009: update nist report link
Date:   Tue, 10 Jan 2023 10:32:51 +0100
Message-Id: <20230110093251.193552-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230110093251.193552-1-rybak.a.v@gmail.com>
References: <20230110083801.186789-1-rybak.a.v@gmail.com>
 <20230110093251.193552-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d656218a83 (docs/bisect-lk2009: update nist report link,
2017-04-20) replaced a dead link to news release on nist.gov.  However,
this might be confusing to the reader (like myself) because the article
git-bisect-lk2009.txt quotes from the news release but the exact quote
cannot be found in the full report.  In addition to that, the link added
in 2017 is also dead in 2023.

Replace the reference to nist.gov with an version of the original NIST
news release archived to the Wayback Machine.  Include also an updated
link to a live version of the full report.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/git-bisect-lk2009.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I wasn't sure about inclusion of links to https://web.archive.org, but there is
a single precedent already in "Documentation/gitcore-tutorial.txt".

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 36168792ee..0bc165788e 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1347,7 +1347,7 @@ author to given a talk and for publishing this paper.
 References
 ----------
 
-- [[[1]]] https://www.nist.gov/sites/default/files/documents/director/planning/report02-3.pdf['The Economic Impacts of Inadequate Infratructure for Software Testing'.  Nist Planning Report 02-3], see Executive Summary and Chapter 8.
+- [[[1]]] https://web.archive.org/web/20091206032101/http://www.nist.gov/public_affairs/releases/n02-10.htm['Software Errors Cost U.S. Economy $59.5 Billion Annually'. Nist News Release.] See also https://www.nist.gov/system/files/documents/director/planning/report02-3.pdf['The Economic Impacts of Inadequate Infratructure for Software Testing'.  Nist Planning Report 02-3], Executive Summary and Chapter 8.
 - [[[2]]] https://www.oracle.com/java/technologies/javase/codeconventions-introduction.html['Code Conventions for the Java Programming Language: 1. Introduction'. Sun Microsystems.]
 - [[[3]]] https://en.wikipedia.org/wiki/Software_maintenance['Software maintenance'. Wikipedia.]
 - [[[4]]] https://lore.kernel.org/git/7vps5xsbwp.fsf_-_@assigned-by-dhcp.cox.net/[Junio C Hamano. 'Automated bisect success story'.]
-- 
2.38.1

