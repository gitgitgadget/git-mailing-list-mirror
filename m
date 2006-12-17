X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_ADSP_DISCARD,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Sun, 17 Dec 2006 19:16:09 +0100
Message-ID: <17797.35177.550000.996862@lapjr.intranet.kiel.bmiag.de>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
	<46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
	<0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de>
	<Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com>
	<906f26060612170633h50e3e974h3b84f1829e546278@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 18:48:24 +0000 (UTC)
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Florian v. Savigny" <lorian@fsavigny.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1875 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 13:47:46 EST
In-Reply-To: <906f26060612170633h50e3e974h3b84f1829e546278@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34699>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw13c-0005fT-JC for gcvg-git@gmane.org; Sun, 17 Dec
 2006 19:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932411AbWLQSrs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 13:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWLQSrr
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 13:47:47 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:35364 "EHLO
 meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932418AbWLQSrr (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 13:47:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1]) by
 meriadoc.bmiag.de (Postfix) with ESMTP id 2665C3AED8; Sun, 17 Dec 2006
 19:16:26 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1]) by localhost (meriadoc
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 13553-08; Sun, 17 Dec
 2006 19:16:25 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de
 [10.130.2.1]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) by meriadoc.bmiag.de (Postfix) with
 ESMTP id 6E46A3AED2; Sun, 17 Dec 2006 19:16:21 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1]) by
 eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id C2B053ADC8; Sun, 17
 Dec 2006 19:16:21 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1]) by localhost
 (eotheod [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 13650-05; Sun,
 17 Dec 2006 19:16:18 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5]) by
 eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 3C55C3ADC6; Sun, 17
 Dec 2006 19:16:13 +0100 (CET)
To: "Stefano Spinucci" <virgo977virgo@gmail.com>
Sender: git-owner@vger.kernel.org

Stefano Spinucci writes:
 > I just tried to use git writing to my FAT32 formatted usb stick.
 > 
 > On windows XP, I compiled git with and without NO_D_TYPE_IN_DIRENT,
 > but after the
 > following actions I always got the error "fatal: Unable to write new
 > index file" or
 > "fatal: unable to create '.git/index': File exists":

Compile git with NO_MMAP. The problem is that the old index file is
mmaped while it is replaced. Cygwin supports this operation only on
NTFS. I don't know whether this is a bug in cygwin or a windows
limitation (I suspect the latter).

Unfortunately NO_MMAP makes git pretty slow if the pack files get
larger than about 10-20 MB.

Johannes claims that there are additional problems with mmap on
cygwin, but it passes the complete test suite on NTFS, so it should be
ok for most operations

IIRC it has been suggested on the list that mmaping the index isn't
that important for git performance and it could be replaced by simply
reading the index file into memory on access.

It would be nice to have mmap work on non-NTFS partitions since my
tests suggest that FAT32 is up to twice as fast (in the hot cache
case). (My test version simply uses an unlink before the rename in
lockfile.c to hack around the cygwin rename problem.)
