From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] teach fast-export an --anonymize option
Date: Thu, 28 Aug 2014 14:50:41 -0400
Message-ID: <20140828185040.GC26855@peff.net>
References: <20140827165854.GC1432@peff.net>
 <20140827170127.GA6138@peff.net>
 <CACsJy8B3gFC7kLf-cLhAk3BgQ+v427rMXWHTqjU4LYP3NQte7Q@mail.gmail.com>
 <20140828123257.GA18642@peff.net>
 <53FF5CD7.8040603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:51:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN4md-0005eB-V0
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 20:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbaH1Suq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 14:50:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:60940 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753132AbaH1Suo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 14:50:44 -0400
Received: (qmail 22025 invoked by uid 102); 28 Aug 2014 18:50:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Aug 2014 13:50:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2014 14:50:41 -0400
Content-Disposition: inline
In-Reply-To: <53FF5CD7.8040603@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256114>

On Thu, Aug 28, 2014 at 05:46:15PM +0100, Ramsay Jones wrote:

> Dumb question (I have not even read the patch, so please just ignore me
> if this is indeed dumb!): Is the map of <original-name, anonymized-name>
> available to the user while he attempts to confirm that the bug is still
> present?

No, it's not.

> For example, if I anonymized git.git, and did 'git branch -v' (say), how
> easy would it be for me to recognise which branch was 'next'?

You can't, really. The simplest thing would be to pare down your
repository to the minimum number of branches before anonymizing.

It might make sense to have an option to dump the maps we've stored to a
separate file (in theory, you could even load them back in and do an
incremental anonymized export[1]). I think I'd rather wait on
implementing that until we see more real-world use cases (but as always,
I'm happy to review if somebody wants to pick it up).

-Peff

[1] Incremental anonymization is not something I think is worth
    supporting by itself. However, there may be some value in being able
    to anonymize two similar repositories using the same mappings. For
    instance, a repository and its clone.
