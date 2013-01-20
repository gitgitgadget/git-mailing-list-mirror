From: Stephen Kelly <steveire@gmail.com>
Subject: git interactive rebase 'consume' command
Date: Sun, 20 Jan 2013 15:05:18 +0100
Message-ID: <kdgtir$apt$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 20 15:06:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwvX5-00074Y-9e
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 15:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab3ATOFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 09:05:31 -0500
Received: from plane.gmane.org ([80.91.229.3]:57826 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208Ab3ATOFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 09:05:30 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TwvWp-00070E-Uz
	for git@vger.kernel.org; Sun, 20 Jan 2013 15:05:43 +0100
Received: from g231115249.adsl.alicedsl.de ([92.231.115.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 15:05:43 +0100
Received: from steveire by g231115249.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 15:05:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: g231115249.adsl.alicedsl.de
User-Agent: KNode/4.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214019>


Hi there,

I find the fixup command during an interactive rebase useful.

Sometimes when cleaning up a branch, I end up in a situation like this:

 pick 07bc3c9 Good commit.
 pick 1313a5e Commit to fixup into c2f62a3.
 pick c2f62a3 Another commit.


So, I have to reorder the commits, and change 1313a5e to 'f'. An alternative 
would be to squash 's' c2f62a3 into 1313a5e and clean up the commit message. 
The problem with that is it ends up with the wrong author time information.

So, I usually reorder and then fixup, but that can also be problematic if I 
get a conflict during the re-order (which is quite likely).

I would prefer to be able to mark a commit as 'should be consumed', so that:

 pick 07bc3c9 Good commit.
 consume 1313a5e Commit to fixup into c2f62a3.
 pick c2f62a3 Another commit.

will result in 

 pick 07bc3c9 Good commit.
 pick 62a3c2f Another commit.

directly.

Any thoughts on that? 

Thanks,

Steve.
