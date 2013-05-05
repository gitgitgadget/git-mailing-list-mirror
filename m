From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] remote-bzr: couple of fixes
Date: Sun, 5 May 2013 15:24:48 -0500
Message-ID: <CAMP44s3JtLzE0vne5VH+bHrLvSuOwaWwuGa7DFggjEOt6ixgTA@mail.gmail.com>
References: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
	<7vd2t5uvi2.fsf@alter.siamese.dyndns.org>
	<CAMP44s1D7LOhDGkZguosPiXyuJ5cP2hmgq4AWagwadrJYK1Pgg@mail.gmail.com>
	<7v4nehuu3o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 05 22:25:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ5Ub-0004gC-Is
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 22:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088Ab3EEUYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 16:24:51 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:34853 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3EEUYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 16:24:50 -0400
Received: by mail-we0-f181.google.com with SMTP id x8so2469716wey.26
        for <git@vger.kernel.org>; Sun, 05 May 2013 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0/QdDQ7hh21jYIOQpmwqbvyQA5hfcDD0yufNww1KnkQ=;
        b=Q35+Rr/qT9HcwXA7spYULCB3c6FJE5EyR1ujVD6Z/lfo4xgv8KDf7MmWLbTF4peJdi
         bN4rTFU3bD47o2BEj7r7B+tZP7CLO3wa/TdDaiGukFlimzA4jQ9h5tvPxDrI+J4/aVUS
         LvZp951OM1rsN3cgcfWSsVLsvas/aBGU1mFNV29wJMJ4piVPCDb7GBud/EUaa5BehHmm
         0MUPdEkTuTTtpt9njsWvn70D4R716BjBctbwz2aicL3g5rXqmeh10fVIDMYQ/s0ZNhQq
         sYh5F/DPtuAM+crR4SRFzFWkcusRQh/ZwbjtmhzFZiuLAUC4ALOTLGCTIIZGFb2LjprC
         /erQ==
X-Received: by 10.180.88.231 with SMTP id bj7mr5734589wib.5.1367785488589;
 Sun, 05 May 2013 13:24:48 -0700 (PDT)
Received: by 10.194.240.135 with HTTP; Sun, 5 May 2013 13:24:48 -0700 (PDT)
In-Reply-To: <7v4nehuu3o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223416>

On Sun, May 5, 2013 at 2:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, May 5, 2013 at 1:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> The previous version had an indentation bug (did I mention I hate python?).
>>>>
>>>> A few fixes to be applied on top of the massive changes already queued. Nothing
>>>> major.
>>>
>>> [2/2] may not matter much in the context of my tree (people would
>>> use post 1.8.2 fast-export if they are using remote-bzr from 1.8.3
>>> from my tree ;-),
>>
>> Maybe, but if even if they have the latest git, pushing a tag will
>> fail miserably, and with the patch it would fail nicely :)
>>
>>> but [1/2] sounds like it is a good thing to have
>>> in 1.8.3 (not "on top of that 'massive' series").
>>>
>>> Assuming the "otherwise some version of bzr might barf" problem is
>>> that repo.generate_revision_history() in those versions may not
>>> apply str() to its first parameter and the caller is expected to
>>> pass a string there, or something?
>>
>> No, there's no change to repo.generate_revision_history(), because we
>> already convert the elements of the array to strings, it's the other
>> callers of Marks::to_rev() that see a change, namely code that pushes
>> to a remote, I think.
>>
>> And BTW, they are already strings, but unicode strings, because they
>> come from a json file, somehow bazaar doesn't like that, but it works
>> fine in my machine without the patch. Shrugs.
>>
>> Also, the emacs developers seem to be fine with all these changes,
>> there's only one patch pending that I need to cleanup.
>
> So do you want to queue these on top of the "massive" in 'next', not
> directly on 'master'?

If they apply on master, master. But I'm confused, are the massive
changes not going to graduate to master? Because if not, I should
cherry-pick the safest changes, as there's a lot of good stuff there.

-- 
Felipe Contreras
