From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Comments on recursive merge..
Date: Tue, 8 Nov 2005 12:58:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Nov 08 13:00:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZS7r-0005GB-GI
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 12:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbVKHL6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 06:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVKHL6w
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 06:58:52 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:30171 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965153AbVKHL6w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 06:58:52 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4C99D13F254; Tue,  8 Nov 2005 12:58:51 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 20DAFB50EE; Tue,  8 Nov 2005 12:58:51 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 04DD4B4FCA; Tue,  8 Nov 2005 12:58:51 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6E66813F26D; Tue,  8 Nov 2005 12:58:50 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11328>

Hi,

On Mon, 7 Nov 2005, Linus Torvalds wrote:

> Is the recursive thing noticeably slower for the "easy" cases (ie things 
> that the old regular resolve strategy does well)?

IIRC recursive does nothing else than recursively merging the merge-bases 
(granted, in a clever way). So if there is only one merge-base, the only 
slow-down would be the startup of python (which is probably worth it, 
anyway).

> It's certainly an option to just do what I just did, namely use the 
> default one until it breaks, and then just do "git reset --hard" and re-do 
> the pull with "-s recursive". A bit sad, and it would be good to have 
> coverage on the recursive strategy..

We already have a fallback list: after really-trivial, try automatic, ...,
try resolve. Why not just add recursive? So, if even resolve failed, just 
try once more, with recursive.

Ciao,
Dscho
