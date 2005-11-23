From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: auto-packing on kernel.org? please?
Date: Wed, 23 Nov 2005 14:18:13 +0000
Message-ID: <b0943d9e0511230618u31d80e57v@mail.gmail.com>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
	 <20051121190151.GA2568@hpsvcnb.fc.hp.com>
	 <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
	 <4382AC11.5090209@citi.umich.edu>
	 <Pine.LNX.4.64.0511212134330.13959@g5.osdl.org>
	 <4383610D.7080100@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Carl Baldwin <cnb@fc.hp.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 23 15:19:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EevS0-0008K8-AV
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVKWOSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVKWOSR
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:18:17 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:38072 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750810AbVKWOSQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:18:16 -0500
Received: by xproxy.gmail.com with SMTP id i30so1160466wxd
        for <git@vger.kernel.org>; Wed, 23 Nov 2005 06:18:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tfzdUtQkgCi5F4+i824Dqv6ckp4b6LVpQugpl0iJQwwWcS0Wbuer/LaZ9+MeC26kqcryWd8GJNouy3VuOv0EUsin1uuBnGOWdL0z/O9oDkWNev9vImnkRGXl/QxX7lh30j8mOhd0SUO0yJQ1bS2KRKg8TnE4Msw67YiW8u1KU9s=
Received: by 10.70.74.2 with SMTP id w2mr4440088wxa;
        Wed, 23 Nov 2005 06:18:13 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Wed, 23 Nov 2005 06:18:13 -0800 (PST)
To: cel@citi.umich.edu
In-Reply-To: <4383610D.7080100@citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12623>

On 22/11/05, Chuck Lever <cel@citi.umich.edu> wrote:
> Linus Torvalds wrote:
> > But maybe that's what stgit wants (since they are "temporary"), but it
> > does mean that if you see a big advantage from packing, you might be
> > losing some of it.
>
> actually, those commits aren't all that "temporary".  the
> history/revision feature i'm working on would like to maintain all the
> commits ever done to an StGIT patch.

That's to avoid pruning them but you might not always want to add them
to a pack.

> the only time you can throw away such commits is when the patch is
> deleted or when it is finally committed to the repository via "stg
> commit".  otherwise, keeping these commits in a pack would be quite a
> good thing.
>
> maybe the first thing to do is to get a basic understanding of an StGIT
> commit's lifetime.

My initial idea was to throw the old commit away once a patch is
refreshed. Even if you want to preserve the history, it would be only
preserved until you send the patch to be merged upstream and you would
delete it locally. If all the patches are meant to be sent upstream at
some point, you can avoid packing them.

--
Catalin
