From: Jeff King <peff@peff.net>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 13:53:58 -0400
Message-ID: <20101007175358.GD12130@sigill.intra.peff.net>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
 <20101007141015.GB8162@sigill.intra.peff.net>
 <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
 <4CADE232.8030801@viscovery.net>
 <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
 <20101007172939.GA12130@sigill.intra.peff.net>
 <AANLkTimYVNNjhaqUHjoVOV-fQBhcENKn7cyj10qcZ+MW@mail.gmail.com>
 <vpqaamp3n6d.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: kusmabite@gmail.com,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 07 19:53:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3uf9-0001im-My
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 19:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab0JGRxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 13:53:46 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52461 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802Ab0JGRxq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 13:53:46 -0400
Received: (qmail 19527 invoked by uid 111); 7 Oct 2010 17:53:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.184)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 07 Oct 2010 17:53:45 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Oct 2010 13:53:58 -0400
Content-Disposition: inline
In-Reply-To: <vpqaamp3n6d.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158419>

On Thu, Oct 07, 2010 at 07:52:42PM +0200, Matthieu Moy wrote:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
> > Also, fwriting like that to stdout might be a bit troublesome on
> > Windows because the string won't end up going through our
> > ANSI-emulation.
> 
> I don't know which one would be most portable, but if fwrite is the
> problem, then
> 
>   printf("%*s%c", buf.buf, buf.len, info->hdr_termination);
> 
> should do the trick.

It does work, but you have to cast the buf.len size_t to an int.

-Peff
