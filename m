Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546731F437
	for <e@80x24.org>; Thu, 26 Jan 2017 09:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbdAZJMq (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 04:12:46 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34455 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbdAZJMn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 04:12:43 -0500
Received: by mail-oi0-f53.google.com with SMTP id s203so459129oie.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 01:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PF94dfdP8WQFKLQmxwXw0I4dqyW/RlCJSVnPBKf5C5Y=;
        b=pzugvfty1P9eDxx17XS7QuSvuExKFJ9HrN+pt838m2yRkZoHDxvSJLEHVlkDIIEfqw
         NPOC1DsNNQM5wOuQt/zAUBhaVPG24XRQN5iNRjeh/sRtO2ls77C1sxX00uv4O5i8BbzU
         j4OntMWsaNKwyvBFafiPqHzBqLeUllwHHRz1+ejV7XQc9CvbDHws9wtQTe6+vbn9sM8r
         Jk1fv+VLDkPE7bWfLhhQ+DkH2bXmiKX800gtY8r+oXxXfvq6cuUZ2O1isOAZ5CdgbiWD
         oXwZKH5J3NT5SIC3oAJ0BJGdLzmfyBOVmV2NK61r+TbGdGxVYXMLcfJueLGyQSrUp9+b
         TX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PF94dfdP8WQFKLQmxwXw0I4dqyW/RlCJSVnPBKf5C5Y=;
        b=GtXXL9JRUqkKgh21/EEn2/rbKdIeB1zruYT0hrYby/RITSAW3O/fOygvVpzonHwHBL
         HCDv69k15cnwytMnDThXGvJrLtf++8O4igUXQ6RRLUG2fOLjx0krMM5Zxd7pFZOJxMED
         Z7xDpld6fQnXn57Uyj+CNVylg61DXal+PK65XRTbAz2q0bSNHbE9CpUQ+no7j5U2oHV9
         q1jwxFBx9QYW3v1vb2z/3VZIKiLmTIiNkp4oM2TYwIDt/1f6QasIbGXVv+hE4uw5TIeK
         FPKr1IR/Qm8PJsr/ON7DD2VwgTZJCqrxwF8ozA/o+FhtTlvvvwtZ83TmG2MIgMn5xsrA
         F3Zw==
X-Gm-Message-State: AIkVDXKcyCvehtZo0rkhVBiZdPiPYzJHvEAKpYmaNcYB8jpjHiDbEKE+p5xJyaUulpdsZ3PgM3Ld9jNLQFtCaA==
X-Received: by 10.202.173.18 with SMTP id w18mr1015378oie.146.1485421962393;
 Thu, 26 Jan 2017 01:12:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 26 Jan 2017 01:12:11 -0800 (PST)
In-Reply-To: <xmqqo9yualqn.fsf@gitster.mtv.corp.google.com>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com> <20170125125054.7422-3-pclouds@gmail.com>
 <xmqqo9yualqn.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 26 Jan 2017 16:12:11 +0700
Message-ID: <CACsJy8Dwr5g6ZvemYgfg7Lecu=PsWz734tWgfFDCkWB_Htg7Hg@mail.gmail.com>
Subject: Re: [PATCH 2/5] revision.c: group ref selection options together
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 4:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  * I am expecting that the new one yet to be introduced will not
>    share the huge "switch (selector)" part, but does its own things
>    in a separate function with a similar structure.  The only thing
>    common between these two functions would be the structure
>    (i.e. it has a big "switch(selector)" that does different things
>    depending on REF_SELECT_*) and a call to clear_* function.

Yep. The "new one" is demonstrated in 5/5.

>    If we were to add a new kind of REF_SELECT_* (say
>    REF_SELECT_NOTES just for the sake of being concrete), what
>    changes will be needed to the code if the addition of "use reflog
>    from this class of refs for decoration" feature was done with or
>    without this step?  I have a suspicion that the change will be
>    simpler without this step.

The switch/case is to deal with new REF_SELECT_* (at least it's how I
imagine it). What I was worried about was, when a user adds
--select-notes, they may not be aware that it's in the same
all/branches/tags/remotes group that's supposed to work with
--decorate-reflog as well, and as a result "--decorate-reflog
--select-notes" is the same as "--select-notes".

With the switch/case, when you add a new enum item, at the least the
compiler should warn about unhandled cases. And we can have a new
"case REF_SELECT_NOTES:" for both --exclude and --decorate-reflog.
Without the switch/case, I guess it's still possible to do something
like

if (!strcmp(arg, "--select-notes")) {
    if (preceded_by_exclude())
        does_one_thing();
    else if (preceded_by_decorate_reflog())
       does_another_thing();
}

It's probably easier to maintain though, if all
decorate-reflog-related things are grouped together, rather than
spread out per option like the above.
-- 
Duy
