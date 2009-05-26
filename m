From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 0/4] git-am support for foreign patches
Date: Tue, 26 May 2009 02:38:06 +0200
Message-ID: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 02:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8kh8-0004qX-Vj
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 02:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbZEZAiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 20:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbZEZAiP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 20:38:15 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:40776 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbZEZAiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 20:38:14 -0400
Received: by fxm12 with SMTP id 12so1678631fxm.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 17:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=4Obajr2f4oiAVLhy4FmIr0ka/2z+gzF5GN8rD/XCM9w=;
        b=clAKcGSaM0z4z7D0yIsbFSQRDaY3nVMD62bcQuz2wTrICx1S0+kJqgVOB0ImNkFBv/
         4KxfVSDeVH29lUhp1EkqhqgCL5vmteLJSj7hwL9eFXb1g3SOf1Jw7Z6G/D4PnZMdB2T7
         DWvDM08KBH12C9LVOLLFnbXayDopI1DW4ae98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wCkdp5dfwsgcQbbe+To+hrYzGFJvwZ4JjKkO9EnVZBmAiKdJXWrB6pwgVEEmnAasJT
         3K32PftLObcgcz/TuUdtQp2hxssMJgb7AeM9X2ok3IFCKRHMykcel/ux46g7/l3m+uJL
         VoF9TBVk+F7wXljBA2IQK8b79mMNEEZrD7NDM=
Received: by 10.103.52.2 with SMTP id e2mr2973820muk.33.1243298295203;
        Mon, 25 May 2009 17:38:15 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id y37sm1865136mug.19.2009.05.25.17.38.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 17:38:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.248.gb44be
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119986>

This patch series introduces a framework to allow git-am to support
patches that are not in mailbox format.

The first patch introduces the command-line settable patch_format
variable, describing the patch format.

The second patch introduces some patch format autodetection heuristics,
for mercurial and StGIT.

The third patch introduces actual support for StGIT patches (both series
and single patches).

The last one does some refactoring for the 'remove $dotest and exit 1'.

Giuseppe Bilotta (4):
  git-am foreign patch support: introduce patch_format
  git-am foreign patch support: autodetect some patch formats
  git-am foreign patch support: StGIT support
  git-am: refactor 'cleaning up and aborting'

 git-am.sh |  148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 144 insertions(+), 4 deletions(-)
