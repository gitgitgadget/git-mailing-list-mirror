From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] New date format: local_original
Date: Wed, 7 Oct 2009 08:54:27 -0400
Message-ID: <20091007125427.GA20067@coredump.intra.peff.net>
References: <200910062209.47606.tuomas.suutari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tuomas Suutari <tuomas.suutari@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 14:59:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvW7I-00080i-70
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 14:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024AbZJGMzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 08:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759113AbZJGMzG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 08:55:06 -0400
Received: from peff.net ([208.65.91.99]:44706 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758951AbZJGMzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 08:55:05 -0400
Received: (qmail 31695 invoked by uid 107); 7 Oct 2009 12:57:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Oct 2009 08:57:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Oct 2009 08:54:27 -0400
Content-Disposition: inline
In-Reply-To: <200910062209.47606.tuomas.suutari@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129646>

On Tue, Oct 06, 2009 at 10:09:47PM +0300, Tuomas Suutari wrote:

> Formats date and time with local and original timezone representation
> in same string. They both can be useful at the same time: local
> timezone for relating timestamp to local events, and original timezone
> to see the author's time of the day.
>
> [...]
>
> It was hard to decide whether to use --date=local or --date=iso
> with git log, so I though that maybe I could have them both.

It's not clear to me. Do you really _like_ seeing them both, or did you
simply want to see local dates in the iso format, but those two options
(which are conceptually orthogonal) could not be used at the same time?

If the latter, then maybe we should resurrect the patch that allows
"--date=local --date=iso" to do what you want. From this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/112026

If the former, then should the options be orthogonal? That is, should it
be a new format combining the two, or should it be an option to show, in
your preferred format, the time in both local and original time zones?
E.g., something like:

  $ git log --date=iso --local-dates-too
  commit bf01a69ed40e1afcf56aff143f7523da2ce263ed
  Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
  Date:   2009-10-04 00:41:55 +0200
  Local:  2009-10-03 17:41:55 -0500

And then you can use it with "normal" dates, iso dates, rfc2822 dates,
etc.

I dunno. I have to admit I never personally really wanted anything
except the default date format, unless I was parsing it for something
special.

-Peff
