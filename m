Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2F9200B9
	for <e@80x24.org>; Sun,  6 May 2018 19:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeEFTcC (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 15:32:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34925 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeEFTcB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 15:32:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id x9so1958804pfm.2
        for <git@vger.kernel.org>; Sun, 06 May 2018 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+wbgIDqAqDKmAuZmJr6YEuC1IUoJ0aWH1Bl6HLpRcq8=;
        b=FCiKYIs4TzmkPJX33s9wWu++bRWqfSR7ZJt6LH1E8nF3gbzntbDg1GwvQINjpwBCMl
         gtBK6w+Oh03tjey3GSmHA6woXdWNMVLpqtEDrfIfnv7jf9OXRq+lI1BEkijPg7eEFraH
         WM8pwpooLvK5AYse9++vx7Lf8NtZsBXZsENOvaUV1oIBOsypyTCkK7cv1hlBI3fhQKjN
         NvstjS1L/12gikD3VAQpKLjc2nlAFQFIYa1RALTbyriu+5PoXyjkgsiBwqxEFrF1gBm5
         uOEXbjo2MHyQYioatuS8kVRmJekAZfSgP9z326RqsdkUhT18y3fl4hItZOxhMPjsXvOb
         kT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+wbgIDqAqDKmAuZmJr6YEuC1IUoJ0aWH1Bl6HLpRcq8=;
        b=aKv9k4tEBpS7XZRLuixgMUCOJwa7KrKhzSqvWGvcckYrLEvCk5MUxhJi8MsR3JBl9G
         cGhVTLVaWVY1jerjc2OkIr1TZWC46KgZ1p4b0IIHYVvWx0Ja4LAaJFL5xWf4FhIAUkb9
         cLxKuwpsyKwE6mEEZ21XU4/bfhvX66U31LdBiwznt2vdADvZpiQ3KdmETyWuuSgPsvzZ
         2zyM4eMJb5sKDkZuo6Wj0IuM5VSjQRscOG7r/59vjrzlnXzovwF+RfI2XMznbK589QJV
         Stga+MxMJDhyjV1xaIImlRxs5lL4VC2x6Hf4xZogi2Q2yE5eFOmDCO9oGzwYBHI3KNDi
         Ic3A==
X-Gm-Message-State: ALQs6tCYOjeAdU+rT4uv0Qzn88CgGmUNnrEUIrUZxd15omSBn5wLo3Q6
        H341vSLJqmObyO+pznVvZ7cpklwHig7hzCvNvDJoRYgb
X-Google-Smtp-Source: AB8JxZppwnY8jKeHVGhuvw3u2QPMg1UwuKRZtyI9FOSfsBiWokkTChg9b+ddhp+/tdLHwdCIxx3LyUlw8LUr7/mt874=
X-Received: by 10.98.80.80 with SMTP id e77mr34619756pfb.16.1525635120858;
 Sun, 06 May 2018 12:32:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sun, 6 May 2018 12:32:00 -0700 (PDT)
In-Reply-To: <CACsJy8Btuc2J4aCTymkvLYyMV5zJrdMUdtV5NDnPqXOjsTVw4w@mail.gmail.com>
References: <20180506141031.30204-5-martin.agren@gmail.com>
 <CACsJy8DyRhQ0DKy8UyK+r7Kmw=0hHD=W6aXXKutk4e-wtGTdNg@mail.gmail.com> <CACsJy8Btuc2J4aCTymkvLYyMV5zJrdMUdtV5NDnPqXOjsTVw4w@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 6 May 2018 21:32:00 +0200
Message-ID: <CAN0heSpA5H7Gwwx0TEY9=iFJrgKb0SPXqKOwHK=4NxPYoGjZ7A@mail.gmail.com>
Subject: Re: [PATCH 4/5] lock_file: make function-local locks non-static
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 May 2018 at 19:42, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, May 6, 2018 at 7:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, May 6, 2018 at 4:10 PM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>>> These `struct lock_file`s are local to their respective functions and w=
e
>>> can drop their staticness.

>>> -       static struct lock_file lock;
>>> +       struct lock_file lock =3D LOCK_INIT;
>>
>> Is it really safe to do this? I vaguely remember something about
>> (global) linked list and signal handling which could trigger any time
>> and probably at atexit() time too (i.e. die()). You don't want to
>> depend on stack-based variables in that case.
>
> So I dug in a bit more about this. The original implementation does
> not allow stack-based lock files at all in 415e96c8b7 ([PATCH]
> Implement git-checkout-cache -u to update stat information in the
> cache. - 2005-05-15). The situation has changed since 422a21c6a0
> (tempfile: remove deactivated list entries - 2017-09-05). At the end
> of that second commit, Jeff mentioned "We can clean them up
> individually" which I guess is what these patches do. Though I do not
> know if we need to make sure to call "release" function or something/
> Either way you need more explanation and assurance than just "we can
> drop their staticness" in the commit mesage.

Thank you Duy for your comments. How about I write the commit message
like so:

  After 076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05),
  we can have lockfiles on the stack. These `struct lock_file`s are local
  to their respective functions and we can drop their staticness.

  Each of these users either commits or rolls back the lock in every
  codepath, with these possible exceptions:

    * We bail using a call to `die()` or `exit()`. The lock will be
      cleaned up automatically.

    * We return early from a function `cmd_foo()` in builtin/, i.e., we
      are just about to exit. The lock will be cleaned up automatically.

  If I have missed some codepath where we do not exit, yet leave a locked
  lock around, that was so also before this patch. If we would later
  re-enter the same function, then before this patch, we would be retaking
  a lock for the very same `struct lock_file`, which feels awkward, but to
  the best of my reading has well-defined behavior. Whereas after this
  patch, we would attempt to take the lock with a completely fresh `struct
  lock_file`. In both cases, the result would simply be that the lock can
  not be taken, which is a situation we already handle.
