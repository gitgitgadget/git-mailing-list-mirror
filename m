Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 687AC1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 18:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbdKNSYo (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 13:24:44 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:51184 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbdKNSYj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 13:24:39 -0500
Received: by mail-ua0-f178.google.com with SMTP id v27so14546989uav.7
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 10:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=69wBWmxBWiQAuWZcpERsfUGTZRuoI8PrFf8Bu8arU8A=;
        b=hL0SmRmNzjqMU7u1nn4ZLqyu91d3StoABN7yDXcWXMCQ1RALvbW8pqUaEBGc97xLWr
         zWgIQrF8AbIXI4ar0QCxMUsS3BMXy2ql8hZ3BkbpYeUxT9/PrO9CIZ0e4YGeKZXx7pGZ
         lqp1w1ymNhgTYjfh6wcR/JpG3RuzfSoR8RBSIuklVlhtQhUR+krME9Gt5AZDcpD+YAtd
         jknBe9FQ/e4Wlp/9ZETJVfAd3WA3EJj9zH5UZ9Hx5qOVKkrLgrk+htwuYa7O4s1B8oxB
         Y0usEVrfA9E3i0mIh+FXoL9LmlmZvYr1kD9R4oLGJFFiKQF+Pt0tF6KBuCY0In7B6Ygc
         fYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=69wBWmxBWiQAuWZcpERsfUGTZRuoI8PrFf8Bu8arU8A=;
        b=MjWqsxxWEGRYD/CRRbdaWhg12EVXGCoKqPxitNeSF2m4MRsMvT+fLDeHa5jbFZ+Lbg
         55ckCgFWAzt0bcabOk/DtC3O4EEyzRs6gESL8SypoejsZMUqELXCw2NLtQiMQLI8TO24
         ObEtVGL+NDrZvGm5jpfTaTPOEwMNsuz2vZZIba3Vid8Dc4mdRVCYVNGNiz+QdxEV4x6L
         kK/oVqFqTrV+8AKC9r7ulVtUlyB48RxDwoocmWZkIyo9ha3MUUgykFasNU3JQzSdIAl8
         acxPjGm/ORkYfCVlwpYgdqOhdSZ1BzJvCJayqN2MAx1MwJxmFIT5mmPMJKxL5MpSsSme
         b7zQ==
X-Gm-Message-State: AJaThX7Bc+yApz6rM6XSYRftlbbPEUz0TNYH+cyjEW1vA7DTtRZDkFB3
        SfKo+oYEhksPzGErS4BZU5Z22eJhe/aIVSLdyEA=
X-Google-Smtp-Source: AGs4zMZMGoNw0AnqfVxIpJynYJ9vPTQ3S9zBGDjGBVS6uKEnvoQ1/cJolwO9MVEipQ8RYtki4/Y3le63abj29h1Pyy8=
X-Received: by 10.176.95.138 with SMTP id b10mr11920426uaj.55.1510683878099;
 Tue, 14 Nov 2017 10:24:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Tue, 14 Nov 2017 10:24:37 -0800 (PST)
In-Reply-To: <xmqqy3n94f36.fsf@gitster.mtv.corp.google.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-17-newren@gmail.com>
 <xmqqd14l5ugx.fsf@gitster.mtv.corp.google.com> <xmqqy3n94f36.fsf@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Nov 2017 10:24:37 -0800
Message-ID: <CABPp-BFJm9C1zTKVLeFf6fnhxrUhTd+XZsD17DezqFKwwzsEBQ@mail.gmail.com>
Subject: Re: [PATCH 16/30] merge-recursive: Introduce new functions to handle
 rename logic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 9:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> +struct rename_info {
>>> +    struct string_list *head_renames;
>>> +    struct string_list *merge_renames;
>>> +};
>>
>> This type is added in order to allow the caller and the helper to
>> communicate the findings in a single logical structure, instead of
>> having to pass them as separate parameters, etc.  If we anticipate
>> that the information that needs to be passed will grow richer in
>> later steps (or a follow-up series), such encapsulation makes a lot
>
> Hmph, I actually am quite confused with the existing code.
>
> The caller (originally in merge_trees(), now in handle_renames())
> calls get_renames() twice and have the list of renamed paths in
> these two string lists.  get_renames() mostly works with the
> elements in the "entries" list and adds the "struct rename" to the
> string list that is to be returned.  And the caller uses these two
> string lists get_renames() returns when calling process_renames(),
> but once process_renames() is done with them, these two string lists
> are never looked at by anybody.

Actually, if I remember correctly, my first stab was to do all the
cleanup at the end of handle_renames(), but then I ran into
use-after-free errors.  I'm not sure if I remember all the details,
but I'll try to lay out the path:

process_renames() can't handle conflicts immediately because of D/F
concerns (if all entries in the competing directory resolve away, then
there's no more D/F conflict, but we have to wait until each of those
entries is processed to find out if that happens or if a D/F conflict
remains).  Because of that, process_renames() needs to store
information into a rename_conflict_info struct for process_entry() to
look at later.  Included in rename_conflict_info are things like
diff_filepair and stage_data entries, both taken from the rename
lists.  If the rename lists are freed at the end of handle_renames(),
then this information is freed before process_entry() runs and thus we
get a use-after-free error.

Since both you and I thought to push this cleanup to the end of
handle_renames(), though, I should probably add that explanation to
the commit message.  Granted, it isn't actually needed for this
particular commit, because up to this point all the information used
in rename_conflict_info was leaked anyway.  But it becomes an issue
with patch 17 when we start freeing that info.
