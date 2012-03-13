From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Auto-matching upstream branches by name (was: [RFC PATCH] push: start warning upcoming default change for push.default)
Date: Tue, 13 Mar 2012 21:01:49 +0100
Message-ID: <1kgwl7x.5pilu08h6t2eM%lists@haller-berlin.de>
References: <vpqaa3kfwss.fsf@bauges.imag.fr>
Cc: peff@peff.net (Jeff King), marcnarc@xiplink.com (Marc Branchaud),
	mhagger@alum.mit.edu (Michael Haggerty),
	cmn@elego.de (=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?=),
	git@vger.kernel.org
To: Matthieu.Moy@grenoble-inp.fr (Matthieu Moy),
	gitster@pobox.com (Junio C Hamano)
X-From: git-owner@vger.kernel.org Tue Mar 13 21:02:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Xuw-0004ns-1H
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 21:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884Ab2CMUBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 16:01:52 -0400
Received: from server90.greatnet.de ([83.133.96.186]:38625 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab2CMUBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 16:01:52 -0400
Received: from [192.168.0.42] (dslb-088-073-085-009.pools.arcor-ip.net [88.73.85.9])
	by server90.greatnet.de (Postfix) with ESMTPA id CAA383B0489;
	Tue, 13 Mar 2012 21:01:49 +0100 (CET)
In-Reply-To: <vpqaa3kfwss.fsf@bauges.imag.fr>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.3 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193062>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> Actually, I'm starting to wonder if the whole "upstream" thing should
> not be deactivated by default, and replaced with a simpler mechanism
> like "pull.default", similar to what "push.default" does today. Then,
> users could set "pull.default=current", and "git pull" would pull a
> branch with the same name remotely. Or users could set
> "pull.default=upstream" and get what Git does today.

Yes, this is pretty similar to what I had in mind, in the last paragraph
of this message:

   http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694

But it's not just about pull versus push. If you make them both work
with same-name branches automatically, you still need to make "status"
and "branch -vv" aware of that too, so that they can report whether you
are ahead or behind your, well, "upstream".  "git log @{u}" would be
nice as well in this mode.

So I think that "pull.default" is not the best option to use for this;
maybe something like "branch.automatchupstreambyname" or some such.

(It's really a separate discussion from the push.default question
though, so I'm changing the subject.)


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
