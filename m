From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v6 0/6] fast-import: add new feature and mark command
Date: Wed,  2 Sep 2009 19:56:57 +0200
Message-ID: <1251914223-31435-1-git-send-email-srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Wed Sep 02 19:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miu5N-0007FK-Fr
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbZIBR5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbZIBR5W
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:57:22 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48496 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZIBR5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 13:57:21 -0400
Received: by bwz19 with SMTP id 19so909246bwz.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=ZvPNkTFrWoyCFfcuD/MK4/qIn9sOE7/7IGy43RxuCzE=;
        b=IL5uGXH9L4pipArZyPrzs3EyNrbhczg6Wk7M5H36SOqMBHtuTKxP4wLKiaOEVKjd95
         joG1HQ5PTXEbP+ichoSWdPv2XUpvg/hcGf0bntnH3JxSGRrlnTgGvMRfW4Lx0T7m2gBt
         yP5K83kz0DIoSyNU2kk9Ejinx5WmGyDwn/Jc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=i2lnkrmBX8hfJAuwI7O+PNJrxa3RWNzOuWE6DUjship1sqrd17uBoj96bIHvuU9fNO
         Hxdb/NHeZx4d6JA+qjnq2jDvmc2LA824LOrg4H3hmZLRv6XcuVwa7nihct5LYP6HPx/c
         lvNsW9XYV/le3FA8tYnO9PI590BajpOkZiwBM=
Received: by 10.204.150.65 with SMTP id x1mr6944897bkv.6.1251914241855;
        Wed, 02 Sep 2009 10:57:21 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 21sm325505fks.9.2009.09.02.10.57.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 10:57:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127614>

Incorperated comments and changed 'option foo' to 'option git foo'. I
think this is ready to be merged to next if there are no objections.

Sverre Rabbelier (6):
      fast-import: put option parsing code in separate functions
      fast-import: put marks reading in it's own function
      fast-import: add feature command
      fast-import: test the new feature command
      fast-import: add option command
      fast-import: test the new option command

 Documentation/git-fast-import.txt |   40 ++++++
 fast-import.c                     |  262 ++++++++++++++++++++++++++-----------
 t/t9300-fast-import.sh            |  102 ++++++++++++++
 3 files changed, 327 insertions(+), 77 deletions(-)
