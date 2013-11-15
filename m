From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/6] Replacement for rr/for-each-ref-decoration
Date: Fri, 15 Nov 2013 16:29:02 +0530
Message-ID: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 12:08:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhHFy-00079H-2K
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 12:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758230Ab3KOLIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 06:08:05 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61127 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab3KOLIC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 06:08:02 -0500
Received: by mail-pa0-f49.google.com with SMTP id lf10so3484613pab.36
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=03Ni1rS5m07H7QHJcWrkn46YeDdiKEKFu9XQiXmLbhY=;
        b=M4aSjOCCieZWMJcribclSKN8uQHNz/b/dPZDFKFnh1BNpqjGw8UAg6/aXZOR7P1D8y
         2QBOefCmzm48JIuK9CSot/oFFQQ8if+FkjJHtcWfMnbbfpD5y3jmcm7bAMCiVoJVNhxb
         l1colv/as/lZ+uAyfhAyGvRuME1kyfi1XWt6oqzTH1kUiNJPy8+LotH/XQG64EtCAcAG
         CM4No2N6r2Zt4B8ItuIoahzCpY0PdanlMVbAn0r2krNueBto4FLlbTO1QblRd4aoe/Zw
         oEP0S5hnXQadKONUu36BzUkmQzeasjRudcKW88e698zO8OT2h60k6A4Jrtiovq1WN6/Y
         SaLA==
X-Received: by 10.66.142.132 with SMTP id rw4mr6445529pab.6.1384513681939;
        Fri, 15 Nov 2013 03:08:01 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id tu6sm3761840pbc.41.2013.11.15.03.08.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2013 03:08:01 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.6.gfd75b41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237899>

Hi Junio et al,

v3 contains the following changes:

- [1/6] is totally unrelated; it's a "while we're there" patch.
- [2/6] is required for the test modification in [4/6].
- [3/6], [4/6], [5/6] now come with tests.
- [6/6] is new: implements Junio's suggestion to auto-reset color.

I haven't included Junio's 78465bb (fixup! for-each-ref: introduce
%(upstream:track[short]), 2013-10-31), because my compiler doesn't
complain, and because it's ugly.

Thanks.

Ramkumar Ramachandra (6):
  t6300 (for-each-ref): clearly demarcate setup
  t6300 (for-each-ref): don't hardcode SHA-1 hexes
  for-each-ref: introduce %(HEAD) asterisk marker
  for-each-ref: introduce %(upstream:track[short])
  for-each-ref: introduce %(color:...) for color
  for-each-ref: auto reset color after each atom

 Documentation/git-for-each-ref.txt | 14 ++++++-
 builtin/for-each-ref.c             | 86 +++++++++++++++++++++++++++++++++-----
 t/t6300-for-each-ref.sh            | 59 ++++++++++++++++++++------
 3 files changed, 135 insertions(+), 24 deletions(-)

-- 
1.8.5.rc0.6.gfd75b41
