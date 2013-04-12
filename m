From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] Make read_index_data() public
Date: Fri, 12 Apr 2013 15:40:12 -0400
Message-ID: <20130412194012.GA5154@sigill.intra.peff.net>
References: <1365787573-597-1-git-send-email-git@cryptocrack.de>
 <1365787573-597-2-git-send-email-git@cryptocrack.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Fri Apr 12 21:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQjpr-0003hT-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 21:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398Ab3DLTkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 15:40:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43117 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538Ab3DLTkP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 15:40:15 -0400
Received: (qmail 29583 invoked by uid 107); 12 Apr 2013 19:42:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Apr 2013 15:42:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2013 15:40:12 -0400
Content-Disposition: inline
In-Reply-To: <1365787573-597-2-git-send-email-git@cryptocrack.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221020>

On Fri, Apr 12, 2013 at 07:26:11PM +0200, Lukas Fleischer wrote:

> This allows for reusing the function in convert.c later.
> 
> Also, move it from attr.c to read-cache.c and add a use_index parameter
> to specify a custom index_state since we are no longer enable to access
> the static use_index variable from attr.c.

I'm all for removing duplicated code, but, but I think the name
"read_index_data" is a bit misleading for a global function. I would
expect it to read data from the index (and the argument "path" does not
help clarify that at all).

Can we rename it read_blob_data_from_index_path() or something?

-Peff
