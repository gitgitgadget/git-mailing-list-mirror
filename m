From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test: fix t7001 cp to use POSIX options
Date: Fri, 11 Apr 2014 07:43:38 -0400
Message-ID: <20140411114338.GD28858@sigill.intra.peff.net>
References: <1c3e86191de8c91545ac3ddc18fd31e@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 13:43:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYZs3-0003V2-RT
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 13:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbaDKLnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 07:43:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:57876 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754673AbaDKLnk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 07:43:40 -0400
Received: (qmail 21985 invoked by uid 102); 11 Apr 2014 11:43:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Apr 2014 06:43:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Apr 2014 07:43:38 -0400
Content-Disposition: inline
In-Reply-To: <1c3e86191de8c91545ac3ddc18fd31e@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246081>

On Fri, Apr 11, 2014 at 01:24:02AM -0700, Kyle J. McKay wrote:

> Since 11502468 and 04c1ee57 (both first appearing in v1.8.5), the
> t7001-mv test has used "cp -a" to perform a copy in several of the
> tests.
> 
> However, the "-a" option is not required for a POSIX cp utility and
> some platforms' cp utilities do not support it.
> 
> The POSIX equivalent of -a is -R -P -p.
> 
> Change "cp -a" to "cp -R -P -p" so that the t7001-mv test works
> on systems with a cp utility that only implements the POSIX
> required set of options and not the "-a" option.

I wonder if the "-R" is the part that we actually care about here.
Including the others does not hurt in that case, but using only "-R"
would perhaps make it more obvious to a later reader of the code exactly
what we are trying to do.

-Peff
