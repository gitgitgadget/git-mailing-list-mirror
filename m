From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Fri, 5 May 2006 17:17:10 +1200
Message-ID: <46a038f90605042217n3261b14cxd63f35a31223848e@mail.gmail.com>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	 <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	 <87mzdx7mh9.wl%cworth@cworth.org>
	 <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Carl Worth" <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 07:17:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbsgl-0001Fz-HP
	for gcvg-git@gmane.org; Fri, 05 May 2006 07:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWEEFRM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 01:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWEEFRM
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 01:17:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:25457 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932468AbWEEFRL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 01:17:11 -0400
Received: by wr-out-0506.google.com with SMTP id i34so500862wra
        for <git@vger.kernel.org>; Thu, 04 May 2006 22:17:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R8feRHzLZcKebUD/yFqCf2DVI7yVVdgv4RZieaby68G8luL8EKcC76e0g6kWFp+rzcs8QfYO/sGsUsPkJ13wWwg07mQctCrwTxSi6q36jUtuDkM3bBHY0Tx4AOZcsKse8/A1BtUu+C/hhQnBN/yIUXRVp6BPVfTTn4YXLcFWm94=
Received: by 10.54.126.20 with SMTP id y20mr798421wrc;
        Thu, 04 May 2006 22:17:10 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Thu, 4 May 2006 22:17:10 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19597>

On 5/5/06, Junio C Hamano <junkio@cox.net> wrote:
> The vocabulary we would want from the requestor side is probably
> (at least):
>
>         I WANT to have these
>         I HAVE these
>         I'm MISSING these
>         Don't bother with these this time around (--since, ^v2.6.16, ...)

Thinking... does the MISSING part matter at all? It seems that what
really matters are the "ignore rules". The pull may bring in a new
merge of a long-running branch, whose mergebase falls out of the
ignore rules.

In that case, the server should apply the ignore rules. Except that
later merges in the local repo would perhaps have to deal with missing
part of the history. I suspect it should refuse to merge something we
don't have all the merging parts for.

cheers,


martin
