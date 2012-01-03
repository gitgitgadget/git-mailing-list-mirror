From: Kevin <ikke@ikke.info>
Subject: rebase -i does not use a commit it should
Date: Tue, 3 Jan 2012 15:00:28 +0100
Message-ID: <CAO54GHB1uwJdjj0=dCVp_M4sAFtqooM9hnBSNurje2n+-dGDEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 15:00:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri4v8-00075j-UU
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 15:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab2ACOAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 09:00:51 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56358 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab2ACOAu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 09:00:50 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm6so9101134wib.19
        for <git@vger.kernel.org>; Tue, 03 Jan 2012 06:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=q4WuaVmzyXarvJVWavwKbbj0e9eqMnw956IbsbDZnIc=;
        b=FPsIEP6hxJvdrgu8HLYz7deOMkWqUHL+9GMjEocFvEXtaZXltx/vCNpx7JKqCNfO7y
         6oZDeBcpciufeUn4zjQTLytwV7prdjbZvMBmWIKlL6tlf1Afm3r8mCQBbCdjC/ReHkKi
         7wJ2fdFuPl+X18O+zIpKicJUMfOBFtUHrSXXs=
Received: by 10.181.13.162 with SMTP id ez2mr114427168wid.17.1325599249345;
 Tue, 03 Jan 2012 06:00:49 -0800 (PST)
Received: by 10.227.57.84 with HTTP; Tue, 3 Jan 2012 06:00:28 -0800 (PST)
X-Google-Sender-Auth: mq6XfhSdYxgg3fOGjWvChU9_7G0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187863>

I tried to rebase some commits, when I found out it didn't pick all
commits it should.

A distiled situation is this:

A (issues/links_footer)
B (issues/links-footer)
C
|  D (master)
|  |
|  |
|  |
|  |
| /
*

Here is the output of git log --graph --oneline --format="%h %d" master HEAD
http://paste.pocoo.org/show/529305/

And this is the output of git log --oneline --format="%h" master..

7fb46fd
6efa164
50b5950

When I do git rebase -i master, it only shows the top 2 commits, but
if I do git rebase -i 50b5950^, it does show all three committs.

Anyone knows whats going wrong?
