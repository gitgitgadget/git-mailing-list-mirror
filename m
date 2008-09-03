From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: gitweb pathinfo improvements
Date: Wed,  3 Sep 2008 11:57:14 +0200
Message-ID: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 11:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kap8O-0000SL-A5
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbYICJ5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYICJ5Y
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:57:24 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:13977 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbYICJ5X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:57:23 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1366057eyi.37
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=f9gCGz2Mb+Tga22EPbsiAwphicZVej9i1J1UBLEK/xU=;
        b=hRQNqwUm1nIUUaMAyGmWLZqAJHkmzq1iAHZ9Mk0B77VUehoOIyXm89Djq7sI6HQvBw
         JNstatAFi76ARGVfCLVHgZBTXuc65K/7LvclH6a5tF3REIiiq5m8Nm0nQiQ+5jWHW3eC
         bik6BGZ2HdAlO+Q9Z9T82VEedO18e/0KbEg+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LekyLlBCNMYywzbphv0f9oXURMoqbzQ7sNya5bSCFYrZUg1vPa3VjNWHBcS6jmqYx0
         5LpC9i/Pvc2KjumR7CC79jAVyiMDKLisyJlNTJbCvdSZeazBY3MlT4AZXiuMwzvuAWmW
         Y1d0+48MT1cJyQXmqbzUITe47Ww5d6xYgqSbs=
Received: by 10.210.105.19 with SMTP id d19mr9828222ebc.110.1220435841643;
        Wed, 03 Sep 2008 02:57:21 -0700 (PDT)
Received: from localhost ( [78.15.13.249])
        by mx.google.com with ESMTPS id 1sm7203215nfv.18.2008.09.03.02.57.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 02:57:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94779>


The following patchset improves on gitweb's support for PATH_INFO
by supporting paths in the form project/action/[parent..]hash,
both in generating them and in accepting them. The old path info
style project/hash is still supported as long as it doesn't
conflict with the new style

For those that prefer git trees to patch bombs, my git tree is
available for gitweb browsing at http://git.oblomov.eu/git and for
git cloning at git://git.oblomov.eu/git/git

The changes are very local to the PATH_INFO parsing and creation,
so I hope they don't conflict with Lea's cache work.
