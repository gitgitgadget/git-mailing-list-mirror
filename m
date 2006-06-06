From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig 0.4
Date: Tue, 6 Jun 2006 14:18:12 +0200
Message-ID: <20060606121812.GA4618@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jun 06 14:18:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnaVp-0005LV-VY
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 14:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWFFMSQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Jun 2006 08:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWFFMSQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 08:18:16 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:33729 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751306AbWFFMSQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 08:18:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 11D78770038
	for <git@vger.kernel.org>; Tue,  6 Jun 2006 14:18:15 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17455-20 for <git@vger.kernel.org>; Tue,  6 Jun 2006 14:18:12 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 96720770006
	for <git@vger.kernel.org>; Tue,  6 Jun 2006 14:18:12 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 935716DF893
	for <git@vger.kernel.org>; Tue,  6 Jun 2006 14:14:53 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 7CB8E6260A; Tue,  6 Jun 2006 14:18:12 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21375>

Hello,

Too many improvements to keep me longer from releasing version 0.4 of
tig, the text-mode interface for git. First off, a big thanks to Aneesh
Kumar for helping with improving the basic user interface. Among the
highlights, colors are now configurable in ~/.tigrc and the diff and
main views are better integrated. For more info, changes I feel are
most important can be found below.

I hope to focus more on fixing some of the accumulated bugs for tig-0.5=
=2E
A particular embarrassing one, is the problem with text wrapping for
long lines which can end up corrupting the screen. But there should als=
o
be room for a first shot at displaying revision graph and maybe
configurable keybindings.

A list of tig resources:

 - Homepage: http://jonas.nitro.dk/tig/
 - Tarballs: http://jonas.nitro.dk/tig/releases/
 - Git URL:  http://jonas.nitro.dk/tig/tig.git
 - Gitweb:   http://pasky.or.cz/gitweb.cgi?p=3Dtig.git;a=3Dsummary

Tarballs contain all the generated documentation, as do the #release
branch of the git repository. Thanks to pasky for the gitweb hosting.

---

Jonas Fonseca:
      Redraw the whole display after toggling line number
      Bind quit to 'Q'
      Add close view request; bound to 'q' by default
      Add preliminary support for UTF-8 handling in the main view
      Make Enter in the main view switch to the split diff view
      Pressing Enter in the diff view will now scroll it one line down
      Bind '-' to PageUp; raises Mutt compatibility
      Bind 'j'/'k' to moving up/down; add next/previous requests bound =
to Down/Up
      Make -h and --help options ouput a help message
      Record builds with dirty working tree by appending -dirty to the =
version
      Make Enter in the pager view always scroll
      Add simple window stack, tracking view relation ship via parent m=
ember
      Move git directory assertion to main; don't require .git repo in =
pager mode
      Add -O2 to CFLAGS to get more warnings
      Make update reporting less verbose
      Improve title updating and remove flickering
      Introduce struct line and use it for view->line
      Add support for loading repo config
      Make UTF-8 handling optional but still default
      Never close backgrounded loads; only clear window when starting t=
o update
      Make window switching smother; fix blurring of previous view when=
 switching
      When updating the title window, move the cursor to the end of lin=
e
      Tab size short option changes from -t to -b
      Notify that the prompt is unusable while loading
      Make the stop all loading request stop all loading
      Document the loading time displayed in the title window after 3 s=
econds
      Various usability improvements
      Add support for setting color options in ~/.tigrc
      Fix segfault where current_view would become >=3D sizeof(display)
      Rename documentation build rules using s/docs/doc/; more like git
      Make 'h' and '?' show built-in key binding quick reference
      Add support for showing tags and other repo refs in the diff and =
log view
      Move documentation out of tig.c to tig.1.txt, tigrc.5.txt, and ma=
nual.txt
      Add COPYING, SITES, TODO, BUGS, and INSTALL files
      Make the view title show percentage shown like less

Junio C Hamano:
      Makefile: make customization of installation locations easier

Kristian H=C3=B8gsberg:
      Bind 'b' to Page Up, and Space to Page Down

Sir Raorn:
      Fix linking with --as-needed ld(1) option.
      Fix warnings

Timo Hirvonen:
      Make some strings "const"
      Mark quit() and die() __noreturn

--=20
Jonas Fonseca
