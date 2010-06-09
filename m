From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [RFC/ PATCH 0/5] unpack_trees: nicer error messages
Date: Wed,  9 Jun 2010 14:44:01 +0200
Message-ID: <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 15:20:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMLCy-00011z-Or
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 15:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab0FINUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 09:20:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33559 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757094Ab0FINUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 09:20:34 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o59Cb3Ql022363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Jun 2010 14:37:03 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o59CimNv010543;
	Wed, 9 Jun 2010 14:44:48 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o59Cim8u025371;
	Wed, 9 Jun 2010 14:44:48 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o59CimWX025370;
	Wed, 9 Jun 2010 14:44:48 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 09 Jun 2010 14:37:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59Cb3Ql022363
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148772>

This patch serie aims at grouping merge and checkout errors messages by type
if possible, listing all the file concerned by the error type.

It was first introduced in the thread:
http://mid.gmane.org/7v63277f92.fsf@alter.siamese.dyndns.org

Diane (5):
  tree-walk: do not stop when an error is detected
  unpack_trees: group errors by type
  unpack_trees_options: update porcelain messages
  t3030: update porcelain expected message
  t7609: test merge and checkout error messages

 builtin/checkout.c             |    2 +-
 merge-recursive.c              |   10 ++--
 t/t3030-merge-recursive.sh     |    8 ++-
 t/t7609-merge-co-error-msgs.sh |  122 ++++++++++++++++++++++++++++++++++++++
 tree-walk.c                    |    5 +-
 unpack-trees.c                 |  128 +++++++++++++++++++++++++++++++++++++---
 unpack-trees.h                 |   12 ++++
 7 files changed, 270 insertions(+), 17 deletions(-)
 create mode 100755 t/t7609-merge-co-error-msgs.sh
