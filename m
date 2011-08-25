From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 17:29:36 -0500
Message-ID: <5qgbkjmEZ8jSRkpVNieElg1bcVbuEStD525CFu1hZPQ7F03R3EzjXwQdDKQBOnR1zWDiZBsGu53K20rbOGpYd6rmp2-e-ZI3Z42BKT01TVI@cipher.nrlssc.navy.mil>
References: <20110825204047.GA9948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 00:29:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwiQu-0007yA-JB
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 00:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab1HYW3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 18:29:52 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:35591 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755583Ab1HYW3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 18:29:51 -0400
Received: by mail3.nrlssc.navy.mil id p7PMTb5m032740; Thu, 25 Aug 2011 17:29:37 -0500
In-Reply-To: <20110825204047.GA9948@sigill.intra.peff.net>
X-OriginalArrivalTime: 25 Aug 2011 22:29:36.0572 (UTC) FILETIME=[787E0FC0:01CC6376]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180132>

On 08/25/2011 03:40 PM, Jeff King wrote:
> We already provide sane hunk-header patterns for specific
> languages. However, the user has to manually map common
> extensions to use them. It's not that hard to do, but it's
> an extra step that the user might not even know is an
> option. Let's be nice and do it automatically.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I tried to think of negative side effects.

That's what I worried about when I last touched this code.  Now I'm
thinking "what took us so long to do this!!??".

> Also, any other extensions that would go into such a list?

*.bib diff=bibtex
*.tex diff=tex

*.[Ff] diff=fortran
*.[Ff][0-9][0-9] diff=fortran

GNU fortran currently recognizes .fXX where XX is 90, 95, 03 and 08
and probably enables/disables features based on the respective standard.
[0-9][0-9] would future proof against fortran f13 and f25 as long as
there aren't other extensions that would conflict.

Wikipedia says that .for is an extension for fortran, but I've never
seen that in the wild.  Maybe it's a windows thing (3-char ext).

-Brandon
