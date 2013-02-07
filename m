From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Use __VA_ARGS__ for all of error's arguments
Date: Thu, 7 Feb 2013 21:14:49 +0000
Message-ID: <20130207211449.GC1342@serenity.lan>
References: <1360267238-21896-1-git-send-email-kraai@ftbfs.org>
 <7vwquj6dio.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 22:15:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Yob-0004AJ-M4
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 22:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759330Ab3BGVPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 16:15:03 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:36288 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759281Ab3BGVPC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 16:15:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 9171A161E2AE;
	Thu,  7 Feb 2013 21:15:01 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 65wZQ93-tzxW; Thu,  7 Feb 2013 21:15:00 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id F108F161E35F;
	Thu,  7 Feb 2013 21:14:51 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vwquj6dio.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215731>

On Thu, Feb 07, 2013 at 01:05:19PM -0800, Junio C Hamano wrote:
> Matt Kraai <kraai@ftbfs.org> writes:
> 
> > -#if defined(__GNUC__) && ! defined(__clang__)
> > -#define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
> > -#endif
> > +#define error(...) (error(__VA_ARGS__), -1)
> 
> Before your change, we only define error() macro for GCC variants,
> but with your patch that no longer is the case.  Does every compiler
> that compiles Git correctly today support this style of varargs
> macros?

At the very least the "! defined(__clang__)" was only recently added
[1], although it shouldn't be needed once Clang 3.3 is released.

[1] http://article.gmane.org/gmane.comp.version-control.git/213787


John
