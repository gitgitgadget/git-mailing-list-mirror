From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Fri, 18 Jul 2008 20:09:48 +0200
Message-ID: <4880DC6C.7090708@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <20080714014051.GK10151@machine.or.cz> <200807150141.39186.jnareb@gmail.com> <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <20080714014051.GK10151@machine.or.cz> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 18 20:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJuPy-0000jN-PW
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 20:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbYGRSJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 14:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbYGRSJ6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 14:09:58 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:16114 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYGRSJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 14:09:57 -0400
Received: by fk-out-0910.google.com with SMTP id 18so302185fkq.5
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=DE0KSp5f6r89RVBA3LblBM4UlQ2HqN83hoVbQDDrDxw=;
        b=SgtpTW8LvIV61hN46tXkj2LhL27Bkn0k2IxPJ3oLgtsPnHV2v3KB7PmMawXLPpT7s3
         Xgw6Np47mGCVzzxWDgU82zSMG6VQu1n/+niWVeWOORbgq5NXPjDGO5lS4rzQf0VYLmyg
         dhfsIVZNsfBBulrvvnEWkRUOqwAnuUj0mbIYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=ZaiXKQKfbZNpGmDfNh34pqQ6ZXUuHkj5TBrInRuyumm9rWhsgfnmg15g96ZNQWFAdm
         HJTHk3M03hPR3uB4FYe8StkJgc2jr3BZl1HDYdyxdaJ1mHyMRkOyFBdLDodECw/+BI6j
         0vM7xhapUad/82t4aZPca32dt6LoiMytDisuo=
Received: by 10.181.27.7 with SMTP id e7mr335418bkj.2.1216404594011;
        Fri, 18 Jul 2008 11:09:54 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.253.216])
        by mx.google.com with ESMTPS id f31sm4022285fkf.0.2008.07.18.11.09.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 11:09:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <20080718164828.GT10151@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89064>

Petr Baudis wrote:
> [$repo->_cmd_output:]
> 
> we _need_ such a wrapper _publically_, because it tends to be
> actually the main use-case of Git.pm,

Well, sure, I happen to not be convinced, but it *may* be useful.  The
point I'm trying to make is that it's not part of what I'm writing here.

> as part of your gitweb migration to Git::Repo, you will temporarily
> introduce calls to _cmd_output(), the "internal" API. :-) Sure, it's
> only temporary, but many won't have the luxury to adjust the Git::Repo
> API to provide all the operations they need, and ultimately they will
> need to defer to the pipe interface.

Yup, and I'm actually fine with that.  (I'll probably alias _cmd_output
to cmd_output in gitweb, just to make it clear that it is, for the
purpose of gitweb, a *supported* mode of operation.)  If the
Git::Repo::_cmd_output API goes away, you'll have to insert a few lines
of code in gitweb, but that's it.  Really, no big deal.

Also, gitweb isn't using cmd_output because it needs a pipe interface,
but because it needs a caching layer in between -- most applications
would do just fine with open calls.

> As I said, majority of Git API usage is actually the pipe API. So we
> should figure out how to provide it. I agree that it's not immediately
> within your scope, but you are introducing new Perl API and this just
> needs to be embedded somewhere there consistently.

Sure, but pleeeease not as part of this patch series! :-)  Look, our
conversation is going something like this:

Lea: Here's a Perl API that fell out of my gitweb development for free.
Petr: I want a pony with the API!
Lea: But I don't have a pony.  Can we please just go with the Perl API
as a start, even if I don't supply ponies with it?

(Cf. the very cute <http://c2.com/cgi/wiki?IwantaPony>.)

>> If you're getting a SHA1 through the user-interface, check its existence
>> with get_sha1 before passing it to the constructor.
> 
> But that's an expensive operation, you need extra Git exec for this,

For the gazillionth time in this thread, there is no extra exec.  It's a
write to a bidirectional cat-file --batch-check pipe.  It's not
expensive.  Really. ;-)

>> I have resolving code in gitweb's git_get_sha1_or_die
> 
> The thing that concerns me about this is that this might show that your
> approach to error handling is not flexible enough for some real-world
> usage and this might be a design mistake - is that not so?

I don't think so; the error handling is fine.  Given that I want
fine-granular error reporting for gitweb, there *needs* to be a
git_get_sha1_or_die function; you can't move that into the API.

-- Lea
