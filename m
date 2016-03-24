From: work <motroniii@gmail.com>
Subject: Re: [PATCH 1/2] Modified flag field type in rev_list_info struct in
 bisect.h. There is no need for flag field to be signed, as it is not supposed
 to be used as decimal.
Date: Thu, 24 Mar 2016 23:01:12 +0300
Message-ID: <56F44788.2050509@gmail.com>
References: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
 <1458848469-12663-2-git-send-email-motroniii@gmail.com>
 <CAGZ79kZmzo+f9YF1K1oC2GfOrzdaojmrca7bUm3cBRoDreeA-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 21:01:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajBRY-0000P3-QR
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 21:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbcCXUBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 16:01:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34743 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbcCXUBP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 16:01:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id i75so4677079lfb.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=K4ng+yE5J1arTiDhEkUV/e/JD7l2hF/PF3Vf6ixkOzg=;
        b=oABOx/06+fipsTAHKa17A1/gHK57MU91EV5Ab3QPD/ezI8GYQbsEINX5tu5ftrny5j
         w2bHMIWi2Mu4IKqXgyAlj+P5L6pPUem2qklsVQx7A4FaeXDnR3H0yjDuJWKpxPene1cg
         SIJW1tQz7uTZ8eUWHyZ153xYvyNMl82JqqvNHR+rD9xCs4qf9p9UBzdDkWwRI64N74Wp
         fCeRbJ5C0ai6/UdNjFcqSBbkeGy1siTIzLT/vM/FZPBHeY8ToNPQiFVQV4+lOHau9N6Z
         B0Ex95sIGbeJGDmE0qmDPpJXqj3sg7t3CZdR7FEjDCvJz0nWmr5wLSv9bc88mnzqc9Ja
         xccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=K4ng+yE5J1arTiDhEkUV/e/JD7l2hF/PF3Vf6ixkOzg=;
        b=AvJhzZ0ykUxJKaf924Qz1KNGvkzuNqJM+xVA9Li7Dsjr63IorRyNLHRvwnJczadF4G
         mauupmk3gTMNG1P735E89yXdyw4JGi+UoMOQQW6rROjQ1EGuIKBBsS7troywG7kgyOvU
         ZBQVrwFB7lQOpX51RxDpXbXrcVZNtQGTNu/qpOFgEBwuXxa2k2pzfGYrHS4hc+7bzsx4
         JB0Bo7CCVWg88UZlp2bj4wIQnQMYlHxTgo3XSIGRwPV5LLnJ3Dy66pXWfr5qwjzZAweN
         gKh3LM0YTxHnD66Ov/pOkrubHIUo10Qly45fpuErfK44fjRSZevHrSX7PIkps5M9cEvP
         ZMMw==
X-Gm-Message-State: AD7BkJJherI329an8yDmd8E5LHxi63LL9uBAG5xOnw/jpp3GeTadvTXrADQ98MFvhoDw/w==
X-Received: by 10.25.148.208 with SMTP id w199mr4363271lfd.124.1458849674211;
        Thu, 24 Mar 2016 13:01:14 -0700 (PDT)
Received: from [172.16.163.135] (ppp91-76-147-218.pppoe.mtu-net.ru. [91.76.147.218])
        by smtp.gmail.com with ESMTPSA id m22sm1405775lfi.18.2016.03.24.13.01.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 13:01:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <CAGZ79kZmzo+f9YF1K1oC2GfOrzdaojmrca7bUm3cBRoDreeA-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289792>

On 03/24/2016 10:51 PM, Stefan Beller wrote:
> On Thu, Mar 24, 2016 at 12:41 PM, Motroni Igor <motroniii@gmail.com> wrote:
>> From: Pontifik <motroniii@gmail.com>
> Here is a good place to put reasoning for why this is a good idea.
> I see you have a long subject, so maybe we can shorten the first line
> (down to less than ~ 80 characters) and put the longer explanation
> here.
>
> How about:
>
>    bisect: use unsigned for flag field
>
>    The flags are usually used as a unsigned variable, because it makes
>    bit operations easier to follow.
Yep, it's definitely a good idea to shorten subject in order to put more 
explanations in body of a message.
>
>
>> Signed-off-by: Pontifik <motroniii@gmail.com>
>  From Documentation/SubmittingPatches:
>> Also notice that a real name is used in the Signed-off-by: line. Please
>> don't hide your real name.
Yep, I didn't mean to hide my real name, but coming across lots of new 
stuff confused me in distinguishing whether I'm asked to enter real name 
or nickname :)
>> ---
>>   bisect.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bisect.h b/bisect.h
>> index acd12ef..a979a7f 100644
>> --- a/bisect.h
>> +++ b/bisect.h
>> @@ -16,7 +16,7 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
>>
>>   struct rev_list_info {
>>          struct rev_info *revs;
>> -       int flags;
>> +       unsigned int flags;
> You can also drop the int here and make it just
> unsigned.
In fact, I just wanted to keep this code clear to understand (as I see 
this). Unsigned short is also unsigned, but a reader should know that 
"unsigned" type stands for "unsigned int". Anyway, I'll keep this in 
mind in future, thanks a lot.
>>          int show_timestamp;
>>          int hdr_termination;
>>          const char *header_prefix;
>> --
>> 2.5.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
