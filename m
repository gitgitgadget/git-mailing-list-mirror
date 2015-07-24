From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/10] port tag.c to use ref-filter APIs
Date: Sat, 25 Jul 2015 00:34:35 +0530
Message-ID: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 21:04:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIiH3-0002tQ-Ao
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbbGXTEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:04:44 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36737 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbbGXTEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:04:44 -0400
Received: by pachj5 with SMTP id hj5so18474450pac.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DO8q9BDw8eAFI0u1mPkp0P4B/ZQm/aFPOo5o5wfuMCQ=;
        b=xOy6F7+vlRQPdRlKn5+993hI44k1HRocgrYG3eHV/WD1dyHyyiDUnZNx99KSWaVYmZ
         4hYXd4HGSlPDw01hZmNPkAkB64anpULQjmYB0Sf5W107HEr3yQD/EEiDN81gRiKv/2Hx
         jFBggy/klMRWE31WwrYhn7SsyWXRdoqwbXCURkd9zoWW+h8QkFrHBmv4JIQ7+iaSug4e
         7oe5l0eESZCCvi5/Av36sewiqcFtmU5Qjl1Pfz4niilQfBY7O9fnf5bIyGUFBJnoNx6U
         /DV20Pjij0Fc7VQxjzNwKVA+1wagteBGmOkFY+GN2eFrjVW5c4Hy8DpOuAlxAJrxADm9
         4TSA==
X-Received: by 10.66.148.6 with SMTP id to6mr30907724pab.132.1437764683446;
        Fri, 24 Jul 2015 12:04:43 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ns14sm15922915pdb.17.2015.07.24.12.04.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jul 2015 12:04:42 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274579>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref.  This patch series is continued from: Git (next)
https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61

Version 3 can be found here
http://thread.gmane.org/gmane.comp.version-control.git/274168

Changes from v3:

[01/10]: Changed the whole implementation as per Junio's Suggestion.
Also fixed parts where the code was wrong, as per Matthieu's and
Eric's suggestion.

[04/10]: Small changes in comments and line wrapping.

[05/10]: Include more tests, better comments and refactored code.

[06/10]: Improvement in comments.

[09/10]: Change the tests to not fallback to default values.
Introduce "for_each_tag_ref_fullpath()" which iterates through tags
without stripping the same.

[10/10]: Improvements in comments.

Set of commits:

[PATCH v4 01/10] ref-filter: add option to align atoms to the left
[PATCH v4 02/10] ref-filter: make the 'color' use
[PATCH v4 03/10] ref-filter: add option to filter only tags
[PATCH v4 04/10] ref-filter: support printing N lines from tag
[PATCH v4 05/10] ref-filter: add support to sort by version
[PATCH v4 06/10] ref-filter: add option to match literal pattern
[PATCH v4 07/10] tag.c: use 'ref-filter' data structures
[PATCH v4 08/10] tag.c: use 'ref-filter' APIs
[PATCH v4 09/10] tag.c: implement '--format' option
[PATCH v4 10/10] tag.c: implement '--merged' and '--no-merged'
