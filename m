From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/6] sha1_name: avoid Yoda conditions
Date: Tue, 30 Apr 2013 17:45:26 -0500
Message-ID: <CAMP44s26oZf0=xdqp5sr_J1TNhK83=88A7KH5n_LnstFe6o5gA@mail.gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-4-git-send-email-felipe.contreras@gmail.com>
	<7vehdrbrvz.fsf@alter.siamese.dyndns.org>
	<CAMP44s3osZJO1P6_KoPVON0cOSAD5D-OZmL=aKGkcWReortiCw@mail.gmail.com>
	<7v1u9rbrb4.fsf@alter.siamese.dyndns.org>
	<CAMP44s3K8BOfnUdc0514KgvYsbncSBO4DRSyfqhFQJomGrZN0A@mail.gmail.com>
	<7vobcvabxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJIi-0003Mo-US
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933874Ab3D3Wp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:45:29 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:46120 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933732Ab3D3Wp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:45:28 -0400
Received: by mail-la0-f52.google.com with SMTP id fd20so914584lab.11
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 15:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=e07cN7jZmp5o8NhmSRNoFeXWQItR6+bR+PhX3b+q+28=;
        b=Rz/jrojQIcLYwsFUXWPhWiqdWLvd/4JfMTxoT3YnKejCMIAiHmYW0stdUG+gpgaOdD
         jr1abz7WG7ATCHhx68qB9G0tWRg2EGIAv0odaUPTvDS8vJTBh+NMwEMCilPcWJKfM1TL
         QF8UHXEW7amy67zmkY4soGZKfI3D7rJlIvExbe4Fohe+C/Veo4Nx1Zfajvx5TEicSw1t
         8r5E5AYSZYt/UsWj1iL3vSoRKqIyFrDm1LuOb2HODd7vLECfMwU0MfzVprr9BuO0BBz8
         NYxDMioAFt1UXX3T8s8dqSwdZEMpAshbOFbmmM30+Vy69/JSaSo95FSPmwsN9kfKRLwc
         pwKQ==
X-Received: by 10.112.154.98 with SMTP id vn2mr375638lbb.8.1367361926740; Tue,
 30 Apr 2013 15:45:26 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 15:45:26 -0700 (PDT)
In-Reply-To: <7vobcvabxi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223036>

On Tue, Apr 30, 2013 at 5:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Apr 30, 2013 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> On Tue, Apr 30, 2013 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> What is a Yoda condition?
>>>>
>>>> ---
>>>> Using if (constant == variable) instead of if (variable == constant),
>>>> like if (4 == foo).
>>>>
>>>> Because it's like saying "if blue is the sky" or "if tall is the man".
>>>
>>> That is an invalid analogy, as the sentences do not make sense.
>>>
>>> A much better explanation I heard on this list is that people do not
>>> say "If 1 is smaller than the number of your wives, you have a big
>>> problem".
>>>
>>> I actually was not asking why people find the convention to visually
>>> align comparison with number lines unusual. We discussed this style
>>> long time ago on this list.  I haven't heard the "Yoda condtion"
>>> expression and was asking about the "Yoda" part.
>>
>> It's popular culture.
>>
>> http://en.wikipedia.org/wiki/Yoda
>
> I know who Yoda is.  What I was puzzled with was what it has to do
> with "if blue is the sky" (which is a bad analogy for "if (0 < len)"
> anyway)?

Yoda speaks in reverse "Stopped they must be; on this all depends".
"if (0 < len)" says "if zero is less than len", which is in reverse,
as reverse as "if 1.50 is taller than you". It's all reversed: "if you
are taller than 1.50", "if len is greater than zero", "They must be
stopped; all depends on this".

I don't understand what is not clear.

-- 
Felipe Contreras
