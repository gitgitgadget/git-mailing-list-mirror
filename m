From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] cat-file: Remove unused includes
Date: Fri, 9 Jan 2015 14:21:30 +0600
Message-ID: <CANCZXo4=TydW=DH9pU4aTOCZRgMnZr1inhmwNPUaDQZMMYt4Ww@mail.gmail.com>
References: <1420743366-14926-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq1tn5f441.fsf@gitster.dls.corp.google.com>
	<CANCZXo7_yUT4x5fBvwNdc7d+ew5M7yaayGE_yXaeLxiPHzK9GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 09:23:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Up5-0003SA-PZ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 09:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004AbbAIIVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 03:21:31 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36518 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658AbbAIIVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 03:21:30 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so12101522obc.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 00:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Gmu3R1ryP+lhNiXgtelOgt3dMfZpIZfXD3MzvDoQOsE=;
        b=XL+amLRoyqd09O8peug8Y7q8hV5iWuTeeRTQwu9mtFmQRlpZWJUgne/9qrU2PxvJJA
         5jhI3cMLCbeSmq8BJVdKxjsRok6Pb5/VcDUPTeOB67L1CMJ/vcxJ8fxEnQDtgIH985Sy
         5XvNm3HF0fvzUERfPtp47KM8qEKiHaYUXEjAsN3QQP8gGTudyGtEr3Te4u7cCPlilUQJ
         gcTAOkJaBg3mawTQuGiyF78KaeVNXehOMwGH4hgyxefQ9Y3XeGRmEOli34d+xs+AY1Id
         5ACqSTSavsNM4HN3+dpK8ympiVaYWonkLRqfj6Iv+p/Apb8ULMMzJOT2RrdqqTQXuAec
         8UKQ==
X-Received: by 10.202.226.70 with SMTP id z67mr8049389oig.95.1420791690374;
 Fri, 09 Jan 2015 00:21:30 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Fri, 9 Jan 2015 00:21:30 -0800 (PST)
In-Reply-To: <CANCZXo7_yUT4x5fBvwNdc7d+ew5M7yaayGE_yXaeLxiPHzK9GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262232>

userdiff.h used in git_cat_file_config for getting textconv driver

2015-01-09 2:21 GMT+06:00 Alexander Kuleshov <kuleshovmail@gmail.com>:
> Will research this question and resend the patch.
>
> Thank you.
>
> 2015-01-09 1:45 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
>> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>>
>>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>>> ---
>>>  builtin/cat-file.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>>> index f8d8129..750b5a2 100644
>>> --- a/builtin/cat-file.c
>>> +++ b/builtin/cat-file.c
>>> @@ -4,12 +4,8 @@
>>>   * Copyright (C) Linus Torvalds, 2005
>>>   */
>>>  #include "cache.h"
>>> -#include "exec_cmd.h"
>>> -#include "tag.h"
>>> -#include "tree.h"
>>>  #include "builtin.h"
>>>  #include "parse-options.h"
>>> -#include "diff.h"
>>>  #include "userdiff.h"
>>>  #include "streaming.h"
>>
>> Interesting.
>>
>>  - "exec_cmd.h" became unnecessary at b931aa5a (Call builtin ls-tree
>>    in git-cat-file -p, 2006-05-26).
>>
>>  - "tag.h" and "tree.h" became unnecessary at 21666f1a (convert
>>    object type handling from a string to a number, 2007-02-26).
>>
>>  - "diff.h" was added at e5fba602 (textconv: support for cat_file,
>>    2010-06-15), together with "userdiff.h".  Was it unnecessary from
>>    the beginning?
>>
>> I didn't dig further to find out the answer to the last question,
>> but a patch to remove these include should explain these in its log
>> message, I would think.
>>
>> Thanks.
>>
>>
>
>
>
> --
> _________________________
> 0xAX



-- 
_________________________
0xAX
