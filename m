From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATHv3 0/3] PATH_INFO snapshot formats
Date: Sun,  2 Nov 2008 10:21:36 +0100
Message-ID: <1225617699-30004-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:22:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZ9n-0002l1-RN
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbYKBJUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbYKBJUu
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:20:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:1682 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbYKBJUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:20:48 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1532303ugf.37
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 01:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=LHMdpONimtbpI2Wkk7ASeC1xLpR3JeWSMRqSUJOYQnk=;
        b=xfUUts4OUcgrELFYL888RphHjiAmUICySzouXfj+LB3iPngvRCJKiLlm7ZSBCa16bE
         u+VkQRBl9ZAiCeEgk5I+eHUwiDYKOCh4M7hn1ch4r8a1FgNqTPAfRSMJ2kXtwuogerkR
         8UCuEMi8kajaP32ebT5aNSdZ0glfQHU8UOiKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Su/MVeyRNvK8AUYNIu7xRo54E+toel2IpmD4gBKKy9Bg1xYEmsVlHPMl2hf5fIgE9+
         WwyP5ER66E7mmpLTDMetZ2eFmGnpzXsK5cnTPlCe4SN36w+rH0jQsMKt1QIhIxhhT8we
         UlAIxRtCtTj8Jiw7FtSJcsMfAqKINe3ad9qF4=
Received: by 10.67.121.14 with SMTP id y14mr1233898ugm.10.1225617645090;
        Sun, 02 Nov 2008 01:20:45 -0800 (PST)
Received: from localhost ([94.37.26.217])
        by mx.google.com with ESMTPS id b35sm17051657ugd.33.2008.11.02.01.20.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 01:20:44 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99825>

The following three patches allow gitweb to read (and emit) PATH_INFO
URLs with embedded snapshot_format information. This eliminates one
for CGI parameter when PATH_INFO is enabled, and also offers a more
user-friendly URL for snapshots.

The first patch is actually rather independent from the other two: it
collects the definition (and calculation) of the array of allowed
snapshot into a global variable.

Giuseppe Bilotta (3):
  gitweb: make the supported snapshot formats array global
  gitweb: retrieve snapshot format from PATH_INFO
  gitweb: embed snapshot format parameter in PATH_INFO

 gitweb/gitweb.perl |   70 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 62 insertions(+), 8 deletions(-)
