Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E77C1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 18:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753768AbeDTSe2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 14:34:28 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:45441 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbeDTSe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 14:34:27 -0400
Received: by mail-vk0-f48.google.com with SMTP id 203so5817461vka.12
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T1iuXMZ5QA2W4AiA5Yemj6rWNeWt2F7QKb/8MOD7k/c=;
        b=e1l563lQydNaUrGuD+57TA3JAnFA6fLjS1wVhY0+C7a9gbMovNczZXyMgMkl/4oHZV
         v2OgCk2LIhfX6CXN9fiKOWnCb+mLZAtj1h1o44FvsJvjsPpehcSwo9qnbVECUNWT+0Fv
         RlI3KeIEoOkOpKfv4EaLpVAyxbDwzJz7JFW3QKCZBI9s1u7JBARtc2DMKrxQDQLynAZk
         m7gQallY+VZBwRnMH6rltdFZ7UJfQSw0mhxmRyUsRDQ6SOMW5zjdMHargqicSu9550YW
         iagGs8goGKD0jsT7FFXjRHxEcmsMDQ4thE6zOabBAt1cY8BHigSCJUtae3qXhiQxgeDQ
         L37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T1iuXMZ5QA2W4AiA5Yemj6rWNeWt2F7QKb/8MOD7k/c=;
        b=QDD36t19InryyfN8DMjDHe0dWY/PH5s9AzOpIv7hwTmeQ/rndTjZX+MTIQeyJqvtS0
         HkuXvDfit3Oip5BXHD87i+IUZEBTVOc5ME7Kr7cNcbAVJi+226hjeGoxBRrypepbbRqb
         InNhVZE3Pk1AfQcNhU6dPtrNdHfBuc858E3dpN7UeL0Efa8N4eZFNKmB3E9kO121dptf
         xQt0204qSFEwGYDcoKcKWhpoNOfS2QnQz8w44Brd8a4Xsjhv6YIt0GOCfdjyRHqeV3M5
         IMucAr01YD6XlWt/MO3ZqT+Z1NDij8jWum9a22Vrdntc0lY/pOQbRLmKs6M1NZxLc4HN
         naxg==
X-Gm-Message-State: ALQs6tCszyNVFQHI0oc7KOAT4pAdVET2qDuqYmjVlInQckHjDLJOst7R
        TgaTcoImvh5qqXtFBWYALh7VRsmikc+feY8Rhto=
X-Google-Smtp-Source: AIpwx482JPOz+LUnK9BBtOv25QTycgQe2etNnJCTw4EJtOQUNvXiv2To0gmKnz8IgON4kyLk1xSfpAj6m9kRagJKNrQ=
X-Received: by 10.31.114.207 with SMTP id n198mr8320569vkc.149.1524249266780;
 Fri, 20 Apr 2018 11:34:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 20 Apr 2018 11:34:25 -0700 (PDT)
In-Reply-To: <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com> <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
 <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Apr 2018 11:34:25 -0700
Message-ID: <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Fri, Apr 20, 2018 at 10:59 AM, Ben Peart <peartben@gmail.com> wrote:
>
> On 4/20/2018 1:02 PM, Elijah Newren wrote:
>>
>> On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com>
>> wrote:
>>>
>>> --- a/Documentation/merge-config.txt
>>> +++ b/Documentation/merge-config.txt
>>> @@ -37,6 +37,11 @@ merge.renameLimit::
>>>          during a merge; if not specified, defaults to the value of
>>>          diff.renameLimit.
>>>
>>> +merge.renames::
>>> +       Whether and how Git detects renames.  If set to "false",
>>> +       rename detection is disabled. If set to "true", basic rename
>>> +       detection is enabled. This is the default.
>>
>>
>> One can already control o->detect_rename via the -Xno-renames and
>> -Xfind-renames options.

This statement wasn't meant to be independent of the sentence that
followed it...

> Yes, but that requires people to know they need to do that and then remember
> to pass it on the command line every time.  We've found that doesn't
> typically happen, we just get someone complaining about slow merges. :)
>
> That is why we added them as config options which change the default. That
> way we can then set them on the repo and the default behavior gives them
> better performance.  They can still always override the config setting with
> the command line options.

Sorry, I think I wasn't being clear.  The documentation for the config
options for e.g. diff.renameLimit, fetch.prune, log.abbrevCommit, and
merge.ff all mention the equivalent command line parameters.  Your
patch doesn't do that for merge.renames, but I think it would be
helpful if it did.

Also, a link in the documentation the other way, from
Documentation/merge-strategies.txt under the entries for -Xno-renames
and -Xfind-renames should probably mention this new merge.renames
config setting (much like the -Xno-renormalize flag mentions the
merge.renomralize config option).

(In general, I think having this as a configuration option makes
sense, though I hope my other performance patches would be enough to
make people consider switching back to the defaults and use rename
detection again.)

<snip>
> I'm of the opinion that we shouldn't bother adding features that we aren't
> sure someone will want/use.  If it comes up, we can certainly add it at a
> later date.

Works for me; I was mostly throwing it out there for thought.

> Yes, command line options override the config settings.

Good.  :-)

>> Also, if someone sets merge.renameLimit (to anything) and sets
>> merge.renames to false, then they've got a contradictory setup.  Does
>> it make sense to check and warn about that anywhere?
>
> I don't think we need to.  The merge.renameLimit is only used if
> detect_rename it turned on no matter how that gets turned on (default,
> config setting, command line option) so there isn't really a change in
> behavior here.

I agree that's the pre-existing behavior, but prior to this patch
turning off rename detection could only be done manually with every
invocation.  I'm slightly concerned that users might be confused if
merge.renames was set to false somewhere -- perhaps even in a global
/etc/gitconfig that they had no knowledge of or control over -- and in
an attempt to get rename detection to work they started passing larger
and larger values for renameLimit all to no avail.

The easy fix here may just be documenting the diff.renameLimit and
merge.renameLimit options that they have no effect if rename detection
is turned off.

Or maybe I'm just worrying too much, but we (folks at $dayjob) were
bit pretty hard by renameLimit silently being capped at a value less
than the user specified and in a way that wasn't documented anywhere.
