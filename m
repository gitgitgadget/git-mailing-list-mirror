From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [msysGit] [PATCH] git grep: be careful to use mutices only when
 they are initialized
Date: Wed, 26 Oct 2011 17:10:10 +0800
Message-ID: <CALUzUxpVWHL8LyqYkYazxSxDr6i=kitACFfVRQsTxQHHYjiOyA@mail.gmail.com>
References: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 26 11:10:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIzV7-0003uO-Aj
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 11:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584Ab1JZJKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 05:10:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61170 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413Ab1JZJKM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 05:10:12 -0400
Received: by faan17 with SMTP id n17so1341665faa.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 02:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AgCrKU9Myt4IQsB9EoSaxMX621PKmgnvEGBuMw9f3do=;
        b=vjEZ5dFMHNut2dbV3mrg5/3WIOs6pX7NKAcrVrjw9ne+xOC5M2CvIEk7G3sMZN0B9K
         DfZ7G0XYhCgNVDIOyxVjJUBZPeIgfRQDx9O2N+rvDZEX6Og6L+k3RktueJjGx9ncFPKn
         FmDen3OfQJa9fTcThVQ9z3vIorgq8XWKlZlBM=
Received: by 10.223.16.82 with SMTP id n18mr57535958faa.2.1319620210997; Wed,
 26 Oct 2011 02:10:10 -0700 (PDT)
Received: by 10.223.83.2 with HTTP; Wed, 26 Oct 2011 02:10:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184249>

On Wed, Oct 26, 2011 at 1:25 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Rather nasty things happen when a mutex is not initialized but locked
> nevertheless. Now, when we're not running in a threaded manner, the mutex
> is not initialized, which is correct. But then we went and used the mutex
> anyway, which -- at least on Windows -- leads to a hard crash (ordinarily
> it would be called a segmentation fault, but in Windows speak it is an
> access violation).
>
> This problem was identified by our faithful tests when run in the msysGit
> environment.

May I ask which test are you talking about specifically?

I ask as I'm curious how this is triggered; git-grep works fine for me
so far (1.7.6.msysgit.0.584.g2cbf)

-- 
Cheers,
Ray Chuan
