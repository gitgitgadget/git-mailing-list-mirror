From: "Michael G. Schwern" <schwern@pobox.com>
Subject: Teach Makefile.PL to find .pm files on its own
Date: Tue, 24 Jul 2012 20:21:08 -0700
Message-ID: <1343186471-1024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 25 05:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StsAK-00069S-R1
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782Ab2GYDVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:21:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57952 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab2GYDVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:21:31 -0400
Received: by pbbrp8 with SMTP id rp8so662367pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=rV7sbWeCcHcXyd+WRrNHcSqNAKkpvxlwYbNUtR6bxPE=;
        b=nO0/qymDdOaQTMMCevnGal+XCOT/EXzRBWvzUasRNB8m1690HXR4/yAhtxnJzcQij2
         ImcyEV4xBM9K1mGaHqnTFuf1gqPvUumCYmJ0yqqr0rJaD8GwbUlLc0tEydtjpy8sSWse
         JUfcYkyv693c1ZPYn3W4qQo9wPHGkoro3i8s1bSvMDyaXvZnA4JonhtQAuMDawMvb1Ch
         6BHS92i1PnDz9X8XGoARxoqWAZuOvoagXo3kxgjuTHqqdBiXvLRvIO+08ABSUHMP3M3q
         tDxnVUmTWRhE2G4cVDDv0c2UjRSSFNJyuIrWIdcNa9JFs5sIvYbkdH72PdxURKjwwhnP
         P2Ug==
Received: by 10.68.218.163 with SMTP id ph3mr19799745pbc.58.1343186490889;
        Tue, 24 Jul 2012 20:21:30 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id hf5sm13423597pbc.4.2012.07.24.20.21.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:21:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202105>

This makes it so you no longer must edit the Makefile.PL every time you
add, rename or delete a Perl module.  This is convenient, and I'm about
to extract a bunch of .pm files out of git-svn.

You still have to edit the Makefile. That parallel build system should be
able to be removed at a later date and replaced with the right Makefile.PL
flags.

Patch 1 and 2 are just things I noticed in the Makefile.PL along the way.
Patch 3 is the meat.  It doesn't depend on 1 & 2 but I figured it would
be silly to send them separately.
