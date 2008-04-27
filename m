From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Sat, 26 Apr 2008 22:23:22 -0700
Message-ID: <7vabjflvlh.fsf@gitster.siamese.dyndns.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org>
 <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org>
 <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 07:24:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpzNG-0001kO-KU
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 07:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbYD0FXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 01:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbYD0FXn
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 01:23:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYD0FXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 01:23:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 58E2A4004;
	Sun, 27 Apr 2008 01:23:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7BEA34001; Sun, 27 Apr 2008 01:23:33 -0400 (EDT)
In-Reply-To: <20080427044049.GJ29771@spearce.org> (Shawn O. Pearce's message
 of "Sun, 27 Apr 2008 00:40:49 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80410>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I _hate_ the default remote.  One of the first things I wind up
> doing is deleting it and creating a new one.  At least git-clone has
> the -o flag to setup your own name, which then the tools (git-fetch
> and git-push) cannot find.
>
> Anytime I use git-fetch, git-pull or git-push I am always giving
> it a remote name, or a remote name and a refspec.  So having these
> tools default to 'origin' is of little to no value to me.

It sounds as if you want to say it a bit stronger than that --- to you,
defaulting to 'origin' is not of "little to no" but "negative" value, is
it?

But I think we are minotiry.  To people with "CVS migrant" workflow,
cloning from _the_ central repo, hacking, and then pushing back will never
involve anything other than 'origin' and local repositories, and I am
sympathetic when they want to say "git push" and have it default to that
single other repository.

If you have more than one places to push, like we do, we have these
multiple repositories exactly because we would want to push to these
repositories for different reasons, and being able to name to which one we
would want to push in each invocation of push is a power.  But not all
people need to use that power.  If somebody pushes only to one place,
which may be very typical, that's fine, and in such a typical "single
remote" configuration, they will be pushing back to where they cloned
from.
