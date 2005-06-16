From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PROPOSAL] Add a module (repo-log.c) to log repository events.
Date: Thu, 16 Jun 2005 19:04:49 +1000
Message-ID: <2cfc403205061602046ec3f430@mail.gmail.com>
References: <20050616035924.31808.qmail@blackcubes.dyndns.org>
	 <2cfc4032050615210961c4d146@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 16 11:00:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiqDr-0005vQ-I6
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 10:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFPJEw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 05:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFPJEv
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 05:04:51 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:29920 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261220AbVFPJEu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 05:04:50 -0400
Received: by rproxy.gmail.com with SMTP id i8so238732rne
        for <git@vger.kernel.org>; Thu, 16 Jun 2005 02:04:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ILy0NEoZe+LRm0VlsGZbEyYXJ3hcaFple2nv/c3ZMCxAi4ugeMDQAm105IIQrs66DQGHdYvI2f1HkZZUnCL5v4dwq277PHKOBivS2cOk1PlOJ3yMZNVyQNEWJsuZ7eODZGx5qaolSwRct4A1c6qdjhvCt769iRtTPAzgs9DzPc4=
Received: by 10.38.66.4 with SMTP id o4mr452283rna;
        Thu, 16 Jun 2005 02:04:49 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 16 Jun 2005 02:04:49 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <2cfc4032050615210961c4d146@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/16/05, Jon Seymour <jon.seymour@gmail.com> wrote:
> A variety of log formats would be possible but the default log format
> I intend to use is:
> 
> for object events:
> 
>      yy-mm-ddThh:mm:ss(+/-)oooo SP object-type SP sha1  LF
> 

Further enhancements along these lines:

      yy-mm-ddThh:mm:ss(+/-)oooo SP object-type SP sha1 [ SP name ]  LF

This will require more invasive instrumentation but when a blob is
written it will allow the name with which the blob was known to be
logged, if that is known. Of course, this name may not survive over
time, but it was accurate at the time of the the repo event.

The objective of doing this, of course, is  to allow a git user to
quickly find a blob or tree that was accidentally "lost", by scanning
the repo log.

jon.
