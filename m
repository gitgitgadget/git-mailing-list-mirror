From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: fetch and pull
Date: Fri, 06 Mar 2009 12:44:49 -0800 (PST)
Message-ID: <m3iqmmidlf.fsf@localhost.localdomain>
References: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 21:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfgwO-0007oa-CJ
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 21:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbZCFUoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 15:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbZCFUoz
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 15:44:55 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:12450 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbZCFUoy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 15:44:54 -0500
Received: by ti-out-0910.google.com with SMTP id d10so358885tib.23
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 12:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=N7Jo66RmbomH+JaUPGw7Bvc+8szz8s8w/NFDXgbumI8=;
        b=UP1mMrdgH/nSKFz8+wUNRZqHmk+z4AAim0dpDahF2WCHXvB/cAnD6ur5TDwGBraza5
         lNmeoLq3YhHQRSGO3ZphhEYUGCyzceou3dHHj9zGS1InBIs6bJYPMES6F+iobUPvmcv6
         +CDSax7fgaO5ecm4gMkA122GXHBMOduNVRrXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KXUMEoNeRURtFyjkwsU9i41OTm9YhNAixdNLDcw8WbGJQnxxskl3swNjC5sUXK0z4Y
         6M46gvjbwKjlvUNHw8hgBBHUSG7FJ05A+Bs4j2aruRD8nE0Xarw9+YgFcSOEnqSnXAMt
         H8Vu5twQsJ0FT2E4PZOeAfGdoKa6cPSeu6exw=
Received: by 10.110.10.16 with SMTP id 16mr4215329tij.27.1236372290999;
        Fri, 06 Mar 2009 12:44:50 -0800 (PST)
Received: from localhost.localdomain (abvg205.neoplus.adsl.tpnet.pl [83.8.204.205])
        by mx.google.com with ESMTPS id d4sm1600974tib.28.2009.03.06.12.44.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 12:44:49 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n26Kkd7e023262;
	Fri, 6 Mar 2009 21:46:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n26KkaLO023259;
	Fri, 6 Mar 2009 21:46:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112478>

"John Dlugosz" <JDlugosz@TradeStation.com> writes:

> So, after inspecting the changes, how do you fast-forward your local dev
> to sync up with origin/dev?
> 
> I'm worried that
> 
> 	git pull origin dev
> 
> will try to merge into the current head.  The documentation indicates
> "The remote ref that matches <src> is fetched, and if <dst> is not empty
> string, the local ref that matches it is fast forwarded using <src>."
> which is what I want, but it does NOT say that the normal behavior of
> merging origin/dev into the =current= HEAD, if it happens to not be the
> local dev.
> 
> So, does it indeed suppress that behavior if you give it an explicit
> destination?  Or will I have to checkout dev first before doing the
> pull, to prevent strange things from happening?  Hmm, or perhaps I
> should be using merge, not pull?  After all, pull is really just a
> wrapper around fetch and then merge, right?  So is it OK to call merge
> when I really want to fast-forward, and is there an option to give an
> error if it isn't ff?

There was patch series adding support --ff=only, but I think it didn't
made into git...  Hmmm...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
