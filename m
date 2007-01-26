From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git merge FETCH_HEAD produced bad commit message
Date: Fri, 26 Jan 2007 15:32:41 +0100
Message-ID: <81b0412b0701260632l2181ef10i8d49ee9a795228b7@mail.gmail.com>
References: <81b0412b0701260102j7d1c44d5nd5aa489cb8312722@mail.gmail.com>
	 <20070126142420.GO10812@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Jan 26 15:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAS8m-0006ip-CL
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 15:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030612AbXAZOcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 09:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030626AbXAZOcs
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 09:32:48 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:34293 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030622AbXAZOcr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 09:32:47 -0500
Received: by wr-out-0506.google.com with SMTP id 68so693745wra
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 06:32:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bWno36P5zDpV52h3hWnsZAWJZ5uX+pXB0K19qzW6qhFAIB1t/1it4bRnbFHyw/NFdq1jN4V9cDBffBoxV9wkdWHMV4LqQ0aR2xfdTyFwhrlR4/CZw9NxqfQIl1E/C8R9wsOSFgYAsJzAZXUkYcG3FjJzLMijK484kNvc/ANeS+w=
Received: by 10.78.203.13 with SMTP id a13mr2277289hug.1169821961201;
        Fri, 26 Jan 2007 06:32:41 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Fri, 26 Jan 2007 06:32:41 -0800 (PST)
In-Reply-To: <20070126142420.GO10812@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37861>

On 1/26/07, Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> > Does it need to?
>
> FETCH_HEAD is not a real head name, so I think the message above is a bug.
>

For whatever Git cares - it is a real reference.

> > Is the below enough (could be line-wrapped):
> >
> > git merge --no-commit FETCH_HEAD && \
> > git commit -M "Merge $(cut -d ' ' -f 2- < $(git rev-parse
> > --git-dir)/FETCH_HEAD) \
> > into $(git name-rev HEAD | cut -d ' ' -f 2-)"
>
> Or I can just commit --amend and edit it manually.
> But that's not the point.

What is the point then? It looked like you were
complaining it were not done automatically.
I showed you how to script it. The message can be
made to look exactly as it is for git-pull. So what's wrong?

> > In the long run you'll almost certainly find this commit message
> > useless, though.
>
> Isn't 'Merge ssh://<hidden>/usr/src/ofed_1_2 info ofed_1_2' much more
> useful than Merge commit 'FETCH_HEAD'?

What for?
Isn't "Merge origin/ofed_1_2 into ofed_1_2" much more useful than
"Merge FETCH_HEAD"?
(IOW: Why don't you just save the fetch result somewhere and
have a "source description" from that?)
