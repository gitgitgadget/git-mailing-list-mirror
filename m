From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: remove another ternary expression always evaluating
 to true
Date: Thu, 8 Aug 2013 23:01:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1308082257580.24252@s15462909.onlinehome-server.info>
References: <1375988103-29947-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens.Lehmann@web.de, gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:01:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7XKZ-0006YS-C3
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966588Ab3HHVBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:01:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:51686 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966550Ab3HHVBF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 17:01:05 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Lzsf1-1WCc3g3Thj-0150gS
 for <git@vger.kernel.org>; Thu, 08 Aug 2013 23:01:03 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1375988103-29947-1-git-send-email-stefanbeller@googlemail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:4H5a6Bt9YLh5qanZHmiYOgSju6wMLtjKvnaXqFhoPsVyzHNzUZT
 JmdizzKimw4qU+h3zQ94HfHyMfdnA6CmxJNLHIErTQI5240xFKjWkXWbkXjHnhRTn1L5li3
 mk+U3DOv/MVFdhpRd+N22m6ql5Q8ME5LRpenUtP3rNhmdFB4LSh1u1cgOrmiivEgs+Ia/k3
 jPfSBUs2OuaZh6l/dtj/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231930>

Hi Stefan,

On Thu, 8 Aug 2013, Stefan Beller wrote:

> The condition before the changed line dereferences 'one' to query the mode,
> so if the condition evaluates to true, the variable one must not be null.

To show this better, please use -U10 (or some other appropriate context
option) in the future.

> Therefore we do not need the ternary operator depending on one, giving
> either one->path or two->path. This always evaluates to one->path, so we
> can remove the ternary operator.
> 
> The condition and the usage of the ternary operator have been introduced
> by the same commit (752c0c24, 2009-10-19, Add the --submodule option to
> the diff option family). As that commit message refers to a GitTogether
> I'd assume that patch was crafted in a hurry, so maybe overlooking the
> need for a ternary operator there.

If this is my code, I do not need a GitTogether to excuse my sloppiness.
In this particular case, I imagine the appropriate fix is to test for
one->path instead of removing the conditional, though.

Ciao,
Johannes
