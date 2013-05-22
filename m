From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Wed, 22 May 2013 02:44:29 +0200
Message-ID: <20130522004429.GI30969@goldbirke>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
 <20130521224119.GF30969@goldbirke>
 <CAMP44s1cbO-xzUAHR4THz4MPdqxY6SHG7uf_da_OM8YCDbTi+A@mail.gmail.com>
 <20130521233617.GG30969@goldbirke>
 <CAMP44s3nMSj5=pr-WmWTd_iUjK4iU_8KnOKHYgRHLAQyyMH9bA@mail.gmail.com>
 <20130522002028.GH30969@goldbirke>
 <CAMP44s3XjJ8AxTAF3OEPDd-3egb9koogxheZj+KdUrvJDOjxmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 02:44:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UexAf-0006HG-6a
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 02:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab3EVAop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 20:44:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:55524 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab3EVAoo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 20:44:44 -0400
Received: from localhost6.localdomain6 (f051105197.adsl.alicedsl.de [78.51.105.197])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MVJxm-1UyIIC0wu6-00YqGP; Wed, 22 May 2013 02:44:30 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3XjJ8AxTAF3OEPDd-3egb9koogxheZj+KdUrvJDOjxmQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:BLvvF0iuNz42ivTt28ofGNNP7n9iYrD6l94j48LyALt
 LOnWbRSDrY6mHwXoeHm/JATWm8NgSmOL82iV8CnPhpxnEQRT/6
 gGRU1+adblDT/4sUmAW5n2Yot5UdHVxcRz9RFsCTlK282ONpfF
 z54hrF+1K4Miv6k+nXLrc6iV4YYuulpd7J4DOr5hxmDNKtSFyH
 eFLhUVAZA/iYys3XBNpu0/VDMmVcWDPbYB68x3Uyv7nMZcNgHt
 ck8N0Z+E9+K6uV2avezWGn16gZFF6Tc4Y6Zm+eGnHH407xSTo4
 uruYN6rVe7o454ofXjtXsXJ09u6UuBKzvmX2KwXb4jOrfF7AdW
 lo4MJKsIr8N3mIwUTmJkspiNg5kTnPKVEKTKMNUdo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225101>

On Tue, May 21, 2013 at 07:29:38PM -0500, Felipe Contreras wrote:
> On Tue, May 21, 2013 at 7:20 PM, SZEDER G=E1bor <szeder@ira.uka.de> w=
rote:
> > On Tue, May 21, 2013 at 07:03:09PM -0500, Felipe Contreras wrote:
> >> On Tue, May 21, 2013 at 6:36 PM, SZEDER G=E1bor <szeder@ira.uka.de=
> wrote:
> >> > On Tue, May 21, 2013 at 06:04:35PM -0500, Felipe Contreras wrote=
:
> >> >> On Tue, May 21, 2013 at 5:41 PM, SZEDER G=E1bor <szeder@ira.uka=
=2Ede> wrote:
> >> >>
> >> >> > On Tue, May 21, 2013 at 10:54:27PM +0200, Thomas Gummerer wro=
te:
> >> >> >> Currently the __git_ps1 git prompt gives the following error=
 with a
> >> >> >> repository converted by git-svn, when used with zsh:
> >> >> >>
> >> >> >>          __git_ps1_show_upstream:19: bad pattern: svn_remote=
[
> >> >> >>
> >> >> >> This was introduced by 6d158cba (bash completion: Support "d=
ivergence
> >> >> >> from upstream" messages in __git_ps1), when the script was f=
or bash
> >> >> >> only.  Make it compatible with zsh.
> >> >> >
> >> >> > What is the actual cause of this problem/incompatibility and =
how/why do
> >> >> > these changes fix it?
> >> >>
> >> >> I think the commit message makes that very clear.
> >> >
> >> > If that were the case I wouldn't have asked in the first place.
> >>
> >> You are not the authority on what *I think*, or if you meant s/If =
that
> >> were the case/If the message was clear/, still; you are not the
> >> authority on what is or is not true. Only on what is your opinion.
> >
> > I would have preferred a more constructive reply, perhaps with answ=
ers
> > to the questions I asked earlier...
>=20
> That's the job of the patch submitter, all I did was express my optio=
n
> about the commit message. You have no say as to what is my option.
>=20
> You are the one not being constructive by claiming that all opinions
> contrary to yours are wrong.

Seriously!?  Alright, I won't waste any more time on this, sorry.

G=E1bor
