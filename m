From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH v1] travis-ci: override CFLAGS properly, add -Wdeclaration-after-statement
Date: Tue, 9 Feb 2016 23:03:40 +0000
Message-ID: <CAFY1edbCSPZg892=pVQ=TDo6PRhUdees36Jp7LQ2YB3_jQd4uQ@mail.gmail.com>
References: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com>
	<20160208122551.GD24217@sigill.intra.peff.net>
	<9FBB5AFB-D44C-43A1-A0C5-A5A45675A122@gmail.com>
	<xmqq4mdh4tel.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>,
	linux.mdb@gmail.com, Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 00:03:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTHJx-00040g-U2
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 00:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbcBIXDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 18:03:41 -0500
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35956 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbcBIXDk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 18:03:40 -0500
Received: by mail-ig0-f194.google.com with SMTP id 5so248193igt.3
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 15:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dtBK5ZrbudDQMuUjWOOEqt2cVXPzSbyxyqU0gQJgUVU=;
        b=nLU3S5fsJ9HgJIq9cL4IzJNoj22nAgfgae5FHaBPymwNnJ96pYJSCRePDrWQJuZncC
         /b08fYbC335jY7Y4MK/Cn0PBhsl8ruEsYrbpvWUK9PkGq2BKPpxwUyqOs1usokQmCyBc
         cYr4G3z5qxJAQiz0FtpQ5hOCEch4F7FjoBbZ0EmwmWZrvX6yqQWNkl3zUeYj+Kzs9TWG
         67Qo6TnIhyYDmB1OiaCzYjPRfY0bhnMBvMWy40Tw92AxOIJmW5EuPuGj0LXg7wrFgjf8
         QniDr/IGtFK5TXj4iwXkfPd4SBeDSMPObW8vLKmibOPHtQippCngZi0NtedlD5JoiECa
         r59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dtBK5ZrbudDQMuUjWOOEqt2cVXPzSbyxyqU0gQJgUVU=;
        b=XaUHq5O92oS2MA31lGQQIO9oLXPWvYmCPsbYg/MnKWJrfbmlzd9ZxplDb//utzDzpe
         JMTYBv0jK2gAE6+1x7u0pJhBLmpr/bAQU9jqrGafWcu8TSRMYhcmRUo5yI6aqX0AOA34
         zsHca2LjlUxgMwiM9MADPphqRBw+ofjPuSPszx+E8GaruBM3ui4vB5ZhwlEQewV9Lg8D
         SSm6iqZQUw9n0nbIM8Cy5wuygnn2TN+eRsECSHi0F4oNc51pVC+DotOh81XqStYAQbho
         4s2ES64QCZX5V5oz21uiBrRsgQi/AoaBQU/XWrKIA1EXm1l8tiPNjj4CNYqW0OCwEabL
         7snA==
X-Gm-Message-State: AG10YOTPRKn9SUztfTQegbZSUgpYUJ0cqROxs3mE0mgoJZ0CNOhk2KqBXqCzYoLFeX8bxvkDlrlXOTx6DavsZA==
X-Received: by 10.50.39.107 with SMTP id o11mr7152773igk.21.1455059020093;
 Tue, 09 Feb 2016 15:03:40 -0800 (PST)
Received: by 10.79.90.198 with HTTP; Tue, 9 Feb 2016 15:03:40 -0800 (PST)
In-Reply-To: <xmqq4mdh4tel.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285883>

On 9 February 2016 at 18:42, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
>> Jeff Merkey made me aware of http://kernelnewbies.org/FirstKernelPatch [2]
>> where I found checkpatch.pl [3]. Would it make sense to check all commits
>> that are not in next/master/maint with this script on Travis-CI?
>
> That does not help very much.  These changes are already shown to
> people and dirtied their eyes, and most likely I've already have
> wasted time tweaking the glitches out locally.  The damage has
> already been done.
>
> It would make a lot of sense if the checkpatch is called inside
> Roberto Tyley's "pull-request-to-patch-submission" thing, though.

I've not personally run checkpatch.pl (as Peff mentioned, it's not
actually a documented part of the Git project's recommend contribution
workflow) - I'm still trying to understand whether it will restrict
it's errors to just the things that are introduced in a patch, or if
it will indiscriminately mention existing problems too (of which I
guess there are many already present in the live Git codebase?). If it
mentions _existing_ problems, I wouldn't personally want it in any
automated flow until it can be tuned to find the trees of master/maint
totally clean. At that point it could be added to the Travis build,
and GitHub would automatically reflect the Travis status in any
git/git PR.

I like the idea of giving helpful guidance to users on how to make
their patches cleaner - I'm not that enthusiastic about submitGit
invoking the checkpatch.pl script directly at this point, given that
it lives in a separate project (the linux kernel) and the version
Junio uses is patched off _that_ - I'm lazy enough to not want to try
to get that all to work reliably on a little transient Heroku box.
