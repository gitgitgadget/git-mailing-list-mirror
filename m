Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCDEC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 08:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C5620708
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 08:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LrMhqAMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgITID3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 04:03:29 -0400
Received: from mout.web.de ([212.227.15.3]:52003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgITID3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 04:03:29 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 04:03:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600589008;
        bh=h/nubBxGdyLdEE0mcNXyxqUgdpNNNruazsPFfFk+dJE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LrMhqAMR294QySikTfgcVPywhV2qf9tvWA5uxzMr1VMUXqKXcHbBR5unkZdeGgvga
         sTG53ak6OP/nx7rffAYTZXaZIvm2ceMxhgxHJbkwA5k+BrOJue8bl3m7i+8P/HJzf3
         9550v9hCE9UlTwIlZwQ9UVQdD8LGONfQDmDfujrk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8C07-1kNUje0Fed-0053GK; Sun, 20
 Sep 2020 09:58:21 +0200
Subject: Re: What's cooking in git.git (Sep 2020, #05; Fri, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqwo0qk0fw.fsf@gitster.c.googlers.com>
 <b7ef3952-872a-40af-0f2e-c392b031a280@web.de>
 <xmqqy2l5iedh.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <eb128388-01b7-5278-aa0b-1f7d2d5222ba@web.de>
Date:   Sun, 20 Sep 2020 09:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2l5iedh.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:heIdazd/26NY3B+jFGLwp3ctskgLeEz5048zTae6k6RP4WrMp4O
 I8cHCws74Mo1KBcLQQ5kjilb8FvXmtXWehnnY6CcwUzVn0Po3Ren308Syvs7O/tdm/bMO3E
 +bg3u+ByuVTeSgtk2iDezunBUiCn4VpLuSaH6a2KV4I+/kpGQ4oHNxJhSODeUZFD3qpMGLK
 MBQ0F/YdbpLedj8ly1oNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WIjQ0EeKXjA=:mcmCk1L9scY+PoY8lL60UI
 5ATdEBKijhEytKxJJsDy+idodB79JjHrnhKj9MJh/gqxsYFEhUGnoRsNGkNzzHg5OnUsXKhUx
 ynuD90azB5uRBidNPptw7QPXYpfNKqwlGGKnuNMZaHLH3CVj/FCc0DUEu3VMgMrt99+95CyXM
 sOPM5wPQNhY4Q3FXFFTMChHzNIUNlSCbaIf1m+4vKa4FsjQ7SfEMUn2hSxmc6UieMBx+kCr08
 cQnF0YlHLXBRIIDiABOgDGyMmqhrFf3S36lbHfSa6/5ZWko8xEaGfIPfANOoywrDL700W6cDn
 dDvQuKNjVHji1BsmTsiQOJN/osrZnJ3KYsv/7Em2r7mTyzhlPHIapVMcqmsH7JfRh0QjXqpk3
 k30TCRFfpX/0cDeCE6lR7hSdNiGnf6myWi3GPh/Bkr6lxn/bdEJvmS5X3eJieQ+xbZsrAlk08
 tSaEHbfgX9ZPQToQp5E6sElj9GyQB9pMaPQSNnL5rs/FuQPHz2/RJP63Hyp6E95II3Rh/bhOY
 Ek4mhQ2OlFa/C2YW82bHpvWwqh4/kz0ud3LgDqUg3tr3+l0hWrbO2aJEFaxWOEYsHRDwy4x1c
 YwIAS4d8LeDNk4mplz0GXm20kWtlz60FCUjVzxpznv2lVOniu70SqHg6+5lULPvt2H/tmCTsI
 XG3A8IYNpjPdu2YqNgootwnCTsU0qkXZPZwHNN3+pMnxsnPJc42KqjYSbQcBvcIoX062hLXeG
 Y9elW9SwRLj2otIbMSVZuJoBUASnb1hA00P198CqWCPxmKbJhVT6biGmw0rR8v9jjRHvwgcUP
 5NeZnVBuLm8aA6cKdkABwAuxeqhJNbkxtZ6+OHBpcsrxsMe4yoot+6I9Z6NXX8hSmRxVm8DMQ
 dkpgqJFeQoyu0iC//o5znqkbPuDYkMLuXPDL3vsZWHR8PGz3vpWkCAozxsiESFJxrNd3O/Q1K
 muRf+/cklnfB/a6jXiZy7Xc347gZ0PWmg6oWqfSXS2EweD5yUDSbvFMM8zkcZ9+usld7fdVhp
 pjHnxOQEiMhtMPSdDQ/Ks7pSvtCIqquwl0TB7AxyS8Rk7pam1mT7qngZrT33ZDszW9dgd5bcJ
 j+hZfeuc2HbFmg21/+d8bb17DrBUNnaVZyI5beZCObanjKlWAOsIVUH0DIZ0S5KB5EKg0ST6S
 X5++QGVGl0Nkf/Bx+bgALWa9yt4vLxl5V8QlyzbBbauEd+NpZZrcCWBg/1QukQMs73gqOb5Fq
 BjOrO4jUOo2PPZGvk
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.09.20 um 00:35 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 19.09.20 um 03:41 schrieb Junio C Hamano:
>>> * jc/dist-tarball-tweak (2020-09-09) 1 commit
>>>   (merged to 'next' on 2020-09-10 at 36cbe7ee9e)
>>>  + Makefile: allow extra tweaking of distribution tarball
>>>
>>>  Allow maintainers to tweak $(TAR) invocations done while making
>>>  distribution tarballs.
>>
>> Just noticed this one.  It reminds me of an alternative solution for
>> archives containing both tracked and untracked files gathering dust on
>> my disk because I didn't see much demand.  It goes the other way and
>> gives untracked files the same meta data as tracked ones.  Interested?
>>
>>   archive: read short blobs in archive.c::write_archive_entry()
>>   archive: add --add-file
>>   Makefile: use git-archive --add-file
>
> Oooh, so is the idea that we do not have to use $(TAR) to append
> untracked ones to "git archive" output, etc.?  If we can get rid of
> all $(TAR) invocations from the build procedure, that would be an
> interesting addition.

The remaining ones are used in the targets install and install-man-perl
for copying po files, Perl libraries and manpages; in artifacts-tar for
archiving binaries etc. and in dist-doc for archiving manpages and HTML
files.

git archive can only solve half of the copy use case at most, so $(TAR)
will still be used -- unless it's replaced by cp+chmod or something
else.

Not sure how to support artifacts-tar.  Allowing git-archive calls
without commit or tree might be a start.  Letting --add-file record the
full relative path of an untracked entry instead of its basename would
help, perhaps counterbalanced with an additional --strip option similar
to the one of patch(1).

dist-doc tars up directories.  This would require adding support for
reading directories to --add-file or adding --add-directory.

Ren=C3=A9
