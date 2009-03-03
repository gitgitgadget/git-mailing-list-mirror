From: Jeff King <peff@peff.net>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 03:06:03 -0500
Message-ID: <20090303080603.GA3158@coredump.intra.peff.net>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com> <1235865822-14625-2-git-send-email-gitster@pobox.com> <1235865822-14625-3-git-send-email-gitster@pobox.com> <20090301031609.GA30384@coredump.intra.peff.net> <7v63itbxe7.fsf@gitster.siamese.dyndns.org> <20090301100039.GD4146@coredump.intra.peff.net> <20090301170436.GA14365@spearce.org> <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org> <20090303070937.GB30609@coredump.intra.peff.net> <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 09:07:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePfA-0002Z6-6k
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbZCCIGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZCCIGJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:06:09 -0500
Received: from peff.net ([208.65.91.99]:40997 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbZCCIGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:06:09 -0500
Received: (qmail 13625 invoked by uid 107); 3 Mar 2009 08:06:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 03:06:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 03:06:03 -0500
Content-Disposition: inline
In-Reply-To: <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112024>

On Mon, Mar 02, 2009 at 11:55:51PM -0800, Junio C Hamano wrote:

> As with the previous "git init --remote" patch, my design constraints
> includes keeping the door open for "git shell" users to optionally allow
> this mode of operation.

OK, I thought your original comment was "I don't think this constraint
(thinking only of normal shell users) is right, but here is a patch
anyway". Which did leave me confused, since it seemed like your patch
did not cater just to such users. But I see now what you meant.

However, if you are thinking of "git shell" users, then is it not a
potential security problem to allow them to create new repositories
without the admin explicitly enabling it? If a site is depending on
hooks in existing repositories to implement some kind of policy, then
isn't this a way to bypass it (not to make changes in those existing
repos, obviously, but let's say there is a policy about how disk usage
is counted).

Even if it isn't a security issue, it might simply be broken. Shawn has
said that Gerrit needs extra magic when creating a repository, and I
wouldn't be surprised if github and repo.or.cz were the same. With your
patch, what switch should a Gerrit admin flip to prevent people from
creating broken repos?

What about places that might simply want to put some policy in place,
like kernel.org having all linux repos point to Linus as alternates?

-Peff
