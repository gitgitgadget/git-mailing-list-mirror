From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/16] port branch.c to use ref-filter's printing options
Date: Sat, 2 Apr 2016 01:12:46 +0530
Message-ID: <CAOLa=ZRHap6C016zKvnWGy7A4OPx2zcSAeT+KYjytetQocPx-w@mail.gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
 <1459517477.3493.5.camel@kaarsemaker.net> <20160401134435.GA16027@spirit> <56FE9099.3030004@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:43:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am4ye-0007U1-Dm
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 21:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbcDATnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 15:43:22 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:32942 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbcDATnV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 15:43:21 -0400
Received: by mail-qg0-f47.google.com with SMTP id j35so105054920qge.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mQpBsbyYtuoDR0G80vmX7EwbiEiVKa5Jaf2Bb2In4uc=;
        b=W5lrzOVCWJuOQwFFEEzMq1X5xSPO6lR5JWrfZlyiXegcEjtmT6jNr4ywInseN/NIv9
         FSKublMY4JTlczPGBo8nazv1shtbeAVMHHAbnKEqaReRNsNRxJmB6x7sHFcmHiyEjOot
         V9h10aO+nXlpwBuWHMjJ22EB5QTxa91VbI5J03+XWNJJCj0qpOO8abDL0fX13BKjigkx
         h4AGHrAi/U6enA0OHk8GqjUzhd/D5xLD91cOV3EFzyZalQ7R3dV8khDmQWvN3//jS+w0
         pE4JHoW0Jl+2HFPrulIaemh5N/3fpp4XR9OzoTYvxRVRZhF6gGR6qpwKevzkB/IimOQN
         V3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mQpBsbyYtuoDR0G80vmX7EwbiEiVKa5Jaf2Bb2In4uc=;
        b=gtAS6O3uwLmHQexiITSh3VbENGDiIc3WWvpIloF0Da4BL98Il/YW1DVvrY1pnD0bIx
         hufF1ihTDAF6uQXa47jO7gj9Zf27eeDqPa+YDFAM2Mv45ywYbqD3y2D+mNuTEWDZihSX
         PwFvHuQn+0k5ruKYSgegKtH+VLQi9OpD9bCgofClPZr23Wvu15IpgoDvDweS0EzqhxI9
         Rks04tmAHSGzwr1byJBhG0LwbkaxgzRnGKYu3kYDC49cZ5I11lx/6NXUm7d54g1JHZpB
         kUeAsBjP/DO4ooPLC7+RbNhZSCVLJJsIpVwccWf/ZX2oUi2cioV8NJ7p4t3UIajyGhEw
         uG5A==
X-Gm-Message-State: AD7BkJLH1ko8uqyfDyxcesNF8P+vTG1r5ZPOww1dTSlof2jf247vJRABy+iDeXGgnrn82U8gxcw/lbZmId+hJw==
X-Received: by 10.140.31.135 with SMTP id f7mr27305990qgf.96.1459539795883;
 Fri, 01 Apr 2016 12:43:15 -0700 (PDT)
Received: by 10.140.18.85 with HTTP; Fri, 1 Apr 2016 12:42:46 -0700 (PDT)
In-Reply-To: <56FE9099.3030004@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290578>

On Fri, Apr 1, 2016 at 8:45 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 01/04/16 14:44, Dennis Kaarsemaker wrote:
>> On Fri, Apr 01, 2016 at 03:31:17PM +0200, Dennis Kaarsemaker wrote:
>>> On wo, 2016-03-30 at 15:09 +0530, Karthik Nayak wrote:
>>>>
>>>> This is part of unification of the commands 'git tag -l, git branch -l
>>>> and git for-each-ref'. This ports over branch.c to use ref-filter's
>>>> printing options.
>>>>
>>>> Initially posted here: $(gmane/279226). It was decided that this series
>>>> would follow up after refactoring ref-filter parsing mechanism, which
>>>> is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).
>>>
>>> Interaction between this series and something I've not yet been able to
>>> identify
>>
>> That someting is es/test-gpg-tags. Karthik, can you maybe squash this
>> fix in if you do another reroll?
>
> Yes, I sent the same patch to Karthik yesterday. Unfortunately, I didn't
> send it as a response to this email thread, so it may have been hard to
> spot on the mailing list. My bad. Sorry for wasting your time. :(
>
> ATB,
> Ramsay Jones
>

Thanks to both of you, it seems that I hadn't rebased my work on Eric's patches
($gmane/288371). Thanks for reporting, I'll fix and reroll.

-- 
Regards,
Karthik Nayak
