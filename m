From: Akshay Aurora <akshayaurora2008@gmail.com>
Subject: Re: [PATCH][GSoC] revision: forbid --graph and --no-walk usage
Date: Sat, 7 Mar 2015 02:27:40 +0530
Message-ID: <CAPGnZZ=B4kX2Cbfa4RmjnQToWcBb6nc3AUgvU2rSY4tbW08MKw@mail.gmail.com>
References: <1425618810-21192-1-git-send-email-akshayaurora@yahoo.com>
	<xmqqtwxyyo5u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 21:57:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTzJa-0003dV-JU
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 21:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbbCFU5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 15:57:42 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34263 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbCFU5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 15:57:41 -0500
Received: by wgha1 with SMTP id a1so11853687wgh.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 12:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fN1NsNub2JJA+sqrFo69XQzJpWSuJQPQI04iTZ9vQSY=;
        b=ODnCaeaOWRK81OxOYT1Hyj03E39pV0QbVNpg75LivL2iolTZYc7Fy4nP8654TE3TZ2
         jFMNlhAqMW6yquKiPVDx6Lph0lp2ByyasE5FICX/61/s2qYIGROdWODOM1Wp7nbEuutv
         ZMxM+uKG2d3TzdhMoKEqnBlWkoda8hzTmjuP38n+OdAtIqFy3TvIuXX8ipUErsTu4tYC
         clHjrhcNoLk4pvEMF9zmBbsUDKyQQTy3Kpo4aAHIDz3OSpxaHS2LMQJxvEGytERnEszw
         NNhPfZ99aD05y0s2jqiTZ2erJlklarN4WxFWCx13qgcIDi2uhvEBebeNgv6D6/EjGI6N
         5c3Q==
X-Received: by 10.180.75.233 with SMTP id f9mr7940468wiw.5.1425675460189; Fri,
 06 Mar 2015 12:57:40 -0800 (PST)
Received: by 10.27.45.1 with HTTP; Fri, 6 Mar 2015 12:57:40 -0800 (PST)
In-Reply-To: <xmqqtwxyyo5u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264961>

Thanks Junio. Working on v2 for this patch.

On Sat, Mar 7, 2015 at 12:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Akshay Aurora <akshayaurora@yahoo.com> writes:
>
>> Signed-off-by: Akshay Aurora <akshayaurora@yahoo.com>
>> ---
>> This is my first patch for a GSoC Microproject, would be great to have your feedback.
>>
>>  revision.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/revision.c b/revision.c
>> index bd027bc..d578652 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2248,7 +2248,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>>        */
>>       if (revs->reverse && revs->graph)
>>               die("cannot combine --reverse with --graph");
>> -
>> +     if (revs->no_walk && revs->graph)
>> +             die("cannot combine --no-walk with --graph");
>>       if (revs->reflog_info && revs->graph)
>>               die("cannot combine --walk-reflogs with --graph");
>>       if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
>
> Needs a new test to make sure "log --no-walk --graph" is rejected,
> and also you need to make sure all other existing tests that used to
> pass before this change still pass.
>



-- 
- Akshay Aurora
