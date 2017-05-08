Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB981FC44
	for <e@80x24.org>; Mon,  8 May 2017 21:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbdEHVia (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 17:38:30 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36505 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdEHVi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 17:38:29 -0400
Received: by mail-io0-f182.google.com with SMTP id o12so30755696iod.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q09SA2qfudzfAKUVVEfBcqYGoPmBm2EV957Ym1cJH0k=;
        b=PmgUPb2ff1GTEwACJdYhzTN93KhcTwOpMpoL2G2+CuLZSvNsbswKsiI/tB9hDK3BNG
         nYLTZ3SQHp0FZCLZfiLkcqnLGr/ajYaGlooL0qSAdefk7xQlA1qLI7I0P2pnc4V/cn9b
         ZMvzCu6Kv+fNEtbC2HrswuBG+Aydio58JxcRrz3yK+CsCjqezg0ol3f9/32OZ2EpggoZ
         MuXQdhxrDozPnkeNsqnVcul6OCfAXAdtPMDzUxG6ojWLWt2CUmq800tEiScY7j0TLTUB
         crUEF5a9dbjrWmA108LU0/U49S3dcWJq2TG9cVeRRsLUICQ+SWC9d5+wUkXF1M4XzZQ3
         SHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q09SA2qfudzfAKUVVEfBcqYGoPmBm2EV957Ym1cJH0k=;
        b=CqK4LrdzEZqytvFyJ1mJ8MwVkONP+X2SaLPKSC5HbHorcVy+cyGunMMDFZofAlmtnR
         ChbsPZrAsjnSVGb/D2lChvI2eFzEOy0sRln1hP5zQZQvl0GP8eDDptLsatqyiCX9qq9t
         yCJV2+a4FPu3JyfbKofi3Wdw+nMc1xEAWw3T9siNABiow+2dr+07BPQtPU+TjIFAbNsL
         zD02uP3CDgm9GAepE54HMUtBWUPv7dkBHhzLzYHBDYq0Q8RTHf6hbnjRdW3lGIQVMxwV
         Ve1EIEIGrlRspDxZuhIEW6W7VRy3O7+y9lP4LdoylL/++JXOr4NWixP7XfIyKaA4LpPa
         H91Q==
X-Gm-Message-State: AODbwcDxufbHXvtGXKRB8NX+wWSTUzrOhFmVwFr/oHoGRnDlVOMVH2M3
        YBu+k0m5gIWtTD3USfuTZvY77TPEKQ==
X-Received: by 10.107.201.206 with SMTP id z197mr2606218iof.85.1494279508571;
 Mon, 08 May 2017 14:38:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Mon, 8 May 2017 14:37:48 -0700 (PDT)
In-Reply-To: <xmqqh90w9do7.fsf@gitster.mtv.corp.google.com>
References: <20170503032932.16043-1-sxlijin@gmail.com> <20170505104611.17845-1-sxlijin@gmail.com>
 <xmqqh90w9do7.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 8 May 2017 16:37:48 -0500
Message-ID: <CAJZjrdVTRdTOiHXdVzVY3CLoi7KMbGozg8rDvrmJOJADMXRFuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Keep git clean -d from inadvertently removing
 ignored files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 7, 2017 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Lijin <sxlijin@gmail.com> writes:
>
>> Addresses the issues raised by Stefan and Junio (thanks for your
>> feedback) about not using C99-style comments and keeping tests
>> working on every commit to prevent breaking git bisect. (About the
>> latter one: is it necessary to prevent compiler warnings, in
>> addition to compiler errors? Because if so I should probably
>> squash some of the commits together.)
>
> Some of us build with -Werror, so yes.  If by "squashing" you mean
> "instead of piling a fix on top of a broken patch, I need to do
> things right from the beginning", then yes, please do so, not just
> for compiler warnings but for all forms of changes.

Got it - will keep this in mind when I reroll the patch series.

>> Note that this introduces a breaking change in the behavior of git
>> status: when invoked with --ignored, git status will now return
>> ignored files in an untracked directory, whereas previously it
>> would not.
>
> What do you mean by a "breaking change"?  Is it just "a new bug"?
> Or "the current behaviour is logically broken, but people and
> scripts might have relied on that odd behaviour and fixing it this
> late in the game would break their expectations"?

The latter, as I believe you noticed in your reply about patch 9/9.

What happens right now is that because (1) directories containing only
untracked and ignored files are considered "untracked" and (2)
read_directory_recursive() skips over untracked directories, even with
DIR_SHOW_IGNORED_TOO set. As a result, `status --ignored` never lists
ignored files if they're in an "untracked" directory (and this is the
currently defined behavior per t7061).

By teaching read_directory_recursive() to recurse into untracked
directories in search of ignored files when DIR_SHOW_IGNORED_TOO is
set, though, `status --ignored` now learns to report the existence of
these ignored files, whereas previously it did not.

>> It's possible that there are standard practices that I might have
>> missed, so if there is anything along those lines, I'd appreciate
>> you letting me know. (As an aside, about the git bisect thing: is
>> there a script somewhere that people use to test patch series
>> before sending them out?)
>
> I hear that people use variations of
>
>     git rebase -x "make test"
>
> on their topic.

Aha - thanks.
