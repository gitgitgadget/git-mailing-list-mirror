From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 03 Mar 2009 00:22:53 -0800
Message-ID: <7v63irf21u.fsf@gitster.siamese.dyndns.org>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
 <1235865822-14625-2-git-send-email-gitster@pobox.com>
 <1235865822-14625-3-git-send-email-gitster@pobox.com>
 <20090301031609.GA30384@coredump.intra.peff.net>
 <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
 <20090301100039.GD4146@coredump.intra.peff.net>
 <20090301170436.GA14365@spearce.org>
 <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
 <20090303070937.GB30609@coredump.intra.peff.net>
 <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org>
 <20090303080603.GA3158@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 09:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePvY-0006kC-14
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbZCCIXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbZCCIXG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:23:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZCCIXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:23:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 11E181378;
	Tue,  3 Mar 2009 03:23:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 414B21377; Tue, 
 3 Mar 2009 03:22:55 -0500 (EST)
In-Reply-To: <20090303080603.GA3158@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 3 Mar 2009 03:06:03 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 826D92CE-07CC-11DE-A0B5-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112027>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 02, 2009 at 11:55:51PM -0800, Junio C Hamano wrote:
>
>> As with the previous "git init --remote" patch, my design constraints
>> includes keeping the door open for "git shell" users to optionally allow
>> this mode of operation.
>
> OK, I thought your original comment was "I don't think this constraint
> (thinking only of normal shell users) is right, but here is a patch
> anyway". Which did leave me confused, since it seemed like your patch
> did not cater just to such users. But I see now what you meant.

Yeah, I wanted to see if we can give git-shell only people a sane way to
host a group project, so that was why I mentioned "chgrp/chmod" in the
follow-up message to the "init --remote" series.

> However, if you are thinking of "git shell" users, then is it not a
> potential security problem to allow them to create new repositories
> without the admin explicitly enabling it? If a site is depending on
> hooks in existing repositories to implement some kind of policy, then
> isn't this a way to bypass it (not to make changes in those existing
> repos, obviously, but let's say there is a policy about how disk usage
> is counted).

Yes and no.  I think "git shell" sites fall broadly into two categories.
The ones arranged ala gitosis without per-user UNIX account, it certainly
is an issue.  The ones with per-user UNIX account would not let anywhere
other than $HOME written, so it is not.

My sole interest lies in building a track record of suggested patches to
eliminate the excuse people would use to complain that we do not attempt
to allow repositories to be created remotely.  I've shown two possible
ways.  It now is turn for those who want to have the feature to fill in
the details.  These are weatherbaloon patches, and it is not my itch to
scratch anyway.

> Even if it isn't a security issue, it might simply be broken. Shawn has
> said that Gerrit needs extra magic when creating a repository, and I
> wouldn't be surprised if github and repo.or.cz were the same. With your
> patch, what switch should a Gerrit admin flip to prevent people from
> creating broken repos?
>
> What about places that might simply want to put some policy in place,
> like kernel.org having all linux repos point to Linus as alternates?

These are all valid points and people who are interested in creating
repositories remotely must think about them when they finally decide to
scratch their own itch.  I am merely helping by showing where to add
hooks.
