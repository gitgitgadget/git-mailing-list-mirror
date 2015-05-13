From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 01/18] t1404: new tests of ref D/F conflicts within
 transactions
Date: Wed, 13 May 2015 22:19:44 +0200
Message-ID: <5553B1E0.9080008@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu> <1431357920-25090-2-git-send-email-mhagger@alum.mit.edu> <xmqqlhgu3nyl.fsf@gitster.dls.corp.google.com> <5551BA88.3090900@alum.mit.edu> <CAPc5daVQEMv-QPDpyNVGzcjrjrw20QLzm8dkC0ZYAX=Y4zGaBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 22:20:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysd8Z-0008BS-A0
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 22:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbbEMUUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 16:20:01 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53381 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752391AbbEMUUA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2015 16:20:00 -0400
X-AuditID: 1207440c-f79376d00000680a-a5-5553b1e3f58d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id CE.9B.26634.3E1B3555; Wed, 13 May 2015 16:19:47 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1DB8.dip0.t-ipconnect.de [93.219.29.184])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4DKJidl021727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 13 May 2015 16:19:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAPc5daVQEMv-QPDpyNVGzcjrjrw20QLzm8dkC0ZYAX=Y4zGaBQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqPt4Y3Cowe7dQhZdV7qZLBp6rzBb
	/GjpYbbYvLmdxeLMm0ZGB1aPBZtKPZ717mH0uHhJ2WPxAy+Pz5vkAlijuG2SEkvKgjPT8/Tt
	ErgzupZvYi44wl1xeEldA+M0zi5GTg4JAROJqZM+MUHYYhIX7q1n62Lk4hASuMwosXbDcSjn
	PJPE/22HmEGqeAW0JRp+7mAFsVkEVCXWn1vKBmKzCehKLOppBpskKhAk0XptKiNEvaDEyZlP
	WEBsEQE1iYlth1hAhjILLGGUuP1/HtggYYFIidsz/4M1CAlMZJI4tM8UxOYUCJR4emMFWJxZ
	QF3iz7xLzBC2vETz1tnMExgFZiHZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW
	6Rrq5WaW6KWmlG5ihAQ4zw7Gb+tkDjEKcDAq8fAqbAgKFWJNLCuuzD3EKMnBpCTK6z89OFSI
	Lyk/pTIjsTgjvqg0J7X4EKMEB7OSCK/NZKAcb0piZVVqUT5MSpqDRUmcV3WJup+QQHpiSWp2
	ampBahFMVoaDQ0mCN24DUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KFbji4HR
	CpLiAdqbCtLOW1yQmAsUhWg9xagoJc6bAJIQAElklObBjYWlrVeM4kBfCvNuB6niAaY8uO5X
	QIOZgAY7xgWADC5JREhJNTA6L0lYYxQo4CLkzlP+9MVM8y1rX3jwnlqgmKYswJm7uyNuE7eg
	2K3DLCy3bnmliJ6Vlls6ff3BZw2zlK+KsjarPgl5add39QA/Q34cu/KCy5/DWLfa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269006>

On 05/12/2015 05:45 PM, Junio C Hamano wrote:
> On Tue, May 12, 2015 at 1:32 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 05/11/2015 09:37 PM, Junio C Hamano wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> ...
>>>> +    test_must_fail git update-ref --stdin <input 2>output.err &&
>>>> +    grep -F "$error" output.err &&
>>>
>>> I am not 100% confident that "grep -F" is the right thing to use
>>> here.  I checked all the error message these tests are expecting and
>>> none seems to go through _(), but is it fundamental that these
>>> errors should not be translated?
>>
>> Aren't tests run in the "C" locale so that tests don't have to worry
>> about i18n?
> 
> But there is a i18n markings test, for which test-i18ngrep was invented for.

Thanks for the info. I wasn't aware of that facility.

So if I understand correctly, s/grep/test_i18ngrep/ will address your
concern? That's fine with me.

Meanwhile, I realized that verify_lock() also writes errors directly to
stderr rather than storing them to a strbuf. I have a few patches that
fix this [1], which would thematically fit well on the end of this patch
series. But maybe this patch series is too big already?

In any case I'll be away for a 4-day weekend so it will have to wait
until Monday.

Michael

[1] They are available as branch "verify-lock-strbuf-err" on

    https://github.com/mhagger/git

-- 
Michael Haggerty
mhagger@alum.mit.edu
