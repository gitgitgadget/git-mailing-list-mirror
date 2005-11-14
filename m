From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] GIT commit statistics.
Date: Tue, 15 Nov 2005 10:25:35 +1300
Message-ID: <46a038f90511141325p23531982kf6a230929bf6d202@mail.gmail.com>
References: <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	 <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
	 <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
	 <7vy83s95k0.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90511131242p4692c74fn20c015998620b9f4@mail.gmail.com>
	 <7vlkzr6gzz.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90511132001x6a9109fk17593b7ceaf3177e@mail.gmail.com>
	 <7vwtjb4vc4.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90511140051o1fa5ef7cyb9dd723fb8161ef9@mail.gmail.com>
	 <20051114092554.GR30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 22:28:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eblpc-0007Hj-37
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 22:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVKNVZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 16:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVKNVZh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 16:25:37 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:59794 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932142AbVKNVZg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 16:25:36 -0500
Received: by zproxy.gmail.com with SMTP id 40so1208031nzk
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 13:25:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o6YM1Qs7nt8xZ/iryJrF+Gas5uCDP+E2WjhHiCW48fsbVbpFDHQ7gsejcoiKQq6MpJKeQTAAae2ttj0738mstvfZcKxFrvk/+0UABS6+D73EeXa2w5qZgqyFsN+mxAmRRnrl9KSjaCNmVDFwyLfnbrjrIkPxlEH9AgIov9DmRuY=
Received: by 10.65.20.6 with SMTP id x6mr4008967qbi;
        Mon, 14 Nov 2005 13:25:36 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Mon, 14 Nov 2005 13:25:35 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051114092554.GR30496@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11851>

On 11/14/05, Petr Baudis <pasky@suse.cz> wrote:
> All the woes just to get rid of the merge commits. What's wrong on merge
> commits? If they irritate you so much, cg-log -M. ;-)

Well, if you have a team of 5 working closely, doing commit/update
several times a day, soon the following things happen:

 - everyone has sightly different histories, even if they all have the same tree
 - in the repo, there are 'update' merges galore.
 - as soon as you _actually_ have branches, it's really hard to
distinguish branch merges from 'same branch update before commit'
merges.

by replacing the daily/hourly intra-team, self-branch `cg-update` with
`cg-fetch && git-rebase` our history makes much more sense _and_
looking at gitk I can see clearly again the interesting merges (ie:
merges with other branches).

In practice, it's exactly what happens with git's history -- the
merges are actually from rebased patches, that's why the history is
"readable".

does that make sense?

cheers,


martin
