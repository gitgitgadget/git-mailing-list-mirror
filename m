Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317F62035F
	for <e@80x24.org>; Thu, 10 Nov 2016 11:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754927AbcKJLBY (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 06:01:24 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:34944 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754542AbcKJLBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 06:01:23 -0500
Received: by mail-it0-f67.google.com with SMTP id b123so2649433itb.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 03:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7u7x/faOtp/dMa3LjGbaSId+9jWTooldtvjX8pYZI/g=;
        b=TCnVXqfvNWH/MC2rLm8bhbaykAbEh57G+yD25hVpexDXdhLtvh+uoIR+KVYqt+lYCS
         Em1iaYjG4CulXZrLMEf615Kn0XSSGJdlmCN99WgYXpDy2DSZuJHJs7UTQZZm8+9wN3hs
         k+Rd1eEG3hcSFVZVOjieVOn5HFqfrnrcP/2N2wmBtMw+f/WTmgrN3msIMr8IRqZWNg//
         1XCc8wXc3sUKC2pqZcRAArz/NzOgOEN6tlAzUiVFmOcMR8MynX9Lp5ngf2mxJnkZ7VQD
         x3HPPhY0qR04xV5nTIHSa/MkJR7O8A60FC7lO9kX1d9l90eQ5v5j/5+QN6qvKxV3e7kh
         SaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7u7x/faOtp/dMa3LjGbaSId+9jWTooldtvjX8pYZI/g=;
        b=FN4wjCd/s2P+JpcTTn4yXfS7Am8ZQAXMB203H/HkiBCbOuB48WjtVQcbUo2Eg7IinE
         2pyim0Iln9v2Nlm+bmUrmSOMDMWui/MDrJQHBcrH910d4Gt+4Craxsfn2/frRRVl7eMj
         TxlRMl3lhHH3iJej3m4cXLkyTcw9CKjIeuTykhokaWBQ+DJd3AjRoKGJlPaNhER8ml8P
         VBOHlG/xTaz+mr8tOU/IAiUepCr/Ux/rczPrAreu5WiEBn3NdXxDQ5ladPKibHZmMptF
         ftdLaDDFlBMwIFXhYLuPwsxKVf/AsvNb49udBZI/WRXKW6Znk4o6j6oKJLM+1pB670qx
         i0GQ==
X-Gm-Message-State: ABUngvf+zOrcoxiGenErqz652xGBA0ogOk0jj73g3VjXwTr+7Tdp1L5zMGn5mCP27R/pJ6gqNVL5LkhBNdDOdg==
X-Received: by 10.36.206.71 with SMTP id v68mr3404109itg.50.1478775681967;
 Thu, 10 Nov 2016 03:01:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Thu, 10 Nov 2016 03:00:51 -0800 (PST)
In-Reply-To: <20161110002335.z2z2stjtzgspikxe@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net> <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
 <20161107211010.xo3243egggdgscou@sigill.intra.peff.net> <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
 <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
 <xmqqmvh88dlu.fsf@gitster.mtv.corp.google.com> <20161109231720.luuhezzziuhx4r75@sigill.intra.peff.net>
 <xmqqoa1o6vca.fsf@gitster.mtv.corp.google.com> <20161110002335.z2z2stjtzgspikxe@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 10 Nov 2016 18:00:51 +0700
Message-ID: <CACsJy8BJkV+0wbrYuVrwixfbnOKw0DrwLHEtH-fzOHtEHyiXBw@mail.gmail.com>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree .gitattributes
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 7:23 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 09, 2016 at 04:18:29PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > On Wed, Nov 09, 2016 at 02:58:37PM -0800, Junio C Hamano wrote:
>> >
>> > I'm slightly confused. Did you mean "supporting any in-tree symlink to
>> > an out-of-tree destination" in your first sentence?
>>
>> I was trying to say that these "control files used solely by git"
>> have no business being a symbolic link pointing at anywhere, even
>> inside the same tree; actually, especially if it is inside the same
>> tree.
>
> OK. That is what my patch does (modulo .gitmodules, which I did not
> think of). But I think that is the opposite of Duy's opinion, as his
> review seemed to object to that.

I only objected the rationale (to be consistent with reading index).
If you sold it as malicious symlinks, or even put it like Junio "no,
the design makes more sense to be this way", I would be ok.

On the implementation side, we should print something friendlier than
strerror(ELOOP) if we decide that "symlinks on .git* files are wrong".
The standard ELOOP message does not communicate our design decision
well to the users. But this is a minor thing and can be ignored.

> As you know my ulterior motive is dealing with malicious out-of-tree
> symlinks, and I would be happy to deal with that directly. That still
> leaves symlinked ".gitmodules" etc in a funny state (they work in the
> filesystem but not in the index), but since nobody is _complaining_,
> it's a bug we could leave for another day.

The discussion trailed off a bit to symlinks in general in worktree
too, I think. But it's not my itch, we can leave it for another day.
-- 
Duy
