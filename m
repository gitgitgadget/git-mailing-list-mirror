From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 0/9] Make gitexecdir relative to $(bindir) on Windows
Date: Wed, 23 Jul 2008 20:49:18 +0200
Message-ID: <200807232049.18686.johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <200807222131.32828.johannes.sixt@telecom.at> <7vmyk8e9p9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:50:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjPs-0002Eo-Aa
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbYGWStY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 14:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbYGWStY
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:49:24 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:47822 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYGWStX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 14:49:23 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 5402410A78F;
	Wed, 23 Jul 2008 20:49:21 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AC2BA1D0E3;
	Wed, 23 Jul 2008 20:49:20 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vmyk8e9p9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89736>

On Mittwoch, 23. Juli 2008, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > On Dienstag, 22. Juli 2008, Johannes Schindelin wrote:
> >> On Mon, 21 Jul 2008, Johannes Sixt wrote:
> >> > The problem was that argv[0] does not have a path in certain cases.
> >>
> >> Note that the same holds true for Linux when calling a program that is
> >> in the PATH:
> >
> > Oh, boy!
> >
> >> I imagine that the proper solution would be to rip out lookup_prog() and
> >> use it for non-Windows Git, too.  Unless you want to limit the
> >> usefulness of your patch series to Windows, that is.
> >
> > This certainly goes beyond what I am prepared to do. It is not my itch.
> > The series is already much longer than I wanted, when there is a much
> > simpler solution that solves *my* problem: to set bindir = $(gitexecdir).
>
> If you are living in the Windows world, perhaps you could record the
> installation location in resource somewhere from the installer and look it
> up at runtime?  Or is it considered a bad practice?

Well, looking at value of _pgmptr *is* "look it up at runtime"; no resources 
or help from the installer are needed.

My rant here is more about that I created a *long* patch series only to find 
out that it does not have enough genericity to solve the same problem 
(relocatability) on platforms other than Windows - and I don't want to make 
it even longer. Windows is special enough that *I* could live with a much 
simpler solution even though it is a bit retro.

-- Hannes
