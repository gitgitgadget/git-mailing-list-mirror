Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F02203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 17:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936457AbcLMRUc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 12:20:32 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32955 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964808AbcLMRUP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 12:20:15 -0500
Received: by mail-lf0-f66.google.com with SMTP id y21so4214517lfa.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 09:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V+ZFyoeYKQe0njKx3ddVtADDLqJGoNXvkVM51th/4Ys=;
        b=SahZ4oSwtNC4cjztpeMtB2BwIdlC0GK5bM2K0vmAE/YVuDzPC9LN0BMJrT1EUVcbFO
         HRGSSZKEvbSfCZ2lj2uNb7oOgSmhgc/Kdl367pw/ugLlq2RiLHBydvXRmnhs+mLfxov4
         M6y2LK97WpDcuBVV7WUg25hDhARd0qFvlXBSXJ9t27/OWJT4QMO2frbwxg5PNFQqqFCX
         QufdotB9ivTPBVa/PF+sy9blP+mHydZudOmvLS1SrhSXSy9EzRGmT8x+B0un6GbZbjkL
         +06CpuYQasaFgXTMrALLIXAua6oxwFLV22qRBTPkopaCmT5Tn08Awb+yWGW2urnmZQsH
         BykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V+ZFyoeYKQe0njKx3ddVtADDLqJGoNXvkVM51th/4Ys=;
        b=ezZ+hyYTOKoKKYaluQstn2wfMHPa3Xr6jtNQ7bxDwLmcC4P08CxOtQthjB4R/dPvVd
         HLaGJiFsRIeRFfw47ZKTyD81PYcQ+RlUoXYeWyW2WpPkrgYBzZ4W6W+u4AHZRxMpNJnJ
         nA/HXXrULCE7hnTihqJvXzG3iEOTMUN2bnn3PNvzw0TPsORM/SpokdrR5PiFcjaTdbGE
         5z8IAicAJ8u2JjykBC5mBfZ1peuYxmd17qTjYRVC98VgMto/xOGYzwUnjHlYf/k7jOfa
         emi060WV2NnlQtRVKR4iGBfuWzogQAJKJ3wSxSr98oFMmlzWnLicqH88W893eO77yIJK
         v4HA==
X-Gm-Message-State: AKaTC00LPjDc3hR1LSE/HR5fLIAlFqUIpKcDmeWfrSk+xMr5TrCcX0N+dSKzpyrTJcGktkbTJ6l7i9w3odSrvA==
X-Received: by 10.25.79.7 with SMTP id d7mr6758846lfb.81.1481649613487; Tue,
 13 Dec 2016 09:20:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Tue, 13 Dec 2016 09:20:12 -0800 (PST)
In-Reply-To: <A5ABBF3E-BED9-4FF3-9DE5-B529DEF0B8E8@gmail.com>
References: <20161130210420.15982-1-chriscool@tuxfamily.org> <A5ABBF3E-BED9-4FF3-9DE5-B529DEF0B8E8@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 13 Dec 2016 18:20:12 +0100
Message-ID: <CAP8UFD2uyq3Uf1co_BUKJX_eogdCDJ30KJZmQ1BQXNQ1dw=w3A@mail.gmail.com>
Subject: Re: [RFC/PATCH v3 00/16] Add initial experimental external ODB support
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 3, 2016 at 7:47 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
>
>> On 30 Nov 2016, at 22:04, Christian Couder <christian.couder@gmail.com> wrote:
>>
>> Goal
>> ~~~~
>>
>> Git can store its objects only in the form of loose objects in
>> separate files or packed objects in a pack file.
>>
>> To be able to better handle some kind of objects, for example big
>> blobs, it would be nice if Git could store its objects in other object
>> databases (ODB).
>
> This is a great goal. I really hope we can use that to solve the
> pain points in the current Git <--> GitLFS integration!

Yeah, I hope it will help too.

> Thanks for working on this!
>
> Minor nit: I feel the term "other" could be more expressive. Plus
> "database" might confuse people. What do you think about
> "External Object Storage" or something?

In the current Git code, "DB" is already used a lot. For example in
cache.h there is:

#define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"

#define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"

#define INIT_DB_QUIET 0x0001
#define INIT_DB_EXIST_OK 0x0002

extern int init_db(const char *git_dir, const char *real_git_dir,
           const char *template_dir, unsigned int flags);

[...]

>>  - "<command> get <sha1>": the command should then read from the
>> external ODB the content of the object corresponding to <sha1> and
>> output it on stdout.
>>
>>  - "<command> put <sha1> <size> <type>": the command should then read
>> from stdin an object and store it in the external ODB.
>
> Based on my experience with Git clean/smudge filters I think this kind
> of single shot protocol will be a performance bottleneck as soon as
> people store more than >1000 files in the external ODB.
> Maybe you can reuse my "filter process protocol" (edcc858) here?

Yeah, I would like to do reuse your "filter process protocol" as much
as possible to improve this in the future.

>> * Transfer
>>
>> To tranfer information about the blobs stored in external ODB, some
>> special refs, called "odb ref", similar as replace refs, are used.
>>
>> For now there should be one odb ref per blob. Each ref name should be
>> refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
>> in the external odb named <odbname>.
>>
>> These odb refs should all point to a blob that should be stored in the
>> Git repository and contain information about the blob stored in the
>> external odb. This information can be specific to the external odb.
>> The repos can then share this information using commands like:
>>
>> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`
>
> The "odbref" would point to a blob and the blob could contain anything,
> right? E.g. it could contain an existing GitLFS pointer, right?
>
> version https://git-lfs.github.com/spec/v1
> oid sha256:4d7a214614ab2935c943f9e0ff69d22eadbb8f32b1258daaa5e2ca24d17e2393
> size 12345

Yes, but I think that the sha1 should be added. So yes, it could
easily be made compatible with git LFS.

>> Design discussion about performance
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Yeah, it is not efficient to fork/exec a command to just read or write
>> one object to or from the external ODB. Batch calls and/or using a
>> daemon and/or RPC should be used instead to be able to store regular
>> objects in an external ODB. But for now the external ODB would be all
>> about really big files, where the cost of a fork+exec should not
>> matter much. If we later want to extend usage of external ODBs, yeah
>> we will probably need to design other mechanisms.
>
> I think we should leverage the learnings from GitLFS as much as possible.
> My learnings are:
>
> (1) Fork/exec per object won't work. People have lots and lots of content
>     that is not suited for Git (e.g. integration test data, images, ...).

I agree that it will not work for many people, but look at how git LFS
evolved. It first started without a good solution for those people,
and then you provided a much better solution to them.
So I am a bit reluctant to work on a complex solution reusing your
"filter process protocol" work right away.

> (2) We need a good UI. I think it would be great if the average user would
>     not even need to know about ODB. Moving files explicitly with a "put"
>     command seems unpractical to me. GitLFS tracks files via filename and
>     that has a number of drawbacks, too. Do you see a way to define a
>     customizable metric such as "move all files to ODB X that are gzip
>     compressed larger than Y"?

I think these should be defined in the config and attributes files. It
could also be possible to implement a "want" command (in the same way
as the "get", "put" and "have" commands) to ask the e-odb helper if it
wants to store a specific blob.

>> Future work
>> ~~~~~~~~~~~
>>
>> I think that the odb refs don't prevent a regular fetch or push from
>> wanting to send the objects that are managed by an external odb. So I
>> am interested in suggestions about this problem. I will take a look at
>> previous discussions and how other mechanisms (shallow clone, bundle
>> v3, ...) handle this.
>
> If the ODB configuration is stored in the Git repo similar to
> .gitmodules then every client that clones ODB references would be able
> to resolve them, right?

Yeah, but I am not sure that being able to resolve the odb refs will
prevent the big blobs from being sent.
With Git LFS, git doesn't know about the big blobs, only about the
substituted files, but that is not the case in what I am doing.

Thanks,
Christian.
