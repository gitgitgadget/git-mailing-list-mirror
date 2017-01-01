Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86EF205F4
	for <e@80x24.org>; Sun,  1 Jan 2017 09:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754835AbdAAJ0b (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 04:26:31 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33608 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753230AbdAAJ0a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 04:26:30 -0500
Received: by mail-lf0-f41.google.com with SMTP id c13so257723783lfg.0
        for <git@vger.kernel.org>; Sun, 01 Jan 2017 01:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iIDzfUlVV2Zs0kI03csvNRwlBuBPSm7k6RzyFvmTMlY=;
        b=ByLlYSudZ5HgTyzeA8uf9VpEJxMaocUnH0R12hmGibGRnH/m18+gic+RDNaUg0uts2
         +bSiL3d/tDxuUxyxhY8nUJaPrRYCnDJjl0EYWTBlbZmfad/EeeLqFQ/viHbabMc3SXjH
         hT0zd9CH22I0f/ShngSLpx9y5StzbxMfqVL9bQ2y2zYIIUl70QXicpeMgAsNiTsxOmQV
         CVkHnnlrXTSyOuEWHHdYSSFrvzUKS7txOMQjU3mAcGoCxZI3+fG8yUUc47rFN1g2bnRZ
         ufP6yRAZG8IF6YSFGzfJdEByDtM7J1OXWh1GdpYSMLrs3FQ/B8C6N5AWDCr1GI9gYc/Q
         stPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iIDzfUlVV2Zs0kI03csvNRwlBuBPSm7k6RzyFvmTMlY=;
        b=J5WUE+ZyVJ8rl1nicew0BWt9ReBZH3HjRvidtmZAAG1ogYF5mwswcsoSihMp6+PxmQ
         RLqobJsV9m4XMnpbcL2RKdBgbavzWl1kPRIlCxKT47eorF+wFn8bVqhvK8zGTzoFivY6
         kjr4KfsCVuU3jMrmIxH4LMfKql5W7Wl0KibT+fwIdOb8AInCZmrCwDLPC1GnkT2YZfVU
         Qjg2JbYfTmwl8K8xbyBHRBUyqnoCXZe5kYBM4lic83/FPV5JxPTTySyPmg+zxuHCF67y
         /S9kkSgcTDsr7JHaJlhSlOPHyg0siecx+eW6uPWeY1zobmVgSpsC+FQB/DdhC/DgwfEl
         zokQ==
X-Gm-Message-State: AIkVDXJVs09FjgS9tmqi6dIA+7HD2ktJXnDmpvY/Rg803YSsdcxKvZbfH+ATLeORsCh0F5FcfrNR63GFkXwT0g==
X-Received: by 10.25.160.20 with SMTP id j20mr8384719lfe.66.1483262789170;
 Sun, 01 Jan 2017 01:26:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.79 with HTTP; Sun, 1 Jan 2017 01:26:08 -0800 (PST)
In-Reply-To: <CA+P7+xqqVFvDKSCTrGVVdpZB_VHwGdZ3gFQzo+RQqCu0FpOsAQ@mail.gmail.com>
References: <cover.1483153436.git.mhagger@alum.mit.edu> <20161231064746.6bvis76p5x5ubc2b@sigill.intra.peff.net>
 <xmqqr34n4ii8.fsf@gitster.mtv.corp.google.com> <CA+P7+xqqVFvDKSCTrGVVdpZB_VHwGdZ3gFQzo+RQqCu0FpOsAQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 1 Jan 2017 01:26:08 -0800
Message-ID: <CA+P7+xq9W_MZaSTw_QaHWEpiQU2u8+6=rr67CUkD4WBqtD=c+A@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Delete directories left empty after ref deletion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Git mailing list <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 1, 2017 at 1:24 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sat, Dec 31, 2016 at 6:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> On Sat, Dec 31, 2016 at 04:12:40AM +0100, Michael Haggerty wrote:
>>>
>>>> This is a re-roll of an old patch series. v1 [1] got some feedback,
>>>> which I think was all addressed in v2 [2]. But it seems that v2 fell
>>>> on the floor, and I didn't bother following up because it was in the
>>>> same area of code that was undergoing heavy changes due to the
>>>> pluggable reference backend work. Sorry for the long delay before
>>>> getting back to it.
>>>
>>> I've read through the whole thing, and aside from a few very minor nits
>>> (that I am not even sure are worth a re-roll), I didn't see anything
>>> wrong. And the overall goal and approach seem obviously sound.
>>>
>>>> Michael Haggerty (23):
>>>
>>> I'll admit to being daunted by the number of patches, but it was quite a
>>> pleasant and easy read. Thanks.
>>>
>>> -Peff
>>
>> Thanks, both.  These patches indeed were pleasant.
>
> I do have one comment regarding this series. Is it ever possible for
> an older version of git to be running a process while a new version of
> git which cleans up dirs runs? Is this expected? I just want to make
> sure we don't need to worry about that scenario since otherwise it
> makes it much more challenge.
>
> My thought as far as I understand it is that it is possible, because a
> user COULD choose to run both this and an older version, but that it
> is unlikely in practice outside of a few developer boxes who
> periodically switch between versions of git, and are unlikely to
> actually run multiple versions at exactly the same time.
>
> Thanks,
> Jake

To add to this, if it is possible, it might be worth merging the "make
ourselves safer against a race" first, and then waiting some time
before merging the "we are now safe to delete directories". I am not
yet convinced that it is necessary, but wanted to point it out so that
someone more knowledgeable could explain why it is safe to do so.

Regards,
Jake
