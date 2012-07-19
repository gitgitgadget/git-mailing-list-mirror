From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH v2 0/7] build system: support automatic reconfiguration for autotools user
Date: Thu, 19 Jul 2012 09:49:55 +0200
Message-ID: <cover.1342683786.git.stefano.lattarini@gmail.com>
References: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 09:50:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlV6-0006Z9-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136Ab2GSHuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:50:16 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44410 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab2GSHuO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:50:14 -0400
Received: by bkwj10 with SMTP id j10so2137707bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=//7xJ6/hq+h7zqptCneZMWb2/BD2I80c4fKEcFe27KQ=;
        b=wGQzCQTfnHmJqN3khzi64YO2UCqUpcbWb2AQ+8wXGkhGkGNjkjzBv573Zhd/cDew8H
         xrTWrxKObZWn8w3hKiUtI3Gp4xYEf+Dj3hBEprZId5iQ0Eej1gp1r3tYNVL4hAW6MvTu
         hxmzBV4H6H4rQnuAgiQMtsgT+TAL7FPyip2MAItuiqSEJteE/gypUtuzm+Jd1kN/cPDF
         KXyKbsvLBkMbbDW0+bky4S486gytGS329eeT6nhx+KOm89E8vcBlBy3fj8/d5vYo/NeZ
         AorN9Ezh2c6vWK1plA//cA5OmkAHOp+vnxc92/Eh5+WvAucOyJxba4xGAMxkiraUhdbV
         rx1A==
Received: by 10.204.132.80 with SMTP id a16mr285110bkt.82.1342684212799;
        Thu, 19 Jul 2012 00:50:12 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id c18sm430224bkv.8.2012.07.19.00.50.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:50:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201718>

> Except for miniscule nits in the the bottom two, I didn't find
> anything objectionable---nicely done.
>
Thanks.

Here is the re-roll, which should address all the reported nits.

Stefano Lattarini (7):
  autoconf: GIT_CONF_APPEND_LINE: change signature
  autoconf: GIT_CONF_APPEND_LINE -> GIT_CONF_SUBST
  autoconf: remove some redundant shell indirections
  autoconf: remove few redundant semicolons
  autoconf: use AC_CONFIG_COMMANDS instead of ad-hoc 'config.mak.append'
  build: "make clean" should not remove configure-generated files
  build: reconfigure automatically if configure.ac changes

 Makefile     | 17 +++++++++++++++--
 configure.ac | 56 +++++++++++++++++++++++++++++++-------------------------
 2 files changed, 46 insertions(+), 27 deletions(-)

-- 
1.7.10.2.1067.g553d16e
