From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: git-remote: Use of uninitialized value in string ne, line 248
Date: Wed, 24 Oct 2007 22:40:11 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071024204010.GC15978@ins.uni-bonn.de>
References: <20071024110807.GA12501@piper.oerlikon.madduck.net> <7vwstc68bk.fsf@gitster.siamese.dyndns.org> <20071024193954.GA5280@steel.home> <20071024202724.GA2292@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 22:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikn1n-0008Ir-Em
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 22:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759627AbXJXUkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 16:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759620AbXJXUkQ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 16:40:16 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:60522 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759127AbXJXUkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 16:40:14 -0400
Received: from localhost.localdomain (xdsl-87-79-255-52.netcologne.de [87.79.255.52])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 23F22400009F6;
	Wed, 24 Oct 2007 22:40:12 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1Ikn1P-0004Bt-AT; Wed, 24 Oct 2007 22:40:11 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071024202724.GA2292@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62238>

* martin f krafft wrote on Wed, Oct 24, 2007 at 10:27:24PM CEST:
> 
> perl -e 'print "The earth is a disk!\n" if ( "earth" == "flat" );'

Well, numerical equality and string equality are two different things,
try eq instead (see: perldoc perlop).

> Is there a way to make it explicit that you're checking for a value
> being defined, where a "false" value would count as true, just as
> long as there is a value?

Yes.  It's called "defined".
  perl -e 'my $a=0; print "yes\n" if defined $a;'

It should be used here, to allow "0" branches.

Cheers,
Ralf
