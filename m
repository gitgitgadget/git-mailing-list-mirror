From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Use __VA_ARGS__ for all of error's arguments
Date: Thu, 7 Feb 2013 13:24:38 -0800
Message-ID: <20130207212438.GA22253@ftbfs.org>
References: <1360267238-21896-1-git-send-email-kraai@ftbfs.org>
 <7vwquj6dio.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Max Horn <max@quendi.de>,
	Jeff King <peff@peff.net>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 22:25:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Yxu-0005b5-7b
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 22:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759396Ab3BGVYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 16:24:42 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:55515 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759361Ab3BGVYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 16:24:41 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1U3YxS-0005pQ-Bv; Thu, 07 Feb 2013 13:24:38 -0800
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Matt Kraai <matt.kraai@amo.abbott.com>
Content-Disposition: inline
In-Reply-To: <7vwquj6dio.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215732>

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

I don't know and I don't think it's likely I can confirm this.  I'll
submit a new patch that just changes the definition, since I don't
know of any problems other than mine with the current situation.

-- 
Matt
