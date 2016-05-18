From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/5] t1500: avoid changing working directory outside of tests
Date: Tue, 17 May 2016 23:33:29 -0400
Message-ID: <CAPig+cRn9fjo6CB9p7fKio=Nav-2WRjiUSkWiM3rqdO-4aREBA@mail.gmail.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
	<20160517193630.10379-4-sunshine@sunshineco.com>
	<xmqqeg90v2ss.fsf@gitster.mtv.corp.google.com>
	<CAPig+cTAgB6DXoEeJaDVy7_J7QiqNOm6AJqZTiSowO6_jqa8_w@mail.gmail.com>
	<20160517215214.GA16905@sigill.intra.peff.net>
	<xmqqshxgti68.fsf@gitster.mtv.corp.google.com>
	<20160518010609.Horde.sM8QUFek6WMAAwho56DDob8@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stefan Beller <sbeller@google.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 18 05:33:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2sEu-000069-HT
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 05:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbcERDdb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2016 23:33:31 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35342 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbcERDda convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2016 23:33:30 -0400
Received: by mail-io0-f195.google.com with SMTP id i75so7158358ioa.2
        for <git@vger.kernel.org>; Tue, 17 May 2016 20:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=8uNSN0upmcGRTLX/zwKKx9ADbh1YElVXSDVAuFFbzII=;
        b=ZGSmMu2HbNvWXI4/G/UbZ1VYNVVTEq8Z/2J5BD0B8eXECP23nQlWxMuaaF69IaBtLZ
         Q1sjxLwLZDBEX0G1bgBVmpSRqWWCcdGQSHUaa6nSI1g+b54n5sNl2QOXH+NFMplU3hBk
         Dm2+2HZo+W6RQL3jgozIYO575XGqh0oNWEU68t+eTmIyqD7JjLvcm41KdRn3Fww/37fu
         tvtWseqrfe5dNNIFWSL3VHcnaM9m4gDuMBgxv6HHQOYVA2TLrQpviR/RqY/E6Y+Fdgpc
         xKm/FJi0a3DgY0MnNhBBs0rJzZ4VRM5mq6yx7oii0qhEFPfphGFvLjLEKi4tIsvYHqss
         4nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=8uNSN0upmcGRTLX/zwKKx9ADbh1YElVXSDVAuFFbzII=;
        b=Ll5cUoe5PbvPUVRWZBhmgDRYbXxCFLjULjDIA/bkmpAY5lm5btBo2q0xpLjejqV3s1
         9QvwLMioTgRvJgGzX8NfyrM9J6+lYvAFa45jD9pOPq0jeYKuLsNanBwYX5P9CsD0m0P0
         ZY+ezyR0srcdIxJaAZigHvvpkA7c4uobSDI0udOi0C9E2OnlwJK5BZwd5H/j9WZhaTjf
         VSHCTP+NydDFFVd0OP2JTZcltKVJjsUQlkKZsohCKv1ZxGAwRk5NwlVPLJne9df/rNSA
         ILRsc4Yh0KH+cQ7jpiRYFQIXXS0R6zfC/n/XOnIE4cv2++9mpgYI4gXmsUsOREL2cxNB
         M7eQ==
X-Gm-Message-State: AOPr4FVK9ryTomzsQfRnkXvqqekHYM+gL+fFMvzv2Iq1FNJo1hQywZesA7be0nin31jfpZhvxGqeGUxjHxATzg==
X-Received: by 10.107.132.66 with SMTP id g63mr3872529iod.34.1463542409396;
 Tue, 17 May 2016 20:33:29 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Tue, 17 May 2016 20:33:29 -0700 (PDT)
In-Reply-To: <20160518010609.Horde.sM8QUFek6WMAAwho56DDob8@webmail.informatik.kit.edu>
X-Google-Sender-Auth: FO5YMP5Pd23jpra9X8ibdaC64WA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294929>

On Tue, May 17, 2016 at 7:06 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> Quoting Junio C Hamano <gitster@pobox.com>:
>> Jeff King <peff@peff.net> writes:
>>> On Tue, May 17, 2016 at 04:48:33PM -0400, Eric Sunshine wrote:
>>>> On Tue, May 17, 2016 at 4:37 PM, Junio C Hamano <gitster@pobox.com=
>
>>>> wrote:
>>>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>>>> +                     git ${dir:+-C "$dir"} rev-parse --$o >actu=
al &&
>>>>>
>>>>> This is kosher POSIX, but I vaguely recall some shells had troubl=
e
>>>>> with the SP between -C and "$dir" in the past.  Let's see if anyb=
ody
>>>>> screams; hopefully I am misremembering or buggy shells died out.
>>>>
>>>> I also am bothered by a vague recollection of some issue (possibly
>>>> involving the internal space and lack of quotes around the entire
>>>> ${...}), but couldn't remember nor find a reference to the specifi=
c
>>>> details. Perhaps someone reading the patch has a better memory tha=
n I.
>>>
>>> Probably:
>>>  http://thread.gmane.org/gmane.comp.version-control.git/265094
>
> And ea10b60c910e (Work around ash "alternate value" expansion bug,
> 2009-04-18) as well.
>
>    http://thread.gmane.org/gmane.comp.version-control.git/116816

Thanks for the additional link. I have v3 ready to roll and will send
it out within the next day if no more actionable review comments
arrive.
