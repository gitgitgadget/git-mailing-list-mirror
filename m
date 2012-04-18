From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Do not use SHELL_PATH from build system in
 prepare_shell_cmd on Windows
Date: Wed, 18 Apr 2012 00:27:50 -0700
Message-ID: <20120418072615.GA2217@sigill.intra.peff.net>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
 <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
 <4F8D15B9.70803@viscovery.net>
 <20120417221449.GC10797@sigill.intra.peff.net>
 <4F8E539F.7030902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, jrnieder@gmail.com,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 09:28:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKPJ7-0000aN-9i
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 09:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab2DRH16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 03:27:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37628
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab2DRH15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 03:27:57 -0400
Received: (qmail 13386 invoked by uid 107); 18 Apr 2012 07:28:05 -0000
Received: from me14036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.64.225)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Apr 2012 03:28:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Apr 2012 00:27:50 -0700
Content-Disposition: inline
In-Reply-To: <4F8E539F.7030902@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195842>

On Wed, Apr 18, 2012 at 07:39:43AM +0200, Johannes Sixt wrote:

> > It sounds like the real problem is not the use of a configurable shell,
> > but rather the use of an absolute path. Should you maybe try to pass the
> > basename of SHELL_PATH? Or maybe that is not even worth worrying about,
> > as somebody on Windows is not going to ever set SHELL_PATH, since it is
> > not like they are working around a non-POSIX "sh" included with the
> > operating system (which is why people on Solaris typically set
> > SHELL_PATH).
> 
> I thought about offering a customization point, but decided that it is not
> worth the hassle: Most people download an installer, then the installer
> can set up the PATH so that "sh" is not broken or something entirely
> unrelated. And those who build git themselves know sufficiently well what
> they are doing.

OK. I'll defer your judgement on what Windows users prefer. I just
wanted to make sure it was a conscious decision.

Other than that, the patch looks obviously correct to me. Thanks, and
sorry for inadvertently breaking git on windows (again). :)

-Peff
