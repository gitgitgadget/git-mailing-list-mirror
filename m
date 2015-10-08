From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Thu, 8 Oct 2015 22:58:31 +0530
Message-ID: <CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <vpqr3l5zgst.fsf@grenoble-inp.fr> <CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
 <vpq8u7dp9qr.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 08 19:29:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkF0E-0003Qf-18
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 19:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbbJHR3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 13:29:04 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36565 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965119AbbJHR3B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 13:29:01 -0400
Received: by vkfp126 with SMTP id p126so36451742vkf.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/mhVvLPdIbp/9/SyhcbuDJFZ1lm9Vg9qococ/06vLJI=;
        b=OU0KkrtSYvTuQTXIBcKQBFt5bzXvbYNlmUoFIo9HLstPDculjA5Dg5Df+K4YfvIICK
         pMXKjY8/dl1XUxkhSsrPw7240WtgFwpuZ60QRx6bTmyCU5HH9T6i8n02pYxmbwfaDXYm
         zjITf4Sal+pEBlA5MRo97C8JaE6dK6pwAP06aFOrefKzISGeDKIxQqB8SwUTAhomp5Lo
         4sCM34Z9XJq1NPGAaSmyxDRikdc1Iz6rZ2S1YPMWs/GQU3kP/JY073U94KBzlKh8LkOy
         3GTlHrMkbOcLsPMUjbPFvT6HNdwdIwqGq7vAmVl38eocLyE/tR9JbKFTbGX4cu4X5qNK
         4ZgQ==
X-Received: by 10.31.178.198 with SMTP id b189mr5261628vkf.114.1444325340769;
 Thu, 08 Oct 2015 10:29:00 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Thu, 8 Oct 2015 10:28:31 -0700 (PDT)
In-Reply-To: <vpq8u7dp9qr.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279251>

On Thu, Oct 8, 2015 at 10:40 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Thu, Oct 8, 2015 at 5:57 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>> +                             unsigned int nobracket = 0;
>>>> +
>>>> +                             if (!strcmp(valp, ",nobracket"))
>>>> +                                     nobracket = 1;
>>>
>>> The code to parse comma-separated values is different here and
>>> elsewhere. I'd rather have the same code (possibly factored into a
>>> helper function), both to get consistent behavior (you're not allowing
>>> %(upstream:nobracket,track) for example, right?) and consistent code.
>>>
>>
>> Speaking of comma-separated values, the only other place we use that is
>> in the align atom. Also I find this very specific to get a function out of.
>> Somehow I think this is the simplest way to go about this.
>
> Well, most pieces of code start with one instance, then two, then
> more ;-). When the second instance starts being different from the
> first, it doesn't give a good example for the future third instance.
>

Totally agree with you here.

> This particular piece of code is so important and I won't fight for a
> better factored one, but in general "there are only two instances" is a
> dubious argument to avoid refactoring.
>
> Still, I find it weird to force the nobracket to be always at the same
> position.
>

No i mean I could follow up with the way we use it in align, but I don't see
how I can make a function out of this.

-- 
Regards,
Karthik Nayak
