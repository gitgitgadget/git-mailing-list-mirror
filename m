From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Make 'remote show' distinguish between merged and rebased
 	remote branches
Date: Wed, 11 Feb 2009 11:59:20 -0500
Message-ID: <499303E8.6030000@xiplink.com>
References: <20090210202046.8EBEC3360AC@rincewind>	 <7v3aemm1po.fsf@gitster.siamese.dyndns.org>	 <4991FA18.1040200@xiplink.com> <76718490902101513i504e515ocb4a2d789ba520f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:01:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXISG-0004kW-Ag
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762AbZBKQ70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756746AbZBKQ7Z
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:59:25 -0500
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:47971 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741AbZBKQ7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 11:59:24 -0500
Received: from relay8.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id A54C0208C15;
	Wed, 11 Feb 2009 11:59:23 -0500 (EST)
Received: by relay8.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 70F81207EBC;
	Wed, 11 Feb 2009 11:59:23 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <76718490902101513i504e515ocb4a2d789ba520f0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109445>

Jay Soffian wrote:
> 
> The output of git remote show seems much too verbose for the
> information it provides.

I agree.

I'm happy to hammer out and implement new output for 'remote show', but is there any chance that such a change would be accepted?

Junio, Dscho, (others) -- any opposition to this?

> Something like this, I think, provides the
> same information in much less space:
> 
> * remote origin
>   URL: git://git.kernel.org/pub/scm/git/git.git
>   Remote branches:
>     html      Not tracked
>     maint     Tracked
>     man       Tracked
>     master    Tracked
>     next      Tracked
>     pu        Tracked
>     todo      Not tracked
>     old-next  Stale (would prune)
>   Local branches configured to pull from this remote:
>     master           upstream is master (merges)
>     wip/remote-HEAD  upstream is next   (rebases)

How about something a bit tighter, merging the local branch list with the remote branch list:

* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  Remote branches:
    html      Not tracked
    master    Tracked by local branches:
                master (merges)
                mywork (rebases)
    next      Tracked by local branch:
                wip/remote-HEAD (rebases)
    pu        Tracked by local branch:
                pu (merges)
    todo      Not tracked
    old-next  Stale (would prune)

?

		M.
