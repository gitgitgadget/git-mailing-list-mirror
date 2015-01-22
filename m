From: Stefan Beller <sbeller@google.com>
Subject: Re: Git compile warnings (under mac/clang)
Date: Thu, 22 Jan 2015 11:59:54 -0800
Message-ID: <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Michael Blume <blume.mike@gmail.com>, Johannes.Schindelin@gmx.de,
	peter@lekensteyn.nl, eungjun.yi@navercorp.com
X-From: git-owner@vger.kernel.org Thu Jan 22 21:00:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YENv5-0000OA-VB
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 21:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbbAVT74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 14:59:56 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:37416 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbAVT7z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 14:59:55 -0500
Received: by mail-ie0-f175.google.com with SMTP id ar1so3446215iec.6
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 11:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nBEaK5pqf9pakCwS7dDM5WdnbSTAGUsL18fFW97TVMA=;
        b=pot1QWwR8MXD5sUkK7O4f9IdqZXpIUM2N/g8J94yK9SlI7WOsl3jfWxeIN4R7L8UtM
         /zIQQkHxq+Uv2erjwAg6WyBmTI+qxXzBMf6n0B0qLv+33QdYTGsRwL1RNT0ooe1fxsC0
         DbhlysjtB/vfQVGMxJ/YlpO3oefysNaFX5IANeHyEDUtPib+22NHolNbbpkgkO13Y9a1
         0GATLakSTUvcHu71yNRsLJhzHpBIy6+bwMp44khshoGYvZ/Z6HVbWIK9tcCv8WkBjBih
         kXmJFgrzTRmPFbxc7vb2TxlEoVJcE1ktTVg2qoohkN2GbCG+pRhh4B7jEqPFyJRL+Xug
         bgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nBEaK5pqf9pakCwS7dDM5WdnbSTAGUsL18fFW97TVMA=;
        b=ZqN/aoWUUbyod6qG2OYU1qR5nEmFgiA21IZISCQiTfNbf+08ix9m+KUFa6Pwgi6GH7
         kWQQXpKK+EjidpoyMEnvJTsxh9n9sp/TMlCB5FJx++5ZfQCffcbujK6tEV7Jb1czvVz9
         glplUbI8eyzmsX8Ank/reRF/qaiWdTKhRtlonFoHnHoAYzH3ZbuFcOcup4lrQ38UUSqE
         QBcb6C3S+FjuFkvbKjEGzhvKwYhDHGX3wh2xrgfXKNIxrrfvV9PgjFponqseS8ap3j6y
         cz845JdLPkMCOxUmGJ0xAKbrd8Y63Vq9kBJ7XoxQQjzHHQxzmHYD0PkQnuC9bbbLZSj2
         Bn8w==
X-Gm-Message-State: ALoCoQlxfIYuCW5uei2hL1BobeH9t+fxDE1ziM0qKctJEjfvrcqYjMlx0gk3PD0GaaP3OFvioKoN
X-Received: by 10.50.222.44 with SMTP id qj12mr15349272igc.48.1421956794721;
 Thu, 22 Jan 2015 11:59:54 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 22 Jan 2015 11:59:54 -0800 (PST)
In-Reply-To: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262862>

cc Johannes Schindelin <Johannes.Schindelin@gmx.de> who is working in
the fsck at the moment
cc Peter Wu <peter@lekensteyn.nl> who worked on builtin/remote.c a few weeks ago

I just compiled origin/pu to test and also found a problem (doesn't
happen in origin/master):

http.c: In function 'get_preferred_languages':
http.c:1020:2: warning: implicit declaration of function 'setlocale'
[-Wimplicit-function-declaration]
  retval = setlocale(LC_MESSAGES, NULL);
  ^
http.c:1020:21: error: 'LC_MESSAGES' undeclared (first use in this function)
  retval = setlocale(LC_MESSAGES, NULL);
                     ^
http.c:1020:21: note: each undeclared identifier is reported only once
for each function it appears in

so I cc Yi EungJun <eungjun.yi@navercorp.com> as well.

On Thu, Jan 22, 2015 at 11:43 AM, Michael Blume <blume.mike@gmail.com> wrote:
> These are probably minor, I only bring them up because Git's build is
> generally so quiet that it might be worth squashing these too.
>
>     CC fsck.o
> fsck.c:110:38: warning: comparison of unsigned enum expression >= 0 is
> always true [-Wtautological-compare]
>         if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
>                                      ~~~~~~ ^  ~
> 1 warning generated.
>     AR libgit.a
> /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
> file: libgit.a(gettext.o) has no symbols
>     CC builtin/remote.o
> builtin/remote.c:1572:5: warning: add explicit braces to avoid
> dangling else [-Wdangling-else]
>                                 else
>                                 ^
> builtin/remote.c:1580:5: warning: add explicit braces to avoid
> dangling else [-Wdangling-else]
>                                 else
>                                 ^
> 2 warnings generated.
>
> (the warning about libgit.a(gettext.o) is probably because I'm
> building with NO_GETTEXT -- I've never been able to get gettext to
> work on my mac)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
