From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 23 May 2006 14:04:59 +0200
Message-ID: <f3d7535d0605230504k51b5fc47yc75cf559cb1cc87b@mail.gmail.com>
References: <f3d7535d0605222020j2d581bd9j602752659a4b3ac2@mail.gmail.com>
	 <8157.1148359875@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 23 14:06:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVdq-0000GY-8f
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWEWMFD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWEWMFD
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:05:03 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:30357 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751207AbWEWMFB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:05:01 -0400
Received: by wr-out-0506.google.com with SMTP id 68so2050637wra
        for <git@vger.kernel.org>; Tue, 23 May 2006 05:04:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l9foRaOyssojdFT7hNTCe+ByV6ZXLsYIPCxSfw0XSlkDk7dnKdw1q8eoWAEEkY8mXoU6c2Vf1M63ZdvokpKArYJGRmggRHKDQbeir0Sb1z2ztJtWUnx+i65WlAS4unMm1r1XjmfZxAldyoD0D09b/BUP6uqs7Obm1tyv1+bgpdI=
Received: by 10.64.131.10 with SMTP id e10mr1684429qbd;
        Tue, 23 May 2006 05:04:59 -0700 (PDT)
Received: by 10.64.253.10 with HTTP; Tue, 23 May 2006 05:04:59 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <8157.1148359875@lotus.CS.Berkeley.EDU>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20591>

Hi Jason,

2006/5/23, Jason Riedy <ejr@eecs.berkeley.edu>:
> This is explicitly allowed by the SUS, even for non-root:
>   http://www.opengroup.org/onlinepubs/000095399/functions/access.html
> For non-root, some ACL systems could allow you to execute
> the file even if there are no execute bits.  What a joy
> ACLs are.  Or NFS uid mappings could play tricks on you,
> or...  And as you've noticed, this kills [ -x ].  (Failing
> to run the hooks in receive-pack.c is noisy but not fatal.
> It's the shell scripts that stop.)

Yup, but this breaks test t5400 - I think because of the post-update
hook is failing.

> I think you're stuck.  To disable the hooks for all possible
> users, OSes, file systems, etc., you need to remove them.
>
> Or just don't run as root, and hope that the OS isn't
> completely insane.

As non-root it works fine.

> BTW, ERR_RUN_COMMAND_EXEC is never returned.  Any failure
> to exec will produce an exit code of 128 from die.  This
> will be an issue when commit becomes a built-in, right?

Think so.

bye

Stefan

-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
