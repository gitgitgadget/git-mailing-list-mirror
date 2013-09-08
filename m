From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] sequencer: trivial cleanup
Date: Mon, 9 Sep 2013 04:27:43 +0530
Message-ID: <CALkWK0mx6dc0=YAwCPKSrCFqCAytOQXhSv36k1S_59sFr_bBWw@mail.gmail.com>
References: <1378680160-4720-1-git-send-email-artagnon@gmail.com> <CAMP44s1fE0XZScL_gU5JAEdC0hPFHPTovqXLx7gqvwVdZbBaVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 00:58:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VInw3-0008RV-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 00:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985Ab3IHW6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 18:58:24 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44364 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab3IHW6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 18:58:23 -0400
Received: by mail-ie0-f174.google.com with SMTP id k10so2838029iea.19
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mtiRrNjCXaKKI+Umtnq8h6sSArK8t/NI9NW8Q1xVUJo=;
        b=DDmipncPc7iDvLetSaJZh0+BWwT59v17sLvouuTXb24DRmQXHOHP6svmIXriBFoP+A
         xnymFyOsKzVsRhih8gxaMS6kk0H6eBwCGd0mhaRbgLrNRjoGfjeSP69BE6Pr/x6QDnyj
         Fw3nJV5T+ziw8hf/ZWwyIVs0nbSUYzmuWZZX26rcIdBJ7+tJDCnZaU7Jpb8yFqdqiSfX
         PeP7a28H/tdWa0YRa+P7Y80YyuY7iP+P8XufcbYN3fIfMjKX1X6Sgsbt+7ptLj3BlRwn
         pExfTtdnNZ+5Ix4whEfb8q5f01YiZ8nQWdYg6pDTnfcEfnH0ihMs4Mm9e6uNPtwP1o/t
         rqvA==
X-Received: by 10.43.143.133 with SMTP id jm5mr8052183icc.25.1378681103075;
 Sun, 08 Sep 2013 15:58:23 -0700 (PDT)
Received: by 10.64.73.5 with HTTP; Sun, 8 Sep 2013 15:57:43 -0700 (PDT)
In-Reply-To: <CAMP44s1fE0XZScL_gU5JAEdC0hPFHPTovqXLx7gqvwVdZbBaVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234279>

Felipe Contreras wrote:
>>  sequencer.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 351548f..8ed9f98 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -466,10 +466,7 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
>>         empty_commit = is_original_commit_empty(commit);
>>         if (empty_commit < 0)
>>                 return empty_commit;
>> -       if (!empty_commit)
>> -               return 0;
>> -       else
>> -               return 1;
>> +       return empty_commit ? 0 : 1;
>>  }
>
> Isn't it the other way around? Moreover, 'return !!empty_commit;'
> would be simpler.

Yeah, thanks for pointing out this grave stupidity. This seems to be
inconsequential as far as the tests are concerned: have to do some
major yak shaving.
