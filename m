From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH v5 0/3] diff: Add diff.orderfile configuration variable
Date: Wed, 18 Dec 2013 19:08:09 -0500
Message-ID: <1387411692-15562-1-git-send-email-naesten@gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 19 01:19:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtRKQ-0002yY-1M
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 01:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab3LSAS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 19:18:58 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:48975 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab3LSAS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 19:18:57 -0500
Received: by mail-qc0-f180.google.com with SMTP id w7so352440qcr.25
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 16:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BlmzNtrNkwang6ydIHaKf/dGog+7GdYhePnn7DRRwZE=;
        b=ObBsjV4kih8AbrcPtfCe4QqXw62qh175mQ/gFcBt/BM3/tyRI40bpMN9PObOPMWpDs
         BAxwjwPkw42H0SMOWnZJemtpC1/1MQpk15vSg0jqRezQlCgZYgVICu+VL9XpQVbWiSVN
         1E8MKJH6Juflp6rYBFIwe0lhBhzeuYcpbJo4BY2pr5nRiv0d/24B+B6oogEmIahonAWp
         QUn/T5E+raxbYonjX+jO4j6Gmly2gB5JbrW7X2gkIoaqBiH06CwTFLiA8gK/SmteRVYR
         EKev3KAnhGzdhk3sbsuBHTnrVvroFjKwbBgKYXqAdnQ6NrlANvetgp1g7uoowx338lKi
         Cxwg==
X-Received: by 10.49.12.102 with SMTP id x6mr59099962qeb.5.1387412336662;
        Wed, 18 Dec 2013 16:18:56 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id o3sm4937104qak.5.2013.12.18.16.18.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 16:18:55 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VtRKF-00046I-Pr; Wed, 18 Dec 2013 19:18:51 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239503>

I expect you've figured out what this patch series is about by now.
In this version, I've applied Junio's suggestions from the last
version, and also the stuff from the FIXUP commit he made after my
stuff in the branch he merged into 'pu'.

Samuel Bronson (3):
  diff: Tests for "git diff -O"
  diff: Let "git diff -O" read orderfile from any file, fail properly
  diff: Add diff.orderfile configuration variable

 Documentation/diff-config.txt  |   5 ++
 Documentation/diff-options.txt |   3 ++
 diff.c                         |   5 ++
 diffcore-order.c               |  23 ++++-----
 t/t4056-diff-order.sh          | 106 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 127 insertions(+), 15 deletions(-)
 create mode 100755 t/t4056-diff-order.sh

-- 
1.8.4.3
