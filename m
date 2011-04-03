From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Git enterprise setup on a large project
Date: Sun, 3 Apr 2011 20:31:15 +0200
Message-ID: <20110403183115.GA28901@nibiru.local>
References: <BANLkTikv4h3GBGB+hTHjJyAqwEmqZETyEg@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 16:00:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7THM-0005GO-MQ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 16:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab1DFOAJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 10:00:09 -0400
Received: from caprica.metux.de ([82.165.128.25]:58836 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756164Ab1DFOAH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 10:00:07 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p36Ds7ue018842
	for <git@vger.kernel.org>; Wed, 6 Apr 2011 15:58:16 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p36Ca3GH006454
	for git@vger.kernel.org; Wed, 6 Apr 2011 14:36:03 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p33IVFlL006470
	for git@vger.kernel.org; Sun, 3 Apr 2011 20:31:15 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <BANLkTikv4h3GBGB+hTHjJyAqwEmqZETyEg@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170976>

* Frederic JECKER <frederic.jecker@gmail.com> wrote:

> What could I do then ?
> - Use submodules ?
> - Create a blessed per-project repository and instead of a public
> repository for each=A0developer=A0create a per-project public and sha=
red
> repository ?
> ...I'm a bit lost

Just think about who has to see whose commits ?

I guess, each project's codebase is accessed by a relatively
small number of people. So it IMHO would be natural to give
each project a separate (blessed) repository. The project
leader will merge (or cherry-pick) the blessed changes here,
and other merge-down or better rebase from there.

If there's some big mainline (the base for many other projects),
it should live in its own repository. BTW: you dont have to use
full clones - you could also fetch individual refs if you like.

Individual WIP branches probably dont necessarily need to be pushed
into the central project repos - devs could sync each other
selectively.


cu
--=20
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
