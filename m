From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 0/4] git-am foreign patch support
Date: Wed, 27 May 2009 11:25:15 +0200
Message-ID: <1243416319-31477-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 11:25:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9FOE-0007YH-DD
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 11:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbZE0JZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 05:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbZE0JZ0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 05:25:26 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:34862 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755952AbZE0JZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 05:25:26 -0400
Received: by fxm12 with SMTP id 12so2679773fxm.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 02:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xGv6+ymz7rhNOC48c6cjdBZBV1+40yBf1O804BJZ4Cg=;
        b=vj6u2aPfNUptg0VrjJ2QabFdtJvKgVoFeoQMlfJrZ7R8alAdzy8w0cqDwzx1bVYSgF
         PBQlvE0pwqPvwTyrH3hw0eIGjYFKjsKPNE3zp0hJamSgEEQXSHozrD4Eyr35gHWyDukc
         FRz7NbYxE1N/5VQnYS6JRwOnYBZ0HP0dmOelI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=K76dTjsJwN2rb6DvcutQUeVPXdN4adM1KohlvshSEGJ29+sc/Ves5cAkf+jn3vIE6E
         ECJN7F3BMlV6qmFl7whFAsgH8oUEkJQJ3md1zJfdTUvla2UY1f3xqdSx54MzG1MqXZ90
         FT69cGPWbcssZw2YsXitboslA4rXgK0sWw4Zk=
Received: by 10.102.215.1 with SMTP id n1mr4940896mug.109.1243416327028;
        Wed, 27 May 2009 02:25:27 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id w5sm2267920mue.34.2009.05.27.02.25.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 02:25:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.274.gd2e8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120050>

Third attempt at introducing foreign patch support for git-am. The only
significant change from the previous round is the StGIT-to-mbox format
conversion which is now done via perl instead of awk.

Giuseppe Bilotta (4):
  git-am foreign patch support: introduce patch_format
  git-am foreign patch support: autodetect some patch formats
  git-am foreign patch support: StGIT support
  git-am: refactor 'cleaning up and aborting'

 git-am.sh |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 129 insertions(+), 4 deletions(-)
