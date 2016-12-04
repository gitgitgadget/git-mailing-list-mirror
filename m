Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4701FF40
	for <e@80x24.org>; Sun,  4 Dec 2016 01:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbcLDA5R (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 19:57:17 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:33902 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbcLDA5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 19:57:16 -0500
Received: by mail-io0-f175.google.com with SMTP id c21so499002278ioj.1
        for <git@vger.kernel.org>; Sat, 03 Dec 2016 16:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ugcIhvJDTrxOLtutLG6fYPTbtG4tFHI5IHHjUR9iazo=;
        b=Lb6zGPuVDCTRIQYPLQ6KMTcs+3Kvujfpz8wt1AbeLqXi8Ywp3ICGWIOpohw3KDnSL7
         a9niciE524cdE0pq9oTaVHXuAC0wQ/tbL473/HeFqUqD4TWRR0ftIGntT2IlYdVJTXZW
         JAxe5u4GrA/uMXO5iQJfnt3XftSqqK35QJ51LFtVH1TJJy83ETx7VVMD+vMTZNkFnUXy
         8llCeztUg9e23VZh0aCCiz1yIxKz19hkk5QaDVilzv5CCq4iPOgdcQ7rrGk7K61LjQUF
         0zq0zjtHokPkBliTHKZn9iKNj3EJ+HoEPeoY8lj8OndK30YdUXW1riX0fZTq7JInJJRs
         xYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ugcIhvJDTrxOLtutLG6fYPTbtG4tFHI5IHHjUR9iazo=;
        b=Z0RG98lxkKhboo23ibAQjsoGaC1oqyjxUGlYjq/5JnlCmzvXw6WKLI9bJznZg+vcvS
         p+EWRk0vqZfZpl/IDnOJAR0hRfrn4A0Exz5wyCvQzriopk0IZ9srozj88cSecNqF+fig
         Bqnn++oCvAJqtbPYnVuEbgQ/5OvuJMkhgTZPvNkLOHrCMKnsAXLarQnZJr+OMOqTdlFn
         xUyoC3mZBxhBhd0jFc6cMJw07Tqf6PyR7oK1DMOu8WWH4EYyLQCxavP/o7giyQjsGOuF
         q6M6KhnioZfqqwnpDjuB5/IT8eVh9c3g27XvMj7gCC9EUUTz9nGWH1svnj2h4lcd572G
         g7QQ==
X-Gm-Message-State: AKaTC02+n1CMPqhBS1IkLeggfT8u1TFxau6Wg8GhDtNjzcTzV2EorX3N7Nu62iV9DxWF2esSyjCvBfOjhgOM+A==
X-Received: by 10.36.95.140 with SMTP id r134mr3320512itb.76.1480813035365;
 Sat, 03 Dec 2016 16:57:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.30.196 with HTTP; Sat, 3 Dec 2016 16:57:14 -0800 (PST)
In-Reply-To: <CAP8UFD0ipS_4p+njfbbDGpYSDJhp43e9XDP69MOruZz9c136ew@mail.gmail.com>
References: <CAJZCeG1Eu+5DfaxavX_WGUCa+SY+yepDWZhPXxiFcV__h0xjrw@mail.gmail.com>
 <CAP8UFD0ipS_4p+njfbbDGpYSDJhp43e9XDP69MOruZz9c136ew@mail.gmail.com>
From:   Julian de Bhal <julian.debhal@gmail.com>
Date:   Sun, 4 Dec 2016 10:57:14 +1000
Message-ID: <CAJZCeG0p5UrqM4oSOJ1ALKqNG8SyYh8cexKaN9R6RYYzPsMfxQ@mail.gmail.com>
Subject: Re: git reset --hard should not irretrievably destroy new files
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 3, 2016 at 6:11 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, Dec 3, 2016 at 6:04 AM, Julian de Bhal <julian.debhal@gmail.com> wrote:
>> but I'd be nearly as happy if a
>> commit was added to the reflog when the reset happens (I can probably make
>> that happen with some configuration now that I've been bitten).
>
> Not sure if this has been proposed. Perhaps it would be simpler to
> just output the sha1, and maybe the filenames too, of the blobs, that
> are no more referenced from the trees, somewhere (in a bloblog?).

Yeah, after doing a bit more reading around the issue, this seems like
a smaller part of destroying local changes with a hard reset, and I'm
one of the lucky ones where it is recoverable.

Has anyone discussed having `git reset --hard` create objects for the
current state of anything it's about to destroy, specifically so they
end up in the --lost-found?

I think this is what you're suggesting, only without checking for
references, so that tree & blob objects exist that make any hard reset
reversible.

Cheers

Jules

P.s. Thank you for such a warm welcome while I blunder through
unfamiliar protocols.
