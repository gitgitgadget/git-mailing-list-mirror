From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] Merge David's SVN exporter
Date: Fri,  4 Jun 2010 15:41:05 +0200
Message-ID: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 04 15:40:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKX7z-0005cL-Ro
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab0FDNjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:39:45 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:41712 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284Ab0FDNjo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 09:39:44 -0400
Received: by ewy23 with SMTP id 23so312332ewy.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QcZmVzx6ART3P40IIsaTXqCEUZRQp+x8Byv2Ym9qFJY=;
        b=O3tZQVWJobOsZ/c4M95HS58sggbl7CHxWCawakneoawgtEwFvP9tBjEpRVG5Daw5tK
         qLG6djXgdTUlzmEpmjV/ARewKzAIG0awTYphJ7r9+0KxHNVxGrdcztyRftDK76PvPWlI
         dVLBkBTuVxnTObanPf3KJw+9mewRSGe5ixB3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DpVDsgCqfQgf3t8HF/OUrUmBSWhLhIEvFeHnfat3LwE/XPZ6sMZWnQ9HaNemD51iN7
         x1HngiDj2gW33dDA+F9k9N9iUgRiWG0ycJra0zAd4/Un2CCxNQA/hrOPaq3jRR3kAZSi
         0eiH0OLGDY1JWXBbRunU5xVOlGGpnqGxar1t0=
Received: by 10.213.2.196 with SMTP id 4mr4846348ebk.20.1275658783579;
        Fri, 04 Jun 2010 06:39:43 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 15sm729602ewy.8.2010.06.04.06.39.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 06:39:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148409>

Hi,

Sorry about the mess- The authorship is corrected in this series.

-- Ram

David Barr (5):
  Add memory pool library
  Add library for string-specific memory pool
  Add stream helper library
  Add infrastructure to write revisions in fast-export format
  Add SVN dump parser

Jason Evans (1):
  Add cpp macro implementation of treaps

 vcs-svn/fast_export.c |   69 ++++++++++
 vcs-svn/fast_export.h |   14 ++
 vcs-svn/line_buffer.c |  129 ++++++++++++++++++
 vcs-svn/line_buffer.h |   14 ++
 vcs-svn/obj_pool.h    |   98 ++++++++++++++
 vcs-svn/repo_tree.c   |  353 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/repo_tree.h   |   27 ++++
 vcs-svn/string_pool.c |  110 +++++++++++++++
 vcs-svn/string_pool.h |   14 ++
 vcs-svn/svndump.c     |  294 ++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndump.h     |    7 +
 vcs-svn/trp.h         |  118 ++++++++++++++++
 vcs-svn/trp.txt       |   62 +++++++++
 13 files changed, 1309 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h
 create mode 100644 vcs-svn/obj_pool.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h
 create mode 100644 vcs-svn/svndump.c
 create mode 100644 vcs-svn/svndump.h
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt
