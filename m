From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Thu, 17 Nov 2005 09:01:04 +1300
Message-ID: <46a038f90511161201h54c5fa73l20b5dcf3b5c19399@mail.gmail.com>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	 <7vveys8n8q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Franck <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 21:04:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTSw-0003LJ-0m
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 21:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVKPUBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 15:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVKPUBG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 15:01:06 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:47065 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030459AbVKPUBF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 15:01:05 -0500
Received: by xproxy.gmail.com with SMTP id s14so2043397wxc
        for <git@vger.kernel.org>; Wed, 16 Nov 2005 12:01:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=orf7HbwCFdqoZx2NUFEgWg+V2U/Vp/B//WmQBZWpZ6GFebbidarrrYO4k2Zpx7sT7n3cr1HHkVhd2sGJ1zn9zIn64xP1JHK1kXKMvD3DKSijxVOJH8IHUxvrrCexG1P6BMaTnHfOhZhsc+Z0tBErqGslpjymwZmBU9IIfcXQqAc=
Received: by 10.64.142.16 with SMTP id p16mr1165792qbd;
        Wed, 16 Nov 2005 12:01:05 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Wed, 16 Nov 2005 12:01:04 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveys8n8q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12047>

On 11/17/05, Junio C Hamano <junkio@cox.net> wrote:
> The underlying network transfer program, 'git-clone-pack', can
> be told to clone only specified branches.  If somebody is
> interested, updating the 'git-clone' wrapper to use it should
> not be too hard -- obviously this needs to be done for other
> transports as well, though.

cg-clone already does this. One tricky thing with the selective
cloning is that you want to pull the named head plus all its related
objects, and then pull only the _relevant_ tags. There's been
discussion of pulling tagsrefs+related tag objects and then pruning
any tagrefs+tagobjects where the commit is unreachable with the
objects you already have. You surely remember my 'git-rev-parse  is
crashing' thread.

If you just pull tagrefs and all the objects needed for them, chances
are you'll get the whole repo anyway ;-)

cheers,


martin
