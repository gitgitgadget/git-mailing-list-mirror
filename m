From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 8 Sep 2006 17:13:42 -0400
Message-ID: <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <20060908184215.31789.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 23:14:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLnfi-0003zN-4R
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 23:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWIHVNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 17:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWIHVNo
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 17:13:44 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:30858 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751259AbWIHVNn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 17:13:43 -0400
Received: by py-out-1112.google.com with SMTP id n25so974601pyg
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 14:13:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ojwRYcX7JZM6iclR4l5pBPtsLLfdQAzxcgjO7zrURfGlvlLv/hMVdc42/QFyFJRdFBDtGmCBuoRkb9tCtjoKjWneUXLZB1PDgeHiPg82pRw7pvX+Ff4Ze/jV5CP0C8g6wW7h93zbvIqO2/qI7qKdZED8WrWiQ/ExbrkGSEZ6dnQ=
Received: by 10.35.31.14 with SMTP id i14mr3665782pyj;
        Fri, 08 Sep 2006 14:13:42 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Fri, 8 Sep 2006 14:13:42 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060908184215.31789.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26709>

> > Here is another way to look at the shallow clone problem. The only
> > public ids in a git tree are the head and tag pointers. Send these to
> > the client. Now let's modify the git tools to fault the full objects
> > in one by one from the server whenever a git operation needs the
> > object.  Dangling references would point to 'not-present' objects.
>
> Er... that would fault in a gigabyte the first time someone ran gitk,
> or several other history-browsing commands.  Don't you need a way to say
> "tell the user this isn't present and will take an hour to download"?

gitk would need to be modified to only run enough of the commit tree
to draw what is displayed in the window.  As you page down it would
retrive more commits if needed. There is no need for gitk to run 250K
commits when I'm usually never going to look at them all. Of course
this may mean some rework for gitk.

-- 
Jon Smirl
jonsmirl@gmail.com
