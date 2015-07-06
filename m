From: Evgen Druzhynin <evgen.druzhynin@gmail.com>
Subject: [PATCH] Git doesn't allow to apply a patch with empty filenames.
Date: Mon,  6 Jul 2015 20:16:13 +0300
Message-ID: <1436202974-7624-1-git-send-email-evgen.druzhynin@gmail.com>
Cc: Evgen Druzhynin <evgen.druzhynin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:16:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCA0J-0006cj-PV
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbbGFRQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:16:25 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:36040 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbbGFRQU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:16:20 -0400
Received: by lagc2 with SMTP id c2so162761502lag.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1IvfnzYYh1pAdZrksKoNM3VQGkNhth7d9KjAn6XktTo=;
        b=mTyBFwmIeAGHVev9S8aVKcC7s4hh2PyiJFKRHWqzOIhWJPmlw+dKT6+NP+VsK2bJ0P
         lkMNrFHclyx/9wxJvmUG34nkgfMRV45a/Lporj5R3Yfy8hrWKigE9XlR3ypx/FCxwKAs
         WSW/eGqTFme9H6yb7m3ao0+JKntBMDEAfg7br22VcyKzsKDGhukWHvIOpi2uR4aoUShx
         B6cpqMJY901Sw9Jwd3C5XkWGek71vkpW6+9306ueMCKEgWRS3xH9O6McD2NWyV1tpPBs
         LoMaDKgu3OUUCKElPiGO8zVE+RKV9F5GClmDAcjhaLvYNCfXfGm5sdZORd3Gd7MP3VRf
         IytQ==
X-Received: by 10.152.164.193 with SMTP id ys1mr50020891lab.65.1436202979276;
        Mon, 06 Jul 2015 10:16:19 -0700 (PDT)
Received: from mech.intropro.com.ua ([193.109.118.129])
        by mx.google.com with ESMTPSA id q1sm4893651lah.27.2015.07.06.10.16.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:16:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273408>

git-apply fails if '-p' option truncate at least one filename in patch to zero size.
This solution tries to bring closer "git-apply" to standard Linux patch tool.
Standard patch tool skip the truncated filenames and successfully applies patch.

Evgen Druzhynin (1):
  Added ability to scip patch hunk with an empty file.

 builtin/apply.c | 16 +++++-----------
 po/bg.po        | 15 ---------------
 po/ca.po        | 15 ---------------
 po/de.po        | 15 ---------------
 po/fr.po        | 15 ---------------
 po/git.pot      | 11 -----------
 po/it.po        | 11 -----------
 po/pt_PT.po     |  7 -------
 po/ru.po        | 12 ------------
 po/sv.po        | 16 ----------------
 po/vi.po        | 12 ------------
 po/zh_CN.po     | 11 -----------
 12 files changed, 5 insertions(+), 151 deletions(-)

-- 
1.9.1
