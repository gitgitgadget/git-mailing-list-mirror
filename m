Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632ED1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 06:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbeD1GIg (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 02:08:36 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:41223 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbeD1GIf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 02:08:35 -0400
Received: by mail-ot0-f170.google.com with SMTP id t1-v6so4379084oth.8
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bt5Pja5f7J4/H058SZDoyJz365grNa2G7OaFe37Gtp4=;
        b=L8TETZLBZ+YS+2Qqvr3sY7NVkfy1VZcIDTmh8AobUBnEUEkjTHpkN2LRuZjSAGUHQ1
         mKhDElBfxvfFEIVZvzzeflu8jK79TDblSkKKUrkwFB1VmEfJOeJFBbR84kibKlOXOjNx
         SASNug2XMp6qLNE+phGdj6j+jrc6O2/P/FFQ38ES3d9bc38Szh+L6H5lR6SRioQ2xxlo
         Of85/c9U3zMrFq/hvUPpfzoDMXT8eTyNttJ/H2Z5Bz7YHG+Fe9zJ0xqxWl8WhBgjdlL6
         6rglJtA3mEMCqNKzJYnpyBCy5Ls/f8LoNs+RUwwLkYnYWOi9iSecMPDSjsWK2IGokeKA
         pACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bt5Pja5f7J4/H058SZDoyJz365grNa2G7OaFe37Gtp4=;
        b=ckgPJ53PxnmRKnO+nrVYvgOto7lAAgOeWo7lDDf47bN0dHi3TWnmE7wXQTtinoPSTW
         lnsRDrjQR2WuFVJdp4wFUdfkK5YHE4h23ONhvd6XwM6QcJw284AYnyPo4ryEcqlwwnQd
         kQZxgSuqTx2xUWUBju4Hc53gItAk5gZHRN0ISWsWxMmEdDgGf8aVNJsbG6hUHVIWmiUl
         ftreHee9foia8QAOWOwTqKYZec2/1CJvQaNJ8saAcAYttTupDjalr2T3e7efCp1vgQzV
         B8s3hxPmy/l4L4Rvnr+tIL5Jf1HleZdRUGcnSGrYjVfXvCAnB+GiWtLrFS7vLD0Hvu5A
         XzuA==
X-Gm-Message-State: ALQs6tBbSeDaxGKdabbIXNt3dxoWgq0NKU/LhRMSiNNKBLCpGZK4kPiV
        V6W3H2AZQh1v00uCcdvik3EjOSfwh5jSqdrmYoo=
X-Google-Smtp-Source: AB8JxZqy3StSlx8Ah7iGfdPwP4GsRpzqMFMbpg8UTU0mxW3QA3nLIh9w8CV68t6j5MvihWnB+zfIKk6CpYkTyaJOCAs=
X-Received: by 2002:a9d:1d92:: with SMTP id y18-v6mr1784204otd.304.1524895715358;
 Fri, 27 Apr 2018 23:08:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 27 Apr 2018 23:08:04 -0700 (PDT)
In-Reply-To: <CABPp-BGPA5BVh7NpBeat+9f0-=ryNg61tf1osgKXGLGDBN1U6w@mail.gmail.com>
References: <20180413170129.15310-1-mgorny@gentoo.org> <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com> <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com> <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
 <CACsJy8AVTkqDomQW7Np5opnK+bMk53pcMtCQRBr-=QXEXs8Nqg@mail.gmail.com> <CABPp-BGPA5BVh7NpBeat+9f0-=ryNg61tf1osgKXGLGDBN1U6w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 28 Apr 2018 08:08:04 +0200
Message-ID: <CACsJy8Dumgu1ssFpa9v40BkzUrBbwpuj9vuispUHV41nT7pr5A@mail.gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     Elijah Newren <newren@gmail.com>
Cc:     Marc Branchaud <marcnarc@xiplink.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 11:08 PM, Elijah Newren <newren@gmail.com> wrote:
> On Fri, Apr 27, 2018 at 10:03 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, Apr 25, 2018 at 5:18 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>>>
>>> * In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are
>>> identical so the above loop does nothing.  Offhand I'm not even sure how a
>>> hook might get the right files in this case.
>>
>> This is a limitation of the current post-checkout hook. $3==0 from the
>> hook lets us know this is not a branch switch, but it does not really
>> tell you the affected paths. If it somehow passes all the given
>> pathspec to you, then you should be able to do "git ls-files --
>> $pathspec" which gives you the exact same set of paths that
>> git-checkout updates. We could do this by setting $4 to "--" and put
>> all the pathspecs in $5+ [1] e.g. "HEAD@{1} HEAD 0 -- path/to/file" in
>> the above example.
>>
>> There is  third case here, if you do "git checkout <tree-ish> --
>> path/to/file" then it cannot be covered by the current design. I guess
>> we could set $3 to '2' (retrieve from a tree) to indicate this in
>> addition to 0 (from index) and 1 (from switching branch) and then $1
>> could be the tree in question (pathspecs are passed the same way
>> above)
>>
>> [1] I wonder if we could have a more generic approach to pass
>> pathspecs via environment, which could work for more than just this
>> one hook. Not sure if it's a good idea though.
>
> Here's a crazy idea -- maybe instead of a list of pathspecs you just
> provide the timestamp of when git checkout started.  Then the hook
> could walk the tree, find all files with modification times at least
> that late, and modify them all back to the the timestamp of when the
> git checkout started.
>
> Would that be enough?  Is that too crazy?

For this use case? Probably (assuming that timestamp precision does
not cause problems).

I'm more concerned about what info post-checkout hook should provide
but does not. Giving hook writer a way to get the list of updated
files lets them do more fancy stuff while providing checkout start
time probably only helps just this one case.

Providing start time in general for all hooks sounds like a good thing
though (and simple enough to implement).
-- 
Duy
