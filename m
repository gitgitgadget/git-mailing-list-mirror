From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix merge-recursive on cygwin: broken errno when unlinking a directory
Date: Thu, 19 Apr 2007 10:28:44 +0200
Message-ID: <81b0412b0704190128o7fccbe77h8df3114328d6a0da@mail.gmail.com>
References: <20070418223327.GC2477@steel.home>
	 <alpine.LFD.0.98.0704181537590.9964@woody.linux-foundation.org>
	 <20070418234034.GE2477@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 10:28:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeS0b-0006LL-N4
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 10:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031200AbXDSI2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 04:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031207AbXDSI2r
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 04:28:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:3193 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031200AbXDSI2p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 04:28:45 -0400
Received: by wr-out-0506.google.com with SMTP id 76so523390wra
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 01:28:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gaRlHcpONK6/Rsx96bQDLmPXAQxe9S0Mss4XOlWQDCnHL4JpBWnZ3lNtERc5Z51A0ekRD8tUd/by/0qvt5gDHVhBqcmFCdt9EadJYXFcdO+/L+9oA0Wfo9cs8RO4pq224mnOw8NsZvcGnhZLBkY4oOPQ7g37kzkK6WbQg6LLcAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KDvhkDCi23HHSmWf9u+vpo4FunGkCXZ+23QW1wVhY+f/tEVEaOWN5aVfiMHZab6mDVTYuYJ0JG307wg9s36Xyr7Q5bQsrhb0Uig4rv/8eIkgkb4ZEzB/fwufEnY2B+jVWfpCGCzocy1AhLdPPHmI7vGHqo5OeM3sLD7JYe5Vznc=
Received: by 10.70.30.5 with SMTP id d5mr2901884wxd.1176971324693;
        Thu, 19 Apr 2007 01:28:44 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Thu, 19 Apr 2007 01:28:44 -0700 (PDT)
In-Reply-To: <20070418234034.GE2477@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44993>

On 4/19/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> >
> > So here's a suggested and totally untested patch. It makes the code more
> > readable, and probably fixes *two* bugs in the process. It also simply
> > doesn't really even care what the error actually was - the important part
> > was not that it was a directory, but that the unlink didn't succeed!
> >
>
> Well, it is a bit tested now. I'll repeat the testing tomorrow on that
> windows box.
>

Tested on windows too. Works.
