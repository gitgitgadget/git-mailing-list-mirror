From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] format-patch: fix dashdash
Date: Thu, 26 Nov 2009 21:11:58 +0200
Message-ID: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 20:12:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDjlJ-0007Xo-Bt
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 20:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbZKZTMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 14:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbZKZTMF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 14:12:05 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:58454 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbZKZTME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 14:12:04 -0500
Received: by bwz27 with SMTP id 27so755484bwz.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 11:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=K2yO8m2Bs1uwzAQcOBkyq4sLtnBpv/+5BzsJFnntYqA=;
        b=WLcbUApKHqOll518qCsQeiYsc3gFDkac1qzt4u2531ilEU5nl3VinSYHbqIZ7bslDP
         +qZUgqsZq5uJn8Z1vR/muGEGtz9G/YBqhoQs1/Tsd2hObEL7HG7eLqQBEPWAKGD+pwEF
         ELgGUzb/riII3V5wAUjNC5YObxjtzU1R13ezE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vsm/L9K1Bb1a/s4sz+SOfmmyTl6S/Xw6JsfT1VSsK63cHgx1dLD5PdjAGtl7XeyRmj
         1tqc+aZBe/rDtDrlFXk6FCM09phZOCaZxVfr5V/EfBfaCsiyPQ4gjkXoXfwUpOOZ6T7F
         ByHv1pm/+N6xwO4N/qh7kH6vWej7XtXsi8nBM=
Received: by 10.204.2.199 with SMTP id 7mr99723bkk.160.1259262729604;
        Thu, 26 Nov 2009 11:12:09 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 16sm244897bwz.11.2009.11.26.11.12.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 11:12:08 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.61.geeb75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133822>

This doesn't work
git format-patch <committish> -- <path not in working dir>

So here are some fixes and a test.

Felipe Contreras (2):
  format-patch: fix dashdash usage
  format-patch: add test for dashdash

 builtin-log.c           |    3 ++-
 t/t4014-format-patch.sh |    4 ++++
 2 files changed, 6 insertions(+), 1 deletions(-)
