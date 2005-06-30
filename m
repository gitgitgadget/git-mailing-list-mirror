From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 23:10:10 +0200
Message-ID: <42C45FB2.8030206@gmail.com>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>	<Pine.LNX.4.58.0506301242470.14331@ppc970.osdl.org> <7vll4r1sxz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 23:06:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do6ER-0000ZZ-1z
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 23:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbVF3VMY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 17:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbVF3VMU
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 17:12:20 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:20204 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263127AbVF3VKQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 17:10:16 -0400
Received: by wproxy.gmail.com with SMTP id i31so180540wra
        for <git@vger.kernel.org>; Thu, 30 Jun 2005 14:10:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sAJHKc+F7xgGH1oSrByd/eQr3AmppX7NfEoU4qN7Eu0gIRXjsleU9JiI3yDJ2DOTvvCN0XTNjzOqSQnHgPp3zE2BdT1PtSiiEWDuNmA+mB3pUmTqmUgNdXU/LZD+Ernv1UPA7FK+jmvGPu9rW6jGM2p9HZEE+tQCYl4oOXMWQlM=
Received: by 10.54.26.45 with SMTP id 45mr639130wrz;
        Thu, 30 Jun 2005 14:10:13 -0700 (PDT)
Received: from ?192.168.0.5? ([80.217.52.214])
        by mx.gmail.com with ESMTP id g5sm244470wra.2005.06.30.14.10.12;
        Thu, 30 Jun 2005 14:10:13 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll4r1sxz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
>>>>>>"LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> 
> LT> In fact, the most recent push was gone with a
> 
> LT> 	git-send-pack master.kernel.org:/pub/scm/linux/kernel/git/torvalds/git.git
> 
> Congrats for a job well done.

Agree totally. And the whole pack thing is really cool. Git is sooo much
faster when running from pack-files only on my poor laptop.

> Now is there anything for us poor mortals who would want to have
> a "pull" support?  Logging in via ssh and run send-pack on the
> other end is workable but not so pretty ;-).

Agreed again :-)

Even cooler would be pack-pulls via http. That would be a bit hard on 
the servers with the current git-pack-objects, but it ought to be 
possible to create something similar that doesn't re-delta anything, but 
instead just spits out what's in an existing pack-file, and (perhaps) 
deltifies objects from the file system.

If people then re-pack their repositories occasionally, this should be 
plenty fast, the number of files for rsync to deal with could be kept 
down, as could download times for mortal users.

/dan
