From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 0/9] Handling empty notes
Date: Sun,  9 Nov 2014 13:30:46 +0100
Message-ID: <1415536255-19961-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 09 13:31:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnReF-0007k1-8Z
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbaKIMbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:31:05 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:45759 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbaKIMbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:31:03 -0500
Received: by mail-lb0-f169.google.com with SMTP id 10so4631891lbg.14
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 04:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=b3Ip/Wl9zzD7WEetuCTTDwFI/LPT5akGdkXHlYjnnmc=;
        b=Nnw49JEtAV5w09qTbMJ4ehpTtQ/gOoMTSWSHtNSF17qGfrRokwFlvmQEDn80A5lhwd
         /p8qaqdAP+4PQUd+oOMTm28qeiFGP9xoky3K7JRMHyTGKD0BG7h+O7gyp24KYdmtOKoX
         /FDdr7tB4bqPccE9RrHawxW3IseuWEhFsqsP1ZLSsV3oLjAPFJKTI25dQkMkJtLp+Ykr
         mErPmRAzino8GgoPxaZ/KOL6NJ+TOSlCW8tdOx0RGVS1yL9j9BW63Xzao0kchDMV3gdd
         NGmTNzqFeCVhheMHUhztE87m/uegh75KErZEdYoFw2FaFtfZCGXs9XxnOpbeJ+Ge9pCp
         EQHw==
X-Received: by 10.152.7.175 with SMTP id k15mr23152207laa.58.1415536261493;
        Sun, 09 Nov 2014 04:31:01 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id l7sm4555178lah.27.2014.11.09.04.30.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Nov 2014 04:31:00 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes v3 -> v4:
 - Incorporate more feedback from Junio:
    - Patch #1: s/git config --unset/test_unconfig/
 - Add patches #3 - #6 to refactor add()/append_edit()/create_note()
   for supporting the direction suggested by Junio
 - Revamp the last patch to more fully modernize t3301


Have fun! :)

...Johan

Johan Herland (9):
  builtin/notes: Fix premature failure when trying to add the empty blob
  t3301: Verify that 'git notes' removes empty notes by default
  builtin/notes: Improve naming
  builtin/notes: Refactor note file path into struct note_data
  builtin/notes: Simplify early exit code in add()
  builtin/notes: Split create_note() to clarify add vs. remove logic
  builtin/notes: Add --allow-empty, to allow storing empty notes
  notes: Empty notes should be shown by 'git log'
  t3301: Modernize

 Documentation/git-notes.txt |   12 +-
 builtin/notes.c             |  235 +++++----
 notes.c                     |    3 +-
 t/t3301-notes.sh            | 1189 ++++++++++++++++++++-----------------------
 4 files changed, 698 insertions(+), 741 deletions(-)

-- 
2.1.1.392.g062cc5d
