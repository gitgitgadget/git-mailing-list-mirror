From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: CR codes from git commands
Date: Fri, 23 Jan 2009 08:12:16 -0800
Message-ID: <18809.60512.654436.59819@hungover.brentg.com>
References: <18805.64312.289059.660023@hungover.brentg.com>
	<alpine.LNX.1.00.0901212319310.19665@iabervon.org>
	<e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
	<alpine.LNX.1.00.0901220238380.19665@iabervon.org>
	<7vbptzahra.fsf@gitster.siamese.dyndns.org>
	<e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com>
	<18808.39712.351656.138702@hungover.brentg.com>
	<alpine.LNX.1.00.0901221117110.19665@iabervon.org>
	<alpine.DEB.1.00.0901221751320.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Brent Goodrick <bgoodr@gmail.com>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 17:13:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQOfF-0000Gw-H7
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 17:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216AbZAWQMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 11:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbZAWQMV
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 11:12:21 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:38534 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898AbZAWQMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 11:12:20 -0500
Received: by rv-out-0506.google.com with SMTP id f9so503171rvb.5
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:mime-version
         :content-type:content-transfer-encoding:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer;
        bh=eKHx+Jjr0xb166+QBuZRvOJZIWOVZYzpOlREhctS74E=;
        b=E4SQ7DSvO6EcWRRhsuRGeV+0odxzgCmhJB4W648Fmk7Ea4APtlya2OTZ8Z85G1TPEl
         hTH7Km9Y7x8TcYCnfKq1VJMqzeYLpjb5cMkM0Liy+q5XC94Tf/Zy7M8JOiMDPa99eiEX
         oVJ7U31mHwfq+v88vd2l1K+iMz8DcF97OdVno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:mime-version:content-type:content-transfer-encoding:message-id
         :date:to:cc:subject:in-reply-to:references:x-mailer;
        b=uPWWLud7h+eISA2p8lTwG6vC35WMWe3VC4Bb7hN+RaGmOop/CQ4/bR8NelHcQv6XK2
         6VL13Jc6jLuWJdgKXPfkK/X8EkS776pvx4c3t+K9npL18iM9Go+NsVYPDWcHx4FnLxXF
         PxW/t7KehR/e0XZaSOsxqqrjQaFIiO5FS05Kw=
Received: by 10.141.193.1 with SMTP id v1mr640813rvp.186.1232727139594;
        Fri, 23 Jan 2009 08:12:19 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id k41sm9240407rvb.3.2009.01.23.08.12.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jan 2009 08:12:18 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901221751320.3586@pacific.mpi-cbg.de>
X-Mailer: VM viewmail-606 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106886>



Johannes Schindelin writes:
 > Hi,
 > 
 > On Thu, 22 Jan 2009, Daniel Barkalow wrote:
 > 
 > > In any case, it's all done in progress.c, so it should be easy enough to 
 > > make changes to if you can come up with something better to do with 
 > > progress messages and some way to determine when it should be done.
 > 
 > Maybe "git --no-progress <program>" would be a sensible user
 > interface?

Thanks. I now see the \r reference inside the "display" file-static
function inside progress.c.

However, I propose to add two options, the first being, IMO, the
minimal one to implement, and the second being "nice-to-have":

 - Bare minimum: Add a new --no-cr option (e.g., "git --no-cr
   <program>") that would prevent any git code (inside progress.c or
   elsewhere) from emitting a CR code from stdout or stderr.  This has
   the effect of allowing progress messages, but not asking too much
   of terminals-that-are-not-really-terminals such as the GNU Emacs
   shell mode.

 - Nice-to-have: Add a "git --no-progress" message that would never
   show progress at all (e.g., perhaps by not installing a signal
   handler inside progress.c such that no messages would not be
   emitted at all.

Both options are intended to be independent of each other.

And for both options, I would like there to be a config option to
allow the user to enable said behavior globally across all git
operations covered by that config file.

I might be willing to take a swipe at this myself and submit a patch,
provided I receive adequate noobie hand-holding (or hand-slapping) on
patch submission and test case development.

bg
