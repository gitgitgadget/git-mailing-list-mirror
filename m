From: Jeff King <peff@peff.net>
Subject: Re: [BUG] inconsistent behavior with --set-upstream vs
 --set-upstream-to
Date: Tue, 2 Apr 2013 13:51:13 -0400
Message-ID: <20130402175113.GD24698@sigill.intra.peff.net>
References: <F58991CB-9C83-4DA6-B82B-2E6C874C30EB@gmail.com>
 <20130402172333.GB24698@sigill.intra.peff.net>
 <A4C40BCB-85DD-4BCB-8BF0-79A75DE73211@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Garrett Cooper <yaneurabeya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:51:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN5N6-0006iw-1M
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761207Ab3DBRvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:51:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52391 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761137Ab3DBRvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:51:17 -0400
Received: (qmail 11939 invoked by uid 107); 2 Apr 2013 17:53:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 13:53:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 13:51:13 -0400
Content-Disposition: inline
In-Reply-To: <A4C40BCB-85DD-4BCB-8BF0-79A75DE73211@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219820>

On Tue, Apr 02, 2013 at 10:30:35AM -0700, Garrett Cooper wrote:

> I push the branch to origin/ and then things tend to work, but since I
> obviously had been doing things wrong what's the correct order of
> operations for creating a branch and setting the upstream
> appropriately?

Once you have pushed it, the push creates the refs/remotes/origin/foo
tracking branch automatically. You are then free to reference it
wherever you like, including in set-upstream-to. However, you can also
just ask push to do it for you with "--set-upstream" or "-u". So the
workflow is something like:

  $ git checkout -b my-topic
  $ hack hack hack
  $ git commit -m "looking good, time to publish"
  $ git push -u origin HEAD

> PS I love git as a tool, but I really wish the workflows were simpler
> or more straightforward, and error messages were clearer. It seems
> like this would help prevent usage errors like this..

Things slowly improve as people make suggestions. I think the thing that
might have helped here is better advice when "set-upstream-to" is
pointed to a ref that does not exist.

Patches coming in a minute.

-Peff
