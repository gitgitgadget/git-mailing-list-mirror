From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 2/2] Fix for git-rev-list --merge-order B ^A (A,B share common base)
Date: Thu, 30 Jun 2005 11:33:25 +1000
Message-ID: <2cfc403205062918336a55e8da@mail.gmail.com>
References: <20050629234533.28709.qmail@blackcubes.dyndns.org>
	 <7v1x6k1z6c.fsf@assigned-by-dhcp.cox.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 03:26:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnnon-0007HJ-06
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 03:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVF3Bdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 21:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVF3Bdc
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 21:33:32 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:7043 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262652AbVF3Bd0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 21:33:26 -0400
Received: by rproxy.gmail.com with SMTP id i8so21921rne
        for <git@vger.kernel.org>; Wed, 29 Jun 2005 18:33:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d8fizLtg8CD9C4rNVWFdjaIiOi9o8xC6h4mLSQQxGGyv1HnbXEZrYN3dDPcUPR0XrBAqLxzShQ2hWasKE5lj/gzz9cOQlO0ABLKnDpJNIEJWaC1wfFwAjSZCjhB/bB+jhFL49OypMn0Ti6x8uE09ATFAVOUf8HxsXlYIjwbY+PE=
Received: by 10.38.208.73 with SMTP id f73mr214134rng;
        Wed, 29 Jun 2005 18:33:25 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 29 Jun 2005 18:33:25 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x6k1z6c.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/30/05, Junio C Hamano <junkio@cox.net> wrote:
> >>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:
> 
> I am puzzled about this part.
> 
> JS> The unit test changes in this patch remove use of the --show-breaks
> JS> flags from certain unit tests. The changed --merge-order behaviour
> JS> changed the annotation that --show-breaks prints for certain test cases.
> JS> The new behaviour is reasonable and irrelevant to the intent of the tests
> JS> so that tests have been changed to eliminate the spurious behaviour.
> 
> If the behaviour of --show-breaks subtly changes, and if that
> changed behaviour is something still acceptable, why not update
> the test to show the new expected results since you are updating
> the test anyway?

I can do it this way, if you prefer. The issue was that the expected output was:

= l2
| l1 
| l0

but became:

^ l2
| l1
| l0

The annotation changes because there is no longer a single head in the
start list. There are now multiple heads, it just happens that one of
the heads is also a prune point.

> 
> Showing that "subtle" change in the diff may draw people's
> attention and would help you to verify that the behaviour change
> is not something that would be unacceptable to them.

Fair enough, I'll resubmit with a less drastic change to the test case.

> 
> Also if you are changing t6001, could you also merge Mark
> Allen's BSD portability fix while you are at it?
> 
>     Message-ID: <20050628014337.18986.qmail@web41205.mail.yahoo.com>
> 
> 

Ok.

jon.
