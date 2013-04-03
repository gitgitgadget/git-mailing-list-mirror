From: =?UTF-8?Q?Mihai_Capot=C4=83?= <mihai@mihaic.ro>
Subject: Re: [PATCH] count-objects: output "KiB" instead of "kilobytes"
Date: Wed, 3 Apr 2013 08:27:55 +0200
Message-ID: <CADyhzG1srEqiDdo8bAB+Hw=DaRB2vkwOoCHzYtpiuUiZHEo4LQ@mail.gmail.com>
References: <1364903010-644-1-git-send-email-mihai@mihaic.ro>
	<7vip44a8xl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 08:28:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNHBJ-0003lK-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 08:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762790Ab3DCG15 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 02:27:57 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:61276 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762135Ab3DCG14 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 02:27:56 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so959864iag.41
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 23:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=OxZKKQ1icDaTLorXfCRZIlk5zJl0tIXqXGeJviP5v4Q=;
        b=jg8E1au7cLeEPtlrNpJ7LaG5ElKgJ/AEyjKyNo0iC3magzULLpC1z25oWIRge15JYQ
         acQO0iC3lNk4BB7rK6fTV+KdIDwJlDWNQnwDJZuYxm16ZkfUtMlbeMcl7B156+3c1itm
         04uhlW1EZzl30DIdDQFse6YzGlMOL6uLzLIW70sblgpbHbjj4ZLmjKusqB4TBJsfGCjX
         eDWbv34HF++oVxJMkbzaePpzUIMvT9FlWGBF+gpSyRDYboPcsazoh9d7CRPerrOj5RU9
         jOpiuOXO67DvaEtXxugo6Tua7FM+j4tBHUjxkulu1cEsX8CXnpISYGxj7odaIA+wwrvC
         /VTQ==
X-Received: by 10.43.4.74 with SMTP id ob10mr219137icb.28.1364970476008; Tue,
 02 Apr 2013 23:27:56 -0700 (PDT)
Received: by 10.64.7.75 with HTTP; Tue, 2 Apr 2013 23:27:55 -0700 (PDT)
In-Reply-To: <7vip44a8xl.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlNjibNLYnH+TETDeAvNSwV2fPEu6fjyWscPJQZ7XUicHEhBAKIl4keFtgnfsYzeeoXuRZd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219920>

I'm really sorry about that. I'll make sure to run the tests before
sending patches in the future.

On Wed, Apr 3, 2013 at 12:01 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Mihai Capot=C4=83 <mihai@mihaic.ro> writes:
>
>> The code uses division by 1024. Also, the manual uses "KiB".
>>
>> Signed-off-by: Mihai Capot=C4=83 <mihai@mihaic.ro>
>> ---
>>  builtin/count-objects.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
>> index 9afaa88..ecc13b0 100644
>> --- a/builtin/count-objects.c
>> +++ b/builtin/count-objects.c
>> @@ -124,7 +124,7 @@ int cmd_count_objects(int argc, const char **arg=
v, const char *prefix)
>>               printf("garbage: %lu\n", garbage);
>>       }
>>       else
>> -             printf("%lu objects, %lu kilobytes\n",
>> +             printf("%lu objects, %lu KiB\n",
>>                      loose, (unsigned long) (loose_size / 1024));
>>       return 0;
>>  }
>
> This breaks existing tests (5301, 7408 and 5700); I noticed it too
> late and wasted 20 minutes, having to re-run today's integration
> cycle.
>
> Next time, please run the testsuite before sending a patch.
