Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F741FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754860AbeASA1B (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:27:01 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45275 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbeASA1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:27:00 -0500
Received: by mail-oi0-f67.google.com with SMTP id j129so12979oib.12
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r5jQZEvrvoiRPnljbDishXIHpNfwezqlOhoU6Y2vNU8=;
        b=dj+QnGRAHqmU3yQiuHbAee0tF8ZQmMLvsXtCoSUe3HPNufG38p2qkRNnnXorOvnGfh
         XgN0FP5nU++hREpDPIo5u3wG/cWCMpTzrxFVhVRb+jeACdCEtTHi5ZP6ERIs1qyJ2YCN
         0B5tAyocY1ME7UZiSNQ773mIDlW9Ihuk6sKfWsX44uR+0r645SMPREC5WBsfNjbwR5l6
         LWrL0DufUqtA1JQYh2UdWMLF2e8YVdieJ6j2uuny/CN0rXm/UauMfeeQfdxK//r5S8bR
         gFUt5JL11G7kGNW4uFwAmHCh6dGlNoOkYbrYpeeGjGg8+LnTKNl5W/sTQJwNnMtoKm6/
         8odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r5jQZEvrvoiRPnljbDishXIHpNfwezqlOhoU6Y2vNU8=;
        b=MOJu9qFUO1IKRlV7oK5wWp6rBbyFOWYQrrM9kiC8dgGT4rpgcbBMhD9jcvpXgL8x1W
         /uNvD1sNqP/7ryvwxN46Bc7L7KvrWI7CenDpbLuBEviZgqrMzkhmisLK2dXHcgtb8NGf
         PrD5x9p15HLBrDsPUqYRyXbwefB3047300LarViyi6yXqUzvxgaLjVpO5ebXtT3I5iYI
         kioSh8dFVswBNwAe5Z7IxbplpbWL2t9YGvfaYL5pTMZbByO+8SBEe8yG3giMo8rqJuUZ
         4QoLz/aFF2LMlbCzHO6Q6SIWCo+LWxmkXVSjVNjdVQyDyZ5gOjVat13iHilmT6wbMDVb
         lv8w==
X-Gm-Message-State: AKwxytcTDGUik9ziGzDIXZWDdsI1HufMLYaV3CtR9xn9C/4Ozq485VeC
        xbNKXx1W1LwiNi+BLudTzNHCFv2bI6y0EfAX+jBftQ==
X-Google-Smtp-Source: ACJfBos4XNwR7SkKQRFcQ4JE8Z2PKKlrYZUwDI/tKeBnRvhEeHcHoCodfBZqpNZDi1sPxoX6YHsPRgI2SV6W4ySp5uI=
X-Received: by 10.202.76.214 with SMTP id z205mr4177644oia.183.1516321619438;
 Thu, 18 Jan 2018 16:26:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Thu, 18 Jan 2018 16:26:28 -0800 (PST)
In-Reply-To: <20180118224814.GA8473@sigill.intra.peff.net>
References: <20180113132211.13350-1-pclouds@gmail.com> <20180118100546.32251-1-pclouds@gmail.com>
 <20180118224814.GA8473@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Jan 2018 07:26:28 +0700
Message-ID: <CACsJy8CPHk+aXHr-mkHZi27s=c3+ny8D9CSuzOSO8PweviBcqQ@mail.gmail.com>
Subject: Re: [PATCH v2] diff: add --compact-summary option to complement --stat
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 5:48 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 18, 2018 at 05:05:46PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> This is partly inspired by gerrit web interface which shows diffstat
>> like this, e.g. with commit 0433d533f1 (notice the "A" column on the
>> third line):
>>
>>      Documentation/merge-config.txt     |  4 +
>>      builtin/merge.c                    |  2 +
>>    A t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++
>>      t/t7612-merge-verify-signatures.sh | 45 ++++++++++
>>    4 files changed, 132 insertions(+)
>
> I like the general concept. Perusing "git log" output, though, it felt
> like the summary column was very close to the filenames. What do you
> think of putting it after the "|", where it is only close to a number?
>
> Something like the patch below (on top of yours, but it probably needs
> tweaked further for graph_width), which gives:
>
>    t/t5573-pull-verify-signatures.sh | A+x  78 ++++++++++++++++++++++++++=
++
>
> (I know this is a bikeshed, so I'm perfectly willing to take "yuck, I
> don't like that as well" as a response).

The position of A+x column is exactly where gerrit put it. Though web
pages have more flexibility than our terminal console so its position
does not have to be the same. I'm just throwing options out there

For many years I have this instead

 t/t5573-pull-verify-signatures.sh (new +x) | 81 ++++++++++++++++++++

Another option is just wrap the code in [] to make it look like check
boxes. But that wastes two more columns

       builtin/merge.c                    |  2 +
 [A+x] t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++++++++
       t/t7612-merge-verify-signatures.sh | 45 +++++++++++++

Back to your suggestion, I kinda like the closeness between the +/-
count and "|" though. The output on 10c78a162f is like this, which
makes "A" looks a bit umm.. disconnected from the path name?

  Documentation/RelNotes/2.14.0.txt | A  97 +++++++++++++++++++++++++++
  GIT-VERSION-GEN                   |     2 +-
  RelNotes                          |     2 +-

Another way is just separate the status code from file name

 A | Documentation/RelNotes/2.14.0.txt | 97 +++++++++++++++++++++++++++
   | GIT-VERSION-GEN                   |  2 +-
   | RelNotes                          |  2 +-

Last note. With colored diffstat, we should be able to use a separate
color (or something in the +/- part) to denote new/deleted files. I
didn't think about this...

>> The new option --compact-summary implements this with a tweak to support
>> mode change, which is shown in --summary too.
>
> One thing I noticed is that --compact-summary by itself does nothing.
> Should it imply --stat?

It might go with --numstat or --dirstat in future too. Didn't really
think hard about this yet. But I probably will go with Eric suggestion
and keep this in --stat=3D.... unless it really makes sense to have
something like this in --numstat or --dirstat.
--=20
Duy
