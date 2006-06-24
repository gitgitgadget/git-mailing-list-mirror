From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 0/7] Rework diff options
Date: Sat, 24 Jun 2006 20:18:43 +0300
Message-ID: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 19:30:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuBxl-0001XZ-6k
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 19:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWFXRaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 13:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWFXRaQ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 13:30:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:12043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750940AbWFXRaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 13:30:14 -0400
Received: by nf-out-0910.google.com with SMTP id m19so402611nfc
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 10:30:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Xz8uQXsMj7HNNy6OHK1djgKJ1BAC1L3qu925at46CIxu8G9I4wTeFCeUGv3Svg1XrH5W+8uXjsTkPWwKboMKBSQ1B6HR/yDwIOABRqLx6SLm+ospzM4Nf7B6ax7vrvBA+oI/OBdamQZT6F6yNoNdmOjpH9YklOG6IB3eDo20Ibc=
Received: by 10.48.163.7 with SMTP id l7mr3541087nfe;
        Sat, 24 Jun 2006 10:30:12 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id p72sm2585713nfc.2006.06.24.10.30.11;
        Sat, 24 Jun 2006 10:30:12 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22531>

This patch series cleans up diff output format options.

This makes it possible to use any combination of --raw, -p, --stat and
--summary options and they work as you would expect.

These patches passed all test and are for the next branch. Patches 6 and
7 are optional.

 b/builtin-diff-files.c  |   10 --
 b/builtin-diff-index.c  |    3 
 b/builtin-diff-stages.c |    3 
 b/builtin-diff-tree.c   |    3 
 b/builtin-diff.c        |   62 +++----------
 b/builtin-log.c         |   13 +-
 b/combine-diff.c        |   55 +++++------
 b/diff.c                |  221 +++++++++++++++++++++++-------------------------
 b/diff.h                |   27 +++--
 b/log-tree.c            |   10 +-
 b/revision.c            |    4 
 11 files changed, 189 insertions(+), 222 deletions(-)

-- 
http://onion.dynserv.net/~timo/
