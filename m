From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Thu, 18 Aug 2011 15:12:20 -0500
Message-ID: <20110818201220.GJ30436@elie.gateway.2wire.net>
References: <1313310789-10216-8-git-send-email-artagnon@gmail.com>
 <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org>
 <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org>
 <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
 <CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com>
 <20110818191812.GG30436@elie.gateway.2wire.net>
 <CALkWK0=jRAq6s1zQ5gwB4feBgC1eo=VYLWx8bsjs+exqmz0f1A@mail.gmail.com>
 <CALkWK0nV35gNFM2NW-FrwBLnvFzmWDdARZk0Xy6LT8c2UE0fAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 22:12:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu8x5-00034C-J0
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 22:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452Ab1HRUMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 16:12:25 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35970 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab1HRUMY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 16:12:24 -0400
Received: by yie30 with SMTP id 30so1767482yie.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pqojJY16YZfJOtkp8J97g83Hsw2FT3DSUDzm2psSL+I=;
        b=LXqLcil1T9yTFcQRHqltVxZJfkYr/OyGqarL+kNY9A0NwqDgbQw1XhkJ4Lze8OUl43
         MsNU2HdjAJAQsGJYRTx4V7FqoPGFdskF8jZhzuew0eCL9GbA0aLA5l6JPgcdeSVz3pXv
         JSO3qr+VtT+dChrzmiUCkUCCLJiKlrBXOfg/A=
Received: by 10.236.78.104 with SMTP id f68mr977787yhe.47.1313698343961;
        Thu, 18 Aug 2011 13:12:23 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-48-207.dsl.chcgil.sbcglobal.net [69.209.48.207])
        by mx.google.com with ESMTPS id z29sm240664yhn.2.2011.08.18.13.12.22
        (version=SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 13:12:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nV35gNFM2NW-FrwBLnvFzmWDdARZk0Xy6LT8c2UE0fAw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179624>

Ramkumar Ramachandra wrote:

> But:
>
>   git cherry-pick foo
>   ..conflict..
>   git sequencer --abort
>   error: No sequencer operation in progress.

I mentioned this before: "git sequencer --abort" could notice that
CHERRY_PICK_HEAD exists and .git/sequencer does not and act
accordingly.

> In a nutshell, the problem we're facing: We persist part of the
> continuation data outside the sequencer's knowledge, and part of it
> inside.  For backward compatibility, we can't move the former part
> into the sequencer.

Why can't it become the sequencer's responsibility, FWIW?  That's an
implementation detail.
