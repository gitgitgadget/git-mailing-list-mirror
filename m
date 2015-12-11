From: Stefan Beller <sbeller@google.com>
Subject: Re: sb/submodule-parallel-fetch, was: Re: What's cooking in git.git
 (Dec 2015, #03; Thu, 10)
Date: Fri, 11 Dec 2015 14:52:53 -0800
Message-ID: <CAGZ79kYOtoWHCzpeHGrCEjTUuKYB3rogfV2dxL_TL5Pcu59RSg@mail.gmail.com>
References: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
	<xmqqvb85g8v9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY8M-Xv1s4-s7HnjxZ_X19SR4PsWMtQ3yogqN=vjDiMwQ@mail.gmail.com>
	<566B4207.8020009@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 23:53:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7WYd-00080j-Vi
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 23:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbbLKWwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 17:52:55 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34583 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbbLKWwy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 17:52:54 -0500
Received: by mail-ig0-f172.google.com with SMTP id g19so49777784igv.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 14:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KvvXlY8rjU56CW6Kg8t8LfqAfwbQiGHtjlKPSpb9d2M=;
        b=Ipc3EmbA0w/t94eIHXK7JLq/UqzoMKg+s6/bEf7/JBkPfHxcUL4D5U/GtQ7f5It6v4
         F8LcFvDdh1gzhENdwU9gAds6tz7r2l6W2BaEeLEDIb/6QMPFMYWcvzk9zxDQWZHk5n+q
         c7ssbB08izw3+gAnVql6Lp5SbGRrs85pyRJgzYbRmuOfpy8BUvP/XPywnOe507JMYje6
         1OhRCXLSOje4nhdgGCu+eye03qMb4mTDd2UoJh27NrAU6L06YcxhYJpr4WkldMFPZVjQ
         pU/7/6NDhdwj1tUe7bQGw2jRjBpRO55Ps15Bs+N4Ta03eJCcc12l1Ekis448bKF8/lC6
         C51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KvvXlY8rjU56CW6Kg8t8LfqAfwbQiGHtjlKPSpb9d2M=;
        b=gY8H+bHKFW6tTx1ke/trvQQpmmO06pgfe+9z6FnIYPn8Oyawnu+zweBFbh7z72VbMm
         Sl8mREpfL55IOA0o+yHRpnSOYhQdY6Ng+OGx+aNTxmNGNpkgg5gRgwZjeMMgpRf3QQCD
         uRFgBGeywxwtxQB/iupXEqt6ldwoXfOj3yd3td2tg51fs9V4CNjrNzuWw0yEROHirocn
         RR078NHxc7sKtVgFzBfqkqHgIQCamsjfAd8+uztJEVYDJ2IyIYyHJL2q9PTJn6a9yt4r
         hjSrSpJd+Y/AD8i4fnF3O/Vwa8b2QiBAfhIjctgDBpGMCA1U5GhRR8BYbYKKD//P9uL5
         97xg==
X-Gm-Message-State: ALoCoQlfK1xm8eYtkvQx4Vn7mDBQWoMTf0S7+wlY7D51xns4cdg7oBn7iqzr3Ys2JKLSM1SHOjXOZLl4o7nhsusl/8ykAGNlCzm7DNdzR+cuVDYTKtMvI8k=
X-Received: by 10.50.109.136 with SMTP id hs8mr7055262igb.93.1449874373520;
 Fri, 11 Dec 2015 14:52:53 -0800 (PST)
Received: by 10.107.19.26 with HTTP; Fri, 11 Dec 2015 14:52:53 -0800 (PST)
In-Reply-To: <566B4207.8020009@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282283>

On Fri, Dec 11, 2015 at 1:37 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Generally, I'm already quite satisfied with the state of the
> infrastructure at the tip of the branch.
>

I was about the rework the patch series.

> Nevertheless, I have a few niggles.

If you don't mind I'll split your patch into chunks and
squash these where appropriate and resend the series
with the suggestions included without the intermediate stages
of non compiling code for Windows.

>
> The primary one is that we are using a global variable of type
> struct parallel_processes to keep track of the processes. Fortunately,
> most functions already take a pointer (I gather you did anticipate an
> object oriented use of the functions). The only exception is pp_init():
> It returns a pointer to the global object, which is then passed around
> to the other functions. This does not conform to our usual style,
> however, where the initializer function takes a pointer to the object,
> too.

Noted. I thought about the init function as a constructor,
such as

    foo *pp = new foo();

in C++ would be just syntactic sugar for what I did there.
I'll adhere to Git style then instead.

>
> After converting pp_init, we can have a nicely object oriented
> collection of functions and get rid of the global object ... almost.
>
> We still need a global variable for the signal handler. But since
> signals and their handlers are a global resource, it is not that bad to
> have a global variable that is dedicated to signal handling.
>
> Another small nit is that I found it confusing that the closure
> parameters are arranged differently in the callback functions. Granted,
> in get_next_task one of them is an out parameter, but that is actually
> an argument to move it to the end of the parameter list, IMHO.
>
> On top of that I found an error or two in the documentation, and I have
> a few suggestions for improvements.
>
> All this is summarized in the patch below.

Thanks for the improvements!

Stefan
