From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [PATCH 0/5 v2] unpack_trees: nicer error messages
Date: Tue, 15 Jun 2010 14:22:51 +0200
Message-ID: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 14:23:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVAr-0006TW-4m
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 14:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab0FOMXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 08:23:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56979 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658Ab0FOMXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 08:23:07 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FCF4Jb002451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 14:15:04 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5FCN4pA021117;
	Tue, 15 Jun 2010 14:23:04 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o5FCN4tp028276;
	Tue, 15 Jun 2010 14:23:04 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o5FCN4IS028275;
	Tue, 15 Jun 2010 14:23:04 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 14:15:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FCF4Jb002451
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
MailScanner-NULL-Check: 1277208904.88936@D6OGDHOjy4s+e3QjNJWcEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149173>

This patch serie aims at grouping porcerlain merge and checkout 
errors messages by type if possible, listing all the file concerned
by the error type.
It also adds porcelain messages for checkout.

It was first introduced in the thread:
http://mid.gmane.org/7v63277f92.fsf@alter.siamese.dyndns.org

Diane Gasselin (5):
  merge-recursive: update merge porcelain messages for checkout
  unpack_trees: group errors by type
  unpack_trees_options: update porcelain messages
  tests: update porcelain expected message
  t7609: test merge and checkout error messages

 builtin/checkout.c             |    4 +-
 builtin/merge.c                |    3 +-
 merge-recursive.c              |   48 ++++++++++------
 merge-recursive.h              |    6 +-
 t/t3030-merge-recursive.sh     |    2 +-
 t/t3400-rebase.sh              |    2 +-
 t/t7609-merge-co-error-msgs.sh |  125 ++++++++++++++++++++++++++++++++++++++++
 tree-walk.c                    |   11 +++-
 unpack-trees.c                 |  119 +++++++++++++++++++++++++++++++++++---
 unpack-trees.h                 |   31 ++++++++++-
 10 files changed, 316 insertions(+), 35 deletions(-)
 create mode 100755 t/t7609-merge-co-error-msgs.sh
