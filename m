From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/12] Bash completion rework
Date: Sun,  8 Apr 2012 06:07:47 +0300
Message-ID: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:08:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiUn-00077H-OR
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657Ab2DHDIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:19 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54731 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab2DHDIT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 23:08:19 -0400
Received: by lbbgg6 with SMTP id gg6so1342002lbb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=9GjC1Ou4HfQ1cyudPyHGrekSkBlMK1k8uyBp20Xn5I4=;
        b=SGUu2vUTQMEnUMvAJxQC0Rm/kXQxFE7IevH66wAy+oEPp5vZT2WZzZHn7BG3NDM9jr
         fqRYX8Wf39RilJ07VmYBm/RpGz+4A+OQCGBbUdfpkq1rhoo3qKYNIHg+dCY1UJnDMRVW
         wsBezK5XEcgSDEIGETIX9wqq+9f7tNTBU3bgvYV13te/8S/R7LcmVBK5ZVBaP2vt0thv
         zCUlSF2MOMvakS1WlbLDHqIhEsLvy3U6K/RWcB9tj3keCxFLNmxrzheHhsOHepTWvAiJ
         F9jo292wvIWEoQFYRe+BkTtJ/KE4kP7bTcsUxbz3RmxtQSWrgnXvVx5E0ex6vCdAyJxx
         0AGQ==
Received: by 10.152.146.67 with SMTP id ta3mr4723228lab.25.1333854496175;
        Sat, 07 Apr 2012 20:08:16 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id mm11sm11399614lab.2.2012.04.07.20.08.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194958>

Hi,

Here's a bunch of patches for bash completion. First of all some tests are
added to verify that there are no regressions, then simple cleanups, then some
fixes, and finally support for external aliases.

So now you can do something like 'git_complete gf git_fetch' and it would just work :)

Cheers.

Felipe Contreras (12):
  tests: add initial bash completion tests
  completion: simplify __gitcomp
  completion: simplify __gitcomp_1
  completion: trivial simplification
  completion: add missing global options
  tests: add more bash completion tests
  completion: simplify command stuff
  completion: simplify _git_bundle
  completion: calculate argument position properly
  completion: add new git_complete helper
  test: add tests for aliases in bash completion
  completion: rename _git and _gitk

 contrib/completion/git-completion.bash |  153 +++++++++-------
 t/t9902-completion.sh                  |  314 ++++++++++++++++++++++++++++++++
 2 files changed, 398 insertions(+), 69 deletions(-)
 create mode 100755 t/t9902-completion.sh

-- 
1.7.10.3.g5a738d
