From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 6 Jan 2014 15:43:54 -0500
Message-ID: <20140106204353.GB643@sigill.intra.peff.net>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
 <20140106201854.GA28162@sigill.intra.peff.net>
 <CAEBDL5UaS2Hd-Yb417W+Fw_7j1+5sRAgszko-PbU7z901_X+cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 21:44:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0H1k-00019R-Ec
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 21:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124AbaAFUn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 15:43:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:56095 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755760AbaAFUnz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 15:43:55 -0500
Received: (qmail 17242 invoked by uid 102); 6 Jan 2014 20:43:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 14:43:55 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 15:43:54 -0500
Content-Disposition: inline
In-Reply-To: <CAEBDL5UaS2Hd-Yb417W+Fw_7j1+5sRAgszko-PbU7z901_X+cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240062>

On Mon, Jan 06, 2014 at 03:29:57PM -0500, John Szakmeister wrote:

> > Yeah, I had similar thoughts. I personally use "branch.*.merge" as
> > "forkedFrom", and it seems like we are going that way anyway with things
> > like "git rebase" and "git merge" defaulting to upstream. But then there
> > is "git push -u" and "push.default = upstream", which treats the
> > upstream config as something else entirely.
> 
> Just for more reference, I rarely use "branch.*.merge" as
> "forkedFrom".  I typically want to use master as my target, but like
> Ram, I publish my changes elsewhere for safe keeping.  I think in a
> typical, feature branch-based workflow @{u} would be nearly useless.

In my feature-branch development for git.git, my upstream is almost
always origin/master[1]. However, sometimes feature branches have
dependencies[2] on each other. Representing that via the "upstream"
field makes sense, since that is what you forked from, and what you
would want "git rebase" to start from.

-Peff

[1] I do not even have a local "master" branch for git.git work, as it
    would just be a pain to keep up to date. I am either working
    directly on a topic branch, or I am integrating in my own personal
    branch.

[2] You should try to minimize dependencies between feature branches, of
    course, but sometimes they simply form a logical progression of
    features.
