From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Find successor of common ancestor
Date: Fri, 16 Jul 2010 17:35:44 +0200
Message-ID: <20100716153544.GC22894@nibiru.local>
References: <20100716082937.GA22894@nibiru.local> <AANLkTintIToGZu3fvK4aE5LFL7MgOnlfwKgsZ79Q0-o1@mail.gmail.com> <20100716090613.GB22894@nibiru.local> <201007161419.39469.johan@herland.net>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 16 17:43:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZn47-0006t5-Jd
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 17:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965906Ab0GPPmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 11:42:22 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:40734 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965917Ab0GPPmT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 11:42:19 -0400
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o6GFgHpE013475
	for git@vger.kernel.org; Fri, 16 Jul 2010 17:42:17 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o6GFZi1D016638
	for git@vger.kernel.org; Fri, 16 Jul 2010 17:35:44 +0200
Content-Disposition: inline
In-Reply-To: <201007161419.39469.johan@herland.net>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151156>

* Johan Herland <johan@herland.net> wrote:

> IINM you have the following situation
> 
> A0---A1---A2---A3---A4  <-- A'
>   \
>    B1---B2---B3--B4  <-- B'
> 
> ...and you want to rebase B' (i.e. B1 through B4), first onto A1, then 
> onto A2, the onto A3, and finally onto A4. I have no idea WHY you would 
> want to do this (rebasing directly onto A4 (like Santi suggests) is 
> much cheaper), but you can certainly coax Git into doing it, anyway.

If the branches go off too far, you can easily end up in a lot of 
unresolvable conflicts, while on zip-rebase, there's great chance
that 3way-merge will catch this.

> To list commits A1, A2, A3, A4 (in that order), do:
> 
>   git rev-list --reverse B'..A'
> 
> You can now loop over the results like this:
> 
>   git checkout B'
>   for a in $(git rev-list --reverse ..A'); do
>       git rebase $a
>   done

Thx, I'll have a try :)


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
