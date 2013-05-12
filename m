From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/7] rebase.autostash completed
Date: Sun, 12 May 2013 17:26:34 +0530
Message-ID: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 12 13:56:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbUsw-0001wz-7e
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 13:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab3ELL4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 07:56:08 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:57125 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab3ELL4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 07:56:07 -0400
Received: by mail-pd0-f171.google.com with SMTP id r11so3807370pdi.16
        for <git@vger.kernel.org>; Sun, 12 May 2013 04:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=6XHEACcVWZTHWKu9+RzSigWn9lPGnvP2RPhPF9OZ0eE=;
        b=tpKfcLJCqmCx2YMIAuDuwYtqBpIHC4vkFNtZgUM+Z8Vd361Rp1+W5SMvHJMTRfv2hM
         /dGkmO/rw5f1puQzIX/9LmDTBa2a3Neje5HpeoP7e4Go2RuwYEGYJPD9gjPHjqxK/i9R
         qZvFDZljJD74s8oKEF1H+qinyuuHU1eYQ2LE74dVmBiqRxrRuVnFPn8UF/xqbA9xyRXq
         LJQgf6cINn4F3/WrTFLOdRdw5LkOFaTN1vyw9j7wgjI0MBKmBEim05TeI1Bt+GHZsasE
         DFNk/eOJkxKC8SLde0R0WpejsM6jQvEYyuI6XW8z+3DwLJP5nWiMIM4/ORPdprq5feEV
         MUdw==
X-Received: by 10.66.245.75 with SMTP id xm11mr25420284pac.40.1368359766635;
        Sun, 12 May 2013 04:56:06 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.41])
        by mx.google.com with ESMTPSA id iy2sm9911078pbb.31.2013.05.12.04.56.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 May 2013 04:56:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.51.gd7a04de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224035>

Minor changes since v2 in response to reviews by Junio and Eric
Sunshine.

Should be ready to merge soon.

Ramkumar Ramachandra (7):
  am: tighten a conditional that checks for $dotest
  rebase -i: don't error out if $state_dir already exists
  rebase: prepare to do generic housekeeping
  am: return control to caller, for housekeeping
  rebase -i: return control to caller, for housekeeping
  rebase --merge: return control to caller, for housekeeping
  rebase: implement --[no-]autostash and rebase.autostash

 Documentation/config.txt     |   8 +++
 Documentation/git-rebase.txt |  10 +++
 git-am.sh                    |  13 +++-
 git-rebase--am.sh            |   8 +--
 git-rebase--interactive.sh   |  11 ++--
 git-rebase--merge.sh         |   5 +-
 git-rebase.sh                |  46 +++++++++++++-
 t/t3420-rebase-autostash.sh  | 148 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 233 insertions(+), 16 deletions(-)
 create mode 100755 t/t3420-rebase-autostash.sh

-- 
1.8.3.rc1.51.gd7a04de
