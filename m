From: Pavel Roskin <proski@gnu.org>
Subject: Re: parsecvs and unnamed branches
Date: Sat, 17 Jun 2006 00:35:50 -0400
Message-ID: <1150518950.9144.17.camel@dv>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
	 <9e4733910606162002x508ec6ccjbc36e4220ca44fd6@mail.gmail.com>
	 <1150513943.29738.15.camel@dv>
	 <9e4733910606162031o69df27fdje50c88949ed990b5@mail.gmail.com>
	 <1150517336.9144.8.camel@dv>
	 <9e4733910606162115g2165212bgf32a2e328cce751a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Keith Packard <keithp@keithp.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 06:36:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrSXa-0007E0-Dx
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 06:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWFQEfz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 00:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWFQEfz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 00:35:55 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:8887 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750821AbWFQEfy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 00:35:54 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FrSXJ-0004iV-Em
	for git@vger.kernel.org; Sat, 17 Jun 2006 00:35:53 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FrSXG-00036h-Ra; Sat, 17 Jun 2006 00:35:50 -0400
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606162115g2165212bgf32a2e328cce751a@mail.gmail.com>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21999>

On Sat, 2006-06-17 at 00:15 -0400, Jon Smirl wrote:
> I had already caught that one, the fix was a few mails back.
> git_dir is an atom and shouldn't be freed with free.

I see it now.  My patch was wrong - there is another free(git_dir) in
the same function.  Keith, please remove both.

> After five hours I hit this:
> fprintf (stderr, "Error: branch cycle\n");

This is more like a logical error.  Maybe you actually have circling
branches due to causality violations or something :-)

Sure, Valgrind would be still useful to make sure it's not something
mundane.

-- 
Regards,
Pavel Roskin
