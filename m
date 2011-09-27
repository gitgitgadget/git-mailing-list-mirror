From: Luke Diamand <luke@diamand.org>
Subject: [RFC/PATCHv2] git-p4: handle files with shell metacharacters
Date: Tue, 27 Sep 2011 09:40:35 +0100
Message-ID: <1317112836-14135-1-git-send-email-luke@diamand.org>
References: <20110926214758.GB3433@arf.padd.com>
Cc: pw@padd.com, vitor.hda@gmail.com, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 10:40:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8TDi-0000ZZ-Av
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 10:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab1I0Ikt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 04:40:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45433 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab1I0Iks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 04:40:48 -0400
Received: by wyg34 with SMTP id 34so6926766wyg.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 01:40:47 -0700 (PDT)
Received: by 10.227.20.6 with SMTP id d6mr8445961wbb.49.1317112847186;
        Tue, 27 Sep 2011 01:40:47 -0700 (PDT)
Received: from localhost.localdomain (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id fy13sm7253961wbb.18.2011.09.27.01.40.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Sep 2011 01:40:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g4db0d
In-Reply-To: <20110926214758.GB3433@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182220>

Updated git-p4 changes incorporating Pete's comments.

 - p4CmdList's stdin argument can now be a list.

 - Getting rid of the string option entirely is very hard; there are
   places where currently git-p4 creates a pipeline.

 - I wonder if verbose should actually be enabled for all the test
   cases?

 - The $ENV{PWD} is needed now because the shell used to set that; now
   that the shell isn't in use git-p4 has to set it.

Pete - I wasn't sure whether you were saying I should rework
my patch against next (and you would then rework your series) or
something else. That sounds complicated though - let me know!

Thanks!
Luke

Luke Diamand (1):
  git-p4: handle files with shell metacharacters

 contrib/fast-import/git-p4     |  200 ++++++++++++++++++++++++---------------
 t/t9803-git-shell-metachars.sh |   70 ++++++++++++++
 2 files changed, 193 insertions(+), 77 deletions(-)
 create mode 100755 t/t9803-git-shell-metachars.sh

-- 
1.7.6.347.g4db0d
