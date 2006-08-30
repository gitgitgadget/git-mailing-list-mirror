From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Add local time and timezone to git_print_authorship
Date: Tue, 29 Aug 2006 21:26:38 -0700
Message-ID: <7vlkp6kfwh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org>
	<11567998513000-git-send-email-jnareb@gmail.com>
	<7vveocpfa3.fsf@assigned-by-dhcp.cox.net> <ed0ths$okn$1@sea.gmane.org>
	<7vu03voqss.fsf@assigned-by-dhcp.cox.net> <ed142v$fbi$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 30 06:25:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIHeC-00088m-3d
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 06:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWH3EZs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 30 Aug 2006 00:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWH3EZs
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 00:25:48 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:26276 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964946AbWH3EZs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Aug 2006 00:25:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060830042547.JWLA21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Wed, 30 Aug 2006 00:25:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id G4Rn1V0071kojtg0000000
	Wed, 30 Aug 2006 00:25:47 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26223>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> =A0(3) I'd like to eventually get rid of the abbreviated commit
>> =A0 =A0 =A0object name from blame output, so the setting in gitweb.c=
ss
>> =A0 =A0 =A0for table.blame td.age[012] (different colors and font
>> =A0 =A0 =A0styles) is not appropriate for what I am shooting at.
>
> What do you want to replace it with? Link can be to "commit" or "comm=
itdiff"
> view, but some marker for commit (perhaps 'git-name-rev --tags'?) is
> needed.

I was hoping I can get away with a narrow single column of solid
color that says nothing.  8 hexadecimal digits do not mean much
to humans and it is taking 8-column or so of screen real estate
that could otherwise be used to show the source lines instead.

I've tried doing that (just set $rev to a single space, and make
the "Commit" column narrower in sub blame2 {}).  One drawback is
that while 8 hexadecimal digits do not mean anything they do
help to match lines that came from the same rev (i.e. "I do not
know what this 8fad7343 mean but this group of lines and that
group are tagged together with that same 8fad7343 so they must
come from the same revision").
