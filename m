From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: git-svn detects some merges incorrectly from svn:mergeinfo
Date: Mon, 22 Feb 2010 09:57:19 +0200
Message-ID: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com>
Cc: Tuomas Suutari <tuomas.suutari@gmail.com>,
	Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 10:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjTB7-00050C-CY
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 08:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab0BVH54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 02:57:56 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:44130 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab0BVH5z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 02:57:55 -0500
Received: by fxm19 with SMTP id 19so2147720fxm.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 23:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=upO25b/FBxa2AdcX9aj+HHIIj62adBTCW7l7pwS6VpE=;
        b=PN7Q23K+CsT94DFl2ep7DdKmS6lRBZKIIX/+R63uh5iHaxT0/eTeZZGoPevWOj1mVx
         YmzT3nw/m81KE/Kbx+LqWLkb1KB/+OCfJ71NI7ESFNmNfK6dgEOaXQ1Ouhb4k1NhYJRl
         NceZ7O+fkCo8AmusSebnPvfUDlkBCelWKEcN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PUz51WxYTxqJljFW58NANBe8ROjwjZx+LCsDGGNi7MuPzwHg9J8kVhK/5Ron2eljYW
         huCbkYVPn6S1JHZacMEx93kdSQBHPLSQo+NCA5hqVo5fHvgePmcexJQwTXU8x/8+Nkxg
         jJdZODDZIdH9FSxQtknhLIoXbUYYxhOvbuUD0=
Received: by 10.87.9.39 with SMTP id m39mr1857695fgi.73.1266825474491;
        Sun, 21 Feb 2010 23:57:54 -0800 (PST)
Received: from localhost.localdomain (ws-26-184.laitilanpuhelin.fi [188.123.26.184])
        by mx.google.com with ESMTPS id e3sm4952313fga.16.2010.02.21.23.57.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 23:57:54 -0800 (PST)
X-Mailer: git-send-email 1.7.0.86.g7501
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140648>

Hi,

Now that git-svn detects merges from svn:mergeinfo, I thought it's
time to re-import some of my SVN repos with git-svn. Detecting of the
merges worked mostly well, but when inspecting the imported history
with gitk, I found some incorrectly detected merges.

This patch series adds a test case and a fix for the case.

I was a bit uncertain if the fix should go to parents_exclude function
or to "cater for merges which merge commits from multiple branches"
section of find_extra_svn_parents function. I chose the latter and at
least it does the trick.

-- 
Tuomas
