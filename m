Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74162042F
	for <e@80x24.org>; Wed, 16 Nov 2016 16:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbcKPQtb (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 11:49:31 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34663 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbcKPQta (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 11:49:30 -0500
Received: by mail-yw0-f195.google.com with SMTP id a10so15182898ywa.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 08:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i82dWaepDIYyhKBj3260fztRFtcPXeDR4y73Ta249nQ=;
        b=QFBU0/Hc7pK5N0LP0jXsk2c62u/zL6XR8D4OibezFuXzjS18QBwE9yClyQayc+eBEG
         sJlz3WX69BgNL3HOjm+2V5hWM+GnHQbs0gkUkeO2AJvIXbYEutMIfTvRe2cx0b2yZG7D
         bXp+GcI/sKFsHDSOo4vh/X/6sgrt2IF7FCu5GZ4auwzCCBkNtEc09Ga5dABFUqAz9/SM
         fajlkCubIjTbMcIInlVLhXSy2ftw4BZCSfu6ObrxSUDb9EQt4oJhANYYLzpjRNU8O2yZ
         p+iMV8wemTUyzmUf3abXOdKf39PNj+yXEdl2Dpv7An3KzDvpDM4XgwteccIXqlHbAtm0
         00IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i82dWaepDIYyhKBj3260fztRFtcPXeDR4y73Ta249nQ=;
        b=c7r82HHNahC18a36a77N6AxAAeRhlzI5liyz0bIgoeXPHli8D1mtwz56cX3mVh829+
         DHUlfmi6M7AiFjCoBMSswNnB1gXh1wcKkBZfisd2jYbmO0WNnf6dJy7kVfR+fbQ8Qo3r
         hjRDsOzSVP30Lw8hBbNG/U1ffH3oLE/Wa11r3/AxvccFZhBc9JK9Xwd0LgfC+VYhNllF
         0QS5nhA/AwE7Ale0gvf7FIzmI4jpQekg1miTSMxZsezwLMBDnaiwIkP50bCGbQ7307gY
         2pWMnbRPO+LS7s7+gvGtXMPj9pOlb0CYRoGaUOv4lUt1gFvHTcy7xlBVXmXG+mOK3lAZ
         lXyA==
X-Gm-Message-State: ABUngvfsf/LP2smouNGCySjNNhXdqhnPKcNUjRF+wjiz4gohwh98k/OBCry1YXFaWiveuxFIVnlPzwTetoQOcg==
X-Received: by 10.107.182.70 with SMTP id g67mr3914135iof.120.1479314969036;
 Wed, 16 Nov 2016 08:49:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.27.209 with HTTP; Wed, 16 Nov 2016 08:49:28 -0800 (PST)
In-Reply-To: <xmqq37istoay.fsf@gitster.mtv.corp.google.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1a82-dc1c5b57-3e93-4996-87e7-4a1d83cb5817-000000@eu-west-1.amazonses.com>
 <13aa642a-2272-c5b8-4a30-382ab5e73b98@gmx.net> <xmqq37istoay.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 16 Nov 2016 22:19:28 +0530
Message-ID: <CAFZEwPMrC=7wJtUO+G3dcESPOJisFsrZ0_F6oKE8eDVGfBEVpg@mail.gmail.com>
Subject: Re: [PATCH v15 04/27] bisect--helper: `bisect_clean_state` shell
 function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Wed, Nov 16, 2016 at 3:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Stephan Beyer <s-beyer@gmx.net> writes:
>
> >> +int bisect_clean_state(void)
> >> +{
> >> +    int result = 0;
> >> +
> >> +    /* There may be some refs packed during bisection */
> >> +    struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
> >> +    for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
> >> +    string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
> >> +    result = delete_refs(&refs_for_removal, REF_NODEREF);
> >> +    refs_for_removal.strdup_strings = 1;
> >> +    string_list_clear(&refs_for_removal, 0);
> >
> > Does it have advantages to populate a list (with duplicated strings),
> > hand it to delete_refs(), and clear the list (and strings), instead of
> > just doing a single delete_ref() (or whatever name the singular function
> > has) in the callback?
>
> Depending on ref backends, removing multiple refs may be a lot more
> efficient than calling a single ref removal for the same set of
> refs, and the comment upfront I think hints that the code was
> written in the way exactly with that in mind.  Removing N refs from
> a packed refs file will involve a loop that runs N times, each
> iteration loading the file, locating an entry among possibly 100s of
> refs to remove, and then rewriting the file.
>
> Besides, it is bad taste to delete each individual item being
> iterated over in an interator in general, isn't it?
>

Not just that, deleting a ref inside for_each*() is illegal because it
builds some kind of index and that is spoiled if anything is deleted
in between. Thus it gives a seg fault. See this[1]. I did the same
mistake when making this patch and I was confused about that was
happening but then Michael Haggerty pointed this out[2].

[1]: https://github.com/git/git/blob/v2.11.0-rc1/refs.h#L183-L191
[2]: http://public-inbox.org/git/574D122F.7080608@alum.mit.edu/

Regards,
Pranit Bauva
