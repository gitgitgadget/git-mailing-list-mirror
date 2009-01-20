From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] Provide pessimistic defaults for cross compilation
	tests.
Date: Tue, 20 Jan 2009 07:59:39 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20090120065939.GC5561@ins.uni-bonn.de>
References: <loom.20090115T123123-915@post.gmane.org> <20090116094110.GD25275@ins.uni-bonn.de> <20090119203400.GA3539@ins.uni-bonn.de> <alpine.DEB.1.00.0901200037510.3586@pacific.mpi-cbg.de> <7vab9mpu8w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julius Naperkowski <j.nap@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 08:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPAbj-0006Zz-LB
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 08:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbZATG7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 01:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbZATG7n
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 01:59:43 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:43327 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbZATG7m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 01:59:42 -0500
Received: from localhost.localdomain (xdsl-87-78-160-12.netcologne.de [87.78.160.12])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id CC573400031D5;
	Tue, 20 Jan 2009 07:59:40 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1LPAaJ-0001db-Tx; Tue, 20 Jan 2009 07:59:39 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julius Naperkowski <j.nap@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vab9mpu8w.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106445>

* Junio C Hamano wrote on Tue, Jan 20, 2009 at 03:49:03AM CET:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > How do you deal with the hardcoded limitation that uname_S is defined to 
> > be the output of "uname -s" on the _build_ system, and that quite a large 
> > part of the Makefile sets variables dependent on this?

Oh, up to now I have blissfully ignored cross-compilation issues in git
outside of configure.ac.  :-)

> > IOW are you certain that configure (with your patch) will override _all_ 
> > uname_S dependent settings?

No, I am certain they won't override them at all.

Fixing Makefile will be more (but independent) work.  All I did was get
configure.ac in shape to not error out in the face of cross compilation.

> It may be a valid question but it is not limited to cross compilation, is
> it?  The matter is if values the Makefile wants to default to can be
> overriden by whatever is placed in config.mak, and as long as that is Ok
> we won't have a problem with or without use of configure (which is a
> second class citizen).

Yeah, I figured that.  I assume it makes little sense to suggest adding
AC_CANONICAL_HOST to configure.ac, letting config.{guess,sub} do their
job, and the user to use "./configure --host=some-value" to specify a
host alias, and then using the computed host triple to decide features,
without the need to modify Makefile or other input files.

See, in a way I come from the GNU world here, and that's what I know
best.  Since git does its own setup here, I trust you will invent some
way to solve this.

Thanks,
Ralf
