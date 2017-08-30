Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3840220285
	for <e@80x24.org>; Wed, 30 Aug 2017 14:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdH3OPH (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 10:15:07 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35536 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdH3OPF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 10:15:05 -0400
Received: by mail-io0-f172.google.com with SMTP id k22so5459295iod.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aWgolOBWQtftUEE90pYwwOdfXWSu7ghYum6KST4zKbo=;
        b=k7cIsHh4Ol1yYtfvXLkNSpVGKLwsKSeZfEpP5gGdkws/dswb3rtCTCObuxeza/OvWy
         dTjLT868Iecq+uxbSj59wS5347Db1d6ekdigL8llpbm+/37K3n2QUM+D5LU/EGyYWsi5
         hJai66dOExElJjmyASvRnshIudbzBu97tDfZrJ+qyTVFAvJ20Cr+cOz8olBFjhAzBB7I
         Ax9exE3MkUDlJNOsvAXttHxtVqjXw3AlHTuXrhhlmpfFVw5IMQ/wVZe4n74mmiwAyd1o
         Nc2b4D5R+JIqecCn54pTahHAnZyf4SBwI5ub6YhyacfNeK2sMXrK6Q90bFHldf2WX0JY
         RDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aWgolOBWQtftUEE90pYwwOdfXWSu7ghYum6KST4zKbo=;
        b=OgLTjenWPQUNqcgK0nbKZte5jsZnFboPG5eMrRDU6HbZnmFQYQ/TL29NOGxUF1ONvt
         vF4gZ1XysPfmmH7ebsi0kljIVhEYGdwujZXy4C+LeJV9r/85wwc5iTp1SqBZvmYIjjyj
         2NGCpN0r3zR3Kw2rQgBEKR7lNjpfHy2Hy7jTL5QrgumZEwObjjkai8L9WgLEJ1nwNSeO
         UVaYJxYNtnLMGXUa5uGfY1iQpdZ/Hy4DVZ3cYwiOBFw0peKrVggb61mkt3d+/08p/UOJ
         CrdgAS36Ew2cGBh65TVWrJ1klg1ooBXnHIjeadlVEpuaUX6Yhu//y3Tfrty8vvlzQEfL
         Q6BQ==
X-Gm-Message-State: AHPjjUhIU7rCE8nXRtIX0y74oJWJtJ4JafFac9E0OXHQ8vZPIeqpIZ95
        4bAcrXMra+K18jkgak6Zx5z08eD/a8UT
X-Google-Smtp-Source: ADKCNb69ioXq8T1nEJ6owzGks3NkFPv9mzSTbvf0unE0sC8A3/rTr+pJL753hfIADKvcnZkMBp4ieJroA1yoaNr+/OM=
X-Received: by 10.107.39.8 with SMTP id n8mr1678872ion.97.1504102504937; Wed,
 30 Aug 2017 07:15:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.115.202 with HTTP; Wed, 30 Aug 2017 07:15:04 -0700 (PDT)
In-Reply-To: <dc9b7aed-c781-d0fc-688f-32d665ad61ab@gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-36-chriscool@tuxfamily.org> <e15513eb-aed9-8bd3-794d-009a91c1d20e@gmail.com>
 <CAP8UFD2VFsJWyP1TWLS15wYz2vQxHd4hG5Bdbo9-B45Q-onG2w@mail.gmail.com> <dc9b7aed-c781-d0fc-688f-32d665ad61ab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 30 Aug 2017 16:15:04 +0200
Message-ID: <CAP8UFD3+4mtmfVB47CsbVzmOMGK-WR4GYzXu6MfvOdGwrqx9=g@mail.gmail.com>
Subject: Re: [PATCH v5 35/40] Add Documentation/technical/external-odb.txt
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 2:50 PM, Ben Peart <peartben@gmail.com> wrote:
>
>
> On 8/29/2017 11:43 AM, Christian Couder wrote:
>>
>> On Mon, Aug 28, 2017 at 8:59 PM, Ben Peart <peartben@gmail.com> wrote:
>>>
>>>
>>> On 8/3/2017 5:19 AM, Christian Couder wrote:
>>>>
>>>>
>>>> +Helpers
>>>> +=======
>>>> +
>>>> +ODB helpers are commands that have to be registered using either the
>>>> +"odb.<odbname>.subprocessCommand" or the "odb.<odbname>.scriptCommand"
>>>> +config variables.
>>>> +
>>>> +Registering such a command tells Git that an external odb called
>>>> +<odbname> exists and that the registered command should be used to
>>>> +communicate with it.
>>>
>>>
>>> What order are the odb handlers called? Are they called before or after
>>> the
>>> regular object store code for loose, pack and alternates?  Is the order
>>> configurable?
>>
>>
>> For get_*_object instructions the regular code is called before the odb
>> helpers.
>> (So the odb helper code is at the end of stat_sha1_file() and of
>> open_sha1_file() in sha1_file.c.)
>>
>> For put_*_object instructions the regular code is called after the odb
>> helpers.
>> (So the odb helper code is at the beginning of write_sha1_file() in
>> sha1_file.c.)
>>
>> And no this order is not configurable, but of course it could be made
>> configurable.
>>
>>>> + - 'get_direct <sha1>'
>>>> +
>>>> +This instruction is similar as the other 'get_*' instructions except
>>>> +that no object should be sent from the helper to Git. Instead the
>>>> +helper should directly write the requested object into a loose object
>>>> +file in the ".git/objects" directory.
>>>> +
>>>> +After the helper has sent the "status=success" packet and the
>>>> +following flush packet in process mode, or after it has exited in the
>>>> +script mode, Git should lookup again for a loose object file with the
>>>> +requested sha1.
>>>
>>>
>>> When will git call get_direct vs one of the other get_* functions?
>>
>>
>> It is called just before exiting when git cannot find an object.
>> It is not exactly at the same place as other get_* instructions as I
>> tried to reuse your code and as it looks like it makes it easier to
>> retry the regular code after the odb helper code.
>>
>>> Could the
>>> functionality of enabling a helper to populate objects into the regular
>>> object store be provided by having a ODB helper that returned the object
>>> data as requested by get_git_obj or get_raw_obj but also stored it in the
>>> regular object store as a loose object (or pack file) for future calls?
>>
>>
>> I am not sure I understand what you mean.
>> If a helper returns the object data as requested by get_git_obj or
>> get_raw_obj, then currently Git will itself store the object locally
>> in its regular object store, so it is redundant for the helper to also
>> store or try to store the object in the regular object store.
>>
>
> Doesn't this mean that objects will "leak out" into the regular object store
> as they are used?  For example, at checkout, all objects in the requested
> commit would be retrieved from the various object stores and if they came
> from a "large blob" ODB handler, they would get retrieved from the ODB
> handler and then written to the regular object store (presumably as a loose
> object).  From then on, the object would be retrieved from the regular
> object store.
>
> This would seem to defeat the goal of enabling specialized object handlers
> to handle large or other "unusual" objects that git normally doesn't deal
> well with.

Yeah, I agree that storing the objects in the regular object store
should not be done in all the cases.
There should be a way to control that.
