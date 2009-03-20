From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Fri, 20 Mar 2009 09:30:34 +0100
Message-ID: <81b0412b0903200130s594ce3beyae21eb0b5cc8fe0@mail.gmail.com>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>
	 <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>
	 <20090319214001.GA6253@blimp.localdomain>
	 <alpine.DEB.1.00.0903200025170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 09:32:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lka9c-0004xT-Gd
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 09:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbZCTIak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 04:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbZCTIai
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 04:30:38 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:23475 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbZCTIag (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 04:30:36 -0400
Received: by yx-out-2324.google.com with SMTP id 31so897911yxl.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gywgpTZn9V3k2qS68xMqJBi4pub56OpJx6BPGN6FXiY=;
        b=WwEoD56S6a9vE+0/PiIjH1Mn33PnnjQYnJivX1prrYUsFIpFkRvCdEvwflY3oUv4ON
         7zV7qBc5AOp0W4Xll0oF+fxmMO/jAxB5rZKnCofwf3S98Jo9iQl6wgruQWYmjsnJ9d4K
         JnYZ7mUqDkucZvKhMx87Yl+TPlSRp8gyTISBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fb0X3mijbFsG934/N0hFjMyB29pNf5UKABX1UskOCEBJ3SlPltJ3IRYdJH0bo8+r5T
         mufcpGUtTbCnjGd8znPspv1i5cUzPycPPx5YUOjr6c4M+ZcgkxmYS/ETFKmrl1edGpNZ
         19eknuknwu4hBgZZiLSoMIH5VKTUDtCou4dp8=
Received: by 10.100.151.8 with SMTP id y8mr2587152and.147.1237537834544; Fri, 
	20 Mar 2009 01:30:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903200025170.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113915>

2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Thu, 19 Mar 2009, Alex Riesen wrote:
>> Johannes Schindelin, Thu, Mar 19, 2009 11:57:01 +0100:
>>
>> > I'd rather just disable WIN32_STAT for Cygwin, because otherwise, we
>> > will keep running into issues.
>>
>> I'd rather not. The thing is just so unbelievably slow and being stuck
>> on it I'm just trying my damnedest to squeeze every last bit of
>> performance out of it.
>
> If you are serious about performance, you will not stay with Cygwin -- for
> the purposes of Git.

I'm staying with Cygwin port not _for_ Git, but _because_ of Cygwin. If it
were for me, I'd gladly let the Cygwin port die (frankly, any Windows port).
I just use Linux everywhere possible. Sometimes it's not...

> Do not get me wrong: Cygwin is a wonderful thing if your goal is to spare
> yourself a lot of trouble with that seriously challenged win32 API.

I beg to differ: Cygwin is a piece of crap and performs dangerously hideous
in what it tries to do.

> But if your goal is to get the most out of the Win32 API in terms of
> speed, you _will_ have to go with MinGW (at least, as long as you are
> unwilling to shell out big bucks in the vague direction of Redmond, and
> add some time tax to that).

My goal in this environment is to make it bearable. I think that both
Cygwin and MinGW ports are dead-on-arrival, because the underlying
platform is so stupidly and hopelessly broken, and no amount of no bucks
can help it.

> Now, we _do_ have msysGit, you _do_ have shown the capability to fix
> issues when they arise, so I do _not_ see any obstacle why you should not
> go msysGit, rather than staying with the pain of trying to stay
> POSIX-compatible, but not quite all the time.

I understand. It is not pure POSIX compatibility I seek. I just can't use MinGW
port, because I absolutely must use the cygwin environment (for "hysterical"
reasons) and they don't play well together (tried, yes. Conflicting libraries,
but you already know that).

I don't have the Windows sickness anywhere else but at my work, and
sadly it is a good place in all respects, even if absolute crazy in this regard.

So I'm sorry, if I ever made an impression that I'm motivated to do any
Windows-related development. I'm _absolutely_ not. I just happen to have that
itch of Perforce (may it burn in hell for thousand years), have a know how, and
have a little time to spare (hopefully no one of management sees that).
