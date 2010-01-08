From: Jeff King <peff@peff.net>
Subject: Re: Possible bug in git-completion.sh
Date: Fri, 8 Jan 2010 12:24:45 -0500
Message-ID: <20100108172445.GB6344@coredump.intra.peff.net>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7vaawosfg9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 18:25:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTIa3-0006Xv-FI
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 18:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab0AHRY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 12:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550Ab0AHRYz
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 12:24:55 -0500
Received: from peff.net ([208.65.91.99]:60498 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab0AHRYz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 12:24:55 -0500
Received: (qmail 19017 invoked by uid 107); 8 Jan 2010 17:29:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 08 Jan 2010 12:29:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jan 2010 12:24:45 -0500
Content-Disposition: inline
In-Reply-To: <7vaawosfg9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136461>

On Fri, Jan 08, 2010 at 08:56:38AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > You can see it as a feature that you can use to check what would happen
> > if you stopped ignoring the directory from the higher level.  With a patch
> > to always cd-up and use pathspec, that will become impossible.
> 
> I hate to say this, but I have a feeling that status might be what needs
> to be fixed instead.  It isn't hard to imagine a use case where you don't
> want to be bothered by crufts in lower level directories when you are
> looking at the bigger picture (e.g. at the top of the hierarchy) but when
> you go to individual subdirectory you would want to see them.

For people who have status.relativepaths off, status is still a global
command. So I would hope that behavior would come out only when doing
"git status .", or at the very least be disabled if status.relativepaths
is set.

Personally, I think having ignored files show up as untracked based on
heuristics like cwd is just going to end up confusing people.

-Peff
