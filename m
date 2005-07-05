From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add script for patch submission via e-mail.
Date: Wed, 6 Jul 2005 02:18:15 +1000
Message-ID: <2cfc403205070509181469b9fa@mail.gmail.com>
References: <7vll5h7k5t.fsf@assigned-by-dhcp.cox.net>
	 <20050705093441.GD6191@pasky.ji.cz>
	 <7vekadfff6.fsf@assigned-by-dhcp.cox.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 18:40:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpqTC-000104-9h
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 18:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVGEQjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 12:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVGEQUs
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 12:20:48 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:51379 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261933AbVGEQSS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 12:18:18 -0400
Received: by rproxy.gmail.com with SMTP id i8so898663rne
        for <git@vger.kernel.org>; Tue, 05 Jul 2005 09:18:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d1HoQ0vBRPrjCceKLNFO4/z6mnpzVg5igoA06xyuRVEJsoN7TBxCapPlxS3LWSz9ZMNdWcpEaqXcSQYJ9wGWZhlS4I0OR9+RWu0wf81cqfkdP5N7CLrJTkZG94hh6hJ9zR/MBmOuBY/UPqGrWFTc6abrxN7aqypjgEVcWaXT1AU=
Received: by 10.38.11.27 with SMTP id 27mr3764118rnk;
        Tue, 05 Jul 2005 09:18:16 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 5 Jul 2005 09:18:15 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekadfff6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 7/6/05, Junio C Hamano <junkio@cox.net> wrote:
> >>>>> "PB" == Petr Baudis <pasky@suse.cz> writes:
> 
> PB> Any reason why this was not applied? It appears kind of cool.
> 
> FYI, the one in <7vll4s47p3.fsf_-_@assigned-by-dhcp.cox.net> is
> newer than what you quoted.
> 
> One thing _I_ am unhappy about what it does is that it does not
> try to be intelligent about merges (I haven't tried the script
> on a merged head myself).

I am not completely sure this is really a problem. I would presume
that the project lead doesn't really need to use
git-format-patch-script and the individual developer should probably
rebase on the latest head which is either done by trivially reapplying
the patches in sequence automatically or reapplying the patches in
sequence with some edits to fix any conflicts that have arisen.

So, it is not clear to me git-format-patch-script needs to worry about
merge questions. It'd be better to put such logic in a separate
rebasing script, I think. If anything, you might want to add checks to
git-format-patch script that refuse to generate a patch sequence for
any sequence of patches that spans a merge commit.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
