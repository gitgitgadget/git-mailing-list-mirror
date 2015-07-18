From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/9] Port tag.c to use ref-filter APIs
Date: Sun, 19 Jul 2015 00:42:20 +0530
Message-ID: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 21:12:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGXXM-0001BA-4i
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 21:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbbGRTMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 15:12:35 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36246 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbGRTMf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 15:12:35 -0400
Received: by pdjr16 with SMTP id r16so80782900pdj.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nOJ+NOicbfBozynim0EAaVWHm0CmYxGPuH9zsI7+6jY=;
        b=FtqGtzknnOSMuVWd4HKO1AzGmEGl2gMPEPzoo8d71wC6cvGGyJd1Rhdy3POGaczz4k
         vLweux06p+gftFi/T0GfKkXrAI2BBpbWwOBDLFwmdA1SMQIjKYWijQrkHCRr7ScC/5NQ
         AWwa2NO1kfLmKpxYeSTsGJnt7uAReLrHJtueXB4NSwnfFlizJXPg4Z71yN+S/7VPkjSR
         i+QzlFAsnYP9fThlFqZw7zzexJYi0jZvwIePNfEcNW5WGX/nc8ni7b0FPpUlIWEOmxcI
         SSkV1jQd2xcx/ic3AAh1xrY750nIn7S4Dp62PeZdvEeds7lhdyQOJvTTeIROIEyLdVmE
         FchA==
X-Received: by 10.66.123.81 with SMTP id ly17mr19867819pab.31.1437246754543;
        Sat, 18 Jul 2015 12:12:34 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ra10sm15104498pab.19.2015.07.18.12.12.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jul 2015 12:12:33 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274168>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref.
This patch series is continued from: Git (next)
https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61

Version 2 can be found here:
http://article.gmane.org/gmane.comp.version-control.git/273569

Changes in this version:
* Grammatical errors were corrected.
* Added missing documentation and tests for "%(version:refname)"
* Made the alignment option an atom as per Duy's Suggestions
  (http://article.gmane.org/gmane.comp.version-control.git/273569)

DiffStat:
Documentation/git-for-each-ref.txt |   2 +
Documentation/git-tag.txt          |  38 ++++++++---
builtin/for-each-ref.c             |   3 +-
builtin/tag.c                      | 371 +++++++++++++++++++----------------------------------------------------------------------------------------
ref-filter.c                       | 148 ++++++++++++++++++++++++++++++++++++++-----
ref-filter.h                       |  15 +++--
t/t6302-for-each-ref-filter.sh     |  26 ++++++++
t/t7004-tag.sh                     |  51 ++++++++++++---


[PATCH v3 1/9] ref-filter: add option to align atoms to the left
[PATCH v3 2/9] ref-filter: add option to filter only tags
[PATCH v3 3/9] ref-filter: support printing N lines from tag
[PATCH v3 4/9] ref-filter: add support to sort by version
[PATCH v3 5/9] ref-filter: add option to match literal pattern
[PATCH v3 6/9] tag.c: use 'ref-filter' data structures
[PATCH v3 7/9] tag.c: use 'ref-filter' APIs
[PATCH v3 8/9] tag.c: implement '--format' option
[PATCH v3 9/9] tag.c: implement '--merged' and '--no-merged' options
