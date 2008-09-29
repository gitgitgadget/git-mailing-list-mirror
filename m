From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3] gitweb path info enhancements
Date: Mon, 29 Sep 2008 17:26:53 +0200
Message-ID: <1222702017-4496-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 17:28:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKeu-0003I8-6W
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbYI2P01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbYI2P01
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:26:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:47119 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYI2P00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:26:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1465125fgg.17
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=X9BJwt3CjtIRlaRZguXWqVE8xKUGoztgF2YFfnSf8DE=;
        b=jLY1so0lnjh6zyf9BocTOS2EwtZ2gc1nqQ67x5UqVYAU7/Osp1GMz8XwBOmMtbuSNN
         1m6H98XUDCU2PaDk04aL3m2cb/43Kk8oPFLU0YUKBHnMA9GmGhepq3ANrXnVKWxWi21g
         U2ebrYq7U6L1Tt2YkLmheOzQRgdpUHsnCeF6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KYI3CvRrQviXcAe/5tMTJBKopOvjo721HZasi8V88xtoXeyDp2yn/Psp1Xi5A0XmSL
         JYjcqEWbUk9zKbrdHbAFybP4jtTCGaVH6o9quVPlLE6l5HIQsLaZVlH8IpScC378f3dD
         EQ2FviFTSAMPuMbG9WxDQTlGk73+S3xy+8gPc=
Received: by 10.180.215.19 with SMTP id n19mr2425523bkg.35.1222701984558;
        Mon, 29 Sep 2008 08:26:24 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id p9sm348953fkb.5.2008.09.29.08.26.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 08:26:23 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97022>

Third run for the PATH_INFO handling enhancements in gitweb. A
trivial but important bugfix was sent as a separate patch, and the
other patches were rearranged a little, reducing the total number of
patches to four, paired in parsing and generation of the enhanced
PATH_INFO URLs.

The first two patches deal with the inclusion of action and hash or
the hash_base:filename pair in the URL, while still keeping support
for old-style PATH_INFO URLs whenever possible.

The other two patches extend the URL format to also include parent
hash/filename information when possible.

Giuseppe Bilotta (4):
  gitweb: parse project/action/hash_base:filename PATH_INFO
  gitweb: generate project/action/hash URLs
  gitweb: parse parent..current syntax from pathinfo
  gitweb: generate parent..current URLs

 gitweb/gitweb.perl |  167 +++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 126 insertions(+), 41 deletions(-)
