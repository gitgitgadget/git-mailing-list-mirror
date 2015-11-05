From: "Lyle Ziegelmiller" <lyle_z@hotmail.com>
Subject: race condition when pushing
Date: Thu, 5 Nov 2015 08:11:13 -0800
Message-ID: <SNT153-DS223275FC4D60A266EE7E28F6290@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "git bug report" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 05 17:19:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuNFb-0006jX-Fg
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 17:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162230AbbKEQSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 11:18:55 -0500
Received: from snt004-omc3s48.hotmail.com ([65.54.51.85]:56255 "EHLO
	SNT004-OMC3S48.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161720AbbKEQSx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2015 11:18:53 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2015 11:18:53 EST
Received: from SNT153-DS22 ([65.55.90.135]) by SNT004-OMC3S48.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Thu, 5 Nov 2015 08:10:53 -0800
X-TMN: [HlvqHa07McXFqjS0Dy6AW8L/kIxgdHIV]
X-Originating-Email: [lyle_z@hotmail.com]
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3528.331
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3528.331
X-OriginalArrivalTime: 05 Nov 2015 16:10:53.0994 (UTC) FILETIME=[8C0A90A0:01D117E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280922>

Hi

git push --set-upstream  has some sort of race condition. Some times when I 
execute it, it works. Other times, it does not. Below is from my command 
window. I've executed the exact same command (using bash history 
re-execution, so I know I didn't make a typo), repeatedly. Notice the last 
execution results in an error. I am the only person on my machine. This is 
non-deterministic behavior.

lylez@LJZ-DELLPC ~/gittest/local
$ git push --set-upstream origin localbranch1
Branch localbranch1 set up to track remote branch localbranch1 from origin.
Everything up-to-date

lylez@LJZ-DELLPC ~/gittest/local
$ git push --set-upstream origin localbranch1
Branch localbranch1 set up to track remote branch localbranch1 from origin.
Everything up-to-date

lylez@LJZ-DELLPC ~/gittest/local
$ git push --set-upstream origin localbranch1
error: could not commit config file .git/config
Branch localbranch1 set up to track remote branch localbranch1 from origin.
Everything up-to-date

I'm using Git in a Cygwin window on a 32-bit Windows 10 machine. Others have 
experienced this as well: 
http://stackoverflow.com/questions/18761284/git-error-could-not-commit-config-file

lylez@LJZ-DELLPC ~/gittest/local
$ git --version
git version 2.5.1


Regards,

Lyle Ziegelmiller
