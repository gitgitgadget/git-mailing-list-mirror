From: newren@gmail.com
Subject: A few fast export fixups -- round 2
Date: Mon, 22 Jun 2009 07:06:35 -0600
Message-ID: <1245676001-14734-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 15:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIjGZ-0004CR-Nt
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 15:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZFVNIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 09:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbZFVNIq
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 09:08:46 -0400
Received: from mail-pz0-f197.google.com ([209.85.222.197]:55508 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbZFVNIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 09:08:45 -0400
Received: by pzk35 with SMTP id 35so731490pzk.33
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+fe+4P8WrpuMiy3Pvi6578nu8GOW92/b8pE6rr6sIzo=;
        b=XdQ9D654usbst8h5ws8r4DfCpzvtqC7Zg8Hf9taQNolpBKnx/XpUnZ3OJNJ5fdIh3S
         K6iSaBFA5pIADsvBSeMUZPvu7dQxHyq2nb10j8Xmh6UjOhoW2i9KzogSPHbOLwNkcJX1
         JHC/eCEDmumkgleJGzODofNVx7iKgiv3n5DeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=F+WB1ZK2/s53yXxgv9LB1Z4x7r0Bq4qHz3yyjU9L/BRum0mFURscWAQQFwTD9C+DHy
         VWnS1cpxLpECi0Vts12lcxsCmqMEHLFZUJGpZdFI/QwgVozixEc5JP1ZHFkcLR1gftqF
         itAVRYSTaFb4uw6cttBr3cmCONDRjwxl2vljI=
Received: by 10.142.148.9 with SMTP id v9mr2632506wfd.183.1245676127776;
        Mon, 22 Jun 2009 06:08:47 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 28sm675507wfd.23.2009.06.22.06.08.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 06:08:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122035>

This patch series fixes a few fast-export bugs I have come across,
plus some new testcases to verify the fixes, and finally a small
addition to the documentation.

Changes since v1:
  - fixed test issues identified by Johannes Sixt and Stephen Boyd
  - squashed patch #2 into patch #1

Elijah Newren (6):
  fast-export: Omit tags that tag trees
  fast-export: Make sure we show actual ref names instead of "(null)"
  fast-export: Do parent rewriting to avoid dropping relevant commits
  fast-export: Add a --tag-of-filtered-object option for newly dangling tags
  Add new fast-export testcases
  fast-export: Document the fact that git-rev-list arguments are accepted

 Documentation/git-fast-export.txt |   17 +++++++++
 builtin-fast-export.c             |   72 +++++++++++++++++++++++++++++++++---
 revision.c                        |   10 +----
 revision.h                        |    8 ++++
 t/t9301-fast-export.sh            |   63 +++++++++++++++++++++++++++++++-
 5 files changed, 155 insertions(+), 15 deletions(-)
