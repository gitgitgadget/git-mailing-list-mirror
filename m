From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 0/3] gitweb: Smarter snapshot names
Date: Sat,  7 Nov 2009 16:13:26 +0100
Message-ID: <1257606809-23287-1-git-send-email-jnareb@gmail.com>
Cc: Mark Rada <marada@uwaterloo.ca>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 16:14:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6mzJ-0000cF-OM
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 16:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbZKGPNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 10:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbZKGPNe
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 10:13:34 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54017 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZKGPNd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 10:13:33 -0500
Received: by bwz27 with SMTP id 27so2098717bwz.21
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 07:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=bDmh87YmvYErg5I9EymDpKJYBtqpOqrExRDQmxLJbfQ=;
        b=bSvAjSPSdSwKYb66oc80qdrse86JudrVITuWt75lbFRrKPF90j6Ijdi/mo8eWAlKmW
         qOw3fEGQx3fNtCj5oBXPpYPky7rU5ZuNTWYI0pbwQJ5STCkBKYsb/dfCHpRgql0sDOE3
         zhkAqsPJfcxtG/S5r9EPeqnKBBkzhkEyF/Atc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sM2tRyMMYPSXSvt5lTGGIgaX4wCw4yrX4T/QYdF0hW4kNpcSMaQh3bxlrLrKrP1sDp
         Db8Y8EV4VG/FQVN5tUjZ0OvMElXrRb6ReGz53SOy6k1us296WPOJQ21XvDfq9jMH6IuQ
         OScmt1huRBjwT2qsAFKs1jEpq613JApwxuv3o=
Received: by 10.204.15.145 with SMTP id k17mr829363bka.212.1257606817118;
        Sat, 07 Nov 2009 07:13:37 -0800 (PST)
Received: from localhost.localdomain (abuz230.neoplus.adsl.tpnet.pl [83.8.197.230])
        by mx.google.com with ESMTPS id 16sm331461fxm.0.2009.11.07.07.13.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 07:13:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nA7FDYEK023318;
	Sat, 7 Nov 2009 16:13:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nA7FDWRQ023316;
	Sat, 7 Nov 2009 16:13:32 +0100
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132366>

This is the replacement for 'mr/gitweb-snapshot' branch (aba1076),
currently in 'pu'.

Compared to previous series the t9502-gitweb-standalone-parse-output
test is created in earlier commit, to better show changes in snapshot
behaviour in "gitweb: Smarter snapshot names".

The first commit in series is identical to the one in previous version
of this series.  Changes in last commit in series are only about
tests.

Shortlog:
~~~~~~~~~
Jakub Narebski (2):
  t/gitweb-lib.sh: Split gitweb output into headers and body
  gitweb: Document current snapshot rules via new tests

Mark Rada (1):
  gitweb: Smarter snapshot names

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCH 1/3] t/gitweb-lib.sh: Split gitweb output into headers and body
 [PATCH 2/3] gitweb: Document current snapshot rules via new tests
 [PATCH 3/3] gitweb: Smarter snapshot names

Diffstat:
~~~~~~~~~
 gitweb/gitweb.perl                        |   76 +++++++++++++++----
 t/gitweb-lib.sh                           |    6 +-
 t/t9502-gitweb-standalone-parse-output.sh |  115 +++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 17 deletions(-)
 create mode 100755 t/t9502-gitweb-standalone-parse-output.sh

-- 
Jakub Narebski
Poland
