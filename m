From: stephen_leake@stephe-leake.org
Subject: aborted 'git fetch' leaves workspace unusable
Date: Mon, 30 Dec 2013 10:07:55 -0700
Message-ID: <7adcf8024c435b9b7178b86f01e447bb@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 18:14:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxgQO-0007YW-Ky
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 18:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab3L3ROl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 12:14:41 -0500
Received: from alt-proxy17.mail.unifiedlayer.com ([66.147.241.60]:43495 "HELO
	alt-proxy17.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756051Ab3L3ROk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Dec 2013 12:14:40 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Dec 2013 12:14:40 EST
Received: (qmail 28833 invoked by uid 0); 30 Dec 2013 17:07:57 -0000
Received: from unknown (HELO host114.hostmonster.com) (74.220.207.114)
  by oproxy6.mail.unifiedlayer.com with SMTP; 30 Dec 2013 17:07:57 -0000
Received: from localhost ([127.0.0.1]:36785 helo=host114.hostmonster.com)
	by host114.hostmonster.com with esmtpa (Exim 4.80)
	(envelope-from <stephen_leake@stephe-leake.org>)
	id 1VxgJp-0003av-H4
	for git@vger.kernel.org; Mon, 30 Dec 2013 10:07:57 -0700
X-Sender: stephen_leake@stephe-leake.org
User-Agent: Roundcube Webmail/0.8.5
X-Identified-User: {2442:host114.hostmonster.com:stephele:stephe-leake.org} {sentby:smtp auth 127.0.0.1 authed with stephen_leake@stephe-leake.org}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239809>

I forgot to do 'ssh-add', so a 'git fetch' running under Windows Emacs
tried to prompt for the ssh passphrase, could not find an ssh 
passphrase
prompt program, and aborted.

That left the workspace unusable:

- .git/FETCH_HEAD is empty

     that causes 'git rev-parse FETCH_HEAD' to fail with a confusing
     error message.

- 'git fetch' just hangs after outputting:

remote: Counting objects: 15, done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 9 (delta 5), reused 0 (delta 0)

     even with -v --progress

A fresh clone allowed me to continue working, but this will happen
again, so I'd like a better fix.

The fetch is from stephen_leake@git.savannah.gnu.org/emacs/elpa.git

I'm running git 1.7.9 from Cygwin. I have access to Debian, where I can
compile git and run it under the debugger, if that helps. I have not 
yet
tried to reproduce this bug on Debian.

--
-- Stephe
