From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 17:22:46 +0100
Message-ID: <dbfc82860701150822o47e0e1ecoe22ee81c979dc1ab@mail.gmail.com>
References: <200701150144.56793.jnareb@gmail.com>
	 <200701151003.44498.jnareb@gmail.com>
	 <20070115095613.GA4037@localdomain>
	 <200701151132.00971.jnareb@gmail.com>
	 <20070115112635.GA5134@localdomain>
	 <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <dbfc82860701150734j7322de15v30dc6822b456ea66@mail.gmail.com>
	 <Pine.LNX.4.63.0701151639490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 18:56:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ViJ-0006mg-1n
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:43 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VAo-0003eK-Ks
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbXAOQWv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 11:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbXAOQWv
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 11:22:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:29893 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbXAOQWu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 11:22:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1393062uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 08:22:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=iHUGkvE6Z+PejLgA1lH2ggRQ4ovSZlTWo71spLii5UiCIm5v2mzdqEOW7g5xlaswDWwHPvaAnRPLjXE4ULaGao5mb2dYmWfSDI7yNV2204VS14bG+Ddyv1RWHoElJkCPGTXlxp6YSmKzlSyqAFq50hQ3J0Sg5+doThoJUIk3cdk=
Received: by 10.82.138.6 with SMTP id l6mr632991bud.1168878166170;
        Mon, 15 Jan 2007 08:22:46 -0800 (PST)
Received: by 10.78.200.7 with HTTP; Mon, 15 Jan 2007 08:22:46 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701151639490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Google-Sender-Auth: c857f1e67fa0d8f2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36804>

On 1/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> On Mon, 15 Jan 2007, Nikolai Weibull wrote:

> > On 1/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> > > On Mon, 15 Jan 2007, Eric Wong wrote:

> > > > > Would you write "git repo-config --perl", then? ;-)

> > > > The below patch should be a start (only tested on my fairly standard
> > > > .git/config).  A --python option should be easy, too :)

> > > A bit shorter (and gets the booleans right, plus being even easier
> > > towards --python extension):

> > If we're going down this slippery slope, why not just give up and add
> > a --xml switch instead?

> AFAIR this switch was meant to _enhance_ performance.

As far as I can tell, comparing fork() vs. reading a dump with eval
vs. XML isn't meaningful - parsing a 20-line XML file can hardly be
much more (if it even is more) expensive than evaling a file of the
same length.

> > That said, parsing the config file as-is can't be so difficult that we
> > need to export it to separate files with a different syntax, now can it?

> The point is having one parser to rule them all, and avoid having
> different parsers, all with their own set of shortcomings.

So then you must agree that having one export format makes a lot of
sense, for the same reasons.  Not that I think that an export format
makes sense in the first place.

  nikolai
