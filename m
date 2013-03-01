From: Jeff King <peff@peff.net>
Subject: Re: two-way merge corner case bug
Date: Fri, 1 Mar 2013 18:08:45 -0500
Message-ID: <20130301230845.GA7317@sigill.intra.peff.net>
References: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
 <20130226201820.GD13830@sigill.intra.peff.net>
 <7vwqtulplp.fsf@alter.siamese.dyndns.org>
 <20130301092201.GA17254@sigill.intra.peff.net>
 <7va9qngisg.fsf@alter.siamese.dyndns.org>
 <20130301223612.GA862@sigill.intra.peff.net>
 <7vppzien3i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 02 00:09:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBZ4i-0005Fy-Ii
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 00:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab3CAXIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 18:08:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39601 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab3CAXIr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 18:08:47 -0500
Received: (qmail 4946 invoked by uid 107); 1 Mar 2013 23:10:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 18:10:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 18:08:45 -0500
Content-Disposition: inline
In-Reply-To: <7vppzien3i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217304>

On Fri, Mar 01, 2013 at 03:06:57PM -0800, Junio C Hamano wrote:

> > I can believe it. So do we want to do that fix, then? Did you want to
> > roll up the two halves of it with a test and write a commit message? I
> > feel like you could write a much more coherent one than I could on this
> > subject.
> 
> I actually was wondering if we can remove that sole uses of two-way
> merge with --reset -u from "git am" and replace them with something
> else.  But we do want to keep local change that existed before "am"
> started, so we cannot avoid use of two-way merge, I guess...

Yeah, I think that is a case we definitely want to keep, as it means any
intermediate work done by the user in applying the patch is not lost.

-Peff
