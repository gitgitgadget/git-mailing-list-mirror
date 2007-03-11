From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Sun, 11 Mar 2007 02:08:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703110201450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
 <45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F2D955.8050800@gmail.com> <Pine.LNX.4.63.0703101749270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F2F934.8060407@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 02:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQCYD-00046W-SG
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 02:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbXCKBIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 20:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbXCKBIZ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 20:08:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:38794 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932089AbXCKBIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 20:08:06 -0500
Received: (qmail invoked by alias); 11 Mar 2007 01:08:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 11 Mar 2007 02:08:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xUrBq43cxBiL3WxGus8cbM/OpiQxHUvrLNWoMEK
	tUhVuVc9611+cw
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45F2F934.8060407@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41888>

Hi,

On Sat, 10 Mar 2007, Mark Levedahl wrote:

> Johannes Schindelin wrote:
>
> > So, what do you do if some of your users do, and some others do not, 
> > have the "blue-sky" branch? If you say "git bundle create new.bundle 
> > --all -10", your bundle will list "blue-sky" as a prerequisite.
> > 
> > Boom.
> > 
> > Some of your users -- those without "blue-sky" -- will _not_ be able 
> > to fetch _anything_ from the bundle. They are lacking the 
> > prerequisites.
>
> Those who have the prerequisites can apply the bundle. Those who do not, 
> cannot. This is unchanged, and completely unrelated to whether the 
> bundle defines 0 objects or 10,000. If you do not have the 
> prerequisites, you need a different bundle.

Only that I suspect that you want to stick more than one ref into the 
bundle. And at some point you -- or any other user -- will expect the 
bundle to work _with several refs_, even if different recipients will pick 
_only one_ of them.

Basically, I am saying that this whole bundle concept is not thought 
through, that it is too loosely defined, and that it will result in unmet 
expectations sooner or later. (Which usually means sooner.)

So, either we have to rethink how to handle prerequisites (so that only 
those are checked which are strictly necessary for _the one_ ref you are 
updating), or we have to make it _very_ obvious to (human) users of 
git-bundle that you should _not_ bundle two unrelated -- or only remotely 
related -- refs into one bundle.

Ciao,
Dscho
