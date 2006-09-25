From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: git pull for update of netdev fails.
Date: Mon, 25 Sep 2006 13:47:38 +0100
Message-ID: <b0943d9e0609250547j472ff0c0j876987663cfb1490@mail.gmail.com>
References: <20060920080308.673a1e93@localhost.localdomain>
	 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
	 <20060920155431.GO8259@pasky.or.cz>
	 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060920160756.GP8259@pasky.or.cz>
	 <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
	 <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060923034407.GF8259@pasky.or.cz>
	 <b0943d9e0609230610h46ffb995gb25ebda8332570e8@mail.gmail.com>
	 <20060924205455.GA20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 14:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRpse-0004hT-8R
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 14:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWIYMrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 08:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWIYMrk
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 08:47:40 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:59078 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750833AbWIYMrj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 08:47:39 -0400
Received: by py-out-1112.google.com with SMTP id n25so2519437pyg
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 05:47:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RJLLoOiho0GgTsIc+rFWMKPVXltV3u1dp0FIJmwignhdk/nhbKgFtEcp09s9uu8tMp1tJK0RXw1pqK8v32P8hj1P+g3GF377vEJmhHganAa9ayzeZKX0WkA2I6RgEN0rgX7h9FSBTCHroiLG7Yqu4uVwLUxx3unrEO+IbAVDW20=
Received: by 10.35.27.1 with SMTP id e1mr8263052pyj;
        Mon, 25 Sep 2006 05:47:38 -0700 (PDT)
Received: by 10.35.77.5 with HTTP; Mon, 25 Sep 2006 05:47:38 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060924205455.GA20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27736>

On 24/09/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Sat, Sep 23, 2006 at 03:10:17PM CEST, I got a letter
> where Catalin Marinas <catalin.marinas@gmail.com> said that...
> > I wasn't following this thread (well, any thread in the last days) but
> > the current patch history implementation in StGIT is prune-safe as it
> > generates additional commits to keep the history. If you undo an
> > operation (push, refresh), the undo will be recorded in the patch
> > history (that's really immutable)
>
> It does not directly reference the history in the additional commits
> though, it just mentions the sha1 in the log message - that is not
> prune-safe:

Yes, indeed (I'm still tired :-)). The patch changes are safe and one
could probably generate the patch from them but it's a bit more
complicated. The quick solution is to add another parent to the
changelog commit so that it points to the patch. However, this
wouldn't look as nice with gitk as it sees them as merges and doesn't
display the diff (is there an option I missed?).

-- 
Catalin
