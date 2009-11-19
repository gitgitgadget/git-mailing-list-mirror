From: david.hagood@gmail.com
Subject: git-cvsserver and (edit|watch) support?
Date: Thu, 19 Nov 2009 11:31:16 -0600
Message-ID: <9a0b317cca5a31a03637335354bfd3ef.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 18:31:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBAqx-00079F-EA
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 18:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbZKSRbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 12:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbZKSRbQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 12:31:16 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45477 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbZKSRbP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 12:31:15 -0500
Received: by bwz27 with SMTP id 27so2596632bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 09:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:message-id
         :date:subject:from:to:user-agent:mime-version:content-type
         :content-transfer-encoding:x-priority:importance;
        bh=IR5pAUgaxosP48JQf/Dg+GJ8QzsKC90YP2PhE7BarL0=;
        b=mVYVsImmemRjzofmCE1MhvGkHFr6gr9aBKIss2pGQdg6UY08v0P+683MOXUFeyYLN5
         fRjbAeS96QYogjSxABBVvYMPQLp29Rg0fA4Eb6wxHD/mCv2mIDeIAWAU3b3JuJnUS7fJ
         63qkf77EE4T0dXMJd/KOHEuV+Hk58hVkW9g1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:subject:from:to:user-agent:mime-version
         :content-type:content-transfer-encoding:x-priority:importance;
        b=koeC1wB4rOQNp+GF8RX34lckmN10x5owUe3j5hX9dDjpssDhBnfe4txx7bx3Zh6d55
         UgJE9Sp+HSQRhiDIaFHxTsVhHXVZ/p1y58/+n9CvUc0dVwX7BCBFEVf7F5DW2XhsVl12
         vcyJSFxkS1/6DQxmpByQuk6IVPN8iw/UNX4l4=
Received: by 10.204.32.201 with SMTP id e9mr268861bkd.122.1258651880628;
        Thu, 19 Nov 2009 09:31:20 -0800 (PST)
Received: from Deathwish.hagood.sktc.net (7206-2.clr.64.71.120.40.clradsl.sktc.net [64.71.120.40])
        by mx.google.com with ESMTPS id 13sm208565bwz.2.2009.11.19.09.31.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 09:31:20 -0800 (PST)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 82319C7B8073
	for <git@vger.kernel.org>; Thu, 19 Nov 2009 11:31:16 -0600 (CST)
Received: from deathwish ([127.0.0.1])
        (SquirrelMail authenticated user wowbaggr)
        by localhost with HTTP;
        Thu, 19 Nov 2009 11:31:16 -0600
User-Agent: SquirrelMail/1.4.19
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133237>

I have an application that, unfortunately, is both closed source and does
not support GIT natively. However, it DOES support CVS. It also makes
heavy use of CVS's locking features (watch/edit).

git-cvsserver (or at least the version I have, 1.5.6.5), does not seem to
support "cvs watch" or "cvs edit".

Attempting to do a "cvs watch" results in:

cvs watch on *xml
server doesn't support gzip-file-contents
Unknown command watch-on at /usr/bin/git-cvsserver line 198, <STDIN> line 49.
cvs [watch aborted]: end of file from server (consult above messages if any)

Likewise:
cvs edit *xml
server doesn't support gzip-file-contents
Unknown command Notify 7200.xml at /usr/bin/git-cvsserver line 198,
<STDIN> line 6.
cvs [edit aborted]: end of file from server (consult above messages if any)


Are there any plans on supporting these functions?
