From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 2/8] submodule config: keep update strategy around
Date: Fri, 30 Oct 2015 14:16:19 -0400
Message-ID: <CAPig+cRh9J0izFvLzRjjU4FEBKJsiJaYFv=9WdxFVfJ3xs0JiQ@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-3-git-send-email-sbeller@google.com>
	<CAPig+cRTa35B5aHcopaWOtCLxN6BhGJKTcVeDUf0hrZE_nfCKQ@mail.gmail.com>
	<CAGZ79kZ1usWVutWwyFQKeujyyTPVRtSQM6dvkU9gWUDSTNpB6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:16:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEDw-0003UI-MZ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759433AbbJ3SQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:16:20 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32966 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758640AbbJ3SQT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:16:19 -0400
Received: by vkgy127 with SMTP id y127so52901348vkg.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0a5MNifnddLhDKI59UjHIFPXznVsYCA/HH6R6ixBulk=;
        b=JYhKZw+cECHfJNESPRTYe2xavre6P4TJz+s3YWAN5Bbho9MeOXXq6GT5GaSYNSZi7W
         +O1hf7jDjIXiMZgdTcwq7nGw8QAR/dARXRc1J8iV/t4LofI+2m+DrzgF+DNgmAWMGvq+
         xRFwl5RDaltW5irvaPA9WhoDiEd+/coPJVeIMbZ2wCHl7DF1q7XTJEJEGeMhuh8QCDpZ
         i21TPPyFFEvtUB11IM+RuH+/0B2lvaV1daWUH/ykqhsdBp/ItaxOpKDEwTI7ElFuCDpd
         iDTwKLI7sontJqwGsm33dXxwDHgZXI1kTLgo38wzIOK33IAfjMgi46QS7trSdRDqz3A7
         SC/g==
X-Received: by 10.31.153.210 with SMTP id b201mr6228435vke.117.1446228979097;
 Fri, 30 Oct 2015 11:16:19 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Fri, 30 Oct 2015 11:16:19 -0700 (PDT)
In-Reply-To: <CAGZ79kZ1usWVutWwyFQKeujyyTPVRtSQM6dvkU9gWUDSTNpB6w@mail.gmail.com>
X-Google-Sender-Auth: KmwUKxQ5n9iDRMTEy4ATw-8eeW8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280505>

On Fri, Oct 30, 2015 at 1:38 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Oct 29, 2015 at 6:14 PM, Eric Sunshine <ericsunshine@gmail.com> wrote:
>>> +               else if (!me->overwrite && submodule->update != NULL)
>>
>> Although "foo != NULL" is unusual in this code-base, it is used
>> elsewhere in this file, including just outside the context seen above.
>> Okay.
>
> ok, I'll clean that up as we go.

Oh, I wasn't suggesting that you clean this up (though you may if you
want). I was merely commenting (for the sake of others reviewing this
patch) that, while not the norm for the project, this instance is
consistent with surrounding code.

>>> +                       free((void *)submodule->update);
>>
>> Minor: Every other 'free((void *) foo)' in this file has a space after
>> "(void *)", one of which can be seen in the context just above.
>
> done
