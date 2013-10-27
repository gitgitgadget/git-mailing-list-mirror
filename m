From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Sun, 27 Oct 2013 09:09:32 +0100
Message-ID: <874n83m8xv.fsf@linux-k42r.v.cablecom.net>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
	<526CA7D4.1070904@alum.mit.edu> <20131027071407.GA11683@leaf>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Sun Oct 27 09:10:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaLQZ-00055K-MJ
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 09:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab3J0IJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 04:09:49 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:52176 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab3J0IJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 04:09:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 3D7E54D6534;
	Sun, 27 Oct 2013 09:09:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id N4iwEEUMqDzf; Sun, 27 Oct 2013 09:09:34 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 293604D6414;
	Sun, 27 Oct 2013 09:09:34 +0100 (CET)
In-Reply-To: <20131027071407.GA11683@leaf> (Josh Triplett's message of "Sun,
	27 Oct 2013 07:14:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236792>

Josh Triplett <josh@joshtriplett.org> writes:

> On Sun, Oct 27, 2013 at 06:42:44AM +0100, Michael Haggerty wrote:
>> But I don't think that this feature should be given the "-f" short
>> option, as (a) -f often means "force"; (b) it will increase the
>> confusion with --fixup; (c) it just doesn't strike me as being likely to
>> be such a frequently-used option (though if this changes over time the
>> "-f" option could always be granted to it later).
>
> (a) -n often means --dry-run, but for commit it means --no-verify.
> Different commands have different options, and commit doesn't have a
> --force to abbreviate as -f.
>
> (b) If anything, I think the existence of a short option will make the
> distinction more obvious, since -f and --fixup are much less similar
> than --fixes and --fixup.  Most users will never type --fixes, making
> confusion unlikely.
>
> (c) Short option letters tend to be first-come first-serve unless
> there's a strong reason to do otherwise.  Why reserve 'f' for some
> hypothetical future option that doesn't exist yet?

No, lately the direction in Git has been to avoid giving options a
one-letter shorthand until they have proven so useful that people using
it in the wild start to suggest that it should have one.

See e.g.

  http://article.gmane.org/gmane.comp.version-control.git/233998
  http://article.gmane.org/gmane.comp.version-control.git/168748

A much better argument would be if it was already clear from the specs
laid out for Fixes that n% of the kernel commits will end up having this
footer, and thus kernel hackers will spend x amount of time spelling out
--fixes and/or confusing it with --fixup to much headache.

-- 
Thomas Rast
tr@thomasrast.ch
