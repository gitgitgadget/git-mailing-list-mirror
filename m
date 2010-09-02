From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/3] (hopefully) Proper fix to set show_all_errors where needed
Date: Thu,  2 Sep 2010 13:57:32 +0200
Message-ID: <1283428655-12680-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq39ttxumz.fsf@bauges.imag.fr>
Cc: Jim Meyering <jim@meyering.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 02 13:58:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or8RW-0007QL-N4
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 13:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab0IBL6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 07:58:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44942 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576Ab0IBL6t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 07:58:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o82BjdmV015441
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Sep 2010 13:45:39 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Or8QC-0006ml-M2; Thu, 02 Sep 2010 13:57:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Or8QC-0003Je-Je; Thu, 02 Sep 2010 13:57:36 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
In-Reply-To: <vpq39ttxumz.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 02 Sep 2010 13:45:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o82BjdmV015441
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1284032741.34059@UqpUIbOJw/dRE2gpq3IRQA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155124>

So, after my toy untested patch, here's a cleaner version. I splitted
it into really small patches, to avoid modifying code while I move it,
but Junio, feel free to squash 1/3 and 2/3 if you prefer.

This fixes a regression, so this should be in the next release if the
patch is OK.

Jim: can you confirm if it fixes your problem?

Matthieu Moy (3):
  Move set_porcelain_error_msgs to unpack-trees.c and rename it
  setup_unpack_trees_porcelain: take the whole options struct as
    parameter
  Move "show_all_errors = 1" to setup_unpack_trees_porcelain()

 builtin/checkout.c |    3 +-
 builtin/merge.c    |    3 +-
 merge-recursive.c  |   46 +-----------------------------------------
 merge-recursive.h  |    6 -----
 unpack-trees.c     |   56 +++++++++++++++++++++++++++++++++++++++++++++------
 unpack-trees.h     |    7 ++++++
 6 files changed, 59 insertions(+), 62 deletions(-)

-- 
1.7.2.2.175.ga619d.dirty
