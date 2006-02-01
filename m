From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 17:10:48 +0100
Message-ID: <81b0412b0602010810m3577263csed57ba75e0d6bb64@mail.gmail.com>
References: <20060201070847.2021.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 17:11:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4KZK-0000oh-4p
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 17:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWBAQKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 11:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWBAQKv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 11:10:51 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:23028 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422668AbWBAQKu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 11:10:50 -0500
Received: by uproxy.gmail.com with SMTP id s2so298365uge
        for <git@vger.kernel.org>; Wed, 01 Feb 2006 08:10:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=td4kyWwe+kIO9l2MMQXNlCXv+UrwonsQXtKUBKVJWdC3VsyvuCD4Pih6A0pMXt1FopJbOYhq/sZP4h4EePXoQewvCRMmFdSxDtZB2DgIRmyg7fu4Lq43EecI4LTYoHbLHzw28TLJtCZh043EjjILv5l9u1dE1LD0kk6Po2IyApo=
Received: by 10.49.18.15 with SMTP id v15mr814378nfi;
        Wed, 01 Feb 2006 08:10:48 -0800 (PST)
Received: by 10.49.23.15 with HTTP; Wed, 1 Feb 2006 08:10:48 -0800 (PST)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060201070847.2021.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15424>

On 1 Feb 2006 02:08:47 -0500, linux@horizon.com <linux@horizon.com> wrote:
> > Yes, I think the "assume unchanged" flag goes well together with making
> > sure that the checked-out file is non-writable at the time.
> >
> > Of course, any number of editors and other actions won't care: if you do
> > anything like
> >
> >       for i in *.c
> >       do
> >               sed 's/xyzzy/bas/g' < $i > $i.new
> >               mv $i.new $i
> >       done
> >
> > you'll never have even noticed that the old file was marked read-only. So
> > it's obviously not in any way any guarantee, but it probably makes sense
> > as a crutch.
>
> At the risk of complicating something already very complicated, and
> possibly breaking on Microsoft file systems, that case can be detected
> by reading the directory and noticing that the inode number changed.

Inodes are either uselessor dangerous  in cygwin (hash of an
absolute pathname on FAT). They may not even change after rm+touch.
