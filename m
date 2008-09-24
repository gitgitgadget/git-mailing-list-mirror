From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Locking binary files
Date: Wed, 24 Sep 2008 19:00:56 +0400
Message-ID: <20080924150056.GY21650@dpotapov.dyndns.org>
References: <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com> <48D8A97E.8070003@op5.se> <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com> <alpine.LNX.1.00.0809231216350.19665@iabervon.org> <7v7i92tzgb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0809231551320.19665@iabervon.org> <20080923215422.GV21650@dpotapov.dyndns.org> <alpine.LNX.1.00.0809231811560.19665@iabervon.org> <20080923232154.GW21650@dpotapov.dyndns.org> <alpine.LNX.1.00.0809232330050.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mario Pareja <mpareja.dev@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:02:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiVsf-0005Dj-Ma
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbYIXPBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYIXPBE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:01:04 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:52447 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYIXPBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:01:03 -0400
Received: by gv-out-0910.google.com with SMTP id e6so219680gvc.37
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MbdtQijJVUOGhr+mKrZQtVm23T/sCEOHuRGNIo5AVmY=;
        b=RARcSZXg4KC2rYfVp55v5a0BmYJsx3SoYYP9KiCyNHIQ/kXMCG7V662mULIHXx6TTW
         RR5qjGN0GU8p0O9+HR7LgUIxzUOuBRc6P2jTgaRdqLjCXETB3qfWR39IYQpbZHgSWpxV
         ZNw2lDNHED5ZFFUSQnNgOmM7ndQO9xoG8n6BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FEfTUY4Hr3AquVJsXkr1RxIyY8a5fLGlyBMxXOX5EsH8r17c3PudHkMbbZHRnnCfuy
         RP+etp0tkjpyxIEPXaK+gtH4sn+zBQj3WEWWsctvwJrciFOPP1aDj+G/ut6ftzDpvsUQ
         QB1KfSC3UO1AFvaHOPhO+CGo3HrFFZVMZFsxo=
Received: by 10.103.16.14 with SMTP id t14mr4875482mui.25.1222268461445;
        Wed, 24 Sep 2008 08:01:01 -0700 (PDT)
Received: from localhost (ppp85-141-236-118.pppoe.mtu-net.ru [85.141.236.118])
        by mx.google.com with ESMTPS id y37sm3807732mug.13.2008.09.24.08.00.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Sep 2008 08:00:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0809232330050.19665@iabervon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96642>

On Wed, Sep 24, 2008 at 12:15:39AM -0400, Daniel Barkalow wrote:
> On Wed, 24 Sep 2008, Dmitry Potapov wrote:
> 
> > 
> > What are you saying is that when I am locking some file on the current
> > branch, Git (or whatever script that performs this locking) should figure
> > out what is the original shared branch for it and lock the file there.
> 
> Or you should have to say. But "git lock <filename>" should probably 
> put the lock on whatever branch "git push" would push to, and similarly 
> for the other argument combinations that "git push" permits.

It seems to me very fragile to rely on the push configuration in deciding
what can be locked and what cannot. Besides this configuration can change
over time. So what is going to happen with locks then? Another problem:
what if I don't push anyway but usually send pull-requests?

The fact is if you cannot get your locking working in _one_ repository
then any hope that it will work when you have more than one is nothing
but a pipe dream.

> 
> > Maybe, it can work, but it sounds too complex to me. I believe that my
> > idea using SHA-1 is better. After all, what is file? It is its content.
> > At least, in Git, we always identify files by their content.
> 
> Not at all; there are plenty of cases where what matters is the path, and 
> some things are relevant by virtue of the form of the filename which names 
> that content.

Whether it matters or not depends on a particular workflow and what the
developer wants to achieve. Such decisions should be taken by human
being, otherwise you are prone to do the wrong things too often.

> 
> > Thus if you lock some file, you put a lock on certain SHA-1. Now, 
> > regardless of branches and paths, this lock can work provided that you 
> > have access to some shared location. Of course, this lock is purely 
> > advisory, but it is good, because you may want to ignore it in some 
> > case.
> 
> In my design, the lock (on the shared repository) is not advisory; if 
> someone else has it, you can't push if the new commit doesn't match the 
> old commit for that path.

Hey, if someone wants to push this file, it means it is already late,
because you _already_ have the situation where two people have edited
exactly the same binary file. Isn't the situation that the lock was
intended to prevent?

So, the goal should be to warn someone who is going to edit file locked
by someone else. You cannot prevent him/her from doing so, only to warn
about that.

As to pushing, it can be different policies. IMHO, the update hook is
the best place to express what push you want to allow and what not, but
some workflow may not use push at all, yet ability to lock (perhaps,
'synchronize' would be a better word here) may still be needed.


Dmitry
