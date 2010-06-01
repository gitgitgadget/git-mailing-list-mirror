From: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
Subject: Best way to apply textconv to a working tree file
Date: Tue, 01 Jun 2010 15:41:05 +0200
Organization: Ensimag
Message-ID: <a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr>
Reply-To: clement.poulain@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: <diane.gasselin@ensimag.imag.fr>, <axel.bonnet@ensimag.imag.fr>,
	<matthieu.moy@grenoble-inp.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 16:10:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJSAh-0001DL-2Z
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 16:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348Ab0FAOKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 10:10:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33573 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756271Ab0FAOKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 10:10:14 -0400
X-Greylist: delayed 1746 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jun 2010 10:10:14 EDT
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o51DXlUI025350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 Jun 2010 15:33:47 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o51Df571021594;
	Tue, 1 Jun 2010 15:41:05 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o51Df5vZ024748;
	Tue, 1 Jun 2010 15:41:05 +0200
X-Sender: clement.poulain@ensimag.imag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Jun 2010 15:33:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o51DXlUI025350
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
MailScanner-NULL-Check: 1276004027.56152@NTP5rXbe909ya32bDz6BGw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148115>

Hello,

In order to add textconv support to "git-gui blame", we have to run
textconv on a file which is in the working tree.
Currently, "git-gui blame" uses the Tcl function 'open' to display the
content of the working-tree file. This doesn't allow us to run textconv on
it.

We are wondering what is the best way to do the textconv. Here are some
solutions we thought about:

- For revisions, "git-gui blame" is based on "git cat-file blob
<sha1:path>". Therefore, we thought of adding a "--textconv" option on
cat-file as well as a "--working-tree" option ("git cat-file --working-tree
<file>" will display the content of <file> in the working-tree)

- Use the "-p" (pretty print) cat-file's option, with a path beginning by
./ (to avoid ambiguous name like HEAD)

- Create a "git textconv" command, to easily run textconv on any object.

Which way you think is the best?

Thanks for your time and comments.
Regards
