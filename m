From: Junio C Hamano <junkio@cox.net>
Subject: Re: disable the compile-flags-changed check
Date: Sat, 15 Jul 2006 14:48:18 -0700
Message-ID: <7vbqrqmtel.fsf@assigned-by-dhcp.cox.net>
References: <E1G1GVy-00007o-PM@moooo.ath.cx>
	<7v7j2gsotv.fsf@assigned-by-dhcp.cox.net>
	<E1G1qAS-0005gv-P7@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 15 23:48:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1rzt-000188-Gr
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 23:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWGOVsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 17:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWGOVsU
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 17:48:20 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:64750 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161066AbWGOVsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jul 2006 17:48:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060715214819.YAIL6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Jul 2006 17:48:19 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G1qAS-0005gv-P7@moooo.ath.cx> (Matthias Lederhofer's message
	of "Sat, 15 Jul 2006 21:51:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23938>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Matthias Lederhofer <matled@gmx.net> writes:
>> 
>> > Is there any way to disable the "the compile flags have changed,
>> > recompile everything" check?  I want to built with another prefix than
>> > installing to create a tarball I copy to other machines.  Is there any
>> > way to do this?
>> 
>> Perhaps
>> 
>> 	DESTDIR=/var/tmp/ make prefix=/usr install
>> 
>> is what you are looking for?
>
> Thanks, this works.

By the way, in older days before binary distributions have
become _the_ way for the end users to get programs, "install
into a saparate place for tarring up" needed to be custom job
per package, because Makefiles of many packages were not set up
to easily allow it (like DESTDIR= stuff).  These days, allowing
it is almost a requirement in order to make binary distros'
lives easier, so if a program is packaged for some binary
distros (say, RPM or deb), often the easiest way to figure out
the answer to your question is to see how they build their
packages out of the source.
