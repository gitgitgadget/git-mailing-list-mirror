From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Fri, 10 Jun 2016 08:40:05 +0200
Message-ID: <CAP8UFD2jCTgBhKGbf9pffX-EAoY3ovBxw2DRHZ6QtUkwEBr2=g@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
 <5734B805.8020504@kdbg.org> <CAP8UFD1ukOMi_VDKzZErwSu1OBU5h1hVOxd7mPu1ytzFr11VGA@mail.gmail.com>
 <5759DB31.2000106@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 08:40:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBG75-0003Gq-LN
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 08:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbcFJGkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 02:40:10 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34847 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbcFJGkI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 02:40:08 -0400
Received: by mail-wm0-f53.google.com with SMTP id v199so135106330wmv.0
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AV2FqsyjzkC1UBB7ZXjY6p/6SVxw6rdoo0pQIlIZjic=;
        b=rI6tf4cuvBgCWWvLQgoj931irLFEP9jWUoQFd/WvxovKBy9xnKP00iGs5zrMWvkYB4
         jWrZl/n7iNxP/TNsnNmXGHHrFrRxPEt6R0g/2AImgt1LBXVTw4I3fNCZgryJJ8lM0KEp
         iyNF021GyjxxWRPuDcngj1+UBesMsWrxGIhzEQoqa31g8LnrZfV5YLpjEWLvyrGie8e4
         yaKKgsHYXyZWQOazg0Z3e18JwY+RSNe7MWjZJrruq2y/g5vHu9q/R3ETbjneo46OT8np
         ia0zUwRuz05hF9Em1wtnBXoRvAkqxGTxNdqbjAgkzIrfVa/Wkfvd+PMwNB1MjeLXIxjH
         1Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AV2FqsyjzkC1UBB7ZXjY6p/6SVxw6rdoo0pQIlIZjic=;
        b=ZdYZorVVyAreNT0eSRDCPYHx59GCm3XJZXYO15z4Hzv/4XYzR/GDcLFXXoxhHolCfN
         3hpRu/3hcTSeRHHet9UdDGXI5Qvlsi9Vm+hH2YFL4jF6MpqAWt1oP+F2OJvYDZ7NO0OM
         ApmZ9H6/6ZJunhtNIqWMXDENukc+ie1I2DTBSenMz1sNoypwM55vJPuxT1pVaktqocUf
         kOzUHcTGQjUS/vVkRVfwePYvIzXw7oj0EjpRjet32Tc1VgqyCIwIqQCmtQINnwCD4cbz
         JSFwU3FRPpplsHdwNoOz5SQGF5CTAVTdRAcpkcw5vL9PvpwCA8A3TqsDQvPXOgKjYIW5
         asQw==
X-Gm-Message-State: ALyK8tLD0uEE5qMDx5U7BMJHqTPDPbpQ/fBFSvNwmej30jljyhGYJe1ZaUl5/eAfZ2g4s2D5c8DRncornhNzOw==
X-Received: by 10.28.167.79 with SMTP id q76mr17586415wme.62.1465540806691;
 Thu, 09 Jun 2016 23:40:06 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Thu, 9 Jun 2016 23:40:05 -0700 (PDT)
In-Reply-To: <5759DB31.2000106@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296945>

On Thu, Jun 9, 2016 at 11:10 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 12.05.2016 um 20:02 schrieb Christian Couder:
>>
>>> I'll also use it in production for a while, although I am not a git-am
>>> consumer nor do I use git-rebase without -i, hence, my tests will
>>> probably
>>> only show that there is no bad fall-out.
>
>
> Meanwhile, I have retrained my muscle memory to stop before typing "-i"
> after "rebase" for an opportunity to consider whether bare rebase can be
> used.
>
> What should I say? I am impressed. It's like 100 times faster than rebase -i
> (on Windows). I'm now using it whenever I can, and more often than not I
> plan my rebase workflow so that I can go ahead without -i.

:-D

Thanks for the report again!

> Can't wait to test a re-roll on top of cc/apply-introduce-state!

It should happen really soon now...
