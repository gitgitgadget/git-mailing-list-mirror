From: Junio C Hamano <junkio@cox.net>
Subject: Re: file name case-sensitivity issues
Date: Tue, 23 May 2006 15:57:04 -0700
Message-ID: <7v7j4c4af3.fsf@assigned-by-dhcp.cox.net>
References: <20060523210615.GB5869@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 00:57:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FifoL-0006NH-Ui
	for gcvg-git@gmane.org; Wed, 24 May 2006 00:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWEWW5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 18:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWEWW5G
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 18:57:06 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:33018 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932275AbWEWW5F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 18:57:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060523225704.FHRH27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 May 2006 18:57:04 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060523210615.GB5869@steel.home> (Alex Riesen's message of
	"Tue, 23 May 2006 23:06:15 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20646>

fork0@t-online.de (Alex Riesen) writes:

> Very simple to reproduce on FAT and NTFS, and under Windows, as usual,
> when a problem is especially annoying. I seem to have no chance to
> get my hands on this myself, so I at least let everyone know about the
> problem.

Isn't it like complaining that the following sequence loses your
precious file on a case-challenged filesystem?

	$ echo precious contents >foo
        $ rm -f FOO

Is it a problem for the user?  Certainly yes.  You lost your
precious file.

Is it a bug in the operating system and/or the filesystem?
Probably not; it is doing what it is asked to do -- its
definition of what string matches what file on the filesystem is
dubious, but that is how it sees the world and you accept that
view while you are on such a system.  Is it a bug in "rm"?
Probably not; it is doing what it is asked to do within the
context that you gave it.

I'd call that a PEBCAK.

If you _know_ you are working on a case challenged filesystem, I
think the best thing you can do is not to work on a project that
has files in different cases on such a filesystem.
