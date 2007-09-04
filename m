From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 10:31:35 -0400
Message-ID: <9e4733910709040731s2695ab14kb9750923fcac007@mail.gmail.com>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	 <20070904025153.GS18160@spearce.org>
	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	 <Pine.LNX.4.64.0709040439070.28586@racer.site>
	 <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>
	 <46a038f90709032121v54454c6fi500ee15497eec85c@mail.gmail.com>
	 <9e4733910709032237y65ccafdai4889078533908fb0@mail.gmail.com>
	 <Pine.LNX.4.64.0709041131030.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZRM-0005MT-Ub
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbXIDObh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753998AbXIDObh
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:31:37 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:2813 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbXIDObg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:31:36 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1184429rvb
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 07:31:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bHpjrfC4mIIY/6iAQfDzJdPZCXHkUjefXmyM2dSRwLbztZ0CbfdwPCTwW8jDgLB4zKGkFUdLQEC/WNbhVtmPrLBrNOmjD224mzrinHaW3RdaWOyk/AVxx98t8S/gPzC74IVdobhN/Nw9gF0NB8vnCtZtU/jvP/pdKOWwD0szsWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nQCT+Ez50ZeadLR1CWmbUoCQT0NNsS7olQnybclb85v0uiW4IuaXM0NzzzbdDEl4RHo7tLBZjYYCShVX60VYLmQy5bb3SMp52RphI5lq3oSNuHfJBbvxF+yGF7XIgXfndvkP1ZFY0giLgkeft+MT5im5EIa2E75Yu/eZFpMav7k=
Received: by 10.141.83.15 with SMTP id k15mr2308369rvl.1188916295616;
        Tue, 04 Sep 2007 07:31:35 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Tue, 4 Sep 2007 07:31:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709041131030.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57579>

On 9/4/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 4 Sep 2007, Jon Smirl wrote:
>
> > In my scheme the path info is moved into the file object nodes and the
> > SHA list is in the commit node.
>
> And how should this "SHA list" be any different from a single tree object,
> except that you now merge it with the commit object?
>
> Really, go back to the mail Martin mentioned.  Having all objects in one
> list kills performance.

You are ignoring the fact the in this scheme temp indexes can be
created as needed. These temp indexes could look just like tree nodes.

I'm saying that it may be a mistake to be recording the indexes (aka
file names) as part of the commit when they really aren't. The
essential part of the commit is the SHA1 list. The path names belong
to the file objects and should be stored there.


>
> > Diffing two trees in the scheme is quite fast. Just get their commit
> > objects into RAM and compare the lists of SHAs.
>
> No, it is not fast.  Just loading the complete list into RAM is likely
> much, much slower than a simple diff _right_ _now_.
>
> Hth,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
