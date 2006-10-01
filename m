From: "Matt McCutchen" <hashproduct+git@gmail.com>
Subject: Re: Multiple checkouts of the same repository
Date: Sun, 1 Oct 2006 15:14:46 -0400
Message-ID: <3bbc18d20610011214y6132d98eq9cd58b23721bb87d@mail.gmail.com>
References: <3bbc18d20610011203p40d631b7o3bd2c6971a2bfcca@mail.gmail.com>
	 <Pine.LNX.4.63.0610012105590.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 21:14:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6m4-0006XJ-L2
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 21:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWJATOt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 15:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWJATOt
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 15:14:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36742 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932226AbWJATOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 15:14:48 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1355571nfa
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 12:14:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=YOvzLzcpKLpxs3OUu1sy7fZS/BA/Q7W5r8Jghd5ul8gWLTCyVMOGnfR6pLAl5vGierM7B+wXzwsEA4YGHHvbC9gFgZYPYofDrNYqT0qZZ/cposymXmlMdKFgGuAaR6WyBU8cooyESLpMnl7Zl+DmFQ1AB9IQgAoj+K7UaJvi6UE=
Received: by 10.82.131.1 with SMTP id e1mr112887bud;
        Sun, 01 Oct 2006 12:14:46 -0700 (PDT)
Received: by 10.82.128.10 with HTTP; Sun, 1 Oct 2006 12:14:46 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610012105590.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 06489c2fe579be9a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28192>

On 10/1/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> A better method is to use a local clone:
>
>         git-clone --local --shared A  B
>
> Such a clone will be very fast, and cheap, because it sets up links (not
> just symbolic links, but links that git understands).

But that gives me two separate repositories, so I have to push and
pull to keep them in sync, which is a pain.

I symlinked only the top-level things in .git, not the individual
files inside them.  That is to say, B/.git/objects is a symlink to
A/.git/objects, B/.git/refs is a symlink to A/.git/refs, etc.  In
fact, this is necessary for A to see objects and refs written through
B.

Matt
