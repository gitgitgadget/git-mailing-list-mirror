From: Jonathan Nieder <jrnieder@gmail.com>
Subject: How to request a fast-forward pull
Date: Mon, 20 Aug 2012 13:40:33 -0700
Message-ID: <20120820204033.GA636@mannheim-rule.local>
References: <20120820202803.GA8378@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, Jeff King <peff@peff.net>,
	Bart Trojanowski <bart@jukie.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 22:40:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Ylf-00089d-8y
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 22:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab2HTUkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 16:40:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52370 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab2HTUkD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 16:40:03 -0400
Received: by pbbrr13 with SMTP id rr13so7449998pbb.19
        for <multiple recipients>; Mon, 20 Aug 2012 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NsH/etfjlUQxU0PcflrJYRsdnsWFFkZG6bnYLOPciTI=;
        b=Vtmn+NfsyKLGEdHRWl/ZBtychEy7qjExe9i1wq0as8Xxb5LNQahFZnvxnAEYCt1xtc
         0NAq1weAZPJqW9AsqujZni2K2dp7nJ4VqKwsUGBzOovO+zRoQ4S6XsnZirCM9+XTWxFD
         kUJd+/vqo12+zx7j/sL/5qGvvf8MRiOWom6yRYdwVEKfx4QA8bM/pC5/wt9sFZtLkMz2
         GvS2ZvP2ISZkUXCbiF2DZunLff1mRd7V0BlteU/xHBTyEb7Jns1VMurMaVPe9uhoUPGR
         dt9XJSuLeHbB0ExiB8Qim33sHK/riJi3KrNg3LFeMLbXI1FCPX83tAQfl0QvaMkpTYji
         es7Q==
Received: by 10.66.89.36 with SMTP id bl4mr32266743pab.58.1345495202255;
        Mon, 20 Aug 2012 13:40:02 -0700 (PDT)
Received: from mannheim-rule.local (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id pf10sm11620468pbc.56.2012.08.20.13.40.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 13:40:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120820202803.GA8378@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203872>

Hi gitsters,

Paul Gortmaker wrote:

> When you have a moment, would you please migrate this
> across to your main linux-stable repository?
>
> Both a branch and signed tag are present and pointing at
> the same commit, but "git request-pull" does favour output
> of the tag over the branch name.
>
> But merging the tag will want to create a merge commit.
>
> So, to avoid a merge commit in your repo, you can fetch
> (fast fwd) into your (local) branch from my branch at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux-stable.git linux-2.6.34.y
>
> and then fetch the signed tag listed below after that.

Can this be made easier?  I could imagine request-pull learning
--ff-only that generates a message like

	Greg,

	Please pull --ff-only

	 git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux-stable.git linux-2.6.34.y

	to get the following changes [...]

which could work ok if the recipient notices the --ff-only, but I
wonder if there is a simpler way.

Thanks for the food for thought,
Jonathan
