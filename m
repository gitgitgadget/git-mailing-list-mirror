From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/8] builtin-clone
Date: Fri, 18 Apr 2008 02:50:48 +0200
Message-ID: <200804180250.48544.johan@herland.net>
References: <alpine.LNX.1.00.0804171923040.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Apr 18 02:52:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmepi-0007LI-Pb
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 02:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110AbYDRAvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 20:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756106AbYDRAvU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 20:51:20 -0400
Received: from smtp.getmail.no ([84.208.20.33]:39010 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104AbYDRAvT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2008 20:51:19 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZH0030VX15OY00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 18 Apr 2008 02:51:05 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZH005MAX0O7Q20@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 18 Apr 2008 02:50:48 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZH00ETMX0OK590@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 18 Apr 2008 02:50:48 +0200 (CEST)
In-reply-to: <alpine.LNX.1.00.0804171923040.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79856>

On Friday 18 April 2008, Daniel Barkalow wrote:
> This is my latest version, rebased approximately on current master (o=
r=20
> recent maint, I guess). It's missing all of Johan's stuff, which is t=
ests=20
> for stuff I've fixed

Does this mean you no longer need the tests, or that you want me to res=
end?

> and (after this series) a series to make the clone generate packed re=
fs.

I'll resend the series once your work has settled down and landed in "n=
ext".

BTW, I noticed in your repo (at iabervon.org) that you put "if (0)" aro=
und
the code generating packed-refs (using the old one instead), and added =
the
following note to the commit message:

  I made this compile-time configurable because I'm not sure we want to
  pack unconditionally.

We should probably figure out the right thing to do here. AFAICS,
compile-time configurability is only a temporary measure, and we basica=
lly
have to choose between:

1. Add a command-line option (and config variable?) for controlling
   whether "git clone" generates packed refs.

2. Make "git clone" unconditionally generate packed refs.

Currently, I'm leaning towards (2), since I don't think there's enough
drawbacks with generating packed-refs to justify adding a command-line
option. AFAICS, the only drawback is that reflogs aren't
created/initialized on clone, but I got the feeling that this was not
particularly important. Quoting Junio from an earlier thread:

  Not writing reflogs is a _different_ behaviour from the previous, but=
 I
  suspect it might even be an improvement. =A0When you have 1000 remote
  branches, probably most of them are not even active.

If there are good arguments for going with (1), I'd love to hear them.


Have fun, and thanks a lot for your hard work!

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
