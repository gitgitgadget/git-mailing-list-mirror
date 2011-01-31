From: Joe Corneli <holtzermann17@gmail.com>
Subject: git2svn path intelligence lacking, and no error correction
Date: Mon, 31 Jan 2011 02:57:51 +0000
Message-ID: <AANLkTinark6-FdSc=4rB=Q6OY-ZX_2AjaT1EttWqX0pj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Jan 31 03:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjjxk-00060h-Qa
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 03:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab1AaC5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 21:57:52 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36234 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab1AaC5v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 21:57:51 -0500
Received: by iwn9 with SMTP id 9so4958756iwn.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 18:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:cc
         :content-type;
        bh=ybLjS2GprTV9KhSQzK04s2jkP7/7td4GfLXKO4w+qRs=;
        b=OZtZ3sB8HZXrFLhxMiXcWqB2KXfs18uwFvS1vSmnuk1sxrppOecmKzU8jKOTUiYuOm
         B4hZ3+9T8qQQNpRr7TXr5LfQ4GxiC81U2bgP03AqWpOhr5/HkEY8Si4L2u8RsdMDftFQ
         IPTOxGAUdrxB9aKBcbnmFmMoxyjENEIg8nRqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:cc:content-type;
        b=ww76n35dMZZE4sCgbSpLjdW6be7Ba7dnklKbMVCkHD/B9fYeqCOfOPAwWdkPLhBx6r
         KW2qlBfHVNtFPIBhJB/tuYu2vWktECMaJN6E8WiA0gI3lN9tseinEqz1iTpkhraX7WL7
         yY7ffCd+SjvOwWKLwuaUtuoQz1BCXZtEsyORE=
Received: by 10.231.15.133 with SMTP id k5mr5840498iba.187.1296442671233; Sun,
 30 Jan 2011 18:57:51 -0800 (PST)
Received: by 10.231.145.1 with HTTP; Sun, 30 Jan 2011 18:57:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165717>

Trying to create an svn repo by specifying the full path fails, but
git2svn keeps running and only fails later.

./git2svn/git2svn --verbose --verbose --keep-logs
document-conversions/destination/
/home/planetary/public_html/pmhistory.svn
syncname tag: git2svn-syncpoint-master
svnadmin: Repository creation failed
svnadmin: Could not create top-level directory
svnadmin: Can't create directory
'home/planetary/public_html/pmhistory.svn': No such file or directory
svn: Unable to open an ra_local session to URL
svn: Unable to open repository
'file:///home/planetary/home/planetary/public_html/pmhistory.svn'
svn: Unable to open an ra_local session to URL
svn: Unable to open repository
'file:///home/planetary/home/planetary/public_html/pmhistory.svn'
git fast-export master (74f3415a58b60ea984004b66301f85bb1d7a5ba2)
creating svn dump from revision 1...
...dumped to revision 53128
(re-)setting sync-tag to new master
loading dump into svn
svnadmin load at ./git2svn/git2svn line 461.
