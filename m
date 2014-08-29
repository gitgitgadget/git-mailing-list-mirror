From: Jeff King <peff@peff.net>
Subject: Re: What happens when the repository is bigger than gc.autopacklimit
 * pack.packSizeLimit?
Date: Fri, 29 Aug 2014 14:47:16 -0400
Message-ID: <20140829184716.GB29456@peff.net>
References: <201408271936.s7RJarOh011358@hobgoblin.ariadne.com>
 <20140827194746.GE7561@peff.net>
 <201408291538.s7TFc0DU001156@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:47:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNRCk-0006tV-8y
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbaH2SrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:47:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:33333 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752942AbaH2SrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 14:47:18 -0400
Received: (qmail 30198 invoked by uid 102); 29 Aug 2014 18:47:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 13:47:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 14:47:16 -0400
Content-Disposition: inline
In-Reply-To: <201408291538.s7TFc0DU001156@hobgoblin.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256176>

On Fri, Aug 29, 2014 at 11:38:00AM -0400, Dale R. Worley wrote:

> > From: Jeff King <peff@peff.net>
> 
> > why are you setting the packsize limit to 99m in the first place?
> 
> I want to copy the Git repository to box.com as a backup measure, and
> my account on box.com limits files to 100 MB.

That makes sense, though I question whether packs are really helping you
in the first place. I wonder if you would be better off keep your
non-delta binaries as loose objects (this would require a new option to
pack-objects and teaching "gc --auto" to ignore these when counting
loose objects, but would be fairly straightforward).

-Peff
