Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075B41F462
	for <e@80x24.org>; Sat, 25 May 2019 21:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfEYVHS (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 17:07:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38727 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfEYVHS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 17:07:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id w11so19944619edl.5
        for <git@vger.kernel.org>; Sat, 25 May 2019 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BUa+XLN2sCZNYncdG8J8fP7/FsWD1n+8VRZFCU8VaNU=;
        b=mtFdLZN4+dcneXsGDUigYVhkoy6RATvw/Poh9KclqDsqjEydk7LT6dzwYlw76cN7YP
         KbfdOteaueoMDv6yBjPw0BGx/v8m0B4CpGn+9zYt37GFQP67v3Rk5KQ76igo0iXiejXU
         xYjR9X64IZVYAvZQ9zoNX05xSh+cjBdJ6z4npZ070W4XiYkTjrdSWcU66jqu8hV3khHr
         pvipGNziEoJJ1VTB9Gl1FH9QdTwyvNBCW+2+V6lauVrlLMWQLxtXvg/CIsUK2AjcSYBh
         0vcJhLWOyzZG0jjsN+OnHkU1GJ8F9ANYaaQW6JAvD0bXGoARU7LDuZOMTO1Cn6golisC
         SONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BUa+XLN2sCZNYncdG8J8fP7/FsWD1n+8VRZFCU8VaNU=;
        b=YKw4TC9oE+AfDZxNFHC53qJoEAhBr6k8s4lL5WcAHflvCoUiSe7FeO7/sNYgf1Fszx
         NtIWPA08vNoCrNgGL8o6sn4+oTzDEEMh/WWV5r+LG5ep2fEgRJhD3GkeQZ0+igeOZbPa
         1zR1A6eyFEoAqZZj8es3z9FBhPASKo2nOGiThpTEpffRZC7WL5qX6tHVeD19La3znPEM
         Z0CAOj+155+erzqPPR5VcGt/JXbJqBZLW7MmJcdqpTpZtGxriamkJoMviKX/DOk1XJxY
         eXWw0UeKaS69EmRKUMowuKUzGa1l4LjxgHbncPHHLboyahq5gTWWF6rj4PFF5JsN+XqC
         8s8A==
X-Gm-Message-State: APjAAAWCnnYNPLg084rCSg1OS+6G32gaTAzW2Eg5jilVBZmUDBltk+4P
        Too5aWm9FeeOhn0F8QX2xA8tAelQ
X-Google-Smtp-Source: APXvYqy51ANhDsHi3NbRQsA9KTQ1bz3PXojhFINsjKilGmVhkp6m0eU3ercqeiqJTUfeQSAmy8n8Hw==
X-Received: by 2002:a17:906:1611:: with SMTP id m17mr37712290ejd.13.1558818435749;
        Sat, 25 May 2019 14:07:15 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id e35sm1848332eda.2.2019.05.25.14.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 14:07:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com> <20190524070644.GF25694@sigill.intra.peff.net> <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com> <20190524081337.GA9082@sigill.intra.peff.net> <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
Date:   Sat, 25 May 2019 23:07:14 +0200
Message-ID: <877eaefdkt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 25 2019, Ren=C3=A9 Scharfe wrote:

> Am 24.05.19 um 10:13 schrieb Jeff King:
>> On Fri, May 24, 2019 at 09:35:51AM +0200, Keegan Carruthers-Smith wrote:
>>
>>>> I can't reproduce on Linux, using GNU tar (1.30) nor with bsdtar 3.3.3
>>>> (from Debian's bsdtar package). What does your "tar --version" say?
>>>
>>> bsdtar 2.8.3 - libarchive 2.8.3
>>
>> Interesting. I wonder if there was a libarchive bug that was fixed
>> between 2.8.3 and 3.3.3.
>>
>>>> Git does write a pax header with the commit id in it as a comment.
>>>> Presumably that's what it's complaining about (but it is not malformed
>>>> according to any tar I've tried). If you feed git-archive a tree rather
>>>> than a commit, that is omitted. What does:
>>>>
>>>>   git archive --format tar c21b98da2^{tree} | tar tf - >/dev/null
>>>>
>>>> say? If it doesn't complain, then we know it's indeed the pax comment
>>>> field.
>>>
>>> It also complains
>>>
>>>   $ git archive --format tar c21b98da2^{tree} | tar tf - >/dev/null
>>>   tar: Ignoring malformed pax extended attribute
>>>   tar: Error exit delayed from previous errors.
>>
>> Ah, OK. So it's not the comment field at all, but some other entry.
>>
>>> Some more context: I work at Sourcegraph.com We mirror a lot of repos
>>> from github.com. We usually interact with a working copy by running
>>> git archive on it in our infrastructure. This is the first repository
>>> that I have noticed which produces this error. An interesting thing to
>>> note is the commit metadata contains a lot of non-ascii text which was
>>> my guess at what my be tripping up the tar creation.
>>
>> Yeah, though the only thing that makes it into the tarfile is the actual
>> tree entries. I'd imagine the file content is not likely to be a source
>> of problems, as it's common to see binary gunk there. Most of the
>> filenames are pretty mundane, but this symlink destination is a little
>> funny:
>>
>>   $ git archive ... | tar tvf - | grep nicovideo4as.swc
>>   lrwxrwxrwx root/root         0 2019-05-24 03:05 libs/nicovideo4as.swc =
-> PK\003\004\024
>>
>> That's not the full story, though. It is indeed a symlink in the
>> tree:
>>
>>   $ git ls-tree -r HEAD libs/nicovideo4as.swc
>>   120000 blob ec3137b5fcaeae25cf67927068af116517683806	libs/nicovideo4as=
.swc
>>
>> But the contents of that blob, which should be the destination filename,
>> are definitely not:
>>
>>   $ git cat-file blob ec3137b5f | wc -c
>>   57804
>>   $ git cat-file blob ec3137b5f | xxd | head -1
>>   00000000: 504b 0304 1400 0800 0800 5069 694e 0000  PK........PiiN..
>>
>> There's quite a bit more data there. And what tar showed us goes up to
>> the first NUL, which does not seem surprising.
>
> That (the symlink target) is a ZIP file with the following contents:
>
>  Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
> --------  ------  ------- ---- ---------- ----- --------  ----
>    39733  Defl:N     3403  91% 2019-03-09 13:10 489e1be1  catalog.xml
>    54131  Defl:N    54151   0% 2019-03-09 13:10 32f57322  library.swf
> --------          -------  ---                            -------
>    93864            57554  39%                            2 files
>
> And link targets longer than 100 characters are encoded in an extended
> Pax header.
>
> (Usually symlink targets are paths, not file contents.)
>
>> It's possible Git is doing the wrong thing on the writing side, but
>> given that newer versions of bsdtar handle it fine, I'd guess that the
>> old one simply had problems consuming poorly formed symlink filenames.
>
> Git preserves symlink targets with embedded NULs in the repository and
> in generated tar files.  Not sure if GNU tar and bsdtar truncating them
> at the first NUL is a bug.  I'm also not sure if there is a platform
> that would allow creating such a symlink in the file system, or how one
> is supposed to use it.
>
> We could truncate symlink targets at the first NUL as well in git
> archive -- but that would be a bit sad, as the archive formats allow
> storing the "real" target from the repo, with NUL and all.  We could
> make git fsck report such symlinks.
>
> Can Unicode symlink targets contain NULs?  We wouldn't want to damage
> them even if we decide to truncate.

I don't see a practical use for this case, and maybe we should even fsck
check for the blob representing the symlink target having a \0 in it as
suggested upthread.

But that being said, this assumption that data in a tar archive will get
written to a FS of some sort isn't true. There's plenty of consumers of
the format that read it in-memory and stream its contents out to
something else entirely, e.g. taking "git archive --remote" output,
parsing it with e.g. [1] and throwing some/all of the content into a
database.

1. https://metacpan.org/pod/Archive::Tar
