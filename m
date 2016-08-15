Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5CAC1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbcHOUKE (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:10:04 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34760 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115AbcHOUKE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:10:04 -0400
Received: by mail-yw0-f181.google.com with SMTP id z8so32287085ywa.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 13:10:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qLstpv43sBvhAeHEjPtAcvn0KkCaGgAGv+uqQ1undCI=;
        b=kFLaJfOdTdMfgf8pmgWRMyjRoa4e1+fKf59rC55AbkYsXFwmR6nxGa+XU9B9c4BVcB
         bJRF+QxjmDdpgJ3mSHMTnLoSg0a1Vr4reczOV0BEzAoOoSDyN/4BQ4rYC55MtejDJSZH
         SEHSkcDXIUM+bj49HkU6MBYkTaROrMl7ikViLWwlnphcRRZXbJ80qv1uUo0WjSNhTPLv
         YRtPkOz7IX02NsM1y6pfA4tefIBEPR/vuGu9h5QJFsy60sitxmMr9fsBR6m9CXY0DlmI
         6dcgFMzuOi0Fybxz9/FElYpZZtuLtp+0x+/eBBtN4HDOrqKLH9Yq6/65Uc9H56s7Mdc6
         CIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qLstpv43sBvhAeHEjPtAcvn0KkCaGgAGv+uqQ1undCI=;
        b=CHiAIP/LtvD7JsTCf2EDq7OfVY1hphCmkMXfwW+cY8dqLIdljbDB7G6TP5ezzuyoml
         Oh4BpXoLO5CeBMDSBvoCqWNU6T+6zKRw7B7HKFVyhwG+Z649RVv4PI+w8VhPDRboPuqy
         JhEhScsUG1wRMf1ytiJx42YVr/gMvvmRflJKhjlDhqAsZXYWuiJ6qzgfn0UJqxN0gFcQ
         uL+m0+qbg6wjMIdu5OzFyeipq5BQinrO1Hi3y3c6CE1lNh33s/1JPbaV+TUdlPgIGykE
         WflG/eRMi+2zDl2Ulj63lnrbEpyrx6iReYrAcdfdBE5XKgI/uOdaaftaj3h3ivZ+C7gv
         U6JQ==
X-Gm-Message-State: AEkoous8Ag/MJGh+9hF8ePf9A0o5Wm7sZ3xL0HTneZVw587qZAMzWmmsOwmsq9bsGaqvk1djue4P9g92Q31rcA==
X-Received: by 10.129.46.136 with SMTP id u130mr23559387ywu.234.1471291803176;
 Mon, 15 Aug 2016 13:10:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Mon, 15 Aug 2016 13:09:42 -0700 (PDT)
In-Reply-To: <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
 <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
 <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com> <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Mon, 15 Aug 2016 13:09:42 -0700
Message-ID: <CA+P7+xqbmZznxq024fhkejp2FeCVYkOYHTSdR69Di3nkzYJooA@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 5:37 AM, Philip Oakley <philipoakley@iee.org> wrote:
> [sorry if this is not the right place to 'drop in'..]
> I appreciate there has been a lot of discussion, but it mainly appears to be
> about an upstream / integration viewpoint.
>
> I'd hate it if there was a one size fits all solution that was only focused
> on one important use case, rather than having at least a simple fallback for
> simple folk.
>
> Personally I liked the idea that I could start my patch series branch with a
> simple 'empty' commit with a commit message that read "cover! <subject of
> the series>" and continue with the cover letter. It's essentially the same
> as the fixup! and squash! idea (more the latter - it's squash! without a
> predecessor). For moderate size series a simple 'git rebase master..' is
> sufficient to see the whole series and decide which need editing, rewording,
> swapping, checking the fixups, etc.
>
> Format-patch would then be taught to spot that the first commit in the
> series is "cover! <subject>" and create the usual 0/N cover letter. Git Gui
> may need to be taught to recognise cover! (haven't checked if it recognises
> an empty commit squash!). Possibly 'git commit' may want a --cover option to
> massage the commit message and add --allow-empty, but that's finesse.
>
> I've no problem with more extensive methods for those preparing very big
> patch series, or with those needing to merge together a lot of series and
> want to keep the cover letters, but ensuring that a simple flow is possible
> should still be there.
> --
> Philip
>

Some people have suggested this simple idea, and I like it, but they
did mention that modifying the cover letter now requires a rebase over
a potentially large series of patches, which can get annoying.

Thanks,
Jake
