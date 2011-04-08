From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: keeping -RT and mainline tree in single repository
Date: Fri, 8 Apr 2011 13:22:20 +0530
Message-ID: <20110408075217.GA25171@kytes>
References: <BANLkTikGMG76QhLaGfs-m-SizcaqnZ0mhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Tharindu Rukshan Bamunuarachchi <btharindu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 09:53:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q86VP-0007Uh-G0
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 09:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756942Ab1DHHxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 03:53:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41242 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756859Ab1DHHxN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 03:53:13 -0400
Received: by iyb14 with SMTP id 14so3226880iyb.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kCRuvLl+GX3+TeTD+8sMYYmwCpfvGdmux9RSmviai90=;
        b=i7l6W1gYQvLxDcPMQeO0lzdoXkCxxb2NsWtStJE4ZCOiGU9LdfAKPye0N8SdJoTLCR
         +XKVvRnKZ+3GUhBniPMk21zux09mXW1wqNOzBUKmbkKNz41UZaGlCij37vFIuovt9B6t
         0ZFW4ZZyGrOQoHIR883j0C7qjtIjMChP6Y0Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=emIGU6o98z+OG0FZ69j1n3IiWcoM25x6hsmgavKuD+cfkKqIjgCMYQXLrmfUHL9bKe
         7wj7RVDBwdoiZFhg7AO8gyFNSiWxFTFPxagbAJQwCbW3/RxdHPttGtdpWCMjJqyAFam3
         SAHZEaaMyXJ6JKQHdZlzuDhpyiIAtGhGoWRZA=
Received: by 10.42.66.147 with SMTP id p19mr3166367ici.7.1302249193244;
        Fri, 08 Apr 2011 00:53:13 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id xn10sm1419614icb.4.2011.04.08.00.53.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 00:53:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikGMG76QhLaGfs-m-SizcaqnZ0mhA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171115>

Hi Tharindu,

Tharindu Rukshan Bamunuarachchi writes:
> at the moment i am pulling latest source from
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> and keep my driver development up-to-date with mainline.
> 
> i need to port my driver to -rt also.
> 
> 1. do i have to pull and use another git repository from RT GIT. i.e.
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
> 2. how can i use current GIT repository to keep sync with both -RT and
> mainline ?

You just need two remotes -- simply run `git remote add rt
git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git`
to add this remote.  Then, `git fetch --all` to fetch from all
remotes.

> 3. how can i pull latest commits without switching between branches. (
> i hv two branches ... master & my-own-hacked). Every time i switch to
> master and pull latest code.

A `pull` is a `fetch` plus an additional action depending on the
switches and the situation (merge, merge with rebase, ff merge etc).
You can run `fetch`, irrespective of the branch you're on.  However,
you need to switch branches to perform a `merge` operation, because of
the way it works.

Hope that helps.

-- Ram
