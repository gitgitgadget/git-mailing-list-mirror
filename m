From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Fri, 13 May 2016 20:49:23 +0200
Message-ID: <CAP8UFD2fSW0nds7myfb_09c+EaCdn6+1OqsNEzfY2rVTeA5TAw@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1605130820160.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 13 20:49:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1I9X-0005QZ-BV
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 20:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbcEMSt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 14:49:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34355 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbcEMStZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 14:49:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so5351357wmn.1
        for <git@vger.kernel.org>; Fri, 13 May 2016 11:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Zo/gN5MGtv1ixAmkW2Zr0MwCUQVzS8/IjIwHAoJDMr0=;
        b=X7Rdku4d5XD2LYb7Ue1h9BxpSnp6Mf2Z/Uyn8keRjmWbBKGEkqDCVy5qB0F2H4qDhi
         eklSta+qi+WJo2cqVCUhqk7bMlxlXOOryetld2aT4xg73DuISWhLGB5dfjb/eyRgd6IW
         1hv/ezuxpM8eh0OEKs+5DKaqPJ/VbteohPJGDyqZC0vNHiBU4YV6MTkOVnIxVNfzgHov
         bFuhZJtSS9EQNdszzZ9GlZ358M7HmHjOo8r4RQo3Hop24s+inBPCa64gZHIipc7Z4yBK
         vch7I5jRZ+o0vrDpsZcSkfpF2Z7JPLups7eS6JEfleEHcEgTekSYqbxdPU3dVuA/8DyN
         lv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Zo/gN5MGtv1ixAmkW2Zr0MwCUQVzS8/IjIwHAoJDMr0=;
        b=gPZBVCp9e/a7Lx4syvZlxRLiFKkq0ZFfeMFYn48xv5Aog2XZcpmlyL/Ll7tFIYNE8Y
         XSr8GYnR38Xgadi11L6oO7TvdssUg3BsJmPcefE5xV8G5YpuOWf2LT+T2/+j1HZyIzrC
         8MeXbcCMGUitW9ObbVYJmAhQ3xahqvt430/BUB62Jaf1csUkINcixnS/Mmn8Q2bKmKm5
         i9aM5jfwfYayRGLJNZukS0yfY37havQvftLdK8jKR9sG41rOBqqo1hfbj+A9n93tvtED
         /vLvLj2wtA6j8iCpTVTMNVMnXqzEOzM3KdHZp45554mOOqQrZpgfAPGYk71+fkgVY+3r
         /2xg==
X-Gm-Message-State: AOPr4FWTq+U4OY2uaq9R8TBqw9NGEAyMAggqRKUkCJ6XSLWeKVvFButVD8by2exxAs9IwTjIqac1BplURWBpmQ==
X-Received: by 10.28.54.33 with SMTP id d33mr5444069wma.62.1463165363984; Fri,
 13 May 2016 11:49:23 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Fri, 13 May 2016 11:49:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605130820160.4092@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294558>

Hi Dscho,

On Fri, May 13, 2016 at 8:32 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Chris,
>
> On Wed, 11 May 2016, Christian Couder wrote:
>
>> I consider that the apply functionality is properly libified before
>> these patches, and that they should be in a separate series, but
>> unfortunately using the libified apply in "git am" unmasks the fact that
>> "git am", since it was a shell script, has been silencing the apply
>> functionality by "futzing with file descriptors". And unfortunately this
>> makes some reviewers unhappy.
>
> It is a misrepresentation to claim that this makes some reviewers unhappy.
> Speaking for myself, I am very happy. Despite having had to point out
> that the previous iteration of this patch series had a serious flaw.
>
> It is also incorrect to say that the shell script had been "futzing with
> the file descriptors". You see, the shell script's *own* file descriptors
> had been left completely unaffected by the redirection of the spawned
> process' output. That was perfectly fine a thing to do, even if it
> possibly hid fatal errors. Shell scripts are simply very limiting. The
> problem was introduced by v1 of this patch series, which changed *the
> caller's file descriptors* back and forth simply because the called code
> no longer runs in a separate process. And *that* was, and is, improper.

I think we should just agree that we disagree on what we think the v1
was doing and move on to v2.

>> By the way there are no tests yet for this new feature, and I am not
>> sure at all that "--silent" and "be_silent" are good names.
>
> If you want to follow existing code's example, we typically call this
> option "quiet".

In the documentation there is:

Documentation/git-am.txt:--quiet::
Documentation/git-am.txt:       Be quiet. Only print error messages.
Documentation/git-branch.txt:--quiet::
Documentation/git-branch.txt:   Be more quiet when creating or
deleting a branch, suppressing
Documentation/git-branch.txt-   non-error messages.
Documentation/git-checkout-index.txt:--quiet::
Documentation/git-checkout-index.txt:   be quiet if files exist or are
not in the index
Documentation/git-checkout.txt:--quiet::
Documentation/git-checkout.txt- Quiet, suppress feedback messages.
Documentation/git-clean.txt:--quiet::
Documentation/git-clean.txt:    Be quiet, only report errors, but not
the files that are
Documentation/git-clean.txt-    successfully removed.
Documentation/git-clone.txt--q::
Documentation/git-clone.txt:    Operate quietly.  Progress is not
reported to the standard
Documentation/git-clone.txt-    error stream.
ocumentation/git-commit.txt:--quiet::
Documentation/git-commit.txt-   Suppress commit summary message.
Documentation/git-fast-import.txt:--quiet::
Documentation/git-fast-import.txt-      Disable all non-fatal output,
making fast-import silent when it
...

So it looks to me that --quiet means something like "don't tell the
story of your life, but in case of problem you are allowed to
complain". In other word --quiet generally doesn't suppress error
messages from error() or die().

On the contrary the new feature I tentatively called --silent does
suppress all output including error messages from error().

Now if people think that it is not worth making a difference between
the different behaviors, then I am ok to rename it --quiet, though I
wonder what will happen if people later want a --quiet that does only
what --quiet usually does to the other commands.

>> Sorry if this patch series is long. I can split it into two or more
>> series if it is prefered.
>
> It is preferred. Much.

Ok, I will split it then.

Thanks,
Christian.
