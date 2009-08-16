From: Thomas Schlichter <thomas.schlichter@web.de>
Subject: git http-push and MKCOL error (22/409)
Date: Sun, 16 Aug 2009 15:57:26 +0200
Message-ID: <200908161557.26962.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 15:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McgEy-0005Bq-RS
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 15:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbZHPN52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 09:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbZHPN52
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 09:57:28 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46604 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbZHPN51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 09:57:27 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1ED87113227B4;
	Sun, 16 Aug 2009 15:57:28 +0200 (CEST)
Received: from [92.207.103.184] (helo=netbook.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1McgEh-0003zp-00; Sun, 16 Aug 2009 15:57:27 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.28-14-generic; KDE/4.3.0; i686; ; )
X-Sender: thomas.schlichter@web.de
X-Provags-ID: V01U2FsdGVkX1+lMZ6nlZNEQU0zbkntp0dUMejCp01wnIzYPMzI
	H/T3dkLaewht7Rhk1Cj5fghh27OrIwSFMvlwprMkwWs8hRAEdO
	m2zJd7rIChkWt9Iqs4YQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126061>

Hello,

I was using git version 1.6.4 and a remote WebDAV repository. But 
unfortunately, git-http-push always returns following error:

schlicht@netbook:~/dummy$ git push
Fetching remote heads...
  refs
  refs/heads
  refs/tags
  refs/heads
  refs/tags
updating 'refs/heads/master'
  from 980385b1032efc0db665dff3ad54068f762af9aa
  to   98fd7fb8f32843c1bb40bd195a2f1cd6cab0751d
    sending 1 objects
MKCOL 98fd7fb8f32843c1bb40bd195a2f1cd6cab0751d failed, aborting (22/409)
Updating remote server info
error: failed to push some refs to 
'https://webdav.smartdrive.web.de/dummy.git'

Current "master" and "next" trees also have this problem. But as git version 
1.6.4 does not have this problem, I was able to bisect it down to commit:

   5424bc557fc6414660830b470dd45774b8f5f281
   http*: add helper methods for fetching objects (loose)

I can always reproduce this problem, so I am willing to test patches to fix 
this regression.

Kind regards,
Thomas Schlichter
