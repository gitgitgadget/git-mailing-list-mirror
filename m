Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC851F453
	for <e@80x24.org>; Tue,  6 Nov 2018 02:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeKFLqr (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 06:46:47 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:34298 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeKFLqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 06:46:47 -0500
Received: by mail-io1-f47.google.com with SMTP id d80-v6so8163127iof.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 18:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97VPbps/IQu0mcU63NfpRQV7fgiUiZmJNVT8A5v7YcA=;
        b=hGbGSLDF03Qz6d84zmb3wYneuxpOAyWK9tpBmLuTTv074po6qbtIL4RnHm7gaem9ui
         h5wh4N0bIS2NOmOHK0+l7/BBlCG2VlNbaRhJ1FgZC4YvHHe5P4JXMAF1Nl7KpVZNYT8p
         ykA898/vtTGbjP4VojNAJQaJziVwJt4GLgy1f3MMzCV2dG8LQBoCtkEMv7o2qdKvFURI
         z6udD9ysTiVgpG5MZxH5DCLbLM79w9JvZoYtyORqYZRVnWn7v9rS7zFPdlO4k/CuMBNs
         fCOkypyRpGJeyBvTRNF2UJlAbk60HmPLjwLA980z71WAkL5p7og/NAQtsUL0hzfSx8H/
         uknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97VPbps/IQu0mcU63NfpRQV7fgiUiZmJNVT8A5v7YcA=;
        b=OfzSr7NiIp++eqtDkDL01UrmigDZiejreT6xLSrf+RRxzoS8KdgUZjufsgClBUkP8u
         EAXw0IaEnitVpYJZc5/OdwE/j2QTQLraVpp2XebukonUKJAr02dGb23+31KRwMseavkT
         ZMZtIjQi6h1ch26pByKOLt7nSTrSVdXpAKvXQ5G5HeDBbtwawT0qZkybRvW18zywLZy6
         /p6KQGWaSu42kITL92wTnT5n57ouU1KgSK0eAdvW5XiuHqa/JOtmB0yKEKU6aWQS4o5l
         +TZ2gJULMNFsMJMLqOAZ6Rgh6RgLXfsNdwlt8MgCCakpzddEgQp0DYl5h4eQEv91RJz+
         eyCw==
X-Gm-Message-State: AGRZ1gI26dRuR6g2s7gCr6MPehxQfoJL1Z4D3YL/OXR3QxeakrFuvATK
        EHM/Od9huHB0bKgpph5wa6vePniQVOHEkCl052c=
X-Google-Smtp-Source: AJdET5e5LAAYjNvTJCgr+GHaT9CwsuSr9VYDQAA/ydoXOD4I3+wrFnuxVJ1Vp5lsukqidx7hCgrvSXN87CIy0dLwflM=
X-Received: by 2002:a5e:9501:: with SMTP id r1-v6mr18828639ioj.224.1541471037792;
 Mon, 05 Nov 2018 18:23:57 -0800 (PST)
MIME-Version: 1.0
References: <CAFd4kYBDWMvVgDmNTzwOK9Q7n_Fb0NrvNAFgHtKvkLkRFWqUKw@mail.gmail.com>
 <xmqqlg6covi6.fsf@gitster-ct.c.googlers.com> <CACsJy8DFUeEddSa2z4VTSqhaUBJ4+SUf8xvjh6iWY2Phhh96iQ@mail.gmail.com>
In-Reply-To: <CACsJy8DFUeEddSa2z4VTSqhaUBJ4+SUf8xvjh6iWY2Phhh96iQ@mail.gmail.com>
From:   Farhan Khan <khanzf@gmail.com>
Date:   Mon, 5 Nov 2018 21:23:45 -0500
Message-ID: <CAFd4kYDcX2BOYvMg1X9zO68EfYYE6Zke_-9CGY-Yi01jCc3EPA@mail.gmail.com>
Subject: Re: Understanding pack format
To:     pclouds@gmail.com
Cc:     gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 12:00 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Nov 2, 2018 at 7:19 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Farhan Khan <khanzf@gmail.com> writes:
> >
> > > ...Where is this in the git code? That might
> > > serve as a good guide.
> >
> > There are two major codepaths.  One is used at runtime, giving us
> > random access into the packfile with the help with .idx file.  The
> > other is used when receiving a new packstream to create an .idx
> > file.
>
> The third path is copying/reusing objects in
> builtin/pack-objects.c::write_reuse_object(). Since it's mostly
> encoding the header of new objects in pack, it could also be a good
> starting point. Then you can move to write_no_reuse_object() and get
> how the data is encoded, deltified or not (yeah not parsed, but I
> think it's more or less the same thing conceptually).
> --
> Duy

Hi all,

To follow-up from the other day, I have been reading the code that
retrieves the pack entry for the past 3 days now without much success.
But there are quite a few abstractions and I get lost half-way down
the line.

I am trying to identify where the content from a pack comes from. I
traced it back to sha1-file.c:read_object(), which will return the
'content'. I want to know where the 'content' comes from, which seems
to come from sha1-file.c:oid_object_info_extended. This goes into
packfile.c:find_pack_entry(), but from here I get lost. I do not
understand what is happening.

How does it retrieve the pack content? I am lost here. Please assist.
This is in the technical git documentation, but it was not clear.

Thank you,

--
Farhan Khan
PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
