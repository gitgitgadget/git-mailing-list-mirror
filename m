Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124D21F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759255AbeD0VIJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:08:09 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33914 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759077AbeD0VII (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:08:08 -0400
Received: by mail-ua0-f180.google.com with SMTP id f22so2028606uam.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PCU/ccxTlwxih4FYRwBkna2cNJs+UkyzevrwVz8iMeI=;
        b=HZBQe9AV3/WpZZdVg90HvENv1Hy0kYiXlAelbUuiALZqWqyBEjbJ1qxBjE+3eI4u6e
         YkMRLF5S5RQ2R2WzP9MZ5HkfNIFVVu8NSYdCBiYA/h4+TtmLkf+xJbK5yc6tAdy8WB5b
         MgNMu7UyXhZzHRTMGvJl/kAPSsjlikAiHhcm0xjQCkmMgel8DKEpYYTvT2A2FdKZmrcI
         BPBzPmQgRsB75005hO6oni4f9uF0EG0rONnDOyETC8aL4JHI3xJAneXAerQHCgwiLawL
         YLYmDlfsS+AncfCRLviKjecfGSuPxNZaWMTxkMBTq3CnzsHZ5c8TfRNow7TnchtczI2W
         sMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PCU/ccxTlwxih4FYRwBkna2cNJs+UkyzevrwVz8iMeI=;
        b=fSEG8cRQO9VtixJRnJRFiG1eQkua5EDvZLu2cwtDzeUBeZK1NjnEBj14tbTc/c2+Av
         J6zJ/85VFv2YR4CMxBSkv6sbNL7Tcigj8YyxLEETPfpkVUFQa9z07nLgfnYDaWtsoWV5
         mhdMwYFp/l11ceia3Sk6/hoLgSnXO8sxmHf1+n5nBP1++E+ep6exStoZ1jtmtWJU/kHh
         EkL6/Xx1EnzRpl3F67X1P+l4q6Jrn1JG319pRcK31X+couNU3Y5RSi8vGIpE1oUO1dgh
         ww7z1ZVg8z1NdDa0nekSuliuISc3w3Vu170KylqXdImndm6t2R7A5vO51SrJj6ScOBp3
         Z/sw==
X-Gm-Message-State: ALQs6tDyuyQzYPeqv4Fi/FHE5lXwNfuKP7FT9q1yZg1bNOhj5hyex5Ke
        Hjb2wup18MvoF4dhJE2v3ZUhCAzeXsvLr/gV+D0=
X-Google-Smtp-Source: AB8JxZpzaF39g/hfIj++kyrNFWZwjN8FpdjOTUSPJqNk4RB7LTA7OcT4mo+bUT6dEFbJRwZylx0J/MkDgjgv/PoZxX8=
X-Received: by 10.176.90.48 with SMTP id l45mr2678197uad.79.1524863287585;
 Fri, 27 Apr 2018 14:08:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 27 Apr 2018 14:08:06 -0700 (PDT)
In-Reply-To: <CACsJy8AVTkqDomQW7Np5opnK+bMk53pcMtCQRBr-=QXEXs8Nqg@mail.gmail.com>
References: <20180413170129.15310-1-mgorny@gentoo.org> <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com> <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com> <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
 <CACsJy8AVTkqDomQW7Np5opnK+bMk53pcMtCQRBr-=QXEXs8Nqg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Apr 2018 14:08:06 -0700
Message-ID: <CABPp-BGPA5BVh7NpBeat+9f0-=ryNg61tf1osgKXGLGDBN1U6w@mail.gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     Duy Nguyen <pclouds@gmail.com>
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

On Fri, Apr 27, 2018 at 10:03 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Apr 25, 2018 at 5:18 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>>
>> * In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are
>> identical so the above loop does nothing.  Offhand I'm not even sure how a
>> hook might get the right files in this case.
>
> This is a limitation of the current post-checkout hook. $3==0 from the
> hook lets us know this is not a branch switch, but it does not really
> tell you the affected paths. If it somehow passes all the given
> pathspec to you, then you should be able to do "git ls-files --
> $pathspec" which gives you the exact same set of paths that
> git-checkout updates. We could do this by setting $4 to "--" and put
> all the pathspecs in $5+ [1] e.g. "HEAD@{1} HEAD 0 -- path/to/file" in
> the above example.
>
> There is  third case here, if you do "git checkout <tree-ish> --
> path/to/file" then it cannot be covered by the current design. I guess
> we could set $3 to '2' (retrieve from a tree) to indicate this in
> addition to 0 (from index) and 1 (from switching branch) and then $1
> could be the tree in question (pathspecs are passed the same way
> above)
>
> [1] I wonder if we could have a more generic approach to pass
> pathspecs via environment, which could work for more than just this
> one hook. Not sure if it's a good idea though.

Here's a crazy idea -- maybe instead of a list of pathspecs you just
provide the timestamp of when git checkout started.  Then the hook
could walk the tree, find all files with modification times at least
that late, and modify them all back to the the timestamp of when the
git checkout started.

Would that be enough?  Is that too crazy?

Sure, people could concurrently edit a file or run another program
that modified files, but if you're doing that you're already playing
race games with whether your next incremental build is going to be
able to be correct.  (Some (annoying) IDEs explicitly lock you out
from editing files during a build to attempt to avoid this very
problem.)

That does leave one other caveat: If people intentionally do really
weird stuff with having files with modification timestamps far in the
future.  However, it seems likely that the group of people doing that,
if non-zero in number, is likely to be dis-joint with the group of
folks that want this special
uniform-timestamp-across-files-in-a-checkout behavior.
