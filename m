From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.3.8
Date: Mon, 11 May 2015 15:46:23 -0700
Message-ID: <xmqqlhgu20n4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue May 12 00:46:34 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YrwT3-0005Cj-I2
	for glk-linux-kernel-3@plane.gmane.org; Tue, 12 May 2015 00:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbbEKWq2 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 11 May 2015 18:46:28 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35110 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbbEKWqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 May 2015 18:46:25 -0400
Received: by ieczm2 with SMTP id zm2so121282595iec.2;
        Mon, 11 May 2015 15:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=FRs09yVD1uvwev1gYgYotASIfCtOhb0nvceVxd/4UCs=;
        b=MMFnMsMZI2zT/lsFF+1YOLraiOYfRTJcRo3ukd/RG3HTV/Z2KPoDkSKa5ywUVDFRqy
         HMEdZHs5nkNePoh2sXeVD1dP/tw/f8NVd9ArwjKgJadIABb/IHFNpQZMqZwI9CySc+Lo
         XQeSk245tCO4dZypN2GysGFwXLwY8rkSHUlnMb6Al1q0Bqmw/1tW6a4lU/EoM66Chogh
         UBGKxjnioO8iphCsDERCFUX71yPGzUbCIRvHcjJLNZ7B1VIDB3isG/nIocPtd9HpS/qT
         QaPo/6WhvhssIqzWZkPaukVcYdbWPv0QgisGdcb68GV1fgvDiiulrvDme6A48hP+cNO6
         BwLA==
X-Received: by 10.50.103.97 with SMTP id fv1mr2850771igb.27.1431384384308;
        Mon, 11 May 2015 15:46:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id fm3sm65505igb.1.2015.05.11.15.46.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 15:46:23 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268828>

A maintenance release Git v2.3.8 is now available at the usual
places.  This release contains fix for "git commit --date=now",
among other things.  It will be the last for 2.3.x series for now.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.3.8'
tag and some of them also have the 'maint-2.3' branch that the tag
points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.3.8 Release Notes
========================

Fixes since v2.3.7
------------------

 * The usual "git diff" when seeing a file turning into a directory
   showed a patchset to remove the file and create all files in the
   directory, but "git diff --no-index" simply refused to work.  Also,
   when asked to compare a file and a directory, imitate POSIX "diff"
   and compare the file with the file with the same name in the
   directory, instead of refusing to run.

 * The default $HOME/.gitconfig file created upon "git config --global"
   that edits it had incorrectly spelled user.name and user.email
   entries in it.

 * "git commit --date=now" or anything that relies on approxidate lost
   the daylight-saving-time offset.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.3.7 are as follows:

Junio C Hamano (5):
      diff-no-index: DWIM "diff D F" into "diff D/F F"
      diff-no-index: align D/F handling with that of normal Git
      parse_date_basic(): return early when given a bogus timestamp
      parse_date_basic(): let the system handle DST conversion
      Git 2.3.8

Matthieu Moy (2):
      Documentation: change -L:<regex> to -L:<funcname>
      log -L: improve error message on malformed argument

Ossi Herrala (1):
      config: fix settings in default_user_config template
