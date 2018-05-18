Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB4C1F51C
	for <e@80x24.org>; Fri, 18 May 2018 21:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeERVZ3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 17:25:29 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40599 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeERVZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 17:25:28 -0400
Received: by mail-ua0-f195.google.com with SMTP id g9-v6so6291263uak.7
        for <git@vger.kernel.org>; Fri, 18 May 2018 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zdv6uE0+6qKx1XTdkOLQGI2wWjog4Bzcb0DYR+gvuSI=;
        b=Y32GHz/b/yhS5QoSq4v1m4W4x941uhI9F5uYHH25dSlPyCJeX6NCFHaMHy+1QYWmn4
         GOmw4Rz+V99IKlGFd4SDbxjEKyCT1cwYQg3WzMsF529/Xz0cawpkjJ+TlITPNVLW9usH
         echaL0BFOgCSAa9Jh74LXTs3BFyI5zwrR5VKCWpM2U1YLi0sCwEb1NXqDq1R9sdZlC+h
         rXSu3Fj2yUywT3YVuB5++1zlUvcqiHtQI5fsu2bG5pkiBDlnfJvMFYBif0N6oDGMTcqw
         RIVqh4UKJ3Gt0zqn4aNl/gBXtRTG/GZQvpGJnckLgif4NCMy/VjvNgdyPeTpEGRKHxgH
         4dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zdv6uE0+6qKx1XTdkOLQGI2wWjog4Bzcb0DYR+gvuSI=;
        b=qvzPlhkQtOEGktVtScFU+YYTld3U8ObpX86z/V/gQ2YrJwFvFtIrgRi+LCIk2kULfk
         9b3HDd+JEW37un9hjVUsXRrXauGMP/Wwy6/7Olr8GoqEPYiHfWryPbWUBSRcohKoHUfx
         z0R0WfMA9h3cQnA9tq1VJMDfTxuCVqOivlzASW8DyG27i1CJGDNqTOEGHBeZxYEg7szF
         muN5a20o0V5rOsnRCz+2PJfucNS11WYqT+D61Hjk0vWCSw7kHJzmSrcZhfWv/KugwFPf
         yVgO4beNWH3aas/XHUHHQ6qqHF+iuXwTOzX59X9b73akgpRh8G1yPxwdBmORshS3H32J
         AD+Q==
X-Gm-Message-State: ALKqPwd3h8/WMeaPpqhYBPI62YiQSJKHZOHmG/Bncg7bMm1/AL5E3TsL
        9PuzL7i1Di5vBSohADNlGAqrV4qPEqMUFwFHRQEe6g==
X-Google-Smtp-Source: AB8JxZpLRk21+dIGV2AiLeCp9LDCBGcD0zB+TM8yVFbhsqUc+LGRpOUPxGcf9yW6stsMAmuG3kDR69y+j+QMyaBw2XE=
X-Received: by 2002:ab0:15c9:: with SMTP id j9-v6mr8518694uae.199.1526678727263;
 Fri, 18 May 2018 14:25:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 18 May 2018 14:25:26 -0700 (PDT)
In-Reply-To: <20180518194802.28355-2-leif.middelschulte@gmail.com>
References: <20180517184008.25445-1-sbeller@google.com> <20180518194802.28355-1-leif.middelschulte@gmail.com>
 <20180518194802.28355-2-leif.middelschulte@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 May 2018 14:25:26 -0700
Message-ID: <CABPp-BGGe3r_QiC5264xkj0cp2Vu6WoLQZeDGEJi4eOpUW9z3g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Inform about fast-forwarding of submodules during merge
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Leif,

On Fri, May 18, 2018 at 12:48 PM, Leif Middelschulte
<leif.middelschulte@gmail.com> wrote:
> From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
>
> Silent fast-forwarding might lead to inconveniences in cases where
> submodules are expected to have a certain revision, because 'more recent'
> (therefore fast-forwardable) versions might break behavior/contain regressions.
>
> A use-case is the integration (merge) phase as part of the feature-centric
> 'git-flow' workflow [0]. I.e. a feature might be well-tested with a certain
> submodule revision, but break because of regressions (or changes in general)
> within an updated version of the sourced submodule.
>
> This change tries to support the integrator by telling her about another possible
> source of unexpected behavior (differing submodule versions) she might see
> during integration tests.

Thanks for continuing to push on this.  This looks good so far (to
me), but I was also hoping to see the analogy between these messages
and "Auto-merging $FILE" for regular files mentioned.  Both Junio[1]
and I[2] pointed out this similarity, and I think this
similarity/analogy is useful additional motivation for making this
change.

[1] https://public-inbox.org/git/xmqqo9hg7554.fsf@gitster-ct.c.googlers.com/
[2] https://public-inbox.org/git/CABPp-BGaibCPWuCnaX5Af=sv-2zvyhNcupT+-PkxHDfJBg_Vbw@mail.gmail.com/


> +               } else if (show(o, 2))
> +                       output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(b));
...
> +               } else if (show(o, 2))
> +                       output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(a));

Also, by analogy to the "Auto-merging $FILE" comparison, the "to %s"
on these two lines feels out of place.  Users can just look at the
submodule to see what it was updated to.  In a sea of output from
merging, this extra detail feels like noise for the standard use-case,
unless I'm misunderstanding how submodules are special.  Junio also
commented on this in the same email referenced above (at [1]).  Is
there a reason this is an important piece of the message for you to be
shown at the standard merge verbosity?
