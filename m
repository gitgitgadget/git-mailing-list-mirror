From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v5 05/10] for-each-ref: introduce 'ref_array_clear()'
Date: Tue, 09 Jun 2015 01:49:23 +0530
Message-ID: <5575F8CB.8080009@gmail.com>
References: <55729B78.1070207@gmail.com>	<1433574581-23980-1-git-send-email-karthik.188@gmail.com>	<1433574581-23980-5-git-send-email-karthik.188@gmail.com>	<vpqvbey6yli.fsf@anie.imag.fr> <5575B25A.6020608@gmail.com>	<vpqbngq2mkw.fsf@anie.imag.fr>	<xmqq3822cer4.fsf@gitster.dls.corp.google.com> <vpqa8wat8u9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 22:19:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z23WA-0004cb-E4
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 22:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbbFHUTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 16:19:30 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34253 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbbFHUT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 16:19:29 -0400
Received: by pdbki1 with SMTP id ki1so112042980pdb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=K/eHJLg1LDmRB0Bq52LYvi2e1ClJhb3erJMoFb/prk4=;
        b=CoYjvy4hpzDqUsxYVBDdZFOQmZwRjzAV/DHUXv7ZMlp9r87AVOqHkAaDQNw6fCra3y
         mXgoEdFcsFP2lX85m+aNoa1gM6deAbF7RdnN7igsWaoK46uYg4iuhGz0oESW/M+nUgwU
         ek8FGgmdwvsPlqTK2zZKKuXTo0JUMGLBxjbbVMyzRZUNV0w9nFbtUwG9QEdiCEhvN/69
         YxK5oxRsTjg15acA9uP9UTsKOwDntjIcqYKkMSrYL/j1TIWe56f+IrWadjjfm+ZozGYJ
         SHX9eN/JN/m0Ql9pMqkXcRx2GN2Wd97TS2CP41+TrTOdhHeOTHmaCbuQy6D7PRYaN2qT
         T5Pw==
X-Received: by 10.68.69.110 with SMTP id d14mr22809815pbu.96.1433794768640;
        Mon, 08 Jun 2015 13:19:28 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id dd3sm3407662pad.45.2015.06.08.13.19.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 13:19:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqa8wat8u9.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271123>

On 06/08/2015 10:51 PM, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> On 06/08/2015 08:23 PM, Matthieu Moy wrote:
>>>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>>>
>>>>>> +/* Free all memory allocated for ref_array */
>>>>>> +void ref_array_clear(struct ref_array *array)
>>>>>
>>>>> Is this a private function? If so, then add static. If not, you probably
>>>>> want to export it in a .h file.
>>>>>
>>>> It is in ref-filter.h.
>>>
>>> Ah, OK. It comes later in the series.
>>
>> Confused I am; if it comes later not in the same patch then it is
>> not OK, is it?
>
> We could introduce ref-filter.h earlier, indeed. To me, the current
> solution is good enough, but introducing ref-filter.h early and adding
> function definition there in the same commit as you drop the "static"
> keyword for them would clearly be an improvement.
>

But that would break the flow, wouldn't it? I wanted ref-filter to be 
introduced together, hence right after ref-filter.h we move code to
ref-filter.c

-- 
Regards,
Karthik
