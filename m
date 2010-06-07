From: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Subject: [PATCH v2 0/3] textconv support for blame
Date: Mon,  7 Jun 2010 16:41:50 +0200
Message-ID: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 07 16:42:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLdWj-00048G-Db
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 16:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab0FGOl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 10:41:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50512 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788Ab0FGOl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 10:41:59 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o57EYGho014779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 7 Jun 2010 16:34:16 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o57EftP0015611;
	Mon, 7 Jun 2010 16:41:55 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o57Eftxm009196;
	Mon, 7 Jun 2010 16:41:55 +0200
Received: (from bonneta@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o57Eftwj009195;
	Mon, 7 Jun 2010 16:41:55 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
Content-Transfert-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Jun 2010 16:34:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o57EYGho014779
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: axel.bonnet@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148601>

This is a patch series to implement textconv support for git blame.
As textconv support has already been added to git diff, so we use textconv methods of diff.
Here are the different changes:
- make the diff textconv API public
- add diff_options to blame (--textconv and --no-textconv)
- perform textconv when we meet an object with textconv driver
- t8006-blame-textconv.sh tests conversion works

Axel Bonnet (3):
  textconv: make the API public
  textconv: support for blame
  t/t8006: test textconv support for blame

 builtin/blame.c           |   82 +++++++++++++++++++++++++++++++++++++--------
 diff.c                    |   12 ++----
 diff.h                    |    8 ++++
 t/t8006-blame-textconv.sh |   80 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 22 deletions(-)
 create mode 100755 t/t8006-blame-textconv.sh
