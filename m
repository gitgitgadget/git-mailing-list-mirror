From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 2/3] branch: suggest how to undo a --set-upstream when
 given one branch
Date: Wed, 11 Jul 2012 17:14:00 +0200
Message-ID: <1342019640.6458.23.camel@centaur.cmartin.tk>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
	 <1341939181-8962-3-git-send-email-cmn@elego.de>
	 <20120710192408.GF8439@burratino> <7vliirgrun.fsf@alter.siamese.dyndns.org>
	 <20120710230014.GA20873@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 17:13:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soybp-000124-W4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 17:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782Ab2GKPNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 11:13:40 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:35789 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932748Ab2GKPNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 11:13:39 -0400
Received: from [192.168.1.5] (p4FC5CD3B.dip.t-dialin.net [79.197.205.59])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 7B66046149;
	Wed, 11 Jul 2012 17:13:34 +0200 (CEST)
In-Reply-To: <20120710230014.GA20873@burratino>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201304>

On Tue, 2012-07-10 at 18:00 -0500, Jonathan Nieder wrote:
> Junio C Hamano wrote:
> 
> >                                                           I think it
> > is better to leave them emitted unconditionally to the standard
> > error stream, in order to train users away from using the old option
> > that has its arguments wrong (the option does not take an argument
> > it should, and makes the command line to look as if it takes two
> > branch arguments in the wrong order).
> 
> I thought we already discussed that that is a side-issue?

The current --set-upstream is the whole reason for this series existing.

> 
> The option is a mode option for the command, like "-m", "-d", or
> "--edit-description".  I genuinely don't think the order of options it
> takes is counter-intuitive.  The second argument defaulting to HEAD
> and the behavior of creating the branch named by the first argument
> when it does not exist are quite counter-intuitive.

This is confusing. First you say that you don't think it's
counter-intuitive but then you say it is? Or is the first part about -m
and -d?

The second part of the paragraph is indeed what I'm trying to solve with
this series. If you want to create a new branch, you should be using -t.

> 
> Transitioning to a different argument order seems like it would just
> make the command more complicated.  After the transition, there are
> two options to explain, and during the transition, it is easy to make
> scripts with gratuitous incompatibilities that won't work on older
> systems.
> 
> Where is my thinking going wrong?

We're not transitioning to a new order as such, particularly not with
the same option name. The incompatibilities would ensue with the other
patch I send which did change the order for --set-upstream, but what
this does is _add_ --set-upstream-to=<upstream> such that the option
takes one argument and the command takes one optional argument, which
makes it closer to what one would expect, specially as changing the
upstream information is something you're most likely to do on the
current branch.

   cmn
