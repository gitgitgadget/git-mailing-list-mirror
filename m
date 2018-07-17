Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0FAD1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 20:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeGQVb0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 17:31:26 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46663 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbeGQVb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 17:31:26 -0400
Received: by mail-yw0-f195.google.com with SMTP id e23-v6so908238ywe.13
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lMYGDIJ7XfmwWNv4y5mYfmJRUeQeFm/aMv/qpoKs48=;
        b=k9g0mPLMFBNUnRFi66Jg0tpCbw035KJcvCdwunDgiVnWPKmBzV4NKFnkj/BYGQZN2K
         6KtM9T9TG4qSmINl1xy1ZDgZJW7QFkZZ7Xox4f6pTRDsFtrQjVwambTD5JUxr/4fdheU
         Cr8nx/uQhHYkY0Jn9mwW58TzsJAZmxxEaidnYczUVZMFyhei19uPFl15mqI6kcRB5sfe
         jYNZtBqHlmz6hFqK3ZfqHFDtCnIW1nvdbGgb2N3etpj2CK6hZrJWw8Iwa+n9PHkeAJWo
         1RgR45zjT4XnCNRzJkay3z4Wh5CvZaE9mscNjgRqiW2wLjxg+45edSENEtk8dCenlTlp
         X/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lMYGDIJ7XfmwWNv4y5mYfmJRUeQeFm/aMv/qpoKs48=;
        b=JLIViWKYz4yfS+klPzYNIY+SvvWjJmG3aVPp5TF4VftTIM6KAPnm96hhsQeNXEt735
         h8VXHZAHkNzhXbzEfibgQmH70U1RxWEM2FRNwHMyqv/+Uje31u6iILudKQbpK4D057Co
         EGI4H5i41CE+L31EiHprpNQe/mRAqD2bdkmR6UHUrAC6IHQn3gCwzm4HV0fudi5+5XND
         EIyMXYi5LVmqv6nhYdrwsrUpccqNH1aB6348BVKCbSueXGLhPLix6WOLzFurmQ2ivlOA
         jxPC4xL+6KGQJnKSsAjA3Eq0JJTLAAmgH4w7GyXEuahbRrIDCYm8FcysaqPEP0t8//aP
         GGlg==
X-Gm-Message-State: AOUpUlF8I4XTaS3ljwZeesjN1hZSnFD+BTaHYZPOPopVqzlWQHolQiON
        9x4T+fJ/tPzSoeLitSVKlxSBy1Lfm+yeXW+QOFu2yg==
X-Google-Smtp-Source: AAOMgpfS2aZlC08AnjVvSJjUWVIWRuRFjA+1MlYL+UWiAa4IAzUg6Qxdd0kBjgOAcN+90q1Qkx2tfvAZowJi+rbpH2E=
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr1717976ywd.414.1531861019973;
 Tue, 17 Jul 2018 13:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180717002654.120375-1-sbeller@google.com> <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com> <xmqqa7qpod29.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7qpod29.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Jul 2018 13:56:48 -0700
Message-ID: <CAGZ79kbYtws-HhX_kQ5Gb4FeAfgRjbCfVbPS1Gcow4xfN-04XQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 12:52 PM Junio C Hamano <gitster@pobox.com> wrote:

> > (A) This sign off is inherent to the workflow. So we could
> > change the workflow, i.e. you pull series instead of applying them.
> > I think this "more in git, less in email" workflow would find supporters,
> > such as DScho (cc'd).
>
> Sign-off is inherent to the project, in the sense that we want to
> see how the change flowed recorded in the commits.
>
> With a pull-request based workflow, until Git is somehow improved so
> that a "pull" becomes "fetch and rebase what got fetched on top of
> my stuff, and add my sign-off while at it" (which is the opposite of
> the usual "pull --rebase"),

and here is where our thoughts did not align.
I imagined a git-pull as of today (fetch + merge), where you in the role
of the maintainer tells me in the role of an author to base my series
on top of $X, such that there is no need for rebase on your end,
(you would also not sign off each commit, but only the resulting merge)
Even merge conflicts could be handed off to the authors instead of
burdening you.

>  we would lose the ability to fully "use"
> Git to run this project, as we would lose most sign-offs, unlike the
> e-mail based workflow, which we can use Git fully to have it do its
> job of recording necessary information.

I think all needed information would still be there, but there would be an
actual change as authors would be committers (as they commit locally
and we keep it all in Git to get it to you and you keep it in Git to put it
into the blessed repository)

> And much more importantly, when "pull-request" based workflow is
> improved enough so that your original without my sign-off (and you
> shouldn't, unless you are relaying my changes) becomes what I
> pulled, which does have my sign-off, range-diff that compares both
> histories does need to deal with a pair of commits with only one
> side having a sign-off.  So switching the tool is not a proper
> solution to work around the "sign-off noise" we observed.

I do not view it as work around, but "another proper workflow that
has advantages and disadvantages, one of the advantages is that it
would enable us to work with this tool".

>  One side
> having a sign-off while the other side does not is inherent to what
> we actively want,

[in the current workflow that has proven good for 10 years]

> and you are letting your tail wag your dog by
> suggesting to discard it, which is disappointing.

I am suggesting to continue thinking about workflows in general, as there
are many; all of them having advantages and disadvantages.
I am not sure if workflows can be adapted easily via improving the current
workflow continually or if sometimes a workflow has to be rethought to to
changes in the landscape of available tools.

When the Git project started, an email based workflow was chosen,
precisely because Git was not available.

Now that it has gained wide spread adoption (among its developers at least)
the workflow could adapt to that.

> > The other (2) downside is that everyone else (authors, reviewers) have
> > to adapt as well. For authors this might be easy to adapt (push instead
> > of sending email sounds like a win).
>
> As I most often edit the log message and material below three-dash
> lines (long) _after_ format-patch produced files, I do not think it
> is a win to force me to push and ask to pull

Ah, that is an interesting workflow. Do you keep patch files/emails
around locally, only to (long after) add a message and resend it?
I try to keep any contribution of mine in Git as long as possible as that
helps me tracking and fixing errors in my code and log messages.

> > (B) The other point of view that I can offer is that we teach range-diff
> > to ignore certain patterns. Maybe in combination with interpret-trailers
> > this can be an easy configurable thing, or even a default to ignore
> > all sign offs?
>
> That indicates the same direction as I alluded to in the message you
> are responding to, I guess, which is a good thing.

Yes, I imagined this is the approach we'll be taking.
I think we would want to give %(trailers:none) or rather
"ignore-sign-offs" to the inner diffs.

Thanks,
Stefan
