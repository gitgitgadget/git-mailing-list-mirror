From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Sat, 7 May 2016 12:12:55 +0200
Message-ID: <CAP8UFD0ht+ozCMguGwBc19dd9ViXG4tTE0mdaOQ+JVXhSOk02Q@mail.gmail.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1604251704300.2896@virtualbox>
	<CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com>
	<572BA80E.3000309@kdbg.org>
	<CAP8UFD35L8P2YJbbvg_-n9Nc61xMs+_2qBJwBxFzXeF-jA4WwQ@mail.gmail.com>
	<alpine.DEB.2.20.1605061733170.2963@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 07 12:13:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayzER-00028o-AE
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 12:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbcEGKM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 06:12:58 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35846 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbcEGKM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 06:12:56 -0400
Received: by mail-wm0-f41.google.com with SMTP id n129so83594398wmn.1
        for <git@vger.kernel.org>; Sat, 07 May 2016 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=TO5KpcKQV5oZXBLv2xeFR4ZAadgx9seaIA0oZBmBozs=;
        b=uyK7NYA26d6scu0kXdB9DM4iRrBw3pJQUh5xxEQSR+kFa4qz5KD8k8Klung7NqJIav
         xE+Iy+B9j4Rhng2bEvolS8RH5hhoo9WEDjt4+Oh/7njH7Ufv8Mzlfvt/BUuVpjHsFm/r
         /fLR545Y4GYMeBZPQtkfCKrJSzz9RpUvYRDnzqJES1K3nksrPy2V+u/xouuHvHBT98J+
         u6rs02NrmH23psTQDjtb6du55yiG+6RbU/2PC+xjhzDJ6GCe25FYslVzu1Y7bMQuNd49
         Rro15dY5aH0Fmj4bgqdYMpuB6y4m366ug3HrNNlH+/Ja6N9Rw3OsoHo+QmmMnjGAHEXX
         FJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TO5KpcKQV5oZXBLv2xeFR4ZAadgx9seaIA0oZBmBozs=;
        b=Hkg81lgp4GsQtBG+sUX8Mbc34T9fWmaDU+jgdK7MgBhLt8ipBjP5EDp9vHTd71A90S
         1UnfpmSILaXTy34/cx6IGBClt6jmw1f5gVdEYOK5uvWcPZvvYTEQXxo70Cd/TOy1pmvY
         n3Zsr8XfJa1zCWiO7TWGB+EEfgFr9omRDCnFX+jRCJ7TdctjMrqmuIMx/VE69s7FAQmu
         zl3dZC+T1GeJdDNaIiRZnmKEZ41+5i6AXy7rI16veSqTaTspNbbKUxI3Bh23jG0XpuJB
         iI+BhAzJthdFmCLfSBfI433IxK9IxVy3KK2Fy5/jflssvvMTJZomIObvJCBgig2E6sTw
         YoWg==
X-Gm-Message-State: AOPr4FWFd2S7GR2hkVPpkxh8Enoz7YQ1gDh6Yp+zfTn+AoZdgRuJTxssXRA8jrUqBcA2/IvxrEyJHnQUsxRgLg==
X-Received: by 10.194.20.162 with SMTP id o2mr23962245wje.78.1462615975079;
 Sat, 07 May 2016 03:12:55 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sat, 7 May 2016 03:12:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605061733170.2963@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293890>

Hi Dscho,

On Fri, May 6, 2016 at 5:34 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Chris,
>
> On Fri, 6 May 2016, Christian Couder wrote:
>
>> On Thu, May 5, 2016 at 10:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> > Am 05.05.2016 um 11:50 schrieb Christian Couder:
>> >>
>> >> On Mon, Apr 25, 2016 at 5:05 PM, Johannes Schindelin
>> >> <Johannes.Schindelin@gmx.de> wrote:
>> >>>
>> >>> Hi Chris,
>> >>>
>> >>> On Sun, 24 Apr 2016, Christian Couder wrote:
>> >>>
>> >>>> diff --git a/run-command.c b/run-command.c
>> >>>> index 8c7115a..29d2bda 100644
>> >>>> --- a/run-command.c
>> >>>> +++ b/run-command.c
>> >>>> @@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
>> >>>>   }
>> >>>>
>> >>>>   #ifndef GIT_WINDOWS_NATIVE
>> >>>> -static inline void dup_devnull(int to)
>> >>>> +void dup_devnull(int to)
>> >>>>   {
>> >>>
>> >>>
>> >>> The #ifndef GIT_WINDOWS_NATIVE rings very, very loud alarm bells.
>> >>
>> >>
>> >> Yeah, but I must say that I don't know what I should do about this.
>> >> Do you have a suggestion? Should I try to implement the same function
>> >> for Windows?
>
> No, you should change the code that requires that ugly dup()ing so that it
> can be configured to shut up.

After taking a look, it looks like a routine that does nothing could
be passed to set_error_routine() and that could do part of the trick.

This part might not be too ugly, but it would anyway be more complex,
less close to what the code is doing now and more error prone, as one
also need to make sure that for example no warning() or
fprintf(stderr, ...) are called and nothing is printed on stdout.

By the way I took a look and there are 11 calls to fprintf(stderr,
...) and 10 calls to warning() in different places in builtin/apply.c.
There might also be such calls in functions outside builtin/apply.c
that are called by the functions in builtin/apply.c.

So I'd much rather keep doing what I am doing now. If you or someone
else want to contribute patches on top of the series to do it in
another way, maybe they might be integrated at the same time by Junio,
so that the whole thing would appear in the same release and there
would be no feature discrepancy between Windows and the other
platforms, and you wouldn't need to implement anything special for
Windows.

But anyway, even though I don't know much about Windows, I think if
you have some code already in compat/mingw.c to handle redirections,
it might be easier and safer overall to just implement the
redirections in Windows.

Thanks,
Christian.
