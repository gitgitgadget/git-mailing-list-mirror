From: Jeff King <peff@peff.net>
Subject: Re: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 20:16:36 -0400
Message-ID: <20100916001636.GA2371@sigill.intra.peff.net>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
 <7v62y661pl.fsf@alter.siamese.dyndns.org>
 <AANLkTimYNtU7sHn4_Vx50evTWDpMK_=XgshU3ZzT+eVw@mail.gmail.com>
 <AANLkTik7ORPUsABJv-bFraFNt2TvP0Xx=-013P2=A6Nr@mail.gmail.com>
 <AANLkTi=L0PA-p5HkWnurfurfyYAQhCBt+Q7SzzCczFLH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 02:16:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow29F-0006GF-Nl
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 02:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab0IPAQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 20:16:05 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53642 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab0IPAQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 20:16:04 -0400
Received: (qmail 25011 invoked by uid 111); 16 Sep 2010 00:16:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 16 Sep 2010 00:16:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Sep 2010 20:16:36 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=L0PA-p5HkWnurfurfyYAQhCBt+Q7SzzCczFLH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156281>

On Wed, Sep 15, 2010 at 07:41:50PM -0400, Jay Soffian wrote:

> On Wed, Sep 15, 2010 at 7:29 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > I sense another use of negative pathspecs here..
> 
> Yeah, I'm really not sure I agree with the reasoning of b5227d8
> (ls-files: excludes should not impact tracked files, 2009-10-12).
> 
> I thought about submitting a patch to revert b5227d8, but with an
> additional option to guard the behavior
> (--exclude-cached-files-too-pretty-please).
> 
> But I guess I don't see the harm in allowing excludes to apply to
> cached files when it is explicitly requested on the command-line. Here
> I think ls-files is slightly different than the other areas of git
> that don't apply excludes to cached files as it's about, well, listing
> files, and it's clear (I think) what the user wants.

It's not just the command line. It's also what's in .gitignore files. If
you disable just half of that, then you get the awful behavior that some
excludes apply to index files, and some don't.

Yes, it's confusing that "-i" is not actually an inversion for index
files. See

  http://article.gmane.org/gmane.comp.version-control.git/131719

It would help if I understood exactly what you're trying to accomplish.

-Peff
