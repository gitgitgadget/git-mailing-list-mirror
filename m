From: "Chris Hart" <chris@christopherhart.ca>
Subject: SSL + mod_dav + Git
Date: Tue, 29 Jul 2008 07:53:08 -0400
Message-ID: <a7b96a640807290453l582c3f11w6a0f0c841063f07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 13:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNnmO-0004gu-T1
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 13:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343AbYG2LxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 07:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756213AbYG2LxL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 07:53:11 -0400
Received: from qb-out-0506.google.com ([72.14.204.237]:20961 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186AbYG2LxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 07:53:10 -0400
Received: by qb-out-0506.google.com with SMTP id a16so673399qbd.17
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=04RfT4hALhUG11AFldb0oDlY5+hlA2tpBoqMjtm4t3k=;
        b=JbClcb/LohAS4xu7hWtMXvuOBo6Hk+ap/GSFQTkOONBNG3NowWpl4eR/ISnqaK1j5d
         rYGW8spqChI7TDthJOg/Cy+IictpIwrjf/gBiIDfsqG36edsniSQ94vBNfMYJgEmp+sm
         pky17djodRZMjsbOmeFt/IYml2CnUpHtQkBEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=HgEJqfD2yx0UN44kPg1vv6w7e3jMwHoyYQfHx02XvAHBnoq/Y2zDIH9JiFvv+sx8om
         oyVoI09S2DXOhaIL27hqzhgL27Ai6fOXrPweBValUFhtRzeaKlc+GyNbHiv3DSq6s8aS
         LA5JeOz1yPULiPvlHU77hPu1DH40mOe7xui6M=
Received: by 10.114.170.2 with SMTP id s2mr6375856wae.170.1217332388671;
        Tue, 29 Jul 2008 04:53:08 -0700 (PDT)
Received: by 10.114.176.3 with HTTP; Tue, 29 Jul 2008 04:53:08 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 3c770b2e9377b3ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90618>

Hi guys, I've been up all night on this one and after exhaustive
Googling and checking the sleepy #git, decided to check with the
mailing list! Here's the current problem:

Git is working perfectly over SSH. The server is Ubuntu, and doing
cadaver https://serveraddress/.git successfully authenticates using
the passwd file I provided to Apache. Basically I've done everything
from Rutger's guide
(http://www.kernel.org/pub/software/scm/git/docs/v1.4.4.4/howto/setup-git-server-over-http.txt)
except for the ~/.netrc stuff.

However, once authenticated to the .git folder (cadaver through
https), basic commands give strange errors or 404s. Ls throws "Listing
collection `/.git/': failed:
Could not read status line: Secure connection truncated" and cd
/to/some/legitimate/directory throws "Could not access /.git/dir/ (not
WebDAV-enabled?):
404 Not Found." Oddly tab-completion for cd suggests the contents of
the directory (although I'm cadaver-ing from localhost). Same results
remotely in a browser: authenticates successfully and gives 404s.

Trying git clone https://server/.git throws:

"warning: remote HEAD refers to nonexistent ref, unable to checkout"

...despite the working certificate and authorization. Any ideas?
Thanks infinity and one to anybody with attention for this!

Chris


Note: Apache owns all the files here so I really hope it's not a
permissions thing.

------------------ Git version info --------------------
server> git version 1.5.4.3
remote-laptop> git version 1.5.6.4
------------------------------------------------------------
