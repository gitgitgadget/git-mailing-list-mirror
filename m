From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 0/4] fast-import: add a new option command
Date: Mon, 24 Aug 2009 13:52:32 -0700
Message-ID: <1251147156-19279-1-git-send-email-srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 22:53:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfgXn-00068r-Gj
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 22:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbZHXUwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 16:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbZHXUww
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 16:52:52 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:50648 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbZHXUww (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 16:52:52 -0400
Received: by pzk32 with SMTP id 32so1142245pzk.33
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=2i6C+S5wNREfAU2URiKoaoxi8QtTJ65Pa/fsIc6XGeA=;
        b=Ns501gN9qchBmk1m/iS1reZ4K/dlUUFqd38SAWhPJj/6pjwK4izsAqB2N2udBg1sqz
         TlJdsW+7z/8ft2Ggi8hBa0lO+Zd+LzfvAWtXOxFRxEGnhaxfu2hMTPlfFnM8PYPT83Ap
         95hLQJdFht/qWjoOsXqrtd4WID4ydeBifNvmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=t5B2oLftBDwOKGEiivelsReuw85bQA93NRwJs0+6n/5Ue324vywrzWGqBjfgRVqyrZ
         y21EqrR0Jzgc3R6NQoinPTNZdbBMbLPrjMT3Esx2CukHNC9uXQsV8NkRfY28VZKhqu59
         70NLgOhpzjipQ1V+hVJj5VEw9RLj5Ck6YWUBk=
Received: by 10.115.133.39 with SMTP id k39mr6521843wan.94.1251147174160;
        Mon, 24 Aug 2009 13:52:54 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id 20sm1023981pzk.5.2009.08.24.13.52.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 13:52:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126965>

The only difference with v3 is that the --import-marks refactoring is
done in a seperate patch.

Meant as replacement for sr/gfi-options in pu.

Sverre Rabbelier (4):
      fast-import: put option parsing code in seperate functions
      fast-import: put marks reading in it's own function
      fast-import: add option command
      fast-import: test the new option command

 Documentation/git-fast-import.txt |   23 ++++
 fast-import.c                     |  235 +++++++++++++++++++++++++------------
 t/t9300-fast-import.sh            |   58 +++++++++
 3 files changed, 239 insertions(+), 77 deletions(-)
