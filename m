From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save author information
Date: Tue, 23 Jun 2009 07:30:01 +0200
Message-ID: <200906230730.01456.chriscool@tuxfamily.org>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org> <7v1vpdqiv2.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906221117270.4168@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 23 07:29:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIyZy-0007MG-Dl
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 07:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbZFWF3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 01:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbZFWF3s
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 01:29:48 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:60686 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbZFWF3s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 01:29:48 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CE9918180EE;
	Tue, 23 Jun 2009 07:29:42 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E06F08180AC;
	Tue, 23 Jun 2009 07:29:39 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0906221117270.4168@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122076>

On Monday 22 June 2009, Johannes Schindelin wrote:
> Hi,
>
> On Sun, 21 Jun 2009, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > On Sat, 20 Jun 2009, Christian Couder wrote:
> > >> This is better than saving in a shell script, because it will make
> > >> it much easier to port "rebase -i" to C. This also removes some sed
> > >> regexps and some "eval"s.
> > >
> > > It will not make it easier to port "rebase -i" to C, as this is an
> > > internal file.  The user is not supposed to touch it at all.  Only
> > > "rebase -i".  So it would be very easy to just use a different
> > > on-disk format when turning "rebase -i" into a builtin.
> >
> > "This is an internal file" is just a declaration you are making, and
> > the file is observable by anybody after "rebase -i" relinquishes the
> > control to let the user sort out the mess.
>
> It is an observation I am making.  Sure, the file is observable by the
> user.  But it is hidden deep inside .git/ and users who change things
> inside .git/ (with the exception of config) are asking for trouble.
>
> I really do not see the point of changing the file format _before_
> turning rebase -i into C.
>
> Oh, and I do not see the point of turning rebase -i into C before finally
> polishing sequencer so it can go into git.git's master.

The problem with this is that it will take a lot of time to implement the 
features that have been added to rebase -i since the sequencer stalled, 
then to polish it, and to get it reviewed and so on, and during that time 
other features or changes may be implemented by other people.

So I prefer to use code from the current sequencer (at 
http://repo.or.cz/w/git/sbeyer.git) to start porting step by step rebase -i 
to C.

Regards,
Christian.
