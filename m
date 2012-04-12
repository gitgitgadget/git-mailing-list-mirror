From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] Be more specific if upstream branch is not fetched
Date: Thu, 12 Apr 2012 16:40:55 -0400
Message-ID: <20120412204055.GA21018@sigill.intra.peff.net>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
 <1334161035-26355-5-git-send-email-zbyszek@in.waw.pl>
 <20120412053017.GA27369@sigill.intra.peff.net>
 <4F869D37.1050508@in.waw.pl>
 <7vd37dgevr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:41:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIQpC-0000oo-Ov
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 22:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762679Ab2DLUk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 16:40:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60339
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756749Ab2DLUk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 16:40:57 -0400
Received: (qmail 30740 invoked by uid 107); 12 Apr 2012 20:41:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 16:41:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 16:40:55 -0400
Content-Disposition: inline
In-Reply-To: <7vd37dgevr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195366>

On Thu, Apr 12, 2012 at 08:15:52AM -0700, Junio C Hamano wrote:

> In other words, the fetch refspec could be without colon.  With
> 
> 	[remote "origin"]
> 		url = ...
>         	fetch = refs/heads/master
> 	[branch "master"]
>         	remote = origin
>                 merge = refs/heads/master
> 
> you can still say "git pull" without any other argument while on your
> "master" and it will do the right thing.  Actually, you do not even have
> to have remote.origin.fetch at all (branch.master.merge will be added to
> the set of refs to be fetched).
> 
> In such a case "master@{upstream}" does not (and should not) resolve to
> anything, and the reason is not because it is not "fetched", but as Peff
> said, because it is not "stored".

Exactly. That was the distinction I was trying to make, but you
explained it much better.

-Peff
