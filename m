From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list --merge-order bug?
Date: Thu, 30 Jun 2005 08:40:16 +1000
Message-ID: <2cfc403205062915406db3a03@mail.gmail.com>
References: <42C2F30A.7030102@gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 00:35:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnl90-0002KX-RM
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 00:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVF2Wl6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 18:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVF2Wly
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 18:41:54 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:3943 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262700AbVF2WkQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 18:40:16 -0400
Received: by rproxy.gmail.com with SMTP id i8so1417893rne
        for <git@vger.kernel.org>; Wed, 29 Jun 2005 15:40:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CmGluA+TALC98I0tkOsN647MUlxc2G5Zxx4zxrwDJIFn4ivFoNq3nWUWBqcoPJ5/4tXPslnQVJGdCFdc4IxPe0fM3MAToAVjZKViYQ3rA052Gm4sd/oM4LBfnLZUJrUysN6HveU7yiGvy1Afn6bDSFiKxEUN60ApCIZpERI5TII=
Received: by 10.38.89.66 with SMTP id m66mr104063rnb;
        Wed, 29 Jun 2005 15:40:16 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 29 Jun 2005 15:40:16 -0700 (PDT)
To: gitzilla@gmail.com
In-Reply-To: <42C2F30A.7030102@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 
> git-rev-list ee28152d03f2cf4b5e3ebc25f7f03f9654d3aa0d \
>         ^aa03413467a2f2ada900817dc2a8e3904549b5fe |wc -l
> 
> git-rev-list ee28152d03f2cf4b5e3ebc25f7f03f9654d3aa0d \
>         ^aa03413467a2f2ada900817dc2a8e3904549b5fe --merge-order |wc -l
> 
> The first git-rev-list returns 4 commits and the second returns 304.
> 

I'll look at it.

It appears to do in cases that look like this:

A
|   B
|   |
|  /
C 

git-rev-list B ^A --merge-order

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
