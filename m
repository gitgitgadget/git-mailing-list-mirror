From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [little BUG] pushing to existing branch with remote-helper shows [new branch]
Date: Wed, 31 Aug 2011 18:46:39 +0200
Message-ID: <vpqfwkho7f4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 18:46:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QynwB-0000tm-OX
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab1HaQqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 12:46:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36723 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756808Ab1HaQqq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:46:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p7VGk217012968
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Aug 2011 18:46:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Qynw0-0005KC-3V; Wed, 31 Aug 2011 18:46:40 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 31 Aug 2011 18:46:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7VGk217012968
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315413966.6201@SIJlD7tMYrrevyQzhVqo+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180484>

Hi,

Nothing serious, but I think this is a little bug in transport-helper. I
noticed it working on git-remote-mediawiki, and could reproduce it with
testgit: 

/tmp/clone$ git push
To testgit::/tmp/repo
 * [new branch]      master -> master
/tmp/clone$ date >> foo.txt; git commit -am bar
[master 4438ced] bar
 1 files changed, 1 insertions(+), 0 deletions(-)
/tmp/clone$ git push
To testgit::/tmp/repo
 * [new branch]      master -> master

(/tmp/clone is a clone of testgit::/tmp/repo)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
