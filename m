From: Jeff King <peff@peff.net>
Subject: Re: git show -m with a parent number
Date: Mon, 28 Mar 2016 15:16:08 -0400
Message-ID: <20160328191608.GA22602@sigill.intra.peff.net>
References: <nd9gq6$412$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anatoly Borodin <anatoly.borodin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:16:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akce8-0004ih-Oq
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 21:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbcC1TQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 15:16:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:39512 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751164AbcC1TQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 15:16:11 -0400
Received: (qmail 21989 invoked by uid 102); 28 Mar 2016 19:16:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Mar 2016 15:16:10 -0400
Received: (qmail 15462 invoked by uid 107); 28 Mar 2016 19:16:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Mar 2016 15:16:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2016 15:16:08 -0400
Content-Disposition: inline
In-Reply-To: <nd9gq6$412$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290058>

On Sun, Mar 27, 2016 at 08:46:02PM +0000, Anatoly Borodin wrote:

> is there a good reason for `git show -m` to not accept the number of a
> parent of a merge commit? I can run `git show --first-parent COMMIT`,
> but need to write `git diff COMMIT^2 COMMIT` every time I want to diff
> with the second parent!

I think it could, but nobody has yet found it useful enough to
implement.

I am not sure of the workflow it would help. Personally, I use "-m" in
two situations:

  1. To puzzle out issues where "-c" or "--cc" do not show what I
     expected.

  2. With "--first-parent", to follow the linear history of a mainline
     branch, showing merged topic branches as a single diff.

For the first one, showing all diffs is what I want. For the second, it
only makes sense to for the first parent case, as following other
parents would zig-zag through history.

But perhaps you have some other use case in mind. In cases like these, I
think it is a good idea to implement the feature, and run with it for a
while, seeing how it can be used. And then if it proves useful, post the
patch to the list describing your experiences.

-Peff
