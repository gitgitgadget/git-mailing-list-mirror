From: Jeff King <peff@peff.net>
Subject: Re: git smudge filter fails
Date: Thu, 10 Mar 2016 16:05:44 -0500
Message-ID: <20160310210544.GB30595@sigill.intra.peff.net>
References: <CAH8BJxHwxp2BtzGBqi6J24Kh0TTGEdCx=-Scu+bx5N-ZVpBZNQ@mail.gmail.com>
 <20160310015939.GA12709@sigill.intra.peff.net>
 <CAH8BJxFmAQtoF+1Q7Ub5qWnz5UewrPS4e8JQWms254hO_E05Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:06:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae7mX-0000f9-TW
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbcCJVFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 16:05:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:58004 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932496AbcCJVFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 16:05:48 -0500
Received: (qmail 3799 invoked by uid 102); 10 Mar 2016 21:05:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Mar 2016 16:05:47 -0500
Received: (qmail 29130 invoked by uid 107); 10 Mar 2016 21:06:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Mar 2016 16:06:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2016 16:05:44 -0500
Content-Disposition: inline
In-Reply-To: <CAH8BJxFmAQtoF+1Q7Ub5qWnz5UewrPS4e8JQWms254hO_E05Hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288639>

On Thu, Mar 10, 2016 at 09:45:19AM -0500, Stephen Morton wrote:

> I am a bit confused because this is basically the example used in
> ProGit [1] and it is fundamentally broken. In fact, if I understand
> correctly, this means that smudge filters cannot be relied upon to
> provide any 'keyword expansion' type tasks because they will all by
> nature have to query the file with 'git log'.

Interesting. Perhaps I am missing something (I am far from an expert in
clean/smudge filters, which I do not generally use myself), but the
example in ProGit looks kind of bogus to me. I don't think it ever would
have worked reliably, under any version of git.

> (Note that although in my example I used 'git checkout', with an only
> slightly more complicated example I can make it fail on 'git pull'
> which is perhaps a much more realistic use case. That was probably
> implied in your answer, I just wanted to mention it.)

Yeah, I think the issue is basically the same for several commands which
update the worktree and the HEAD. Most of them are going to do the
worktree first.

-Peff
