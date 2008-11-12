From: "Kyle Moffett" <kyle@moffetthome.net>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Tue, 11 Nov 2008 19:44:06 -0500
Message-ID: <f73f7ab80811111644y14f0e0ccweed44440356a6508@mail.gmail.com>
References: <20081107220730.GA15942@coredump.intra.peff.net>
	 <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
	 <20081108142756.GC17100@coredump.intra.peff.net>
	 <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org>
	 <20081109014926.GA31276@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Sam Vilain" <sam@vilain.net>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 01:45:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L03ra-0000Lw-Qw
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 01:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692AbYKLAoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 19:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756662AbYKLAoK
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:44:10 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:42875 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbYKLAoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:44:07 -0500
Received: by yx-out-2324.google.com with SMTP id 8so101526yxm.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 16:44:06 -0800 (PST)
Received: by 10.100.134.10 with SMTP id h10mr3634478and.150.1226450646085;
        Tue, 11 Nov 2008 16:44:06 -0800 (PST)
Received: by 10.100.241.4 with HTTP; Tue, 11 Nov 2008 16:44:06 -0800 (PST)
In-Reply-To: <20081109014926.GA31276@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100701>

On Sat, Nov 8, 2008 at 8:49 PM, Jeff King <peff@peff.net> wrote:
> The behavior is configurable via receive.denyCurrentBranch,
> defaulting to "warn" so as not to break existing setups
> (though it may, after a deprecation period, switch to
> "refuse" by default). For users who know what they are doing
> and want to silence the warning (e.g., because they have a
> post-receive hook that reconciles the HEAD and working
> tree), they can turn off the warning by setting it to false
> or "ignore".

Hmm, I wonder if it would be possible to also add a "detach" variant;
which would create a detached-HEAD at the current commit when
automatically receiving a push to the working branch.  I have a
post-receive script that does so right now on a couple repositories.
It's still a little confusing to someone actively working in the
repository being pushed to, but it's much easier to explain than the
current default behavior.

Cheers,
Kyle Moffett
