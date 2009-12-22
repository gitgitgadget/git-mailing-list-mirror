From: =?ISO-8859-1?Q?Florian_K=F6berle?= <florian@fkoeberle.de>
Subject: [BUG REPORT] git-svn fails to create branches if ssh+svn gets used
 as protocol.
Date: Tue, 22 Dec 2009 10:53:52 +0100
Message-ID: <4B309730.5070509@fkoeberle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 11:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN1lA-0003qJ-IP
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 11:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbZLVKO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 05:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbZLVKO2
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 05:14:28 -0500
Received: from wp165.webpack.hosteurope.de ([80.237.132.172]:43085 "EHLO
	wp165.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131AbZLVKO1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 05:14:27 -0500
X-Greylist: delayed 1233 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2009 05:14:27 EST
Received: from p54965148.dip.t-dialin.net ([84.150.81.72] helo=[192.168.1.50]); authenticated
	by wp165.webpack.hosteurope.de running ExIM with esmtpsa (TLSv1:RC4-MD5:128)
	id 1NN1RB-0008QK-J9; Tue, 22 Dec 2009 10:53:53 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Enigmail-Version: 0.96.0
X-bounce-key: webpack.hosteurope.de;florian@fkoeberle.de;1261476867;4431af79;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135577>

Hello

I haven't seen a link to a bug tracker so I am sending this bug report
to the mailing list, I hope it's okay.

If you try to run
$ git svn branch foo
in a project using a svn+ssh url, you get the following error log:

Copying svn+ssh://example.org/svn/project/trunk at r1000 to
svn+ssh://me@example.org/svn/project/branches/foo...
Trying to use an unsupported feature: Source and dest appear not to be
in the same repository (src: 'svn+ssh://example.org/svn/project/trunk';
dst: 'svn+ssh://me@example.org/svn/project/branches/foo') at
/home/florian/libexec/git-core/git-svn line 722

It fails as the username is missing in the source url. If you modify the
git-svn script and add the username it works. The bug can be reproduced
with git-svn version 1.6.5.7 (svn 1.5.1).

Best regards,
Florian
