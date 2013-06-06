From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/9] cherry-pick: improvements
Date: Thu,  6 Jun 2013 03:58:55 -0500
Message-ID: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 11:03:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkW69-0007qD-3o
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 11:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494Ab3FFJDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 05:03:05 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:47909 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932329Ab3FFJAz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 05:00:55 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so4251486obq.35
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=oRQZGobGjZUQriWuIRH+Qo5s86BPrudVSuoYwciXtJg=;
        b=SpEmmu36p4JLRLa+BpEnDYkIyd8SCHnhioHu1pLVdxkAXU6gLMHC3EaFZU8tcB5qlf
         33GvBU5ATC0ovX/FF0w4kGpYQTAHvN4hkA8/i3yKUZ1lEo7i5oKrS8cbbriQx9yG1ZVt
         WWXNhLJLJQn7ZN3trh/PFLDFvFdeZFrVhMem/xt582z/sNpx4N4eSvzJPuabvkSzNRGy
         Js/Zv9CHGhfyzZRXEBc4I3lrxh1wnXTwduRLm9NdiqzGJnmZm64tLGl7N57vZpgUUpoI
         JEPC/0Q2Z2/jw5gYcLuv9l3Xc1DX1h8cY7QLeP9LLUgd832tDL9bZ5mjBVPj+BILA3U9
         xFtw==
X-Received: by 10.60.138.234 with SMTP id qt10mr17922084oeb.118.1370509254281;
        Thu, 06 Jun 2013 02:00:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm59247647oel.2.2013.06.06.02.00.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 02:00:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226498>

Hi,

Sames as v2, plus a few changes from the feedback, and cleanups.

Felipe Contreras (9):
  sequencer: remove useless indentation
  sequencer: trivial fix
  cherry-pick: add --skip-empty option
  cherry-pick: store rewritten commits
  sequencer: run post-rewrite hook
  cherry-pick: add support to copy notes
  revert/cherry-pick: add --quiet option
  revert/cherry-pick: add --skip option
  cherry-pick: don't barf when there's nothing to do

 Documentation/git-cherry-pick.txt   |  10 +-
 Documentation/git-revert.txt        |   7 +-
 Documentation/sequencer.txt         |   3 +
 builtin/revert.c                    |  15 +++
 sequencer.c                         | 230 ++++++++++++++++++++++++++++++++++--
 sequencer.h                         |   6 +-
 t/t3508-cherry-pick-many-commits.sh |  13 ++
 t/t3510-cherry-pick-sequence.sh     |  12 ++
 8 files changed, 280 insertions(+), 16 deletions(-)

-- 
1.8.3.698.g079b096
