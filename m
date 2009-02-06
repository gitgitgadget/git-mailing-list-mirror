From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 06 Feb 2009 14:12:29 -0800
Message-ID: <7vskmr43le.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
 <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
 <buobptg6tek.fsf@dhlpc061.dev.necel.com>
 <7vfxis86tp.fsf@gitster.siamese.dyndns.org>
 <buor62c3yin.fsf@dhlpc061.dev.necel.com>
 <7vprhw6l1i.fsf@gitster.siamese.dyndns.org>
 <buoab8z52te.fsf@dhlpc061.dev.necel.com>
 <7vd4dv7tb3.fsf@gitster.siamese.dyndns.org>
 <20090206192505.GE19494@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, gyles19@visi.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 23:14:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVYxc-0007Nz-2e
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 23:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbZBFWMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 17:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbZBFWMk
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 17:12:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbZBFWMk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 17:12:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DD6FD9705C;
	Fri,  6 Feb 2009 17:12:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F37389705B; Fri,
  6 Feb 2009 17:12:31 -0500 (EST)
In-Reply-To: <20090206192505.GE19494@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 6 Feb 2009 14:25:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43FDF59A-F49B-11DD-8FBE-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108794>

Jeff King <peff@peff.net> writes:

> Now, in this case, it was only one tweak and other responders have
> already pointed him in the right direction. So just making that tweak
> manually is probably the sane thing to do in this situation.
>
> But I wanted to point out that autoconf is not totally without value
> here.

I am not saying something that strong, either.  If autoconf generated
configure works _for you_ without hassle, great.  Keep using it.

The original message that started this thread was what to do when it does
NOT work for you, and my point was in general it is much nicer to point at
the knob to tweak from the make invocation command line (or in config.mak)
than having you spend time on upgrade autoconf, generate configure and run
it.

Fanboys may say that autoconf generated configure is the greatest thing
since sliced bread.  But let's face it.  Honestly, the track record of
those people in keeping autoconf part in this project up-to-date has not
been all that great.  There are things that the generated configure file
does not detect nor configure correctly (we had --with-expat patch, and we
also saw "the trailing slash in template_dir definition in config.mak.in"
discussed fairly recently).  You are much better off tweaking known
peculiarity of your platform in config.mak, when configure does not work
out of box for you.
