From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: pre-commit hook not run on conflict resolution during rebase
Date: Fri, 29 May 2015 09:25:28 +0200
Message-ID: <1m56dnm.1tg204rp3q4paM%lists@haller-berlin.de>
References: <xmqqy4k8fp1g.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com (Junio C Hamano)
X-From: git-owner@vger.kernel.org Fri May 29 09:25:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyEff-0004Ff-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 09:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbbE2HZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 03:25:31 -0400
Received: from server90.greatnet.de ([178.254.50.90]:35594 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbbE2HZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 03:25:30 -0400
Received: from [192.168.42.152] (dslb-188-102-144-123.188.102.pools.vodafone-ip.de [188.102.144.123])
	by server90.greatnet.de (Postfix) with ESMTPA id 350CC6014C;
	Fri, 29 May 2015 09:25:28 +0200 (CEST)
In-Reply-To: <xmqqy4k8fp1g.fsf@gitster.dls.corp.google.com>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.10.3 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270210>

Junio C Hamano <gitster@pobox.com> wrote:

> lists@haller-berlin.de (Stefan Haller) writes:
> 
> > I guess the next best solution would be to also have a pre-push hook
> > that performs the same checks again, just in case the bad code managed
> > to get past the pre-commit hook for some reason or other. This feels
> > very redundant, but I guess it would work well.
> 
> I'd say pre-receive would be the most sensible place to check things
> like this.

Yes, I totally agree, and we used to have this setup when we were still
hosting our code in-house; with pre-receive doing the authorative
checks, and pre-commit being optional as a convenience for developers,
as you say.

Now we have moved most of our code to github, and you can't have
pre-receive hooks there, as far as I can tell. (I should have mentioned
that, sorry.)

To make up for that, we have put considerable effort into ensuring that
everyone on the team has up-to-date hooks locally, by installing them
automatically as part of our build system infrastructure.

In that light, do you agree that a pre-push hook is the best we can do
now to plug this hole?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
