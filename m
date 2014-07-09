From: Jeff King <peff@peff.net>
Subject: Re: Branch list by date
Date: Wed, 9 Jul 2014 01:21:14 -0400
Message-ID: <20140709052114.GC2318@sigill.intra.peff.net>
References: <CAMxk9GhQs_kF5573MS1SJ6a7UZuPu+oquXidOOvibznLQ7_FWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeremy Apthorp <nornagon@nornagon.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:21:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4kJo-00044r-K3
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 07:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbaGIFVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 01:21:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:58485 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750718AbaGIFVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 01:21:16 -0400
Received: (qmail 23349 invoked by uid 102); 9 Jul 2014 05:21:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 00:21:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 01:21:14 -0400
Content-Disposition: inline
In-Reply-To: <CAMxk9GhQs_kF5573MS1SJ6a7UZuPu+oquXidOOvibznLQ7_FWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253063>

On Mon, Jul 07, 2014 at 09:54:55PM -0700, Jeremy Apthorp wrote:

> I write this missive with dual purpose: firstly to share a potentially
> useful tool, and secondly to suggest that this feature (with a less
> mind-wrenchingly disgusting implementation) might be included in
> mainline git, as for example `git branch [-t] | [--by-time]`.

I think what we should aim for is:

  1. Teaching git-branch the same sorting as for-each-ref. So first
     --sort, and then possibly "-t" as an alias for "--sort=committerdate".

  2. Teaching git-branch custom output formats. We have "-v" and "-vv",
     but it should support the full power of for-each-ref's --format
     atoms.

  3. Teach branch and for-each-ref to support readable colors in their
     formats, like we do for "log --format".

  4. Optionally add config options to configure defaults for the above,
     so "git branch" shows what you want.

I'm (slowly) working on a refactor that will unify for-each-ref and
branch, which would accomplish (1) and (2).

-Peff
