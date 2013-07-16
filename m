From: Dirk Wallenstein <halsmit@t-online.de>
Subject: Re: [PATCH] howto: Use all-space indentation in ASCII art
Date: Tue, 16 Jul 2013 20:01:58 +0200
Message-ID: <20130716180158.GA7524@bottich>
References: <20130715164658.GA8675@bottich>
 <7v61wba3gu.fsf@alter.siamese.dyndns.org>
 <20130716082413.GA27283@bottich>
 <CAPc5daXZxkLOJwzaoSMZvJ87zYvns1MeYZU=RoEK=CQYP1qpag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 20:02:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz9Zm-0003Xw-93
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933356Ab3GPSCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:02:09 -0400
Received: from mailout06.t-online.de ([194.25.134.19]:51433 "EHLO
	mailout06.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932988Ab3GPSCI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:02:08 -0400
Received: from fwd53.aul.t-online.de (fwd53.aul.t-online.de )
	by mailout06.t-online.de with smtp 
	id 1Uz9Zd-0006RA-E8; Tue, 16 Jul 2013 20:02:05 +0200
Received: from localhost (Tn++pUZf8hN86RfRHa-V3dG+fR2gXSIE+uZrJ4IubRorPgHx8gp-vabGms7rWjBgZ3@[178.202.218.27]) by fwd53.t-online.de
	with esmtp id 1Uz9ZZ-0MfQxs0; Tue, 16 Jul 2013 20:02:01 +0200
Content-Disposition: inline
In-Reply-To: <CAPc5daXZxkLOJwzaoSMZvJ87zYvns1MeYZU=RoEK=CQYP1qpag@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ID: Tn++pUZf8hN86RfRHa-V3dG+fR2gXSIE+uZrJ4IubRorPgHx8gp-vabGms7rWjBgZ3
X-TOI-MSGID: 0c12c33f-cc21-4156-a1ac-c580a1fdcc96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230567>

On Tue, Jul 16, 2013 at 10:13:28AM -0700, Junio C Hamano wrote:
> > Why would you want to limit those files to be source for HTML only?
> >
> > The HTML after this patch is still fine.
> 
> Have you thought the reason why the formatted result _before_ the patch is good?
No, as I said, *.txt suffixes tell me there is text in there and not
source code.  But what is more important is that they are installed (by
Git) as is (obviously) into share/doc.  I'm happy to learn about the
conversion through these posts, but the installation is flawed.

> These *.txt files are asciidoc formatted source files. They are meant
> to be easy to read and edit without distracting mark-ups (unlike roff
> and html), but with one big precondition: your tab-width ought to be
> 8. That is how asciidoc expands the tab when producing the formatted
> output, and that is why the formatted result _before_ the patch is
> good.
asciidoc replaces the other spaces in the sketch with spaces in the
result.  Hard to believe it stops doing that if it is accidentally a
sequence of 8 spaces.  And spaces are invisible by design.  Whitespace
only distracts if it leads to a wrong result.
> 
> Expanding these tabs to all spaces do not buy us anything, other than
> source code bloat, and with one downside.
Correctness maybe, if you open them in an editor to read them.  Imagine
the code bloat when the installation procedure expands the tabs so that
the final installation is correct.

> It would give a false impression that it somehow is OK to open these
> *.txt files with a wrong tab-width setting, and even worse, edit them.
> You may even type a new tab yourself to indent by 4 places, and
> formatted result will be broken by such a person.
Luckily there are whitespace checks for mixed space and/or tab-indent.
The right approach would probably be to have no tabs indent in any of
these files.  I'm happy to assist ;)
> 
> It would signal that your tab-width setting is not suitable to
> view/edit these files if the elements in the illustration do not line
> up. View it as a bonus safety feature ;-)
gitattributes could solve that much more reliable if there wasn't any
tab indentation allowed.

In the end, this is installed as documentation with a requirement on the
tab-width of any reader application used.  The easiest and most foolproof
solution without introducing errors is to simply expand these tabs.
Again, the current installation is flawed.

-- 
Cheers,
  Dirk
