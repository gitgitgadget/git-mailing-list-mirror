From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 3/3] fetch --all/--multiple: keep all the fetched branch information
Date: Wed, 24 Feb 2010 21:07:08 +0200
Message-ID: <87y6iizc4j.fsf@mithlond.arda>
References: <1267035726-2815-1-git-send-email-gitster@pobox.com>
	<1267035726-2815-2-git-send-email-gitster@pobox.com>
	<7vpr3uqwya.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Lukashov <michael.lukashov@gmail.com>
To: "Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 20:07:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMaG-00058G-CG
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757598Ab0BXTHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 14:07:39 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:40741 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757501Ab0BXTHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:07:38 -0500
Received: from mithlond.arda (84.251.132.215) by kirsi1.inet.fi (8.5.014)
        id 4B1D0B4D03585888; Wed, 24 Feb 2010 21:07:18 +0200
Received: from dtw by mithlond.arda with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1NkMZg-0001dp-4P; Wed, 24 Feb 2010 21:07:08 +0200
In-Reply-To: <7vpr3uqwya.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 24 Feb 2010 11:02:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140971>

* 2010-02-24 11:02 (-0800), Junio C. Hamano wrote:

> Since "git fetch" learned "--all" and "--multiple" options, it has become
> tempting for users to say "git pull --all".  Even though it may fetch from
> remotes that do not need to be fetched from for merging with the current
> branch, it is handy.
>
> "git fetch" however clears the list of fetched branches every time it
> contacts a different remote.  Unless the current branch is configured to
> merge with a branch from a remote that happens to be the last in the list
> of remotes that are contacted, "git pull" that fetches from multiple
> remotes will not be able to find the branch it should be merging with.
>
> Make "fetch" clear FETCH_HEAD (unless --append is given) and then append
> the list of branches fetched to it (even when --apend is not given).  That
                                                ^^^^^^^

Not very important but there's a typo: "apend".


> way, "pull" will be able to find the data for the branch being merged in
> FETCH_HEAD no matter where the remote appears in the list of remotes to be
> contacted by "git fetch".
>
> Reported-by: Michael Lukashov
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
