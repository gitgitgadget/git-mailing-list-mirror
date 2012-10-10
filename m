From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] MALLOC_CHECK: Allow checking to be disabled from config.mak
Date: Wed, 10 Oct 2012 20:38:36 +0200
Message-ID: <CA+EOSBkpWhYbJKxT-JZ1FkLp8mctVcqKmvAEN0aKvC_Ni3Pf6Q@mail.gmail.com>
References: <50706B54.8090004@ramsay1.demon.co.uk>
	<7vbogfquc8.fsf@alter.siamese.dyndns.org>
	<5075B47C.6030607@ramsay1.demon.co.uk>
	<CA+EOSB=NQTsSCs-EJF80h2L+xMULcu_HbaW+mc=yr-3u2hEKbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 20:38:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM1BA-00068O-O7
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 20:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756587Ab2JJSii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 14:38:38 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54597 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756464Ab2JJSih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 14:38:37 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1495762iea.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=QUXQYGi/uwbY52B1doXH9syEnYMsLjbUlkl8LrTzjhI=;
        b=WgOJvLzlwbh0Fq51wB3XKhmJq/2bgMotlOfDuegS+lB4pA9IBoM43hBOdl3x898gXk
         z1O5m0RJFlbct1cjxo7jexnWT3y2LeyfhTmJWfbCjQkqH+BrrO2Rg+38TkK3JD+JsXqL
         /w3kUghF0jr2B2rvkWbYjkgLSotVfzYv/+tkqoLgDbjvTdqfN06fQNyJT72jL5UPDR7c
         RFPXVruQZHXBldMZuhVNpwtQS91dLF7LN39/eas9hRpvgb/IOVwuwp2T9K6iO0cHN/2g
         1hEkX1HyalWgmt7ndnfkCpGq9CwCK/E7uiefPhEzH4Vk5ONMFJu/jEwSijQr0qNEjGre
         ZSUQ==
Received: by 10.50.209.71 with SMTP id mk7mr6288496igc.34.1349894316983; Wed,
 10 Oct 2012 11:38:36 -0700 (PDT)
Received: by 10.64.58.135 with HTTP; Wed, 10 Oct 2012 11:38:36 -0700 (PDT)
In-Reply-To: <CA+EOSB=NQTsSCs-EJF80h2L+xMULcu_HbaW+mc=yr-3u2hEKbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207424>

No reboot.  lsb-release -a from memory or something similar, always on travel...

Regards

2012/10/10, Elia Pinto <gitter.spiros@gmail.com>:
> Hemm, too old release distro , no ? 4-5 year ago. It is time to
> upgrade to something more recent , 5.7 5.8 . Rhel5.3 is not a good
> distro for a developer isn't it ?
>
> 2012/10/10, Ramsay Jones <ramsay@ramsay1.demon.co.uk>:
>> Junio C Hamano wrote:
>>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>>
>>>> The malloc checks can be disabled using the TEST_NO_MALLOC_CHECK
>>>> variable, either from the environment or command line of an
>>>> 'make test' invocation. In order to allow the malloc checks to be
>>>> disabled from the 'config.mak' file, we add TEST_NO_MALLOC_CHECK
>>>> to the environment using an export directive.
>>>
>>> We would want to encourage people to test with cheap but effective
>>> checks when available.  I do not see "malloc: using debugging hooks"
>>> message anywhere when I run tests, but if you do, I'd rather see us
>>> check if we can tell glibc to stop doing so first without disabling
>>> the whole test.  Your patch feels like the first step to a slipperly
>>> slope whose destination would make us say "we get too many messages
>>> so let's do nothing in "make test" with this configuration." when
>>> taken to the extreme, and obviously we would not want to go there
>>> ;-).
>>
>> [sorry for the late reply, I've been away ...]
>>
>> Yes, but ... I really don't see that this patch would encourage anyone
>> to skip the malloc checks, who wasn't going to anyway! I didn't notice
>> much of an increase in the running time of the tests, so that wouldn't
>> discourage me. This idiotic message spewage is a different issue.
>> (the complete loss of terminal scroll-back is particularly annoying)
>>
>> I had intended to run the tests with malloc checks enabled before
>> submitting patches, testing -rc* builds etc., but have them disabled
>> for day-to-day programming.
>>
>>> Besides, doesn't a simple instruction to export TEST_NO_MALLOC_CHECK
>>> to your environment before running "make test" suffice?
>>
>> Yes, so I can simply disable the malloc checks in my ~/.bashrc file.
>> However, it would be disappointing to have my config tweeks in two
>> places ... :(
>>
>> I guess I can live with it ...
>>
>> ATB,
>> Ramsay Jones
>>
>>
>>
>>
>
> --
> Inviato dal mio dispositivo mobile
>

-- 
Inviato dal mio dispositivo mobile
