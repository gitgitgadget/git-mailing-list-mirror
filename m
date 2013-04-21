From: John Tapsell <johnflux@gmail.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Sun, 21 Apr 2013 14:46:34 +0100
Message-ID: <CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
 <20130420140051.GB29454@ruderich.org> <7vd2towdiq.fsf@alter.siamese.dyndns.org>
 <CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com> <20130421102150.GJ10429@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 15:47:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTubi-0001t2-6T
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 15:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab3DUNq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 09:46:56 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:33127 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475Ab3DUNqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 09:46:55 -0400
Received: by mail-ia0-f179.google.com with SMTP id p22so728303iad.38
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ntTS7O1seR5XvwBW5atEcymQCsZq/aETxz2r2MeobmM=;
        b=yDzxjVPhOiPeCAk9A1/mtqszpxsC3ja8WaqhCR7ZAKwqZoaAMkEoVBZqz49cTK+pWz
         vEAAwK+6e6fMBP0n7VXIqH6fijpbxf0A4fOlpE0NevdKzdJ12snLTiZ9mLyoWNbKD9pw
         eiwU2L+hwekhJthLbLWZlS0/BRinQy1Yt/3GH0crgpUnNecuTiv2Pi/bRwzqXaC8ATu4
         1OfJGhr5EedL0bktxPyb/ZN1aZEYAyt6Y7fCVazn46ldETHbUfKek1+TFqsYWru3yHf0
         V1sWWyE8btAH9Ogubv90vxx3O8BwkGeeXZiCqJg8LK5zzeVaAOrPpQImmfG/YVBJoe4y
         b1QA==
X-Received: by 10.42.66.140 with SMTP id p12mr11267520ici.15.1366552015068;
 Sun, 21 Apr 2013 06:46:55 -0700 (PDT)
Received: by 10.64.8.235 with HTTP; Sun, 21 Apr 2013 06:46:34 -0700 (PDT)
In-Reply-To: <20130421102150.GJ10429@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221953>

On 21 April 2013 11:21, Jonathan Nieder <jrnieder@gmail.com> wrote:
> John Tapsell wrote:
>
>> I'm concerned that noone is taking this security risk seriously.
>
> If anyone relies on "git log -p" or "git log -p --cc" output to make
> sure that the untrusted code they use doesn't introduce unwanted
> behavior, they are making a serious mistake.

Which is exactly my problem.

Go and ask the average person using git this very question, and I bet
you the vast majority will not know about -cc etc.

You can't just push all the blame on the user for bad defaults.
Hiding code changes is a bad default.

> A merge can completely
> undo important changes made in a side branch and "-c" and "--cc" will
> not show it.

Wait, what?  This is getting even worse then!  Can you expand on this please?

And then how do I show all of these important changes with a git log -p ?
Or is it impossible to get a sane output?

>  The lack of "-c" cannot be a security issue here,
> because in normal life adding "-c" isn't a secure deployment strategy.

So, is it impossible to make git log -p a "secure deployment strategy" ?

> That's why if you want to review the code you are pulling in as a
> whole, it is worthwhile to do
>
>         git diff HEAD...FETCH_HEAD

Which basically means that you're asking the review the same code
twice.  Once that way, and once using git log -p (to check for the
exact reason that you said).

>  Unfortunately that doesn't protect you from
> maliciously written commits that will be encountered when bisecting.
> At some point you have to be able to trust people.

Seriously?  Your reasoning for awful defaults is that you should just
trust people?

This is getting worse and worse!

John
