Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327B420281
	for <e@80x24.org>; Fri, 15 Sep 2017 13:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdIONQ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 09:16:56 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:44982 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdIONQz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 09:16:55 -0400
Received: by mail-io0-f170.google.com with SMTP id v36so8328704ioi.1
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 06:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K0DeVsQcDs22t+pAR4z7a+wPadXyqhht4z0HJHXcAnw=;
        b=sWAm+9FA7pwm+3Okar6rmT1NCvet2Lu+DFPBTaLD+7VHCTJ19aiSXd3PzvhxJwF3Rd
         gcl3kzbnexHlthBjhopbZoLt/hRMkrqaKf5OgsYQcRw4L+uZBzH/k4Z3kGGf9UCJn6ei
         5G0eP+ZFJWxVUhoPUpO2Fmogs/xLzuaHbMG6BIHPsWlv5IkS7O08iTJAAmN0Vsew3sE2
         RAC9cSGvymriIJSwa9RoUhsMq2dEc4f5q5uos6IajMwPZHhG82MMq+dq2E3izuBI1awF
         evIcUIqpBHnRrqBUk6B8gKt+iTXM1BG7b+e+z9BVHACZ+YYFNewg+dM0tn76luUYmvxO
         5zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K0DeVsQcDs22t+pAR4z7a+wPadXyqhht4z0HJHXcAnw=;
        b=cU2Ct28iIrKGuO5wRIi2VMl0xtWU3nRMqPQVk81RMmkic9D2WLrajkcwaqGk26wUlx
         o+dvdHIv4ZRGHbs1f2SbtqvR0sKkz9UzmnFtU76gxIDJ+ujccqo73KnA4gHUUo5ce8bg
         /GXS51ahOnMV2vk9i74Qdp3YoFi6J300vPZUhE9OMCg7h3zLQpJDrzLvqJIjP2mhi1Ya
         iGxfCOfwNqdJ1eK3A7TTIZUH5/RGJT/nd4ZDmS7zErEQMIX4n5/0BG8MEakv9jngDXbb
         evESD0Abk70iWI5JIag6UsiJQOCTSogwBWpb8ygQkj8J+g0wuHJSVC7TnvJkwf67qBMI
         pM2g==
X-Gm-Message-State: AHPjjUhAA6hrkLsVLjWcsz8J/kfXTRiGhOQE3p8F7187Whn2IFK3M11Y
        dlid8+9Aa5D0FLRyogKk2Yw6WU3nao3jjVbsEp0=
X-Google-Smtp-Source: AOwi7QBgN5jKrkKsDG6x4NQYmJOFsx+GAHzu/AKIAuPznvjPSME9HNdIDgJMT6n5nyNblkwt28V7Vq28blarUP3EG7E=
X-Received: by 10.107.147.8 with SMTP id v8mr8838642iod.45.1505481414314; Fri,
 15 Sep 2017 06:16:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Fri, 15 Sep 2017 06:16:53 -0700 (PDT)
In-Reply-To: <20170712120647.6340f75a@twelve2.svl.corp.google.com>
References: <20170620075523.26961-1-chriscool@tuxfamily.org> <20170712120647.6340f75a@twelve2.svl.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 15 Sep 2017 15:16:53 +0200
Message-ID: <CAP8UFD1hYHU0Wb+=vd3OK1cKUOKETEH5APGNaXa0W2ZBUUNgFQ@mail.gmail.com>
Subject: Re: [RFC/PATCH v4 00/49] Add initial experimental external ODB support
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
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

(It looks like I did not reply to this other email yet, sorry about
this late reply.)

On Wed, Jul 12, 2017 at 9:06 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, 20 Jun 2017 09:54:34 +0200
> Christian Couder <christian.couder@gmail.com> wrote:
>
>> Git can store its objects only in the form of loose objects in
>> separate files or packed objects in a pack file.
>>
>> To be able to better handle some kind of objects, for example big
>> blobs, it would be nice if Git could store its objects in other object
>> databases (ODB).
>
> Thanks for this, and sorry for the late reply. It's good to know that
> others are thinking about "missing" objects in repos too.
>
>>   - "have": the helper should respond with the sha1, size and type of
>>     all the objects the external ODB contains, one object per line.
>
> This should work well if we are not caching this "have" information
> locally (that is, if the object store can be accessed with low latency),
> but I am not sure if this will work otherwise.

Yeah, there could be problems related to caching or not caching the
"have" information.
As a repo should not send the blobs that are in an external odb, I
think it could be useful to cache the "have" information.
I plan to take a look and add related tests soon.

> I see that you have
> proposed a local cache-using method later in the e-mail - my comments on
> that are below.
>
>>   - "get <sha1>": the helper should then read from the external ODB
>>     the content of the object corresponding to <sha1> and pass it to
>> Git.
>
> This makes sense - I have some patches [1] that implement this with the
> "fault_in" mechanism described in your e-mail.
>
> [1] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/
>
>> * Transfering information
>>
>> To tranfer information about the blobs stored in external ODB, some
>> special refs, called "odb ref", similar as replace refs, are used in
>> the tests of this series, but in general nothing forces the helper to
>> use that mechanism.
>>
>> The external odb helper is responsible for using and creating the refs
>> in refs/odbs/<odbname>/, if it wants to do that. It is free for
>> example to just create one ref, as it is also free to create many
>> refs. Git would just transmit the refs that have been created by this
>> helper, if Git is asked to do so.
>>
>> For now in the tests there is one odb ref per blob, as it is simple
>> and as it is similar to what git-lfs does. Each ref name is
>> refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
>> in the external odb named <odbname>.
>>
>> These odb refs point to a blob that is stored in the Git
>> repository and contain information about the blob stored in the
>> external odb. This information can be specific to the external odb.
>> The repos can then share this information using commands like:
>>
>> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`
>>
>> At the end of the current patch series, "git clone" is teached a
>> "--initial-refspec" option, that asks it to first fetch some specified
>> refs. This is used in the tests to fetch the odb refs first.
>>
>> This way only one "git clone" command can setup a repo using the
>> external ODB mechanism as long as the right helper is installed on the
>> machine and as long as the following options are used:
>>
>>   - "--initial-refspec <odbrefspec>" to fetch the odb refspec
>>   - "-c odb.<odbname>.command=<helper>" to configure the helper
>
> A method like this means that information about every object is
> downloaded, regardless of which branches were actually cloned, and
> regardless of what parameters (e.g. max blob size) were used to control
> the objects that were actually cloned.
>
> We could make, say, one "odb ref" per size and branch - for example,
> "refs/odbs/master/0", "refs/odbs/master/1k", "refs/odbs/master/1m", etc.
> - and have the client know which one to download. But this wouldn't
> scale if we introduce different object filters in the clone and fetch
> commands.

Yeah, there are multiple ways to do that.

> I think that it is best to have upload-pack send this information
> together with the packfile, since it knows exactly what objects were
> omitted, and therefore what information the client needs. As discussed
> in a sibling e-mail, clone/fetch already needs to be modified to omit
> objects anyway.

I try to avoid sending this information as I don't think it is
necessary and it simplify things a lot to not have to change the
communication protocol.
