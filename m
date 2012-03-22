From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 13:37:01 -0400
Message-ID: <20120322173701.GA11928@sigill.intra.peff.net>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <4F6ACB67.1080503@viscovery.net>
 <4F6B0C3E.8090501@in.waw.pl>
 <20120322141245.GB8803@sigill.intra.peff.net>
 <7vbonozi8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 18:37:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAlwn-0001Fk-If
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 18:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135Ab2CVRhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 13:37:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56760
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311Ab2CVRhG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 13:37:06 -0400
Received: (qmail 2709 invoked by uid 107); 22 Mar 2012 17:37:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 13:37:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 13:37:01 -0400
Content-Disposition: inline
In-Reply-To: <7vbonozi8c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193669>

On Thu, Mar 22, 2012 at 09:57:23AM -0700, Junio C Hamano wrote:

> Hrm, replacing unclear part with clarified text may make sense, but it
> would not help adding new text if the existing description is not clear
> enough.
> 
> How about doing it like this?
> 
>    Case-insensitive filesystems like FAT and HFS+ have various strange
>    behaviours, like reporting that a file "Makefile" already exists when
>    the file that actually exists on them is "makefile". By setting this
>    variable to `true`, Git employs logic to work around them.
> 
>    The default is false, except that git-clone[1] and git-init[1] will
>    probe the filesystem and set it to `true` as necessary when a new
>    repository is created.

IMHO, it suffers from the same problem as the original, which is that it
does tells when to use core.ignorecase, but does not specify what
happens when one sets core.ignorecase to true on a case-sensitive
filesystem. Maybe we should be more explicit about what _does_ happen in
that case (to be honest, I am not completely sure). Or just say that it
is not a supported use case.

-Peff
