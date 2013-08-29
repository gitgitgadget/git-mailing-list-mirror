From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/9] transport-helper: updates
Date: Thu, 29 Aug 2013 10:23:19 -0500
Message-ID: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:28:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF48o-0008EG-C6
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab3H2P2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:28:06 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:44620 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab3H2P2F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:28:05 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so622349obc.40
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Byfgp7Ql7RWd36mlAzij6JrENG+qoENrvYgdqHxonxk=;
        b=jqYpvOSDU8h53W3pn/4WAId02QtfZujaN6A+7TAMw2C8wSdvblHyJusJSR02ggcuqd
         O9UNZEuxLjHYvi8nBxNIRc7xkotCnhyl1nlVwvbueWTraAH7LkG7eJuiMtD+jX2NlK54
         3Y+rg+A5wyvQvc1SQdcS7dVUcpM0JmnAS6ENkaaCcLnKa/wDcHxa1u4+E8Ts6FhpOnQJ
         RaFrAuW1zD1npj9UsVwG/1A93apJUYIf6W1OjpAA6HgsJ3CpPGCBsNidlmjEGA32kpOE
         AdQ26QC+84L+mZU8II7EirwM04WBhUiPqiT5sLe15ibFNV5WDw6Y/XQLty3Onfld+Nro
         y66g==
X-Received: by 10.60.63.68 with SMTP id e4mr2978234oes.23.1377790084782;
        Thu, 29 Aug 2013 08:28:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm31908251obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:28:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233267>

Hi,

Here are the patches that allow transport helpers to be completely transparent;
renaming branches, deleting them, custom refspecs, --force, --dry-run,
reporting forced update, everything works.

Some of these were were sent before and rejected without a reason, but here
they are again in case anybody is interested.

Felipe Contreras (9):
  transport-helper: add 'force' to 'export' helpers
  transport-helper: check for 'forced update' message
  fast-export: improve argument parsing
  fast-export: add new --refspec option
  transport-helper: add support for old:new refspec
  fast-import: add support to delete refs
  fast-export: add support to delete refs
  transport-helper: add support to delete branches
  transport-helper: don't update refs in dry-run

 Documentation/git-fast-export.txt |  4 ++++
 Documentation/git-fast-import.txt |  3 +++
 builtin/fast-export.c             | 47 ++++++++++++++++++++++++++++++++++++++-
 fast-import.c                     | 13 ++++++++---
 t/t5801-remote-helpers.sh         | 10 ++++++++-
 t/t9300-fast-import.sh            | 18 +++++++++++++++
 t/t9350-fast-export.sh            | 18 +++++++++++++++
 transport-helper.c                | 42 ++++++++++++++++++++++++----------
 8 files changed, 138 insertions(+), 17 deletions(-)

-- 
1.8.4-fc
