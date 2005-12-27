From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] t5300 considered dangerous
Date: Tue, 27 Dec 2005 15:08:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512271507490.318@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512270018310.3067@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5jjffxu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512271452470.17086@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 15:08:36 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErFVC-0004pK-Md
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 15:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVL0OIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 09:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVL0OIc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 09:08:32 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:37821 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932318AbVL0OIb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 09:08:31 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6BF67E3EFE; Tue, 27 Dec 2005 15:08:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 5FEC4344F;
	Tue, 27 Dec 2005 15:08:30 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 43E70861;
	Tue, 27 Dec 2005 15:08:30 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 17E421415B2; Tue, 27 Dec 2005 15:08:30 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0512271452470.17086@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14076>

Hi,

On Tue, 27 Dec 2005, Johannes Schindelin wrote:

> On Mon, 26 Dec 2005, Junio C Hamano wrote:
> 
> >       cp test-1-${packname_1}.pack test-3.pack &&
> > -     dd if=/dev/zero of=test-3.idx count=1 bs=1 conv=notrunc seek=1200 &&
> > +     dd if=/dev/zero of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
> >       if git-verify-pack test-3.pack
> >       then false
> >       else :;
> 
> When the commit is not skipped, I fail to see why this should not fail in 
> one out of 256 cases: the input is (partially) pseudo-random. The last 20 
> bytes are the SHA-1 which should inherit this pseudo-randomness. So, the 
> first byte should be pseudo-random, too.
> 
> Something I missed?

Yes, I missed the "count=20".

Sorry,
Dscho
