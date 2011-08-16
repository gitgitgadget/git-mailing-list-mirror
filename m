From: "Vadim K." <klug@hot.ee>
Subject: GIT commit strategy
Date: Tue, 16 Aug 2011 19:17:31 +0300
Message-ID: <C0B80A98F4E14FA287D3BAFA8366BEAC@procyon>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 16 18:26:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtMSy-0006Ew-Oh
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 18:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab1HPQ0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 12:26:04 -0400
Received: from bounce-out.neti.ee ([194.126.101.104]:49659 "EHLO
	bounce-out.neti.ee" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab1HPQ0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 12:26:03 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Aug 2011 12:26:03 EDT
Received: from smtp-out.neti.ee (vm-relay2.estpak.ee [88.196.174.133])
	by Bounce1.estpak.ee (Postfix) with ESMTP id BA327500A43
	for <git@vger.kernel.org>; Tue, 16 Aug 2011 19:17:41 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by vm-relay2.estpak.ee (Postfix) with ESMTP id 6233F155
	for <git@vger.kernel.org>; Tue, 16 Aug 2011 19:17:37 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at vm-relay2.estpak.ee
Received: from smtp-out.neti.ee ([127.0.0.1])
	by localhost (vm-relay2.estpak.ee [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-qYUNFwnK96 for <git@vger.kernel.org>;
	Tue, 16 Aug 2011 19:17:34 +0300 (EEST)
Received: from HOT-Relayhost3.estpak.ee (hot-relayhost3.estpak.ee [88.196.174.147])
	by vm-relay2.estpak.ee (Postfix) with ESMTP id A286316F
	for <git@vger.kernel.org>; Tue, 16 Aug 2011 19:17:34 +0300 (EEST)
X-SMTP-Auth-NETI-Businessmail: no
Received: from procyon (11.235.196.88.dyn.estpak.ee [88.196.235.11])
	by HOT-Relayhost3.estpak.ee (Postfix) with SMTP id A3B90635
	for <git@vger.kernel.org>; Tue, 16 Aug 2011 19:17:34 +0300 (EEST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179456>

Hello all,

    Imagine developer A has changed files f1 and f2, then made commit and 
push to the server
    Developer B has changed files f2 and f3 and made local commit.

    Next B wants to publish changes to the server and make pull to resolve 
conflicts at f2.  After pulling from the server it has all 3 files - f1, f2 
and f3 to commit before push. But B did not changed f1 and actually can 
"ban" this change if he commits only f2 and f3 - files that were changed by 
him. In latter case after pushing to the server GIT will restore previous 
version of the f1, even if it has more recent one !! It does not seem to be 
very logical.

    Question: is it possible to show to the developer only files, that he 
changes? Like in SVN - after updating from the server developer must resolve 
conflicts (if any) and only commits changes that he has made. By the way - 
in a case of non-conflicting files (let me say A changes f1, B changes f2) 
GIT makes commit automatically and does not show to the B, that f1 was 
changed and need to be re-commited. B only need to push the change back.

Thank you,

Vadim. 
