From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git help -w should not create nohup.out
Date: Fri, 8 Feb 2008 06:37:03 +0100
Message-ID: <200802080637.04015.chriscool@tuxfamily.org>
References: <1202434421-8066-1-git-send-email-dpotapov@gmail.com> <alpine.LSU.1.00.0802080153570.11591@racer.site> <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 06:31:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNLpr-0005jg-HC
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 06:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbYBHFbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2008 00:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbYBHFbF
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 00:31:05 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:47390 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbYBHFbE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2008 00:31:04 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0F3051AB2AF;
	Fri,  8 Feb 2008 06:31:03 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E435B1AB2B3;
	Fri,  8 Feb 2008 06:31:02 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73040>

Le vendredi 8 f=E9vrier 2008, Junio C Hamano a =E9crit :
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > Hi,
> >
> > On Fri, 8 Feb 2008, Dmitry Potapov wrote:
> >> git-help--browse uses 'nohup' to launch some browsers.
> >
> > Why?
> >
> > "nohup" should be used to start a program that should persist even
> > after you logged out.  I fail to see how this should be sensible fo=
r
> > "git help -w".  So "off with the head", uh, do away with the "nohup=
", I
> > say!
>
> True.  Christian, what was the reason you added nohup?

I think I was worried about something like this:

1) ssh -Y other_machine
2) git help -w, it opens my browser
3) open many other tabs in the browser
4) exit other_machine, oops my browser with all my tabs is gone

or

1) open my favorite browser and many tabs in it
2) ssh -Y other_machine
3) git help -w, cool it opens a tab in my already opened browser in 1)
4) exit other_machine, oops my browser with all my tabs is gone

I thought it would perhaps help, and it was better to be on the safe si=
de.=20
But I just tested a little and it seems it doesn't change anything.

Also there are some browser that are very verbose on the SDTOUT or STDE=
RR=20
(especially konqueror) and I thought the nohup would also help move the=
=20
output out of the command line while not discarding it in case it's nee=
ded.=20
But I agree that it's not very often usefull and anyway there are bette=
r=20
ways to deal with it.

So no problem to do away with the "nohup".

Thanks,
Christian.
