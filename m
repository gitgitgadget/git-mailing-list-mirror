From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 0/2] gitweb: gravatar support
Date: Sun, 21 Jun 2009 19:57:03 +0200
Message-ID: <1245607025-19296-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 19:58:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIRJ4-0007oE-S4
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 19:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbZFUR4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 13:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbZFUR4F
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 13:56:05 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:45440 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbZFUR4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 13:56:05 -0400
Received: by bwz9 with SMTP id 9so2688201bwz.37
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bdR40VV98gbZanPAnLZ+5LerkOsB1Wav2jrZgKSzSYo=;
        b=v6jFN3giapfa8IK0EVNAylR8S2B3KU4nQa9LW2UYedztD5E+kkrh/9v/RkI7DexsJp
         0IZeLXPwrjGM/zN8zHLr+ldfoiDxAHzMI1OYX+mz2Lq7nXAmJXjPePgc/iONLbQqAQhW
         T7PRBTLLlt6VJvMSVoO96VlDk2gQqcfLIJkBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=M41AL6tBRK2upcqBso8vXdpjRJEDN9UVZg4WAPOh54qO7EL9sMjK/1UJFjGNpZS75j
         9dIr6NO4cVfc3L+kVFS+jcmre7A+c+Jr6N4kndtSMUOT8ahjNOujrN0XnOxV/5fqI6Db
         tREfAYE2d5jMGUiVahqX/SH6Zy+pKxkLwEWUI=
Received: by 10.204.60.194 with SMTP id q2mr5228987bkh.150.1245606965997;
        Sun, 21 Jun 2009 10:56:05 -0700 (PDT)
Received: from localhost (host-78-15-4-45.cust-adsl.tiscali.it [78.15.4.45])
        by mx.google.com with ESMTPS id 9sm10870265fks.28.2009.06.21.10.56.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Jun 2009 10:56:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121990>

I've done the refactoring in a separate patch, to have a better (IMO)
view of what I was doing. I can squash them together if needed. There
have also been a couple of other changes such as the use of 'require'
instead of 'use' to access Digest::MD5, and a better call pattern for
git_get_gravatar.

One thing that is missing but could be done is an email -> MD5 hash
mapping to cache multiple occurences of the same email (not unusual
in (short)log view).

Giuseppe Bilotta (2):
  gitweb: gravatar support
  gitweb: refactor author+gravatar insertion

 gitweb/gitweb.css  |    9 +++++-
 gitweb/gitweb.perl |   83 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 76 insertions(+), 16 deletions(-)
