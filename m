From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 0/6] win32-dirent
Date: Tue, 23 Nov 2010 19:38:23 +0100
Message-ID: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 19:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKxln-0007PH-S7
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 19:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297Ab0KWSjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 13:39:06 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51282 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266Ab0KWSjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 13:39:04 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so4858031eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 10:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6fxdXvcYjKnURb/G5u3mhe/XCVsZg4EZNM07AAnfkUY=;
        b=cQcNwOamN4LPSdh6HcNWoEtHlLb/wczDwDxSARfweg8UDhKbVG/ty2dtgnk9PXgCBs
         NUpFxFDioc/sVCDh0NLLqHF4RI8jQw8zKNKUWQUJkY1xe73+pmjwLGrOnxu1bFdnZHny
         G0iKg4bRd2e0QVEJeb9RVlhhHC0IWFdnm5Naw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Z3Nh6BbSi5tH2HoglYWYqQhlFHU3INPGhbKjOmyFms746aI9oAMdjNaiHwhOeuFwOL
         0w6SQ5gPM9H3EGiAuy22N5d3isouPgSp/p1AIMIsBYYiMPDyFAgJ1Bi9VVqB1NibRMJ6
         lpuUJLd7lx6kVNoIiybguGOJYpO9S5UGNY990=
Received: by 10.14.45.78 with SMTP id o54mr5365824eeb.41.1290537544050;
        Tue, 23 Nov 2010 10:39:04 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v51sm6075473eeh.10.2010.11.23.10.39.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 10:39:03 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162003>

Here's a re-roll of my win32-dirent branch, this time with some comments
by Jonathan Nieder taken into account.

* 1/6 is back to using malloc (as opposed to xmalloc),
* 2/6 corrected the strlen, and now does strlen of the input-string. It
  seems I messed up when splitting some patches.

The other patches are adjusted accordingly.

Erik Faye-Lund (6):
  msvc: opendir: fix malloc-failure
  msvc: opendir: allocate enough memory
  msvc: opendir: do not start the search
  win32: dirent: handle errors
  msvc: opendir: handle paths ending with a slash
  win32: use our own dirent.h

 Makefile                        |    7 ++-
 compat/mingw.c                  |   60 ------------------
 compat/mingw.h                  |   29 ---------
 compat/msvc.c                   |   29 ---------
 compat/vcbuild/include/dirent.h |  128 ---------------------------------------
 compat/win32/dirent.c           |  108 +++++++++++++++++++++++++++++++++
 compat/win32/dirent.h           |   24 +++++++
 7 files changed, 137 insertions(+), 248 deletions(-)
 delete mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/win32/dirent.c
 create mode 100644 compat/win32/dirent.h

-- 
1.7.3.2.493.gc8738
