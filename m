From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/2] teach am and rebase -q/--quiet
Date: Sat, 13 Jun 2009 13:21:38 -0700
Message-ID: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 22:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFZje-0007Uf-JX
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 22:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262AbZFMUVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 16:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755384AbZFMUVm
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 16:21:42 -0400
Received: from mail-px0-f187.google.com ([209.85.216.187]:50269 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbZFMUVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 16:21:41 -0400
Received: by pxi17 with SMTP id 17so1257966pxi.33
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=dwIJ6Zu4qO4u2d/pDKR0Pi+Ij5mi3RbgyIbQHMjztPM=;
        b=TA4+wMRZlvvzn3+5iTWa2y2fmHsK7t2HiHNQPKxMbkLBl40uaMN81TyKf9aS7zkp23
         dQyrK+r2IbAaVqvutZrG3omsKv0y3BbLc71N1C5jgfPhSWSs+GU1wLkBUqbzuDxbAAMC
         OepDvKgYjp/+/nysSfLY6K4foTnFk4G3EHqCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=UrUecVosyMq+e8jdP8PRprRz8tZDQm1c25bj0Cqzo79CwAoS4O7c8yuE9jXWMBAVO4
         bEM1wn29qJ+b4h/HLp7R6g1vu22vZ3TGMukv1iXsASwWgMnR74oGLdPXiwmySuXm1iFR
         Supy3/GWWbW0x99r5MBTTUQHZcgUvKvGfM2jQ=
Received: by 10.142.237.19 with SMTP id k19mr1965320wfh.296.1244924503994;
        Sat, 13 Jun 2009 13:21:43 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 30sm1263261wff.9.2009.06.13.13.21.41
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 13:21:43 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 13 Jun 2009 13:21:40 -0700
X-Mailer: git-send-email 1.6.3.2.225.gb8364
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121521>

am and rebase are talkative scripts. Teach them to be less verbose.
This is useful for script writers incorporating rebase or am into
their scripts.

I am not sure why "current branch $branch is up to date" and
"Fast-forwarded $branch to $onto" is echoed to stderr, but I've
wrapped those in a quiet check because it doesn't seem to be
an error. Maybe those should be changed to stdout?

Stephen Boyd (2):
  am: teach quiet option
  rebase: teach quiet option

 Documentation/git-am.txt     |    6 ++++-
 Documentation/git-rebase.txt |    4 +++
 git-am.sh                    |   27 ++++++++++++++++++----
 git-rebase.sh                |   49 ++++++++++++++++++++++++++++++++---------
 t/t3400-rebase.sh            |    7 ++++++
 t/t4150-am.sh                |    7 ++++++
 6 files changed, 83 insertions(+), 17 deletions(-)
