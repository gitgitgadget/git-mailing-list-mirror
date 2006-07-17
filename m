From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 18:32:03 +0200
Message-ID: <17595.48003.145000.414361@lapjr.intranet.kiel.bmiag.de>
References: <20060706055729.GA12512@admingilde.org>
	<87k66p8jee.fsf@mid.deneb.enyo.de>
	<Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<87fyh1ncm0.fsf@mid.deneb.enyo.de>
	<f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
	<20060716223607.GA6023@steel.home>
	<87d5c4ajlu.fsf@mid.deneb.enyo.de>
	<Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 18:48:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2WF4-0002Ux-Mx
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 18:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWGQQqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 12:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWGQQpB
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 12:45:01 -0400
Received: from meriadoc.bmiag.de ([62.154.210.133]:36244 "EHLO
	meriadoc.bmiag.de") by vger.kernel.org with ESMTP id S1750957AbWGQQcX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 581513AECB;
	Mon, 17 Jul 2006 18:32:20 +0200 (CEST)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19016-04; Mon, 17 Jul 2006 18:32:20 +0200 (CEST)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 45EF73AEC8;
	Mon, 17 Jul 2006 18:32:14 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 1192C3BB4D;
	Mon, 17 Jul 2006 18:32:14 +0200 (CEST)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00411-06; Mon, 17 Jul 2006 18:32:08 +0200 (CEST)
Received: from LAPJR (lapjr.intranet.kiel.bmiag.de [10.191.7.182])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id ECFBD3BB4C;
	Mon, 17 Jul 2006 18:32:05 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23975>

Johannes Schindelin writes:
 > > > It is not Cygwin really. It's windows. You can't rename or delete an
 > > > open or mmapped file in that thing.
 > > 
 > > And GIT's workaround is to read the whole file into memory and close
 > > it after that?  Uh-oh.
 > 
 > If you have a better idea (which does not make git source code ugly), go 
 > ahead, write a patch.

On several boxes I've tested the mmap code passes the tests on NTFS.

It is usable for my simple work even on FAT32 with an unlink before
the rename in lockfile.c, but that probably breaks in more involved
scenarios.

  jr
