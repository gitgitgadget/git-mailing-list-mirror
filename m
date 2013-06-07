From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Fri, 7 Jun 2013 16:20:31 +0200
Message-ID: <CABPQNSa1-dna_b+q-U6jgYy7p6zeiT7dAwu1Mw47QAezSNYKqA@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net>
 <20130606063754.GA20050@sigill.intra.peff.net> <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
 <20130606064409.GA20334@sigill.intra.peff.net> <7vy5anyx1w.fsf@alter.siamese.dyndns.org>
 <20130606174032.GB32174@sigill.intra.peff.net> <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com>
 <51B1B4DF.90705@viscovery.net> <CABPQNSYE=Mvrmc44dZmKnB14KLh4A=HxWo2-xgnJRyj1Q+BJLg@mail.gmail.com>
 <51B1CFD4.3030908@viscovery.net> <CABPQNSasTdkmpeGWb7_wZK2cQhiOyF7bX5ObcBg5kHm0KBGS5w@mail.gmail.com>
 <51B1DB2A.2060306@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 07 16:21:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkxXa-0003pO-OH
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 16:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157Ab3FGOVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 10:21:14 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45080 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab3FGOVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 10:21:13 -0400
Received: by mail-ie0-f178.google.com with SMTP id at1so6518573iec.23
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8cuNVtMxMpSkIkaKw8GdUuIp7I+wVzoUYyutpCCCoi8=;
        b=Djk1dWkFRyM7XuCqIXBfA3BJQLV/OMUL4fZKWkFpCz4IxsXbkRgSbBRZZ+TjbI1hTl
         OGRS/wRN/l/gd/LTKuAIUbO1agvqnrWtSkhTnoOZHDCWF6fUbui0YYp08cX+KqzFJVMc
         7R8c90jm+ie9aSdRffI7+brskmgErhWmIvjkhAwi9aivvLaev8ywrLLpp3pU1XXrGY0x
         bkW+BBRdbPB04vS0IttHtTAsfFoTfbdHoGnzMxP05POnkDirJu8UuS18aLQOzREZXmh/
         RGAPcVj7vkcnFUA1nH6WFvMrxfD4i62b/G6pdngOwmVbZ230gz7/wyp+bxR+dzEtRZDR
         l+4A==
X-Received: by 10.50.87.10 with SMTP id t10mr1283982igz.108.1370614872380;
 Fri, 07 Jun 2013 07:21:12 -0700 (PDT)
Received: by 10.64.23.199 with HTTP; Fri, 7 Jun 2013 07:20:31 -0700 (PDT)
In-Reply-To: <51B1DB2A.2060306@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226631>

On Fri, Jun 7, 2013 at 3:07 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 6/7/2013 14:46, schrieb Erik Faye-Lund:
>> On Fri, Jun 7, 2013 at 2:19 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 6/7/2013 14:00, schrieb Erik Faye-Lund:
>>>> On Fri, Jun 7, 2013 at 12:24 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>>>> Am 6/7/2013 12:12, schrieb Erik Faye-Lund:
>>>>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>>>>> index b295e2f..8b3c1b4 100644
>>>>>> --- a/compat/mingw.c
>>>>>> +++ b/compat/mingw.c
>>>>>> @@ -1573,7 +1573,8 @@ static HANDLE timer_event;
>>>>>>  static HANDLE timer_thread;
>>>>>>  static int timer_interval;
>>>>>>  static int one_shot;
>>>>>> -static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL;
>>>>>> +static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL,
>>>>>> +    sigterm_fn = SIG_DFL;
>>>>>>
>>>>>>  /* The timer works like this:
>>>>>>   * The thread, ticktack(), is a trivial routine that most of the time
>>>>>> @@ -1688,6 +1689,10 @@ sig_handler_t mingw_signal(int sig,
>>>>>> sig_handler_t handler)
>>>>>>               sigint_fn = handler;
>>>>>>               break;
>>>>>>
>>>>>> +     case SIGTERM:
>>>>>> +             sigterm_fn = handler;
>>>>>> +             break;
>>>>>> +
>>>>>>       default:
>>>>>>               return signal(sig, handler);
>>>>>>       }
>>>>>> @@ -1715,6 +1720,13 @@ int mingw_raise(int sig)
>>>>>>                       sigint_fn(SIGINT);
>>>>>>               return 0;
>>>>>>
>>>>>> +     case SIGTERM:
>>>>>> +             if (sigterm_fn == SIG_DFL)
>>>>>> +                     exit(128 + SIGTERM);
>>>>>> +             else if (sigterm_fn != SIG_IGN)
>>>>>> +                     sigterm_fn(SIGTERM);
>>>>>> +             return 0;
>>>>>> +
>>>>>>       default:
>>>>>>               return raise(sig);
>>>>>>       }
>>>>>
>>>>> That's pointless and does not work. The handler would only be called when
>>>>> raise() is called, but not when a SIGTERM is received, e.g., via Ctrl-C
>>>>> from the command line, because that route ends up in MSVCRT, which does
>>>>> not know about this handler.
>>>>
>>>> That's not entirely true. On Windows, there's only *one* way to
>>>> generate SIGTERM; "signal(SIGTERM)". Ctrl+C does not generate SIGTERM.
>>>> We generate SIGINT on Ctrl+C in mingw_fgetc, but the default Control+C
>>>> handler routine calls ExitProcess():
>>>> http://msdn.microsoft.com/en-us/library/windows/desktop/ms683242(v=vs.85).aspx
>>>
>>> But a call to signal(SIGTERM, my_handler) should divert Ctrl+C to
>>> my_handler. The unpatched version does, because MSVCRT now knows about
>>> my_handler and sets things up so that the event handler calls my_handler.
>>
>> No, it does not:
>> Ctrl+C raises SIGINT, not SIGTERM.
>
> <action type="slap" destination="forehead"/>
>
> You are right. Your change would "fix" SIGTERM as it can be raised only
> via raise() on Windows nor can it be caught when a process is killed via
> mingw_kill(...,SIGTERM) by another process.
>
> But then the current handling of SIGINT in compat/mingw.c is broken. The
> handler is not propagated to MSVCRT, and after a SIGINT handler is
> installed, Ctrl+C still terminates the process. No?

Yeah, probably. I wasn't aware that it handled SIGINT, but yeah it
does. So this was indeed a regression.

> BTW, isn't mingw_signal() bogus in that it returns the SIGALRM handler
> even if a SIGINT handler is installed?

Yep, that's a bug. Thanks for noticing.

I've pushed out a branch here that tries to address these issues, but
I haven't had time to test them. I'll post the series when I have. In
the mean time:

https://github.com/kusma/git/tree/win32-signal-raise
