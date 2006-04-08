From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Funny repack behaviour
Date: Sat, 8 Apr 2006 12:41:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604081233170.3283@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 08 12:41:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSAsu-00030I-Fp
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 12:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWDHKlU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 06:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWDHKlU
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 06:41:20 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28067 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964800AbWDHKlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 06:41:19 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 97B4ACC7
	for <git@vger.kernel.org>; Sat,  8 Apr 2006 12:41:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 8BD51CC2
	for <git@vger.kernel.org>; Sat,  8 Apr 2006 12:41:15 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 766A0B9F
	for <git@vger.kernel.org>; Sat,  8 Apr 2006 12:41:15 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18514>

Hi,

I just accidentally reran "git-repack -a -d" on a repository, where I just 
had run it. And I noticed a funny thing: Of about 4000 objects, it reused 
all but 8. So I reran it, and it reused all but 2. I ran it once again, 
and it reused all.

The really funny thing is: it created the same pack every time!

It is not critical, evidently, but I'd like to know what is causing this 
rather undeterministic behaviour. (Before you ask: no, I did not make a 
backup before running the tests, so I unfortunately cannot reproduce it).

Ciao,
Dscho

P.S.: This is the output:

$ git-repack -a -d
Generating pack...
Done counting 4259 objects.
Deltifying 4259 objects.
 100% (4259/4259) done
Writing 4259 objects.
 100% (4259/4259) done
Total 4259, written 4259 (delta 3391), reused 4241 (delta 3379)
Pack pack-66bd976bbdc2ac6da623b8af02037218ecd72ef0 created.
$ git-repack -a -d
Generating pack...
Done counting 4259 objects.
Deltifying 4259 objects.
 100% (4259/4259) done
Writing 4259 objects.
 100% (4259/4259) done
Total 4259, written 4259 (delta 3393), reused 4257 (delta 3391)
Pack pack-66bd976bbdc2ac6da623b8af02037218ecd72ef0 created.
$ git-repack -a -d
Generating pack...
Done counting 4259 objects.
Deltifying 4259 objects.
 100% (4259/4259) done
Writing 4259 objects.
 100% (4259/4259) done
Total 4259, written 4259 (delta 3393), reused 4259 (delta 3393)
Pack pack-66bd976bbdc2ac6da623b8af02037218ecd72ef0 created.
