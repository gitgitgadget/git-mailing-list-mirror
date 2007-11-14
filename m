From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Wed, 14 Nov 2007 20:58:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711142047170.4362@racer.site>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br>
 <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com>
 <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr>
 <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <87myth58r5.fsf@osv.gnss.ru>
 <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org> <18235.22445.16228.535898@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:59:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsPKJ-0005WQ-GC
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbXKNU6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 15:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbXKNU6u
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:58:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:48690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754061AbXKNU6s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 15:58:48 -0500
Received: (qmail invoked by alias); 14 Nov 2007 20:58:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 14 Nov 2007 21:58:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+KQpUWUkCKvtV0JuU8FQVmTQJQMoWIA+aY22kcWz
	2dEK5eTEJnrpFf
X-X-Sender: gene099@racer.site
In-Reply-To: <18235.22445.16228.535898@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65015>

Hi,

On Wed, 14 Nov 2007, Bill Lear wrote:

> On Wednesday, November 14, 2007 at 11:32:32 (-0800) Junio C Hamano writes:
>
> >But cloning void to start the same project by multiple people and 
> >pushing their initial commits as roots to start a project indicates the 
> >lack of developer communication (besides, it just feels like a bad 
> >style, a hangover from centralized SCM mentality, but that is fine). 
> >...
> 
> We have several users who have been using git for the past 9 months and 
> they each find this unreasonably complicated.  [...]
> 
> Well, here's what we'd like:
> 
> % mkdir new_repo
> % cd new_repo
> % git --bare init
> 
> [on another machine:]
> % git clone git://host/new_repo
> % cd new_repo
> % git init
> [add content]
> % git commit -a -m "Initial stuff"
> % git push

I have a better idea:

[the initial import, on another machine:]
% mkdir new_repo
% cd new_repo
% git init
[add content]
% git commit -a -m "Initial stuff"
% git remote add origin git://host/repo
% git push origin master

If you do not want to be bothered with setting up the default 
"remote" and "merge" config variables manually, it is reasonable to ask 
for support to do that in "git remote".

If you really think that this workflow has anything to do with cloning an 
empty repository, I cannot help you.  I mean, you did not need to clone 
the big, empty void to do the initial commit, or did you?

(I actually think that it is another example of cvs/svn damage, where you 
_need_ to clone first, or otherwise you will _never_ be able to commit 
to the repository.)

BTW I am somewhat disgusted by your usage of git:// for pushing.

Ciao,
Dscho
