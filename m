From: gima@iki.fi
Subject: http-backend GIT_COMMITTER_NAME & -EMAIL documentation bug
Date: Sat, 10 Nov 2012 17:26:19 +0200
Message-ID: <509E721B.8070700@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 16:26:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXCxE-00020O-F2
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 16:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab2KJP0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 10:26:23 -0500
Received: from mail.kapsi.fi ([217.30.184.167]:39476 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab2KJP0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 10:26:22 -0500
Received: from kapsi.fi ([217.30.184.161] helo=[127.0.0.1])
	by mail.kapsi.fi with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <gima@iki.fi>)
	id 1TXCwt-0005xA-Ez
	for git@vger.kernel.org; Sat, 10 Nov 2012 17:26:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
X-SA-Exim-Connect-IP: 217.30.184.161
X-SA-Exim-Mail-From: gima@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209280>

Documentation says that envvars GIT_COMMITTER_NAME and 
GIT_COMMITTER_EMAIL formed from REMOTE_USER and REMOTE_ADDR, but doesn't 
mention that they are left alone if they have been set already.
Referring to: 
https://github.com/git/git/blob/master/Documentation/git-http-backend.txt#L178

Source code says that they are set conditionally (referring to this part 
of the source):
https://github.com/git/git/blob/master/http-backend.c#L335

And the (most recent) commit pertaining to this behavior explains the 
change:
https://github.com/git/git/commit/e32a4581bcbf1cf43cd5069a0d19df07542d612a

I'm also for the possibility of custom implementations assigning those 
envvars, so could the documentation be changed to reflect that?
