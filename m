From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 19/21] t9003: become resilient to GETTEXT_POISON
Date: Thu, 19 May 2016 23:30:19 -0400
Message-ID: <CAPig+cRo3tjt9N0YO8sNn90dL3dP0asfmKTr5rerS9YLO6QBtw@mail.gmail.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
	<CAPig+cT3yf7D4xOmOhy5Y21qwHuA5Ny9ULEJhC1OBgrhiayQ3g@mail.gmail.com>
	<573E30C8.4070600@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 20 05:30:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3b8v-00056O-G7
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 05:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbcETDaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 23:30:22 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36465 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbcETDaV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 23:30:21 -0400
Received: by mail-ig0-f170.google.com with SMTP id qe5so124631672igc.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 20:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=ADrXitRty6A/pfdCk890SOFAaDgLPkCb9qaJTaIB9tQ=;
        b=WKGylCdmu/geA6atdjZ0rXjx94jNI0yX8OdrAbdTWvNYjkWstzQo0l3BpOXMh0q0Y1
         whuE+5gOWf6xT2bY6RxJZ6Kwhkp2Ze0298Wi0nTXPhMn1cEsdVmxFz22bIuideXPK8wY
         jT8xt0/Z5hbJkTNG15hGFq/QDdY9ALtif0fZ6tePeeZFHEGuTZcdBxJkhnPF5u32eXGs
         VPsRRFC6nwAtnjSKqTB1ktlpaoAAJckQIJMT/Dqxh0dXarhJqKR3t8/7j6es6FdGy37H
         qe4YekQh3gdSGR4RUT600izoNzHXDeKc0PG5pPDBEbDuEtxVWuaVXS06l9yCULRUU2vL
         dZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=ADrXitRty6A/pfdCk890SOFAaDgLPkCb9qaJTaIB9tQ=;
        b=Kqqo7b69nVldNEgHmm8HNlCS4P29bDYcUE/81TMiulLrEZFV4RC9diqZGvdSOAtPya
         Q/4Z23MtpBJOBReLDowZFTrRivaE2w4bDea2akc549017f4dwpKjL2du5n+tHtdnxNv9
         SI5yWKbFFU+mB9y7Na3bqxPuV6Xhw+HO11kDZSCFrFfbxrQUbyV2dtmri8nMpUVhfXTR
         zibTdOtMXEo7n3XJDqg2tyK52Uc0vDMcbPFX2yJdCYIb+fGRElley7UlCSGU0b0uACXs
         lHDERQSmZDg1HRlhL1JG+FzXJvII9AGHl7qUXQMXKdM/VzTKTg72bQUImtfvqi3ZxlTM
         WZWA==
X-Gm-Message-State: AOPr4FVLpdXUHQo6breLsouXs3jZOqibQ+yw1MUQtYr6U/BxnP3orPcHpBbKvVPO1W8/gUaj8k07KF7BMzWdaw==
X-Received: by 10.50.6.15 with SMTP id w15mr1014539igw.91.1463715019928; Thu,
 19 May 2016 20:30:19 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Thu, 19 May 2016 20:30:19 -0700 (PDT)
In-Reply-To: <573E30C8.4070600@sapo.pt>
X-Google-Sender-Auth: FqF8b7F_4OF6F32EjJ0TrGq9YLs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295136>

[cc:+junio]

On Thu, May 19, 2016 at 5:31 PM, Vasco Almeida <vascomalmeida@sapo.pt> =
wrote:
> =C3=80s 18:34 de 19-05-2016, Eric Sunshine escreveu:
>> On Wed, May 18, 2016 at 11:27 AM, Vasco Almeida <vascomalmeida@sapo.=
pt> wrote:
>>> -       sed -e "1,/^Did you mean this/d" actual | grep lgf &&
>>> +       sed -e "1,/^Did you mean this/d" actual |
>>> +       sed -e "/GETTEXT POISON/d" actual |
>>> +       grep distimdistim
>>
>> Why not do so with a single sed invocation?
>>
>>    sed -e "..." -e "..." |
>
> I tried but it seems not to work.
>
> Actually I did this wrong, I haven't thought this through.
>
> Under gettext poison:
> sed -e "1,/^Did you mean this/d" removes all lines, gives no output.
> And then the one second, sed -e "/GETTEXT POISON/d", outputs "lgf" as
> expected.
>
> But running normally (without gettext poison):
> 1st sed outputs "lgf" as expected
> And then second one output the entire 'actual' file, like if it were
> cat, undoing the first sed.
>
> I think the sed here is superfluous in the first place.
> Should we remove it? If it weren't the case of gettext poison it was =
ok
> to have sed there, but it makes the test fail under gettext poison.

Indeed, the sed seems superfluous. The output of the test command is:

    git: 'lfg' is not a git command. See 'git --help'.

    Did you mean this?
        lgf

And, the grep'd string, "lgf" only appears once, so grep alone should
be sufficient to verify expected behavior. Likewise for the other case
of misspelled "distimdist" and grep'd "distimdistim" which appears
only once.

I agree that the simplest fix to make GETTEXT_POISON work is to drop
the sed invocation.

Anyhow, I've cc:'d the author of 9d1d2b7 (git: remove an early return
from save_env_before_alias(), 2016-01-26) which introduced it.
