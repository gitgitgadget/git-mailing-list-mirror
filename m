From: sean <seanlkml@sympatico.ca>
Subject: Re: git pull origin doesn't update the master
Date: Mon, 10 Apr 2006 01:03:16 -0400
Message-ID: <BAYC1-PASMTP11D3D1D967525A6F029F85AECC0@CEZ.ICE>
References: <cc723f590604092141q3517136cmc0a895a069021b8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Apr 10 07:06:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSobw-0007aj-Oi
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 07:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWDJFGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 01:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWDJFGq
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 01:06:46 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:60303 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1750982AbWDJFGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 01:06:45 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 9 Apr 2006 22:10:26 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 50805644C28;
	Mon, 10 Apr 2006 01:06:39 -0400 (EDT)
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Message-Id: <20060410010316.2aec94ae.seanlkml@sympatico.ca>
In-Reply-To: <cc723f590604092141q3517136cmc0a895a069021b8f@mail.gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 10 Apr 2006 05:10:26.0875 (UTC) FILETIME=[144A10B0:01C65C5D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 10 Apr 2006 10:11:05 +0530
"Aneesh Kumar" <aneesh.kumar@gmail.com> wrote:

> While updating the git code base the master branch is not getting
> updated. First look tell me that the below commit is the issue
> a9698bb22fb7b66e5882c3a5e7b2b8b53ea03f90
> 
> git-pull.sh does
> git-fetch --update-head-ok "$@" || exit 1
> 
> and git-fetch.sh exit with status 1 printing the below message
> 
> * refs/heads/pu: does not fast forward to branch 'pu' of
> http://git.kernel.org/pub/scm/git/git;
>   not updating.
> 

The "pu" branch often won't fast forward because some commits have
been completely deleted in it since the last time you pulled.

If you want to track it, add a plus (+) sign to the proper line in 
your .git/remotes/origin file, like this:

Pull: +refs/heads/pu:refs/heads/pu

Which tells git to deal with the problem for you by merging instead
of fast forwarding.   Or you can just delete that line completely
if you don't want to track the pu branch at all.

HTH,
Sean
