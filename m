From: Thomas Schlichter <thomas.schlichter@web.de>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Sun, 16 Aug 2009 16:52:37 +0200
Message-ID: <200908161652.37282.thomas.schlichter@web.de>
References: <200908161557.26962.thomas.schlichter@web.de> <be6fef0d0908160727r7dfa9b46l4d493e3954c21de3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 16:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mch6N-0007zr-HZ
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 16:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbZHPOwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 10:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbZHPOwj
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 10:52:39 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:47702 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbZHPOwi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 10:52:38 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 1D65910D70A8B;
	Sun, 16 Aug 2009 16:52:39 +0200 (CEST)
Received: from [92.207.103.184] (helo=netbook.localnet)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1Mch65-00022M-00; Sun, 16 Aug 2009 16:52:37 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.28-14-generic; KDE/4.3.0; i686; ; )
In-Reply-To: <be6fef0d0908160727r7dfa9b46l4d493e3954c21de3@mail.gmail.com>
X-Sender: thomas.schlichter@web.de
X-Provags-ID: V01U2FsdGVkX1/qMyFPAWT+DCB6lfBsHJwsYJ2/Q2qD2DSe+nQN
	iRqoluOv2ii0D6GuFmGp0++Bd+9Em0tLqY/PRJSTsu/L91T3By
	QstLXPLkB+lZ7Hde2/Aw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126063>

Hi,
Am Sonntag 16 August 2009 16:27:40 schrieb Tay Ray Chuan:
> Interesting. Please do provide:
>
>  -steps to reproduce,
>  -your server's access log.

Unfortunately I cannot provide the server's access log. It is a server 
provided by the German E-Mail provider web.de. It allows to save files via a 
web-interface and via WebDAV.

Steps to reproduce:
  1. locally set up a git archive:
     mkdir dummy.git
     cd dummy.git
     git init --bare
  2. Upload this directory to the server.
     I did do this using KDE's dolphin via WebDAV.
  3. Clone this remote repository:
     git clone https://webdav.smartdrive.web.de/dummy.git my_dummy
  4. Create a local commit:
     cd my_dummy
     touch dummy.c
     git commit -a
  5. Push this commit up to the remote repository:
     git push origin master

The last step fails es explained. During bisecting git I was able to commit 
several changes with versions before commit 
5424bc557fc6414660830b470dd45774b8f5f281.

Kind regards,
Thomas Schlichter

P.S.: Maybe it is important that the server uses the secure https protocol, 
therefore I set my username and password combination in my local ~/.netrc 
file.
