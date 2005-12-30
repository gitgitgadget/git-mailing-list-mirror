From: Matt Draisey <matt@draisey.ca>
Subject: local git push bug wrt GIT_OBJECT_DIRECTORY
Date: Fri, 30 Dec 2005 01:08:20 -0500
Message-ID: <1135922900.2103.37.camel@della.draisey.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 30 07:13:43 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsDWI-0001Gh-2L
	for gcvg-git@gmane.org; Fri, 30 Dec 2005 07:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVL3GNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 01:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVL3GNc
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 01:13:32 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:62878 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751174AbVL3GNc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2005 01:13:32 -0500
Received: from [192.168.2.3] ([67.70.2.178]) by tomts10-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20051230061328.GQKS14963.tomts10-srv.bellnexxia.net@[192.168.2.3]>
          for <git@vger.kernel.org>; Fri, 30 Dec 2005 01:13:28 -0500
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 
X-Originating-IP: [0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14110>

Using git-send-pack to push to a local repository will propagate the
environment variable GIT_OBJECT_DIRECTORY to git-receive-pack.
git-receive-pack correctly ignores GIT_DIR (as opposed to what the
documentation says) but, unfortunately, honours GIT_OBJECT_DIRECTORY.

It's not clear to me whether the correct behaviour is for git-send-pack
to clean up its environment before it execs or for git-receive-pack to
ignore most GIT variables.

Interposing a short script with env -i or env -uGIT_OBJECT_DIRECTORY is
the easiest workaround.
