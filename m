From: Jeff King <peff@peff.net>
Subject: Re: branch annotations?
Date: Mon, 25 Nov 2013 09:56:44 -0500
Message-ID: <20131125145644.GB23802@sigill.intra.peff.net>
References: <20131125084644.350bd4f7@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 15:56:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vkxal-00086A-FH
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 15:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab3KYO4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 09:56:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:45340 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754422Ab3KYO4q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 09:56:46 -0500
Received: (qmail 12701 invoked by uid 102); 25 Nov 2013 14:56:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Nov 2013 08:56:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Nov 2013 09:56:44 -0500
Content-Disposition: inline
In-Reply-To: <20131125084644.350bd4f7@bigbox.christie.dr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238313>

On Mon, Nov 25, 2013 at 08:46:44AM -0600, Tim Chase wrote:

> Is there any way to associate some sort of note with a branch that
> would be shown when listing them?  While I currently have things like
> "issue/QA-42", it would be nice to have a note associated with it so
> I could do something like
> 
>   $ git branch --show-notes
>     issue/CR-88: make sure NoSQL engines support .CSV file backends
>     issue/QA-31: add missile launch codes
>   * issue/QA-42: support flying cars
>     master

There is a "branch description" config entry that you can edit with "git
branch --edit-description" (or by simply tweaking the config file
yourself). However, it is currently only used by git-request-pull when
generating the request.

I think it makes sense to be able to show it as part of "git branch",
but the verbose branch listing there is a bit of a mess. Doing it
cleanly would probably involve refactoring the branch-display code to
allow users to specify more flexible formats.

Ramkumar (cc'd) was looking into that refactoring a while back, but I
did not follow it closely (it looks like some of the underlying
for-each-ref refactoring is on the 'next' branch?).

-Peff
