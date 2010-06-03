From: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Subject: [RFC/PATCH 0/4] textconv support for blame
Date: Thu,  3 Jun 2010 12:47:14 +0200
Message-ID: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 13:18:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK8Rh-00016h-Uj
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 13:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516Ab0FCLSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 07:18:41 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mx2.imag.fr ([129.88.30.17]:44534 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849Ab0FCLSk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 07:18:40 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o53AfGJL001804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 3 Jun 2010 12:41:16 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o53AmgR3023194;
	Thu, 3 Jun 2010 12:48:42 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o53AmgHt008444;
	Thu, 3 Jun 2010 12:48:42 +0200
Received: (from bonneta@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o53AmgUW008443;
	Thu, 3 Jun 2010 12:48:42 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 03 Jun 2010 12:41:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o53AfGJL001804
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: axel.bonnet@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148310>

This is a patch series to implement textconv support for git blame. As =
textconv support has already been added to git diff, so we use textconv=
 methods of diff.
Here are the different changes:
- make the diff textconv API public
- add diff_options to blame (--textconv and --no-textconv)
- perform textconv when we meet an object with textconv driver
- t8006-blame-textconv.sh tests conversion works

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>

Axel Bonnet (4):
  textconv: make the API public
  textconv: make diff_options accessible from blame
  textconv: support for blame
  t/t8006: test textconv support for blame

 builtin/blame.c           |   92 ++++++++++++++++++++++++++++++++++---=
-----
 diff.c                    |   12 ++----
 diff.h                    |    8 ++++
 t/t8006-blame-textconv.sh |   98 +++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 184 insertions(+), 26 deletions(-)
 create mode 100755 t/t8006-blame-textconv.sh
