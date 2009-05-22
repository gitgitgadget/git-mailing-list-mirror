From: Renato Botelho <rbgarga@gmail.com>
Subject: Ignoring svn custom id lines on merge
Date: Fri, 22 May 2009 17:30:27 -0300
Message-ID: <747dc8f30905221330r691dc58cwf21a0070e9652aaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 22:38:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7bVg-0007V7-NX
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 22:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378AbZEVUiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 16:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757139AbZEVUiX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 16:38:23 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:23302 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756952AbZEVUiX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 16:38:23 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1378749qwd.37
        for <git@vger.kernel.org>; Fri, 22 May 2009 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=hnZzcYk0ugJBy7lkj0lR5e8nNqjif0aRM1PUwfV2RAI=;
        b=SEWJfDfTO36Q6PnPg7urh6qiW6kYKSH/fh2xmaB5fR/oW7m9k3NPX9+oiPIocNEOy+
         Nz6S3mtKprY4hKHVQDvWnC4iDmzi7CweISwcGGyK5AswU1dMyCVPk2zdT57biItTS+Wy
         yxowNynoKqg+IcFSPiVwjTHFtGjPKZ67IHYFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=ZhwEOk3wPHjEQeCN/uPk/kyROsCQHrIC1xIivb/YoY3RMN9ft0EMJH4SB0XSY/sdLd
         Gs6TSbK6NkFUUi+t0sUM2kYBVoEQI0D/gp2hiMQ4ieAwUw+FlsToN0UBh3aGNDfF/d8e
         cDQNInp/GLhr4B0IzE9IDCFqeqyE7D6MnJSew=
Received: by 10.220.72.194 with SMTP id n2mr4698824vcj.52.1243024247850; Fri, 
	22 May 2009 13:30:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119750>

Hello,

I'm starting tests to move from cvs to git, and i got just one
problem on all my tests.

We maintain a custom copy of FreeBSD sources, so, on
cvs we did follow when new FreeBSD version is released:

1. Import new freebsd src as a vendor branch
2. Merge changes on HEAD

I tried to do the same with git, and it worked, but since
almost all FreeBSD files has a custom Id like this:

$FreeBSD: release/7.0.0/COPYRIGHT 175036 2008-01-01 09:36:30Z imp $

These lines always change, because the place they stay
on svn repository (release/7.0.0, 7.1.0, 7.2.0) and git
generated a lot of conflicts to fix manually.

I would like to know if there is a way to configure git to
just ignore diffs on these lines and use the new one without
ask.

I can do it with diff command ignoring those lines, like this:

diff -q -I'[$]FreeBSD:.*$'

Thank you in advance
-- 
Renato Botelho
