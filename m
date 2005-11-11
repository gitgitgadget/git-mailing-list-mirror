From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Getting rid of symlinks in .git?
Date: Fri, 11 Nov 2005 13:43:18 +0100
Message-ID: <81b0412b0511110443x48415032k8ca40d999071e8a9@mail.gmail.com>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Pavel Roskin <proski@gnu.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 13:46:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaYFW-0006fl-JT
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 13:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVKKMnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 07:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVKKMnT
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 07:43:19 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:22441 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750714AbVKKMnT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 07:43:19 -0500
Received: by nproxy.gmail.com with SMTP id n15so156592nfc
        for <git@vger.kernel.org>; Fri, 11 Nov 2005 04:43:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TPPUp6QNAbJeHENIY2FMwGfBH0kqUQwvIuwQ25wvmgP5tUTAgd7nkTBPPXJc9JAxFnGqfdnt1QfM6plb5T08TCsrrF4TBiu4xPjIPomVkhhv9idu7TrZFP2lW4PBeR5OGVrYHPYMdBRliKrBnagmioKMQgAUXyEvS+x7X81Lu3o=
Received: by 10.48.211.14 with SMTP id j14mr126577nfg;
        Fri, 11 Nov 2005 04:43:18 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Fri, 11 Nov 2005 04:43:18 -0800 (PST)
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <43746118.30404@hogyros.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11592>

On 11/11/05, Simon Richter <Simon.Richter@hogyros.de> wrote:
> > I personally would not mind getting rid of symlinks completely, but we
> > will still have to support them for some reasonable time period (several
> > major releases, as far as Cogito is concerned - actually, there is
> > plenty of people still using 0.13 and such).
>
> As someone who carries around git repositories on VFAT formatted USB
> sticks, I welcome our symlink-deprived overlords.
>

But you shouldn't care if you have reasonably recent git everywhere:
symlinks and their absence already handled: .git/config created by
init-db contains the configuration parameter for filemode, which
decides whether it is safe to use the symlinks on the underlying
filesystem.
It looks more like a rhetorical question of code cleanup, because
in-file symlinks already handle all possible cases.
