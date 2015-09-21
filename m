From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 5/8] branch: drop non-commit error reporting
Date: Mon, 21 Sep 2015 17:05:53 +0530
Message-ID: <CAOLa=ZTJUqu2Y1opZJmuYzvGDRNwD-3-RQ_jvLjs49sgyRpPnw@mail.gmail.com>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
 <1442772627-25421-6-git-send-email-Karthik.188@gmail.com> <vpq6134gauz.fsf@anie.imag.fr>
 <CAOLa=ZTYfNN6ATae6pYy1QHPo-u70itz9euHvaWjiayUgKD9GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 21 13:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdzVo-0003wp-PN
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 13:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621AbbIULn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 07:43:57 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33899 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472AbbIULn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 07:43:56 -0400
Received: by vkhf67 with SMTP id f67so62694867vkh.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PVyxlke9ljIRkUFa31+nf0EXbyeqH6ULWA5PHcAuxYE=;
        b=hYJdPXv7hailBp9IyWlsw95qrRlb3y67hAOlJNEHZ+gJvBnNqNsUjJPE/hpwXuCs+q
         HD4lKViuWObEsDW8UhwCJdJN7eYkHwQBHToTHXOQFnhY3Y1b6HFTTqZ1/oEECsDaqYjz
         CHS83y9ESnoSKiEidICT+7hXLtJqWmA2aziuQqgmIgJuh2DV8/59Q8JUtVxYc99PBcwl
         tANNKpzwv/Q4kCwlE/BUE7wVJDs/+kbD/wdMQ2KZS1yDZJ/kGFshIG968nPrXfu9tbRp
         EvQffdi9+bN5UmNj/FWqZvvVEAo27CHx0M0FCJLKK3iLnh0H4p0AUAerNPulbEySrUXs
         9DXA==
X-Received: by 10.31.21.149 with SMTP id 143mr12561959vkv.79.1442835383093;
 Mon, 21 Sep 2015 04:36:23 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Mon, 21 Sep 2015 04:35:53 -0700 (PDT)
In-Reply-To: <CAOLa=ZTYfNN6ATae6pYy1QHPo-u70itz9euHvaWjiayUgKD9GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278301>

On Mon, Sep 21, 2015 at 3:50 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Mon, Sep 21, 2015 at 12:46 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Remove the error reporting variable to make the code easier to port
>>> over to using ref-filter APIs. This variable
>>
>> (it's not just a variable, it's also a message on the output)
>>
>>> is not required as in ref-filter we already check for possible errors
>>> and report them.
>>
>> You should explain more why the check is redundant with the ones in
>> ref-filter. You discussed this with Junio on the last round. The
>> arguments you gave would deserve to appear in the commit message IMHO.
>> Pointing to the exact checks in ref-filter would help.
>>
>> It may make sense to split the commit into several smaller ones, so that
>> you can give a precise commit message for each error reporting you
>> remove (error(_("branch '%s' does not point at a commit") and
>> error(_("some refs could not be read"))).
>>
>
> I could do that, but it would be small changes. But I think it's worth it,
> will wait for other changes if needed and send.
>

But then again, both those are interrelated, the cb.ret value is set at
(error(_("branch '%s' does not point at a commit"), refname) and the second
error is printed on the basis that the first error set's cb.ret value.
So I find it
better to modify and commit message and leave the commits united.

-- 
Regards,
Karthik Nayak
