From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 2/5] fetch doc: update note on '+' in front of the refspec
Date: Fri, 30 May 2014 10:35:26 -0400
Message-ID: <5388972E.2010008@xiplink.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com> <1401403350-7122-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 16:35:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqNtm-0001e2-Hv
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 16:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933417AbaE3OfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 10:35:01 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:38634 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933107AbaE3OfA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 10:35:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp20.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 6A2E61C10B6;
	Fri, 30 May 2014 10:34:59 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp20.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C69261C1065;
	Fri, 30 May 2014 10:34:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401403350-7122-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250440>

On 14-05-29 06:42 PM, Junio C Hamano wrote:
> While it is not *wrong* per-se to say that pulling a rewound/rebased
> branch will lead to an unnecessary merge conflict, that is not what
> the leading "+" sign to allow non-fast-forward update of remote-tracking
> branch is at all.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/pull-fetch-param.txt | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index 18cffc2..2a7e2b7 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -24,15 +24,15 @@ is updated even if it does not result in a fast-forward
>  update.
>  +
>  [NOTE]
> -If the remote branch from which you want to pull is
> -modified in non-linear ways such as being rewound and
> -rebased frequently, then a pull will attempt a merge with
> -an older version of itself, likely conflict, and fail.
> -It is under these conditions that you would want to use
> -the `+` sign to indicate non-fast-forward updates will
> -be needed.  There is currently no easy way to determine
> -or declare that a branch will be made available in a
> -repository with this behavior; the pulling user simply
> +When the remote branch you want to fetch is known to
> +be rewound and rebased regularly, it is expected that
> +the tip of it will not be descendant of the commit that
> +used to be at its tip the last time you fetched it and
> +stored in your remote-tracking branch.  You would want

I think the second part of that last sentence might be clearer as

	it is expected that its new tip will not be a descendant of
	its previous tip (as stored in your remote-tracking branch
	the last time you fetched).

Then start the next sentence with

	In this case, you would want ....


		M.

> +to use the `+` sign to indicate non-fast-forward updates
> +will be needed for such branches.  There is no way to
> +determine or declare that a branch will be made available
> +in a repository with this behavior; the pulling user simply
>  must know this is the expected usage pattern for a branch.
>  +
>  [NOTE]
> 
