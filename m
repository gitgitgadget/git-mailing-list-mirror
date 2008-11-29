From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/2] gitweb: patch view
Date: Sat, 29 Nov 2008 14:41:09 +0100
Message-ID: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 29 14:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Q5O-0003Hc-Cg
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 14:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbYK2Nk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 08:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbYK2Nk5
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 08:40:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:10452 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbYK2Nk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 08:40:57 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2196178ugf.37
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 05:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pYTKVAdS8T9otIhvlQmJ8JVgdNdvVKY7f98uIcJ1OC0=;
        b=hYO3wsx0zGKjnMXdxKWk05G6D7/ZqtPrn/p4bzqxmNGnkjuKLqpUplwOTW3DHNK1pV
         J1bvjjdKAIptXCpDXYgDlhxuCkMAV+JlocSWkRghK9TqphiMh1c9ylMGkRsCGd6pfnEm
         fxkhiwtLMBkJ4CUW2VeFOkdx9L7YHurLhPwxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=s7X8dtO1KWKQkZpXeuPAbSuGZiH0o0QiMAwRk0KpXoHYAEd34d2hPsWaurqx7UWiJE
         x/F2VZv1i9eY4jO/nDULnHu8Uti04tdu0p7Jn01v/Dki3LvaXiHVTsVbzZIP5GKhYYTM
         geWNGOR4EaWFsHUzoKStb28BJ+RUvWszjGWXQ=
Received: by 10.103.227.13 with SMTP id e13mr3613166mur.20.1227966055344;
        Sat, 29 Nov 2008 05:40:55 -0800 (PST)
Received: from localhost ([78.13.52.113])
        by mx.google.com with ESMTPS id s11sm4104058mue.42.2008.11.29.05.40.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 05:40:54 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101910>

I recently discovered that the commitdiff_plain view is not exactly
something that can be used by git am directly (for example, the subject
line gets duplicated in the commit message body after using git am).

Since I'm not sure if it was the case to fix the plain view because I
don't know what its intended usage was, I prepared a new view,
uncreatively called 'patch', that exposes git format-patch output
directly.

The second patch exposes it from commitdiff view (obviosly), but also
from shortlog view, when less than 16 patches are begin shown.

Giuseppe Bilotta (2):
  gitweb: add patch view
  gitweb: links to patch action in commitdiff and shortlog view

 gitweb/gitweb.perl |   35 +++++++++++++++++++++++++++++++++--
 1 files changed, 33 insertions(+), 2 deletions(-)
