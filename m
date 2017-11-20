Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A722036D
	for <e@80x24.org>; Mon, 20 Nov 2017 07:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdKTHDM (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 02:03:12 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:41894 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdKTHDL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 02:03:11 -0500
Received: by mail-it0-f45.google.com with SMTP id x28so10792517ita.0
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 23:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xZl0SVSch/XagxPeK/T+BCxUqi9oCrr6VLvhLWtC5ew=;
        b=MAwWYFNMPTL/WK+lPpCsyFq8ijasPV3rzjKtjtzvwd2+nzb3Gs6QcanQzxOtS6zfSs
         liMm8sbsng5yHGPF0FLf+V3tob24IrWvYhjWxX+YKNHRkP0poHtFE3KVMiXE/VWJO2F+
         kYdf/Vu/Ce8wBU0N/ZbDlF/vai9CheqjGB2CSbpQYYKErNdAFfMbyz6VaRnHaqfEi0aR
         q8HbrHUo3MmWAfpYmLekN+qtoE4lf6cHfZ7E521vuRf8Fjojyh9PxlD91A6zUQA7fnz3
         JxiyV1MOFCghKMO50ybp97clj48tu2sS0ukoCm8QvOc1ykSEvm+M7kDjYvwKal0E3dre
         N8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xZl0SVSch/XagxPeK/T+BCxUqi9oCrr6VLvhLWtC5ew=;
        b=pcGajr/sxER+3B+4IDPonTUfqZIu/0RTvGqHlMWme7RxP2ntRl9bPvshNttWGWqgyF
         0zav5YVu72iya57FXd9vqE5canSquZitifSGWt8tcGZTG/6gYBZfOhQ9QSZcsnbXKq0n
         +xiRjZkjoywfObaWBF3oK9Iv3WLAbwF9BSpQpfPORGrpg8JZIUFh0FyI+sdrKlbnqBnD
         DRgFoRIFzCKzDQmRAqCfZ1JSw/hjh/Z5DXFAA590mx94lZJlTPb+Mit76IaSCjxt/3kq
         dILAq+YmnZiMYJPX5+ZTIJIof3NKOKlH7H6rgNybZwMtlD6ilnH94CVJXT7+ju/WqcK0
         +RcQ==
X-Gm-Message-State: AJaThX4l8WMz6bhiscju9+EiinHjIAGJyzPYBbR7irp8UjjTVbulNiJm
        v64dVTixkNebzvnUtKqf9DbzFWRaytx9Q1N8jcc=
X-Google-Smtp-Source: AGs4zMZMv8FtnswUzt0gKROE2x7qRf7E/pg2mDXAER87SKt60O2K0+3ElwuQZukLPnGe1E2doqrIMifxjxuIBWgu6Lo=
X-Received: by 10.36.78.73 with SMTP id r70mr960433ita.75.1511161390808; Sun,
 19 Nov 2017 23:03:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 19 Nov 2017 23:03:10 -0800 (PST)
In-Reply-To: <xmqqlgj1myyj.fsf@gitster.mtv.corp.google.com>
References: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
 <0102015ecc65d76b-124658b5-5b79-4321-a6cc-01be807c62aa-000000@eu-west-1.amazonses.com>
 <CAP8UFD3SYU_+MOT-TGCV4uJ-cxrd9VhgOOprkq-XP0CUhtGTig@mail.gmail.com> <xmqqlgj1myyj.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Nov 2017 08:03:10 +0100
Message-ID: <CAP8UFD30RWeXbRDhrxzcrT9_88WhBt-prcNMxC=XwPd7+4UgBA@mail.gmail.com>
Subject: Re: [PATCH v16 6/6] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 4:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Fri, Sep 29, 2017 at 8:49 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> Reimplement `is_expected_rev` & `check_expected_revs` shell function in
>>> C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
>>> call it from git-bisect.sh .
>>
>> It looks like this patch forgot to add the `--check-expected-revs`
>> subcommand to the usage string.
>
> Usage string of what?  "git bisect"?

bisect--helper

> I do not think bisect--helper even needs to have end-user facing
> "usage string", but "git bisect--helper -h" still gets the new thing
> listed in its output for free thanks to parse-options API, so that
> is not what you found "this patch forgot to add" and you are making
> me scratch my head.

Right now in master the usage string for bisect--helper is:

static const char * const git_bisect_helper_usage[] = {
    N_("git bisect--helper --next-all [--no-checkout]"),
    N_("git bisect--helper --write-terms <bad_term> <good_term>"),
    N_("git bisect--helper --bisect-clean-state"),
    NULL
};

So it lists 3 of the command modes out of 4. The missing one is for
--check-expected-revs.
For consistency I think it would be nice to add the missing one.
