From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: [ANNOUNCE] Guilt v0.31
Date: Tue, 09 Sep 2008 12:10:19 +0200
Message-ID: <48C64B8B.5000606@fastmail.fm>
References: <20080908135244.GB27550@josefsipek.net> <36ca99e90809081133s58e3d32h8b85804f5bb76902@mail.gmail.com> <20080908184322.GE27550@josefsipek.net> <36ca99e90809081150v4ad6e7a0n72b5cca39e02b1bc@mail.gmail.com> <7vmyiifnwa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Josef 'Jeff' Sipek <jeffpc@josefsipek.net>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	guilt@lists.josefsipek.net, Brandon Philips <brandon@ifup.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 12:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd0C4-00075R-S9
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 12:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbYIIKKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 06:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbYIIKKZ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 06:10:25 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44613 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751493AbYIIKKY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 06:10:24 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id E540D15D1EA;
	Tue,  9 Sep 2008 06:10:22 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 09 Sep 2008 06:10:22 -0400
X-Sasl-enc: jAiI6Whee29Pn8lrK9efuYQDTWA6xVdBAp2lbW4gK8FK 1220955022
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9163229CE7;
	Tue,  9 Sep 2008 06:10:21 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <7vmyiifnwa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95368>

Junio C Hamano venit, vidit, dixit 08.09.2008 21:17:
> "Bert Wesarg" <bert.wesarg@googlemail.com> writes:
> 
>> I must admit, that I don't like these extra tarballs with docs. I
>> always expect, that the manpages are nicely installed if I type 'make
>> install' (or at least with a install-doc target). But I need to
>> download this extra package, and extract it to the right place, there
>> is no Makefile whatsoever. In case of git its really annoying, because
>> the help mechanism is relying on the manpages (i.e. git help <cmd> or
>> git <cmd> --help, but you know this).
> 
> There is no need to feel "it[']s really annoying", as install-doc from the
> tarball distribution works out of the box.
> 
> I used 1.6.0.1 in the demonstration below, but this is nothing new in that
> version but has been like this for quite some time (it is how sample RPMs
> binary packages are built, so the procedure ought to work):
> 
>     $ ls -1 /usr/bin/git ;# to show there is no other "git" on this box
>     ls: /usr/bin/git: No such file or directory
>     $ mkdir /var/tmp/16
>     $ cd /var/tmp/16
>     $ wget http://www.kernel.org/pub/software/scm/git/git-1.6.0.1.tar.gz
>     $ tar xf git-1.6.0.1.tar.gz
>     $ cd git-1.6.0.1
>     $ make prefix=/var/tmp/16test install install-doc
>     $ PATH=/var/tmp/16test/bin:/usr/bin:/bin
>     $ export PATH
>     $ unset MANPATH
>     $ git help cat-file | cat -s | tail -n 8
>     Reformatting git-cat-file(1), please wait...
>     DOCUMENTATION
>            Documentation by David Greaves, Junio C Hamano and the git-list
>            <git@vger.kernel.org>.
> 
>     GIT
>            Part of the git(1) suite
> 
>     Git 1.6.0.1                       09/08/2008                   GIT-CAT-FILE(1)
> 

This works because you have the full toolchain, especially xmlto.
asciidoc'ing directly to man (bypassing xmlto) may help some of us.

> The extra tarballs for documentation are also given as courtesy because
> they are supposed to be platform independent and some people do not want
> to generate them themselves (even though they could).
> 
> Either be thankful for the availability of tarballs, or ignore them and
> generate them yourself --- it's your choice.

He might want an install target which installs doc from the doc-tarball
or from the man- and html-branches. Be it a Makefile in those
convenience branches. I know it's just a tar or cpio away, of course. I
might look at a Makefile for the doc branches.

Michael
