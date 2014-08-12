From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailsplit.c: remove dead code
Date: Tue, 12 Aug 2014 14:50:54 -0700
Message-ID: <CAPc5daVuO9_wNCSzTi2PFb5JGKSw_awdsUaFNZS_S7v89fAZHg@mail.gmail.com>
References: <53EA430E.8050905@web.de> <1407878487-23530-1-git-send-email-stefanbeller@gmail.com>
 <vpqy4utz8x5.fsf@anie.imag.fr> <xmqqvbpx4cd6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 12 23:51:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHJyS-0000Fr-G5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 23:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbaHLVvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 17:51:16 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:40789 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230AbaHLVvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 17:51:16 -0400
Received: by mail-la0-f46.google.com with SMTP id b8so8407137lan.19
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RZZvTcBhrIcVxBkvqATfpUUfplEOZ58yaPHomtEDNSg=;
        b=VuZhTJ+BMspwneYgaM4BNBedhD0K5pyui7J26sU1trE3KOnq9Q9bYXNm0OK985NEk4
         ObUuD8INAG+dbz5KjKghSRbOnlDkJWfs++NOV58eaonIO2qJdD/nIBipUh2c/IVsHiuY
         0eHGnvuv/BpLP8yTJ2BYTvCdyjNm4K6GSKsWpaAxYaXxrS5/SqMtlduWU4cVQCc+AG1J
         i0FDS6KZMaw5poFsebquimQmjgn7BdsaSyVKMYYiIErKfRxuEWE5/Ja3duwl/X0Tot+O
         KZcFyzbnhLe9glt3kMN2AWDTFzpQITs4aO6XeOIe9G1J1yNHx/CnoGRBnffSP4zjLYhb
         1ekA==
X-Received: by 10.112.158.161 with SMTP id wv1mr541650lbb.8.1407880274324;
 Tue, 12 Aug 2014 14:51:14 -0700 (PDT)
Received: by 10.112.199.74 with HTTP; Tue, 12 Aug 2014 14:50:54 -0700 (PDT)
In-Reply-To: <xmqqvbpx4cd6.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: t1eng4jYAwjw97KVKkPUj5qOq9I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255169>

... answering to myself, the only invoker does not seem to care,
so I do not mind if the fprintf/exit gets turned into die() in a
follow-up patch.

Thanks.

On Tue, Aug 12, 2014 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Stefan Beller <stefanbeller@gmail.com> writes:
>>
>>> +    if (is_bare && !allow_bare) {
>>> +            unlink(name);
>>> +            fprintf(stderr, "corrupt mailbox\n");
>>> +            exit(1);
>>> +    }
>>
>> Not directly related to your patch, but shouldn't this be using
>>
>> die(_("corrupt mailbox"));
>>
>> instead?
>
> Doesn't the exit status of mailsplit matter to its existing
> invokers?
