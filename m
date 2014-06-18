From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v18 16/48] refs.c: add an err argument to delete_ref_loose
Date: Wed, 18 Jun 2014 15:27:12 -0700
Message-ID: <CAL=YDWnbKTysV=OaDuxOz10=QbpSWkzmoYteSeq_-Fv=HtcOSQ@mail.gmail.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
	<1403020442-31049-17-git-send-email-sahlberg@google.com>
	<53A1FAF8.4050700@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:27:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxOK7-0003lg-2x
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 00:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbaFRW1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 18:27:15 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:37268 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaFRW1O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 18:27:14 -0400
Received: by mail-ve0-f177.google.com with SMTP id i13so1512956veh.8
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 15:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8OdqTiMGySqPJHd62clYmavbYDOTRMwxKH/jvwafH9Q=;
        b=lbK2QJJItjpnibWf3pLIa4/DiNXVLmrkJHU73wdrUViSrOuHi3+XmtN8ukb7DpJVEV
         y2c4i6aIV93sQnzkedqtRPVkdqIrnDwdoYgPQCt81NA8661yTwDYzId6PhMg3tfcTKov
         tlweYNIR9ISwD4BfqG36Aaf+MAn/BxrAKNNiABJyGLUwbsoITKvfpildOo2+fPhyzCEj
         T+LqUUXEn2KnAGp81OYJ5VeYfRXnB8xlHKkcfRkYEhalN2/wHWS0q3rx08NcWli7fJ7n
         oADPcnM9s0YKkW2q3qaVVuWFO7Y/9JvLcWYOJQxhL74lQc6dGWoLRbS/Xt3iGfZpYbv9
         eqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8OdqTiMGySqPJHd62clYmavbYDOTRMwxKH/jvwafH9Q=;
        b=DVZg/VKPFlpyTBieXTeM/J76l3iPQ47uWJ7k8cuMhnupKRmnAdbb4pMeNLasItX2J3
         AfO4wTSj0hdtr+gyBl5PRbSkVvGhT7giUSD//cpvwBQ5pId1lW+LGhyu1WwEsxn/DaIp
         M7jt0rLzQz30RDEnb+czscQEJ9u/n0m7zZnIQGMUW/HLtAmzEL+35CXPyT1Shas23Jpu
         vvxyHB+Bp/CIaMbGd3ABJu/wN2vB2DZyCGOzMJ6lcUAb9BtAKSuDFxCEWFl/kjaLHYHh
         kEddyOmdM8TFTssuN9TqI3K3VySBBzPBGK8jgwm4/1pZffFO6z+S0+RiMKJpyo9/Af1d
         mdpQ==
X-Gm-Message-State: ALoCoQkjChClxVOh5YbBQxhX1oJ+B+/VvcwlGLk6K45lMuEssvzavywxY50zlYzruZavspICq65k
X-Received: by 10.220.249.6 with SMTP id mi6mr484975vcb.33.1403130432447; Wed,
 18 Jun 2014 15:27:12 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Wed, 18 Jun 2014 15:27:12 -0700 (PDT)
In-Reply-To: <53A1FAF8.4050700@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252076>

It looks like we need to reorder two of the patches.
This patch needs to be moved to later in the series and happen after
the delete_ref conversion :

refs.c: make delete_ref use a transaction
refs.c: add an err argument to delete_ref_loose

I will respin a v19 with these patches reordered.


Thanks,
ronine sahlberg


On Wed, Jun 18, 2014 at 1:47 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/17/2014 05:53 PM, Ronnie Sahlberg wrote:
>> Add an err argument to delete_loose_ref so that we can pass a descriptive
>> error string back to the caller. Pass the err argument from transaction
>> commit to this function so that transaction users will have a nice error
>> string if the transaction failed due to delete_loose_ref.
>>
>> Add a new function unlink_or_err that we can call from delete_ref_loose. This
>> function is similar to unlink_or_warn except that we can pass it an err
>> argument. If err is non-NULL the function will populate err instead of
>> printing a warning().
>>
>> Simplify warn_if_unremovable.
>> [...]
>
> I'm getting test failures starting with this commit:
>
>> Test Summary Report
>> -------------------
>> t5514-fetch-multiple.sh                          (Wstat: 256 Tests: 11 Failed: 3)
>>   Failed tests:  6, 8-9
>>   Non-zero exit status: 1
>> t6050-replace.sh                                 (Wstat: 256 Tests: 28 Failed: 1)
>>   Failed test:  15
>>   Non-zero exit status: 1
>> t1400-update-ref.sh                              (Wstat: 256 Tests: 133 Failed: 4)
>>   Failed tests:  86-87, 130-131
>>   Non-zero exit status: 1
>> t5540-http-push-webdav.sh                        (Wstat: 256 Tests: 19 Failed: 2)
>>   Failed tests:  8-9
>>   Non-zero exit status: 1
>> t5505-remote.sh                                  (Wstat: 256 Tests: 76 Failed: 5)
>>   Failed tests:  11, 45-48
>>   Non-zero exit status: 1
>> t9903-bash-prompt.sh                             (Wstat: 256 Tests: 51 Failed: 1)
>>   Failed test:  19
>>   Non-zero exit status: 1
>> t9300-fast-import.sh                             (Wstat: 256 Tests: 170 Failed: 1)
>>   Failed test:  71
>>   Non-zero exit status: 1
>> t6030-bisect-porcelain.sh                        (Wstat: 256 Tests: 55 Failed: 47)
>>   Failed tests:  2-5, 7-11, 13-14, 16-30, 32-34, 36-37, 39-44
>>                 46-55
>>   Non-zero exit status: 1
>> t7512-status-help.sh                             (Wstat: 256 Tests: 35 Failed: 1)
>>   Failed test:  27
>>   Non-zero exit status: 1
>> t5516-fetch-push.sh                              (Wstat: 256 Tests: 80 Failed: 3)
>>   Failed tests:  47-49
>>   Non-zero exit status: 1
>
> Let me know if you need more information.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
