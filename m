Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6451F404
	for <e@80x24.org>; Thu,  6 Sep 2018 21:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeIGCCg (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 22:02:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42592 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIGCCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 22:02:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id l5so10029189edw.9
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6I4uhoCAmQv2XquctP4ZzniNPD3VmBiQ9+o9kf6y07M=;
        b=b5M1lP5EUSOL60PLyqAaLTMegwIwYANZAuHXAti17AmdiH1r+4+c+w5tEcYDL24zWu
         hiij5kAUvjb5wogf55sBHOSYU/gB4c2LhnejnlvDnDm2+pnbyaxAOa5ph2crwlMtJJL+
         eUxiuj+Um0NXI9z8xfernXdQ84iOBCQ/05U67Hay76DLIwB54zjIzbOkrgENO1ev1zLU
         0JkQJXmGL5jv6wuHKhSTY725sVcRtVkrLwKaOtWYd6LeegCvkqSH1DPOCel4K+r9GzaJ
         to28NXRHWQd73TpxDZu+P2gp0kFxSWJf1V7fYZfRoSpddp69dmwLlG287et5wTUUhNyY
         D4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6I4uhoCAmQv2XquctP4ZzniNPD3VmBiQ9+o9kf6y07M=;
        b=P+Mit/rKyxAM/LOxX/1udSb52z7Q1pccg+lxaAtUZCiMHLt8zvzHgFRaFOVsXbGdJw
         rR5gEAGk7ijFa4Y/KhBmkUewdVdYY1ia9cxlg6fRd87e+BG963dCyxfRrzRzwWAjvFVd
         Gp+W3/27ehdgUAVWDWSqN2vAaz7SVrjFsA6ZA8keVRh1M7HhamXbF+GYxivHThmtZRn1
         J/gLI8xJfa9Y1bbyjqZylFxUyWd6uF3bNyIAGAcq0HId95KX/4q9v6mtcJS+0Ieqe+CK
         cO99IcRUssDsZj++lxP+EciXxGKH+D070+J5PfH6yLu9R5JXwB32Klvxy8w0jPsl/qfp
         Rm6w==
X-Gm-Message-State: APzg51CWA9NDRHwHtDWWBqXyjKnAch+BoNGAwuXUDGOrT/5nhnVIoPbU
        52s61xWiAN2yV2hFe6QHOO2W1EqRp3wwXhK7sB4zBnOU
X-Google-Smtp-Source: ANB0VdbzL956p4zvhezVuom7o+A9n+VzUnKp/bOxqirauA0Pl+FhxWBoL7bQ7CUNhA83bijtKgCCiIefXvAX8X/ebpM=
X-Received: by 2002:a50:b410:: with SMTP id b16-v6mr5759797edh.190.1536269112422;
 Thu, 06 Sep 2018 14:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180905225828.17782-1-sbeller@google.com> <20180905231258.GD120842@aiede.svl.corp.google.com>
 <xmqqefe6z5ws.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefe6z5ws.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Sep 2018 14:25:01 -0700
Message-ID: <CAGZ79kbFGdtGL7jpYRrw_KaxJ5NY4HZNauOy-y3sxqnNDkHfWg@mail.gmail.com>
Subject: Re: [PATCH] diff: allow --recurse-submodules as an synonym for --submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 6, 2018 at 2:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> > It seems like various commands are gaining --recurse-submodules options
> > taking different kinds of arguments:
> >
> > - clone takes --recurse-submodules=<pathspec>
> > - fetch takes --recurse-submodules=<mode>
> > - after this patch, diff takes --recurse-submodules=<mode>
> >
> > Is there a unifying principle?  Can Documentation/gitsubmodules.txt
> > say a word or two about what kind of argument values the user should
> > expect to be accepted by these options?
>
> I am not sure if the above is rhetorical.  The only thing such a
> document can say about status-quo is that the user cannot make an
> educated guess, as there is no consistency.  Some take an option to
> clarify which subset of submodules to act on, others take an option
> to specify what variant of operation to be made on the submodules.
>
> In the ideal world, the users ought to be able to give these two
> independently, i.e. "fetch" should be able to say "only fetch these
> submodules" with pathspec while "run the fetch in all of these
> submodules specified (with the pathspec) as necessary" with
> "on-demand" mode, for example.
>
> It may mean that it is too early to add "diff --recurse-submodules"
> as a synonym for "diff --submodule", before what we can do to
> improve the situation for commands that already take that
> "--recurse-submodules" option.

Good point. So let's retreat that patch for now?

Stefan
