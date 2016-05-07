From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Sat, 7 May 2016 15:46:58 +0200
Message-ID: <CAP8UFD2wFZgOzmadm7X2988RyDGve92TsoMHPf2S5Ydyhc=Nyg@mail.gmail.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1604251704300.2896@virtualbox>
	<CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com>
	<572BA80E.3000309@kdbg.org>
	<CAP8UFD35L8P2YJbbvg_-n9Nc61xMs+_2qBJwBxFzXeF-jA4WwQ@mail.gmail.com>
	<alpine.DEB.2.20.1605061733170.2963@virtualbox>
	<CAP8UFD0ht+ozCMguGwBc19dd9ViXG4tTE0mdaOQ+JVXhSOk02Q@mail.gmail.com>
	<alpine.DEB.2.20.1605071409490.2963@virtualbox>
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
X-From: git-owner@vger.kernel.org Sat May 07 15:47:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az2ZX-00026c-KA
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 15:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbcEGNrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 09:47:01 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37785 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbcEGNrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 09:47:00 -0400
Received: by mail-wm0-f51.google.com with SMTP id a17so117718218wme.0
        for <git@vger.kernel.org>; Sat, 07 May 2016 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=yjr8kNJVHpGTCa2ttpc3k0iVDSGyt+0RxM8RFqFYtkk=;
        b=K/wuYXAyrAn3zlTOv3MUrHDyeDgZsogBiEI2yi0Jg4qDYP1vCCxXXiRFsoHvcBobUj
         +D6+ZIfWL9RxD/Q9ozFBZqCW9Chnth2pqwbEey5baBMv7wy4GLqbRBhbke92UvK2iJw8
         GZhtKxMNHzqVnlMjJkhT8oHMvSiSFZN3Vyr+oM18F7/8BLBXeM9I4EECfTD/0/3zIE1q
         VAlKxsgifEr15Glq1Uxmv07WniJjJdjdiiwAOzO4SWUwpEK6nYKYLr21N6XZ7aDwBF1R
         nX0ojkXpi1ZIlkIEHGWNmuwNZqQ2eXbWP9T8d8PNqmLxdSj3PbZ+p2ZFEEBTu/Usm8Ea
         IZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=yjr8kNJVHpGTCa2ttpc3k0iVDSGyt+0RxM8RFqFYtkk=;
        b=l0v1XjKZSB7qbEqj9XRU0kFZ0sc5/pCez3jpPbYrJL3qztBmVBXLRcG6qaIPfhxwJv
         +oPCaN4Swc40U9bAsU03Divvfv3qrpTT/S41ZtTR4WTtmK3szmqe9bS+NJyMhKCcXK+4
         gBaKkQOJh5B4ac3yzMVvLRH3dCZ7mndh7/+F5v0Fs6DiWNgbmDrenEn1fyrFqgftRFt8
         1E+PXSekKiyTXnbx9L9od4obTUmCG4Smq1N3RJwdpAvmLgZ4T+WabSEc0qPX8iY0TG0f
         1zxEnNx0Qs+y0CgCynavdkXm9JQo3YulUEbI7GWC16FF10qNLADIVdhJwisV5jvOtqG5
         p93A==
X-Gm-Message-State: AOPr4FWAXSALfma0S9XOYlTWF3eEpeHYHQYZ8ZaIzmKPClhZHYS1d1ai+F2os/5CvUniEsqdS9uzFguDuLlnVA==
X-Received: by 10.194.117.70 with SMTP id kc6mr27239491wjb.94.1462628818861;
 Sat, 07 May 2016 06:46:58 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sat, 7 May 2016 06:46:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605071409490.2963@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293898>

Hi Dscho,

On Sat, May 7, 2016 at 2:13 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Chris,
>
> On Sat, 7 May 2016, Christian Couder wrote:
>
>> On Fri, May 6, 2016 at 5:34 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > No, you should change the code that requires that ugly dup()ing so that it
>> > can be configured to shut up.
>>
>> After taking a look, it looks like a routine that does nothing could
>> be passed to set_error_routine() and that could do part of the trick.
>>
>> This part might not be too ugly, but it would anyway be more complex,
>> less close to what the code is doing now and more error prone, as one
>> also need to make sure that for example no warning() or
>> fprintf(stderr, ...) are called and nothing is printed on stdout.
>
> I am afraid that you *have* to do that, though, if you truly want to
> libify the code.
>
> Of course you can go with really ugly workarounds instead. Something like
> a global flag that die() and error() and warning() respect. It would
> incur some technical debt, but it would make your life easier in the short
> run.
>
> Both the real solution and the workaround would be better than the current
> version of the patches that dup() back and forth, just to avoid addressing
> the real problem.

The code that is now in master in builtin/am.c does:

    if (state->threeway && !index_file) {
        cp.no_stdout = 1;
        cp.no_stderr = 1;
    }

and in run-command.c there is already:

        if (cmd->no_stdout)
            dup_devnull(1);
        [...]
        if (cmd->no_stderr)
            dup_devnull(2);

for Linux and the following for Windows:

    if (cmd->no_stderr)
        fherr = open("/dev/null", O_RDWR);
        [...]
    if (cmd->no_stdout)
        fhout = open("/dev/null", O_RDWR);

so the current code is already using dup_devnull() for Linux that you
don't want me to use, and it looks like there is already a simple way
to do that on Windows.

So what's the problem? Isn't it just that you don't want a
dup_devnull() for Windows that would be a few lines long?

You keep saying that what is done in this patch is "ugly" or that
there is a "real problem", but frankly I don't see why. Could you
explain exactly why?
Because the more I look at it, the more it looks to me like the
solution that is the simplest (even for Windows), the safest and the
closest to what the current code is doing.

Thanks,
Christian.
