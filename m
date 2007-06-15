From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Newbie questions about moving around repositories
Date: Fri, 15 Jun 2007 16:18:41 +0200
Message-ID: <81b0412b0706150718t2382648aw25959844f52c5c02@mail.gmail.com>
References: <1b5a37350706150652y7710c380l79e785cba8f6b02e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ed Schofield" <edschofield@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 16:18:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzCdT-0008W7-3Q
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 16:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbXFOOSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 10:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbXFOOSn
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 10:18:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:49968 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbXFOOSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 10:18:42 -0400
Received: by ug-out-1314.google.com with SMTP id j3so871686ugf
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 07:18:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ChyVJjCZWgo0MnMVDTCbECt2WuJt7d5lXNkKOwT3wgqz23je+owPF6De9usGgG3tQS2Diq3iKYCS10Ty9nCDI4SjSMkxoIUr7Vu+wLesA5JXFlT+6vJufPWOfsOC3S45xryakZwpMcxoapanFEzd+Kz0HLvMr6vt6a9uuf8a3Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c2kfF7Dnzm4fGQcDau6tAYP/ou0h8AdMOpLbY6c0pp2hOZxOqMSRTjwswWd+qrNqEqpcZZk8zCs3kdAwyBDQuQZZgSUXgTZGSCDGIyVif7X8pdr5LBXwleecvuexIG4kNWa4HtIznBKWmJNa9Cast9zoIq4SSnmOg2JGkzdOPQw=
Received: by 10.78.132.2 with SMTP id f2mr1283627hud.1181917121035;
        Fri, 15 Jun 2007 07:18:41 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Fri, 15 Jun 2007 07:18:41 -0700 (PDT)
In-Reply-To: <1b5a37350706150652y7710c380l79e785cba8f6b02e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50262>

On 6/15/07, Ed Schofield <edschofield@gmail.com> wrote:
> 1. I would like to move my repository (including all branches) from
> directory A to a directory B on a different filesystem. Can I use
> git-clone for this? It seems that git-clone creates remote-tracking
> branches, but I want to keep all of the branches as local branches so
> I can remove the original repository.

Just copy it.

> 2. I can't just move the entire directory A, because I get
>
> Error in startup script: error: object directory
> A/../A-cvs-git/.git/objects does not exist; check
> .git/objects/info/alternates

... but fix that .git/objects/info/alternates files in the repos left to
point to the new location of the moved directory.

> I think I originally created the repository by cloning from my
> A-cvs-git/ directory with git-clone --shared, but I don't quite
> remember. So I suppose I want a way to stop using the alternates
> mechanism and make my repository self-contained in one directory. Is
> this possible?

git repack -f, and remove the alternates, probably.
Otherwise you can just copy .git/objects directory into all
related repos, remove alternates there and you're free.

> Will I then be free to move the directory?

Yes
