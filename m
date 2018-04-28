Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660E11F428
	for <e@80x24.org>; Sat, 28 Apr 2018 06:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759506AbeD1GR3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 02:17:29 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:35334 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeD1GR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 02:17:27 -0400
Received: by mail-ot0-f177.google.com with SMTP id h8-v6so4401758otb.2
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 23:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HODO4u++cBqYgUWarP6frfoJlhLvaE6V1Gk6ZBdWhRc=;
        b=Kf0GWnGIakdrjWPy7mn3B5YnaIbAGe1VlhSM//Z7AyIiHzvgf/aZ/m1UjQcpS2oKls
         gC3BYVx/A1EFD1yETnFBXRLD6cIyEjKWLSzOMVw13vwvFx2sG2FoR9/2VYxgIfCdYS43
         mD158jQGdVfQ9dub+lMujIWjQ2EKCf9Br9h++WFaDP5h0H5piD3ZKQoT51V3KWveVxws
         6V4pIrYfAMeobm5a0vI42UMrWCKLSPnnpGTO0LYkNf+K0pglqdQejIWOkEDzeyYd3M8X
         SXKPpO4ZCAI0JHdvRz807WuA35ELiJ8qi74TFgHd5uk/NO4hezxoHcPAOlyZXP4+ajaZ
         DY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HODO4u++cBqYgUWarP6frfoJlhLvaE6V1Gk6ZBdWhRc=;
        b=oUBIyhkIhaj4o7nU53phFHgSSKkRI5YYpFNVMyriQzS5tzq1LbJXnn8BUNsPqHcuNw
         VQU4DlFVDZsevK383+PJDqSvanKTIGZsnCY897PlCsYsKUK7Arx9yFMp6wEvRQWUOEQF
         /4eQ204VeLJDm61S06PC6UbVS4+8nhfqLG8fsw0K4w8IqQ0NP/PMywIx8Azc9pSLQyl5
         mx5WGMTq+3RTyAtueQW1X9M1Q/Efz43e70+6jgzGAtgfadWi4AMc9nULKINpQ8gVvLrU
         rPdCNJu34TqwT/DyI5W8miX3gBrdf2HeXP04pnXKv2S9fYrOikvYBYiSYCUa/6lMhZix
         XMyw==
X-Gm-Message-State: ALQs6tBWhDCkzkWOjyhfH4FWb1+pBY8oqcF/jNNK4Pl/BwXwRdA45uBl
        5gEQfyVZNxIdnyg511EBjSYv9ubdHPOR05+/Mks=
X-Google-Smtp-Source: AB8JxZqXub+iPpqU2JbkQq0x1GGUIYIDpJwBD0t1ghrfNNIR13zxzGVU0vDanS0JRJavEZzSCuZQAXa4p6/l4ApyxHc=
X-Received: by 2002:a9d:4197:: with SMTP id p23-v6mr3481516ote.75.1524896247329;
 Fri, 27 Apr 2018 23:17:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 27 Apr 2018 23:16:56 -0700 (PDT)
In-Reply-To: <38e961ca-e354-6390-982d-4d0c9c9e55da@xiplink.com>
References: <20180413170129.15310-1-mgorny@gentoo.org> <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com> <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com> <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
 <CACsJy8AVTkqDomQW7Np5opnK+bMk53pcMtCQRBr-=QXEXs8Nqg@mail.gmail.com> <38e961ca-e354-6390-982d-4d0c9c9e55da@xiplink.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 28 Apr 2018 08:16:56 +0200
Message-ID: <CACsJy8D9=f8KSEne3RKka_QkS9-c05bZ3D3vRcJ3Wq9NXaBkhQ@mail.gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
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

On Fri, Apr 27, 2018 at 11:08 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>> On Wed, Apr 25, 2018 at 5:18 PM, Marc Branchaud <marcnarc@xiplink.com>
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
>
> I think there needs to be something other than listing all the paths in the
> command is viable, because it's too easy to hit some command-line-length
> limit.

I send pathspecs, not paths. If you type "git checkout -- foo/" then I
send exactly "foo/" not every paths in it. You can always figure that
out with git-ls-files.

Sure this can still hit command length limit when you do "git checkout
-- foo/*" and have lots of files in foo just one more param from
hitting the limit, then the hook may hit the limit because we need
more command line arguments. But this is the corner case I don't think
we should really need to care about.

> It would also be good if hook authors didn't have to re-invent the
> wheel of determining the changed paths for every corner-case.

Flexibility vs convenience I guess. A sample hook as template should
help the reinvention.

> My first instinct is to write them one-per-line on the hook's stdin. That's
> probably not generic enough for most hooks, but it seems like a good
> approach for this proposal.
>
> Throwing them into a temporary file with a known name is also good ---
> better, I think, than stuffing them into an environment variable.

This goes back to my post-checkout-modified proposal. If you're
writing to file, might as well reuse the index format. Then you can
read it with ls-files (which lets you decide path separator or even
quoting, I'm not sure) and it also provides some more info like file
hashes, access time...
-- 
Duy
