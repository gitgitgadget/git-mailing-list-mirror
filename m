From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] log/ format-patch improvements
Date: Sun, 22 Aug 2010 01:58:49 +0530
Message-ID: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 22:31:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmuiV-00008O-PA
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 22:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab0HUUa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 16:30:59 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61976 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab0HUUa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 16:30:57 -0400
Received: by pvg2 with SMTP id 2so1723335pvg.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=CQvAxaVMkfPGmJGYv7Pmvq2qRDe+xiwGs7ptE/JxE4Y=;
        b=lhlY6JXN66zkt/bmoMXYWggashxIY4cqSj/+K9dsX0QIpj3lUYX4F5M9Mh9Z0BkqLi
         MYW+npn6N+1E1FaZC9iZlM/lV/e6YlDOjaCVf1IXKDtcY4faaBpPkt2TgMP6QNvMroNm
         fyws6bLXt5H9lmtkZVVXDrMT5Uv84lTRhm+NI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fqhVZUSS5r3nC4Wa81uOoiGwr3lpt96ePhwZPMclj80mNd6dKEsFVyG7xN+xRWgSjj
         Fch8Gp24qHZPa7RRqMHiSABZ8LSR5B+0an7Y0rkVe30gw6MkllPSBiXfgTY6KaVgKMiM
         YWLUeKYOdrq1SRfqP2DMMsXZg74D8rqMLMaIY=
Received: by 10.114.24.1 with SMTP id 1mr3490729wax.76.1282422657518;
        Sat, 21 Aug 2010 13:30:57 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d35sm8096273waa.9.2010.08.21.13.30.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 13:30:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154156>

Hi,

The first patch implements Jakub's suggestion. Arguably, it's slightly
complicated- it took me more than a few minutes to do the math with
`nr` and `nr_i`.

The second patch clarifies the meaning of the `-<n>` option. We should
also probably force the mutual exclusivity of `-<n>` and <revision
range> to avoid confusion.

Additionally, thanks to Thomas for drilling into me the fundamental
difference between -<n> and a revision range (on IRC).

Ramkumar Ramachandra (2):
  git-format-patch: Print a diagnostic message when ignoring commits
  log: Improve description of '-<n>' option in documentation

 Documentation/git-format-patch.txt |    2 +-
 Documentation/git-log.txt          |    2 +-
 builtin/log.c                      |   42 ++++++++++++++++++++++++++---------
 3 files changed, 33 insertions(+), 13 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
