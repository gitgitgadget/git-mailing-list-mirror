From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state
 stack machinery
Date: Thu, 20 Aug 2015 16:01:09 +0530
Message-ID: <CAOLa=ZTxNVfwHboxLBcd0obL8RbfemWmq51GVUvbdKoYsSnfQA@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
 <1439923052-7373-4-git-send-email-Karthik.188@gmail.com> <vpqvbcb2uoi.fsf@anie.imag.fr>
 <xmqq37zf9klg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 12:31:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSN8L-0000L0-7H
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 12:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbbHTKbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 06:31:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35039 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbbHTKbj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 06:31:39 -0400
Received: by obbwr7 with SMTP id wr7so28302372obb.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uEEv1GQbbcF1+XuB0POs69OXH45tRtLPwYsecMyK7LU=;
        b=wiBjmkeW41ZaoDr11sC/ZNQqxu2pe6imORpc46bCycqQ76swabvR6N526QqeHCgfw+
         8UaXXww2Af8XxNG7wDLH3t7W3uAu7Y3Plc7usBtLd3UYR1suYULzK9dAEN5XgJC8uATU
         INECyHOfI0w1iuZSmauzYc6uGO6fFuWaLozqQusLkBLvkzyogVOGZZRPPOLDzbhCAKkU
         lWvKZR3vtWLKZZmgyJwiUcMe0Q82DfAp2pbU9Sl0WJj7uho3/6EMvR1dUbvSVfB2OvK7
         RdFrsu2HTpp2mOTGO4zwpyVcEfkFc2QVKvUIPJuRRtjKyZTWoSHD7zjQRNYTJ4/C//qK
         eRTg==
X-Received: by 10.60.92.37 with SMTP id cj5mr2061897oeb.30.1440066698821; Thu,
 20 Aug 2015 03:31:38 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 20 Aug 2015 03:31:09 -0700 (PDT)
In-Reply-To: <xmqq37zf9klg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276234>

On Thu, Aug 20, 2015 at 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> You replaced the quote_style argument with ref_formatting_state, and I
>> think you should have kept this argument and added ref_formatting_state.
>> The other option is to add an extra indirection like
>>
>> struct ref_formatting_state {
>>       int quote_style;
>>       struct ref_formatting_stack *stack;
>> }
>>
>> (ref_formatting_stack would be what you currently call
>> ref_formatting_state). But that's probably overkill.
>
> I think this is the right way to go.  As you explained in your later
> messages, this is conceptually a global setting that applies to
> anybody working in the callchain and not something individual
> recursion levels would want to muck with.
>
> Thanks.
>

I'll work on this :)

-- 
Regards,
Karthik Nayak
