From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: How to check out the repository at a particular point in time
Date: Mon, 22 Aug 2011 18:56:30 +0200
Message-ID: <4E528A3E.2070505@web.de>
References: <1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	in-git-vger@baka.org
To: rdiezmail-temp2@yahoo.de
X-From: git-owner@vger.kernel.org Mon Aug 22 18:56:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvXnj-00015f-Nx
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 18:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab1HVQ4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 12:56:36 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:45268 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab1HVQ4e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 12:56:34 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5279F1A8F78CE;
	Mon, 22 Aug 2011 18:56:33 +0200 (CEST)
Received: from [79.247.235.148] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QvXnd-0002Mi-00; Mon, 22 Aug 2011 18:56:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18yJzVCTmMl6izop4y8U7HOumpD2xVNDBzOk2Ng
	yFcGptYig8dx37iPy56XYHCDFvHTsnzJlEbfgqSRJA+RHjyvhE
	bqQefRcka17JsApzkFug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179872>

Am 22.08.2011 17:18, schrieb R. Diez:
> But that problem the daily build is trying to solve is precisely that it's
> too hard to keep track of all component versions in all repositories. Things
> just move too fast, and as far as I understand it, git submodules require
> manual intervention. If I ever tag anything manually, it must have already
> passed the daily build!

Submodules can easily be scripted too. Why don't you let your buildsystem
automatically create a commit with the current HEADs in the superproject
when building and testing all repositories was successful? Then each
developer can use one of those superproject commits as starting point and
happily hack away on a repository. And as a bonus he can see in the
superproject how many changes he did from the nightly build he started
with. And if he doesn't care, he can forget about the superproject until
he needs to sync again.

> The development model looks like this: the latest HEAD versions of all
> components should always work well with each other. If something breaks,
> the daily build will let the developer know by the next day. If two
> developers make incompatible changes, they'll speak to each other and
> commit their changes within a few hours. During that time, they will be
> trouble, but that's quite alright (at least for the moment).

You can decide later if you want to use the superproject to coordinate
such possibly conflicting changes, but that would mean your developers
would have to commit their changes in the superproject too.
