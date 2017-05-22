Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341EA2023D
	for <e@80x24.org>; Mon, 22 May 2017 17:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760628AbdEVR2f (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 13:28:35 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36073 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760625AbdEVR2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 13:28:34 -0400
Received: by mail-it0-f65.google.com with SMTP id i206so11962503ita.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Qqj5YKQmvX5KJJSWP3ZtFyWW3Y6BanIJaxIYyd2rWM=;
        b=nnSvX0jg/g1qNcnaitgZBo8vuD0IP3nxcUqm9WHvd7+qV2wWOpDC8BMZLOA5qTpNVD
         kh9DWVjTaRg4OcTNgjsFUCCYZm/PQFIYt1JZmyyXQg3HNRQmVqNXiTGnAug9xT6mRbKP
         Y8NiXVyT9hB1yRK18KqFxBY9insHX35IXEGJCbwAMxLOUiIrcA9TBPFD2qd+WzfqiLin
         LfpJkLntrTxFZvT1OfVrLlShGxa4xLibE1wGevOfU2mtfnZZN3GlvLGplVzEZk99MU+x
         Ugm5KyVUWC+9ukwO2U2KyNoZ4el/v/5gDnV43pYAzFzyYBVGvp6XM5MtJ2OYoqB0xBXT
         3Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Qqj5YKQmvX5KJJSWP3ZtFyWW3Y6BanIJaxIYyd2rWM=;
        b=YhQI9T1k0OTcc3kJSnRESWLyjvBoMQDlxSeZr3iIl7sJPQECAGq4MsGBdYiNrBSvG2
         mweQBlzzRXu5oGeQqmG/2+zxkb48S5Mz2D8lq3NJ+3Gdtb80LhZ3366HcNZqlidN9mGL
         n0rZcO6ketYq7nVX54O3BA96rBXE3ARctRseiDCkAE73ZiGiFGd/hA34h8FAnvzShHxq
         qAFPMyrkk1pYMp5z+K+ouoa3jolyG6Vuz4jCGIXUadLQCyAPtZG8SVRYsPb4JQpfkPP3
         y/ezAHEGp4lI8IjPFRHNuHFI+Nj1WIgAY6y4cndiXVkLgRw+tYby1O7rkE4y15GdTzha
         xb6w==
X-Gm-Message-State: AODbwcDf9aQqpGjInR/YotjDZnfzUfK0AQpliUcIvfc7b1G0aMc9jLMg
        P1GEb/Vb/1E15ctq+6hn+EHWOYL9rw==
X-Received: by 10.36.166.4 with SMTP id q4mr23227465ite.66.1495474113717; Mon,
 22 May 2017 10:28:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 22 May 2017 10:28:12 -0700 (PDT)
In-Reply-To: <5ab333a4-c3cd-1cb5-ba3e-6b08fa14c9e7@gmail.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <20170518201333.13088-6-benpeart@microsoft.com> <CACBZZX5URAeA+=12ezW-oDGnkdAqvQqV7it=HBaYCKUdx0p_XA@mail.gmail.com>
 <5ab333a4-c3cd-1cb5-ba3e-6b08fa14c9e7@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 22 May 2017 19:28:12 +0200
Message-ID: <CACBZZX6LENwuVuTyU-RetaXz8jZtUp1dv+gmQQ281sPx1czPnA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] fsmonitor: add documentation for the fsmonitor extension.
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, benpeart@microsoft.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David.Turner@twosigma.com, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 6:18 PM, Ben Peart <peartben@gmail.com> wrote:
> On 5/20/2017 8:10 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>> +=3D=3D File System Monitor cache
>>> +
>>> +  The file system monitor cache tracks files for which the
>>> query-fsmonitor
>>> +  hook has told us about changes.  The signature for this extension is
>>> +  { 'F', 'S', 'M', 'N' }.
>>> +
>>> +  The extension starts with
>>> +
>>> +  - 32-bit version number: the current supported version is 1.
>>> +
>>> +  - 64-bit time: the extension data reflects all changes through the
>>> given
>>> +       time which is stored as the seconds elapsed since midnight,
>>> January 1, 1970.
>>> +
>>> +  - 32-bit bitmap size: the size of the CE_FSMONITOR_DIRTY bitmap.
>>> +
>>> +  - An ewah bitmap, the n-th bit indicates whether the n-th index entr=
y
>>> +    is CE_FSMONITOR_DIRTY.
>>
>>
>> We already have a uint64_t in one place in the codebase (getnanotime)
>> which uses a 64 bit time for nanosecond accuracy, and numerous
>> filesystems already support nanosecond timestamps (ext4, that new
>> Apple thingy...).
>>
>> I don't know if any of the inotify/fsmonitor APIs support that yet,
>> but it seems inevitable that that'll be added if not, in some
>> pathological cases we can have a lot of files modified in 1 second, so
>> using nanosecond accuracy means there'll be a lot less data to
>> consider in some cases.
>>
>> It does mean this'll only work until the year ~2500, but that seems
>> like an acceptable trade-off.
>>
>
> I really don't think nano-second resolution is needed in this case for a =
few
> reasons.
>
> The number of files that can change within a given second is limited by t=
he
> IO throughput of the underlying device. Even assuming a very fast device =
and
> very small files and changes, this won't be that many files.
>
> Without this patch, git would have scanned all those files every time. Wi=
th
> this patch, git will only scan those files a 2nd time that are modified i=
n
> the same second that it did the first scan *that came before the first sc=
an
> started* (the "lots of files modified" section in the 1 second timeline
> below).
>
> |------------------------- one second ---------------------|
> |-lots of files modified - git status - more file modified-|
>
> Yes, some duplicate status checks can be made but its still a significant
> win in any reasonable scenario. Especially when you consider that it is
> pretty unusual to do git status/add/commit calls in the middle of making
> lots of changes to files.

I understand that we get most of the wins either way.

I'm just wondering why not make it nanosecond-resolution now from the
beginning since that's where major filesystems are heading already,
and changing stuff like this can be a hassle once it's initially out
there, whereas just dividing by 10^9 for APIs that need seconds from
the beginning is easy & future-proof.

There are some uses of git where this would probably matter in practice.

E.g. consider a git-annex backed fileserver using ext4, currently
git-annex comes with its own FS watcher as a daemon invoked via `git
annex watch` to constantly add new files without killing performance
via a status/add in a loop, with this a daemon like that could just
run status/add in a loop, but on a busy repo the 1s interval size
might start to matter as you're constantly inspecting larger
intervals.

More importantly though, I can't think of any case where having it in
nanoseconds to begin with would do any harm.

> In addition, the backing file system monitor (Watchman) supports number o=
f
> seconds since the unix epoch (unix time_t style).  This means any support=
 of
> nano seconds by git is academic until someone provides a file system watc=
her
> that does support nano second granularity.

I haven't used watchman for anything non-trivial, but the
documentation for the query API you seem to be using says you can
request a {ctime,mtime}_ns field:

https://github.com/facebook/watchman/blob/master/website/_docs/cmd.query.ma=
rkdown#user-content-available-fields

And isn't this the documentation for the "since" query you're using,
saying you can specify any arbitrary fs timing field, such as a _ns
time field:

https://github.com/facebook/watchman/blob/master/website/_docs/expr.since.m=
d

?

> Finally, the fsmonitor index extension is versioned so that we can
> seamlessly upgrade to nano second resolution later if we desire.

Aside from my nanosecond bikeshedding, let's say we change the
semantics of any of this in the future: The index has the version, but
there's one argument passed to the hook without a version. Is the hook
expected to potentially be reading the version from the index to make
sense of whether (in this case) the argument is a mtime or mtime_ns?

Wouldn't this make more sense than that on top, i.e. pass the version
to the hook, untested (and probably whines about the sprintf
format...):

$ git diff -U1
diff --git a/cache.h b/cache.h
index 6eafd34fff..3c63f179f8 100644
--- a/cache.h
+++ b/cache.h
@@ -346,2 +346,3 @@ struct index_state {
        struct untracked_cache *untracked;
+       uint32_t fsmonitor_version;
        time_t fsmonitor_last_update;
diff --git a/fsmonitor.c b/fsmonitor.c
index f5a9f818e8..7236b538ac 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -60,2 +60,4 @@ int read_fsmonitor_extension(struct index_state
*istate, const void *data,
                return error("bad fsmonitor version %d", hdr_version);
+       else
+               istate->fsmonitor_version =3D hdr_version;

@@ -137,2 +139,3 @@ static int query_fsmonitor(time_t last_update,
struct strbuf *query_result)
        struct child_process cp =3D CHILD_PROCESS_INIT;
+       char version[1];
        char date[64];
@@ -143,2 +146,3 @@ static int query_fsmonitor(time_t last_update,
struct strbuf *query_result)

+       snprintf(version, sizeof(version), "%d", istate->fsmonitor_version)=
;
        snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update)
