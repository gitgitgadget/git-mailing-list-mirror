From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Quickly searching for a note
Date: Fri, 21 Sep 2012 08:41:04 -0600
Message-ID: <505C7C80.3000700@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 16:47:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF4WM-0002je-MI
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 16:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab2IUOru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 10:47:50 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:34915 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552Ab2IUOrt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 10:47:49 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2012 10:47:49 EDT
Received: (qmail 13675 invoked by uid 399); 21 Sep 2012 08:40:37 -0600
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@67.182.221.164)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Sep 2012 08:40:37 -0600
X-Originating-IP: 67.182.221.164
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
X-Antivirus: avast! (VPS 120921-0, 09/21/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206125>

Background: To tie Perforce changelists to Git commits, I add a note to 
a commit with the form "P4@123456".  Later, I use the note to sync down 
the closest Perforce changelist matching the Git commit.

I search for these notes by getting a list of revisions:

         git rev-list --max-count=1000

I iterate those revisions and run git show and grep on each:

         git show -s --format=%N%n%s --show-notes=p4notes COMMIT

For short runs, this isn't so bad.  For longer runs of commits (I just 
walked through approximately 100), it takes a long time. Running 'git 
show' is costing me about 7/10 of second, presumably because I am on 
Windows.

Is there a faster way to do this?

Thanks.

Josh
