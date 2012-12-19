From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Wed, 19 Dec 2012 09:29:20 +0100
Organization: Bertin Technologies
Message-ID: <20121219092920.2dc0f33e@chalon.bertin.fr>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org> <877goht6eu.fsf@pctrast.inf.ethz.ch>
 <20121217114058.449cbc3c@chalon.bertin.fr>
 <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
 <m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
 <20121218120058.0c558ba5@chalon.bertin.fr>
 <7vehinibpc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 09:29:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlF25-0001nb-4M
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 09:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab2LSI3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 03:29:23 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:60941 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab2LSI3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 03:29:21 -0500
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 057BBA0F98
	for <git@vger.kernel.org>; Wed, 19 Dec 2012 09:29:20 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 2F803A0F96
	for <git@vger.kernel.org>; Wed, 19 Dec 2012 09:29:19 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MF900ACNRKUHR80@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 19 Dec 2012 09:29:19 +0100 (CET)
In-reply-to: <7vehinibpc.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19462.002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211813>

On Tue, 18 Dec 2012 08:09:35 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Yann Dirson <dirson@bertin.fr> writes:
> 
> > On Mon, 17 Dec 2012 13:14:56 -0800
> > Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> Andreas Schwab <schwab@linux-m68k.org> writes:
> >> 
> >> > Christian Couder <christian.couder@gmail.com> writes:
> >> >
> >> >> Yeah, at one point I wanted to have a command that created to craft a
> >> >> new commit based on an existing one.
> >> >
> >> > This isn't hard to do, you only have to resort to plumbing:
> >> >
> >> > $ git cat-file commit fef11965da875c105c40f1a9550af1f5e34a6e62 | sed s/bfae342c973b0be3c9e99d3d86ed2e6b152b4a6b/790c83cda92f95f1b4b91e2ddc056a52a99a055d/ | git hash-object -t commit --stdin -w
> >> > bb45cc6356eac6c7fa432965090045306dab7026
> >> 
> >> Good.  I do not think an extra special-purpose command is welcome
> >> here.
> >
> > Well, I'm not sure this is intuitive enough to be useful to the average user :)
> 
> I do not understand why you even want to go in the harder route in
> the first place, only to complicate things?

Although the approach you propose is elegant, it still looks like one
could not leave the worktree untouched in the case of creating a merge replace,
which the "just forge an arbitrary commit" approach handles easily.

It seems the latter would also be more powerful, in that you can create new commits with an
arbitrary number of parents, even when merge-octopus would simply refuse to help;
and it is has no special case for creating merges.

> Is this not intuitive enough?

I would say it is a nice read that can help an advanced user to earn
some XP - but well, replace refs are also meant for somewhat advanced users :)

-- 
Yann Dirson - Bertin Technologies
