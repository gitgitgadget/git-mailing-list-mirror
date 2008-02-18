From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream local branches
Date: Mon, 18 Feb 2008 09:38:48 -0500
Message-ID: <76718490802180638k6f776463t692a828f71ce0a58@mail.gmail.com>
References: <1203342817-19653-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.LSU.1.00.0802181403040.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 15:39:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR79S-0004Pr-E7
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbYBROiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 09:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYBROiu
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:38:50 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:26540 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbYBROit (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:38:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2830137wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xiz0c8HwIjqUKzQvKueT4lgDag7LZCMLTDa+rvhuuM0=;
        b=pAelRIwQNuC8f17Svua3AvA0UlUdj3B2L5Gs07K8I8ZFVU+OL8wjgB0zgACQMddGeerV3zqt7lJ54fBnBHKTINuMQ5qHHBSGTRrevgJPdLvXePYWTqrcrHerVXRfLSvhkpwwvUd4XN9uH2Fiv9u7H18+ec6xKmRIEoyIc8Nkk6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OHpr1hl0qqai+VGoNqvbZFDdSyRYPV9PZ+lJlVuTUzRo8WqBdpWPweACrjcUS1ZG0gFjp1JItU/HVGL8Jp+MnXighBpzrFJ47Lr4EgaamrvMKGWz0ZyzW4+EGsB1DcSApH2cZvh7lFwj+6vhybBAmrKMhr3V4shGQrn4ljYK05k=
Received: by 10.114.124.1 with SMTP id w1mr1057590wac.131.1203345528668;
        Mon, 18 Feb 2008 06:38:48 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Mon, 18 Feb 2008 06:38:48 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802181403040.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74297>

On Feb 18, 2008 9:05 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 18 Feb 2008, Jay Soffian wrote:
>
> >  Incorporated Johannes' second round of feedback.
>
> Not exactly.

Heh...

> This looks completely different than what I commented on.  And my comments
> suggested a different solution.

Thought process went like this:

- fix sprintf() to use snprintf()
- notice setup_tracking() uses sprintf() and think about fixing it too
- realize setup_tracking() does bounds checking first and its use of sprintf()
  is therefor safe.
- go to copy the bounds checking code from setup_tracking() to the area you
  commented on.
- realized duplicating the code was dumb and I could just re-use what was
  already in setup_tracking() via what was just sent.

> But you can use the time to write some tests ;-)

Sure I can. I really hope after all this work the patch gets accepted.

j.
