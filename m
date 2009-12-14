From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH 03/23] Introduce "skip-worktree" bit in index, teach
	Git to get/set this bit
Date: Mon, 14 Dec 2009 18:06:19 -0500
Message-ID: <20091214230619.GA30538@dr-wily.mit.edu>
References: <1260786666-8405-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKJzs-0007gv-VP
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 00:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758728AbZLNXG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 18:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbZLNXG0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 18:06:26 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:59768 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758707AbZLNXGZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 18:06:25 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nBEN5nCm023607;
	Mon, 14 Dec 2009 18:05:50 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nBEN6Ur6009827;
	Mon, 14 Dec 2009 18:06:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1260786666-8405-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135252>

Hi Duy,

> +Skip-worktree bit
> +-----------------
> +
> +Skip-worktree bit can be defined in one (long) sentence: When reading
> +an entry, if it is marked as skip-worktree, then Git pretends its
> +working directory version is up to date and read the index version
> +instead.
> +
> +To elaborate, "reading" means checking for file existence, reading
> +file attributes or file content. The working directory version may be
> +present or absent. If present, its content may match against the index
> +version or not. Writing is not affected by this bit, content safety
> +is still first priority. Note that Git _can_ update working directory
> +file, that is marked skip-worktree, if it is safe to do so (i.e.
> +working directory version matches index version)
> +
> +Although this bit looks similar to assume-unchanged bit, its goal is
> +different from assume-unchanged bit's. Skip-worktree also takes
> +precedence over assume-unchanged bit when both are set.

I confess I can't tell how the skip-worktree bit does differ from
assume-unchanged.  Is its 'goal' different only in that you have a
different motivation for introducing it, or does it actually have a
different effect -- and what is that different effect?

Looking forward to seeing sparse checkouts soon!

Cheers,
Greg
