From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 01/10] refs: add "for_each_bisect_ref" function
Date: Fri, 27 Mar 2009 08:21:03 +0100
Message-ID: <200903270821.03521.chriscool@tuxfamily.org>
References: <20090326055509.1bc16b28.chriscool@tuxfamily.org> <200903270141.57426.chriscool@tuxfamily.org> <alpine.DEB.1.00.0903270305340.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 08:23:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln6Pk-0007SO-26
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 08:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbZC0HWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 03:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbZC0HWJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 03:22:09 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:59437 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbZC0HWI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 03:22:08 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 775E69400FD;
	Fri, 27 Mar 2009 08:21:55 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 6FED794012C;
	Fri, 27 Mar 2009 08:21:53 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903270305340.10279@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114865>

Le vendredi 27 mars 2009, Johannes Schindelin a =E9crit :
> Hi,
>
> On Fri, 27 Mar 2009, Christian Couder wrote:
> > Le jeudi 26 mars 2009, Johannes Schindelin a =E9crit :
> > > On Thu, 26 Mar 2009, Michael J Gruber wrote:
> > > > Christian Couder venit, vidit, dixit 26.03.2009 08:48:
> > > > > Le jeudi 26 mars 2009, Sverre Rabbelier a =E9crit :
> > > > >> A 10 patches series with no cover letter?
> > > > >
> > > > > I am not a big fan of cover letters. Usually I prefer adding
> > > > > comments in the patches.
> > > >
> > > > I'm sorry I have to say that, but your individual preferences d=
on't
> > > > matter. Many of us would do things differently, each in their o=
wn
> > > > way, but people adjust to the list's preferences. It's a matter=
 of
> > > > attitude. So, please...
> > >
> > > Actually, a better way to ask for a cover letter would have been =
to
> > > convince Christian.  So I'll try that.
> >
> > Thanks.
> >
> > As you know, I have been sending patches since nearly 3 years ago t=
o
> > this list. And it's only since a few weeks ago that I am asked to s=
end
> > cover letters...
>
> Heh, I have the feeling that your patch series were much shorter, and=
 did
> not have many revisions, until a few weeks ago ;-)

Please try to look for a 9 patch long series that you reviewed around=20
october 2007 with "dunno" or "skip" in the title ;-)

> > > From the patch series' titles (especially when they are cropped d=
ue
> > > to the text window being too small to fit the indented thread), i=
t is
> > > not all that obvious what you want to achieve with those 10 patch=
es.
> > >
> > > From recent discussions, I seem to remember that you wanted to ha=
ve
> > > some cute way to mark commits as non-testable during a bisect, an=
d I
> > > further seem to remember that Junio said that very method should =
be
> > > usable outside of bisect, too.
> >
> > Well, we want to move "git bisect skip" code from shell (in
> > "git-bisect.sh") to C. So this patch series does that by creating a=
 new
> > "git bisect--helper" command in C that contains the new code and us=
ing
> > that new command in "git-bisect.sh".
>
> Oh?  I _completely_ missed that.  And that's being one of the origina=
l
> Cc:ed persons...
>
> > > Unfortunately, that does not reveal to me, quickly, what is the
> > > current state of affairs, and what you changed since the last tim=
e.
> >
> > Yeah, I should have at least put something in the comment section o=
f my
> > first patch in this series.
>
> No.  I would still have missed it.
>
> The cover letter is outside of any patch, because it describes the
> purpose of the _whole_ patch series, not just one patch.
>
> So, it would have been nice to get a heads-up that this is not your
> bisect-skip-a-whole-bunch-of-commits series, but a new animal.
>
> This way, I decided I do not have time for something I do not need, a=
nd
> deleted it without having a look.

Well as I said in my previous email I am willing to improve. So perhaps=
 next=20
time.

Best regards,
Christian.
