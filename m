From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/16] port branch.c to use ref-filter's printing options
Date: Sat, 19 Mar 2016 00:13:21 +0530
Message-ID: <CAOLa=ZS7nwqnjciN2MkaRcuhf2NwOrDDgtqKDsDUJURuP8R1=A@mail.gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com> <CA+P7+xoHy0oBGdYqhCmA3h=fv-YhDSyZV=kJyizwNnNcm37jBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 19:43:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agzNM-0005Um-WC
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 19:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845AbcCRSnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 14:43:53 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35769 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbcCRSnv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 14:43:51 -0400
Received: by mail-vk0-f52.google.com with SMTP id e6so152399557vkh.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VVIx9RkjA2GITMMOMz9vgFNCkwkjUPbP65xmRLFkmMQ=;
        b=uOADv0blDJa/jHG8jy8ZDcXXXCEFV3WCcz/+wIJdzaKx0/4zAZGTEBHYat7RF98tDP
         zU8QYdOhtju437PLqX/U3jRcBap/0qojjeaDO0s8pPe73W+jq3h8BA2VCuDaTjINsMLh
         sRxu1hp9lW2vSisMy42O5bzhu0WPk+jdBNv9nJ9FEG8LqXCA1mGd0Jp/TxKOQJJ5elUL
         /aL1XVK8zMOJ/toXoo3/krGPpngKR0kMy9Kli5H8dYMCkkoVXFxUc221levyTxsbCq4I
         gkd6D9nRNpH9+znOROWayluKLkithsdt2hQj0Zpj+sB/e1RGsSwoe4UZlS6rUmqiuxyp
         GkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VVIx9RkjA2GITMMOMz9vgFNCkwkjUPbP65xmRLFkmMQ=;
        b=GC18QMTb/Mre86HCFAMlN9r4RovQ6CCC4A6rLUSpPofrLIjy2Yz28CZ+P5BJWM90QV
         PFa9nOUGsfvVf+WftuR3QnYJD5Hhip++RvkPGC1xcqz60NKcnDkkfmDFWfTN523VF3SA
         LmzfB26lt+u/wdnmcRephRuXtEgyl5k+Ay3FTV+1+FNiZpUaS1FTpaeFZsR/1mXMFFd2
         NQHvgiD0GYn1GMfAI4ZIzqqbaB4HAKEG/EGZTZizCAxCzUR3azyR6EosPvfvY6Awct7W
         mi/QvsrAvNsGziQcAoKk/UwFoejwn7gUYhMufAW//Tc/M4pndg+XaIE4oZaxYhu6/Ror
         SySQ==
X-Gm-Message-State: AD7BkJLvhG4AUljEUF8iFCJN+BrGymnZO0RAIKlN34oRQdXU+3qWelBlvINeD+7slJ6gCAV/+ci69BBQDW+ttw==
X-Received: by 10.31.54.75 with SMTP id d72mr18356443vka.30.1458326630909;
 Fri, 18 Mar 2016 11:43:50 -0700 (PDT)
Received: by 10.103.112.68 with HTTP; Fri, 18 Mar 2016 11:43:21 -0700 (PDT)
In-Reply-To: <CA+P7+xoHy0oBGdYqhCmA3h=fv-YhDSyZV=kJyizwNnNcm37jBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289242>

Hello,

On Wed, Mar 16, 2016 at 3:30 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Mar 15, 2016 at 9:47 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index 193e99e..578bbd1 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -116,10 +116,12 @@ upstream::
>>         `refname` above.  Additionally respects `:track` to show
>>         "[ahead N, behind M]" and `:trackshort` to show the terse
>>         version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
>> -       or "=" (in sync).  Append `:track,nobracket` to show tracking
>> -       information without brackets (i.e "ahead N, behind M").  Has
>> -       no effect if the ref does not have tracking information
>> -       associated with it.
>> +       or "=" (in sync).  Has no effect if the ref does not have
>> +       tracking information associated with it. `:track` also prints
>> +       "[gone]" whenever unknown upstream ref is encountered. Append
>> +       `:track,nobracket` to show tracking information without
>> +       brackets (i.e "ahead N, behind M").  Has no effect if the ref
>> +       does not have tracking information associated with it.
>>
>
> It looks like you duplicated "Has no effect if the ref does not have
> tracking information associated with it"

Will fix that, thanks.

-- 
Regards,
Karthik Nayak
