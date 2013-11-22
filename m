From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: Git issues with submodules
Date: Sat, 23 Nov 2013 03:46:20 +0600
Message-ID: <CAErtv24_M-h-4T187Tj0gtsaqK7U76T2PwXRwLu1+FP6a6nFfg@mail.gmail.com>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
	<CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
	<CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
	<CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
	<20131122151120.GA32361@sigill.intra.peff.net>
	<CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
	<CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
	<CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
	<CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
	<CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
	<528FC638.5060403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 22 22:46:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjyYT-000858-OF
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 22:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976Ab3KVVqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 16:46:22 -0500
Received: from mail-vc0-f177.google.com ([209.85.220.177]:61433 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab3KVVqU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 16:46:20 -0500
Received: by mail-vc0-f177.google.com with SMTP id hv10so1245982vcb.36
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 13:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2DEPN//SyDXrE1JQUVLlQnJ5/isb9DsLgSHwl1lCOrM=;
        b=JJ1fBZoqz05gkqZPT01MUjUbwJ3WzfZ9SYgZheQwvItrRt56ZmEO3wcPgl9T/hGTFj
         EWwlisg8dwv/ANEUwdGs9fMlToOeLK9DHY2IjrnxYtg7tDKK0gQJISuvamau/8y5yFtN
         GkVfNx8s+neuNykDdi8ic4M+h6nFH1smc+u6LCn63Eq1pJbFTVDnbhJEE5hlhg11cavV
         W1AA34zU7drS2zz9YyXPVk75g1caY0U+WmndU/l1gJc44LnpK7/GA9IvoKeleULKr8k8
         Vh34jTxZXomhgnLS5wN+NrphBaAMXShrDLiU7Y7YfqNrs5RCEijQo79hxWJdd9Yj8hbX
         2iaQ==
X-Received: by 10.58.216.74 with SMTP id oo10mr13315676vec.0.1385156780166;
 Fri, 22 Nov 2013 13:46:20 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Fri, 22 Nov 2013 13:46:20 -0800 (PST)
In-Reply-To: <528FC638.5060403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238215>

> > For some reason, the
> > `git add .` is adding the ignored submodule to the index.
>
> The ignore setting is documented to only affect diff output
> (including what checkout, commit and status show as modified).
> While I agree that this behavior is confusing for Sergey and
> not optimal for the floating branch model he uses, git is
> currently doing exactly what it should. And for people using
> the ignore setting to not having to stat submodules with huge
> and/or many files that behavior is what they want: don't bother
> me with what changed, but commit what I did change on purpose.
> We may have to rethink what should happen for users of the
> floating branch model though.
>

I totally see what's happening here and indeed current logic of `git
add .` agree is correct from how it was designed to. I could also see
why it might be useful to keep `git add .` and `git commit .` not to
respect submodule ignore flag. The only confusing thing here is that
if i stage changed submodule with this command i wouldn't see this
submodule in "changes to be committed" wen doing a commit.

So seems it's just matter of better communication of what's gonna to
be committed in "changes to be committed" section? Or maybe even make
it so `git status` will show staged changes from submdules hash
regardless ignore flag? Just an ideas how to make communication what's
going on a bit better :)

And for sure don't think suppressing stuff from git show is a nice
idea (if i understand your proposal f making submodule ignore option
affect on other commands).

-- 
With best regards, Sergey Sharybin
