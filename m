From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv1bis 0/2] git apply: cope with whitespace differences
Date: Thu,  2 Jul 2009 19:48:39 +0200
Message-ID: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Robert Fitzsimons <robfitz@273k.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 19:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMQP1-0004Cb-TJ
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 19:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbZGBRsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 13:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbZGBRsp
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 13:48:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:40459 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbZGBRsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 13:48:45 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1168644fga.17
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PegTyy/bO3VfEiNn4LNpmuNvu8XfYgXWRJA5WGSb5Jw=;
        b=TFXY8lpNH5gpR2TYYrSJc5hVAfjQOIYPXxuqCsWyg2UEULkyY2p2T5P6n9wj2cm7LG
         kedHjCmRq/oyOb1FOeyww+g03Hn/nMLzgOIOZaJR/nuBXpozE7kzlitDzbS1bW7/XN4e
         zSkOxt4zuihjxK4FzWnhafe99NLIWnbmXz1JE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OOglv2/z+f7jFSHDXrArt62vgOJPOGrlYsu4CdR346nHOnQv/5ZPb9V5eaiL62TLmj
         z4GWrpLvN9F7ANq5U0j4IoVDzXNA5BkZ1i9pTF1Ari8DDo32JMsIf2hDAHtcrsBuJfh9
         GpStT+1I54UTRljwu3pz/EERYP9q7dZLi5qsk=
Received: by 10.86.98.19 with SMTP id v19mr499375fgb.29.1246556926619;
        Thu, 02 Jul 2009 10:48:46 -0700 (PDT)
Received: from localhost (host-78-15-5-16.cust-adsl.tiscali.it [78.15.5.16])
        by mx.google.com with ESMTPS id l19sm6071857fgb.26.2009.07.02.10.48.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 10:48:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.512.g509a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122658>

Sometimes I do some very stupid things, as was the case with the first
version of this sequence. This new version still doesn't include Junio's
suggestion to move whitespace fixing to before the check, because I'm
not convinced it should be the case.

Giuseppe Bilotta (2):
  git apply: option to ignore whitespace differences
  git apply: preserve original whitespace with --ignore-whitespace

 builtin-apply.c                        |   90 +++++++++++++++++++++++++++++--
 contrib/completion/git-completion.bash |    2 +
 git-am.sh                              |    3 +-
 git-rebase.sh                          |    3 +
 t/t4107-apply-ignore-whitespace.sh     |   74 ++++++++++++++++++++++++++
 5 files changed, 165 insertions(+), 7 deletions(-)
 create mode 100755 t/t4107-apply-ignore-whitespace.sh
