From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/5] Makefile: add missing header dependency rules
Date: Sat, 23 Jan 2010 08:42:01 -0600
Message-ID: <20100123144201.GA11903@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 15:42:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYhBi-0001Od-PD
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 15:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab0AWOmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 09:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943Ab0AWOmA
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 09:42:00 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:38297 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab0AWOmA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 09:42:00 -0500
Received: by iwn16 with SMTP id 16so925995iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 06:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=iBqiMi+PG3FLiObGptFKhuFuMKoFCJ045sMjt15DcwM=;
        b=HxY3r7j3/bGXh6nSgBTzdPL4PypA2XpJMnfsL+i6ujryK+Rt1ctPcXpeD32g52+Fyb
         j7zDYgUzkMeP90MvBj87XcSf+cMG2jGhtEPo0b7hUX3iRJNQPHkCDL0LRobl+Aoo7eGl
         HG6tI7sEtEbR/TN8pMbMBfYDCBQwcYgnpbHJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Evkq2hJR4HlwTZ9ENTLrVuL22VyUUPXT0VuDlix26k5BkrRu5jWwlfESGaOQ1Sv4Di
         ag9Pbt2Y0/3L1lVHkXqjLRl9/7o0A5Ilt3NeDc1X/uASa+5P7H/mmdo85ctLlWanlas+
         W9YaHZ3Q1J6gAIZoC7KgSnQAbTWnigEQ78qH4=
Received: by 10.231.150.142 with SMTP id y14mr491177ibv.32.1264257719547;
        Sat, 23 Jan 2010 06:41:59 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2825720iwn.5.2010.01.23.06.41.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 06:41:59 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137842>

Hi,

As a side-effect of generating dependency rules during the build
locally, it is possible to sanity-check the existing hard-coded
header file dependencies. [1]  Now the original topic of that thread [2]
can be addressed without collateral damage.

That is what patches 1 and 2 do.  The remaining patches are small
clean-ups that decrease the amount of dependencies again.

These patches are independent of the jn/makefile topic.  I sent them
before, but I screwed up the sender so nobody received them.  Anyway,
perhaps they could be useful.

Jonathan Nieder (5):
  Makefile: add missing header file dependencies
  Makefile: make sure test helpers are rebuilt when headers change
  Makefile: remove wt-status.h from LIB_H
  Makefile: clean up http-walker.o dependency rules
  Makefile: drop */*.h dependency rule

 Makefile |   58 +++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 37 insertions(+), 21 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/133872/focus=136257
[2] http://thread.gmane.org/gmane.comp.version-control.git/133872/focus=133884
