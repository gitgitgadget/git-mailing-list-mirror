Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08391F453
	for <e@80x24.org>; Mon, 18 Feb 2019 09:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfBRJxb (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 04:53:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45191 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfBRJxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 04:53:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so17544553wrn.12
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 01:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=08r5whKIC5UQrOoU9PMhyxwuRIov2sP8toeweNarnxg=;
        b=tps+aYOm0aRq/Spqbi8Efl27C9NAqJB4Tn/TZZRVLVlVJKzVE/SdNE1eWR2PXJEH/y
         +DhOF/xi0S4Cdom5hL2DtA7MNE81miDeuwB7hKCo2XIqBcRj0NEfEMM27zvMpEyQonCE
         Fgid2/7SYcF7oRccqhxoq3fnpTb2wgLhubf+y5PPShaoishm3lNzQ9P+HnV/toiJcAeC
         Mav0ucyADykTmW0hIv64Lpr6m9xc0g+IyaNvrlcXRrjzH9+6qt2Lw/SdeQbG2OLzylbD
         KQeMEHNBDpytKsta+mcMAVbIaSkytEWL72VDdY82+es4Uf9WuZ32qh/LQS3w5O+bierB
         CMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=08r5whKIC5UQrOoU9PMhyxwuRIov2sP8toeweNarnxg=;
        b=tn7/k/hf8yqn1cyewG3poX9MDWh/S+C4Yw20ajJGPQGtUnKXJ8NyI/nDaCl/nm4z2t
         FAZuUrjy3ZE3VN7NiNAtGF0DmurAdH+PZklrZkqASTph92qR0fQtq+42UDb1o83nB2XA
         JBsTtPEoT3qWQNZ7QbMyo8M1tAWAkCE+pGDt7ssNLLQQKVlSL47uD57ceg34KcXTsO0+
         yez8yaD3ea9f/PhRXo5VfMwIywPF57gbDQ93/c2YSv6SvgCiRanaOyEGiITjdFqTUWfE
         I5S/ojOhvVcm9ysj8UNPJsBNSA1uYxqD21HLmiP9bWquKrNFlVV76PIvthmdVW1kte0S
         HRvw==
X-Gm-Message-State: AHQUAuY0qF6vgNQb3lMgLCCK5P+EvN1AGE0LIgG8E1T4v4GLM9vNRGFu
        21V57qbAUKkMVS3fuQ0PpWg=
X-Google-Smtp-Source: AHgI3IYy2Ddt90odO3ydEFph4VDqgT2/GTEsg1lnMjTCZgVu/qIr2m6ARA1mVoP+7hrlA/tyHP3mJw==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr16437913wrn.298.1550483607947;
        Mon, 18 Feb 2019 01:53:27 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id w3sm8269838wrl.22.2019.02.18.01.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 01:53:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
References: <20190216114938.18843-1-pclouds@gmail.com>
        <20190216114938.18843-2-pclouds@gmail.com>
        <87wolzo7a1.fsf@evledraar.gmail.com>
        <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
Date:   Mon, 18 Feb 2019 10:53:25 +0100
Message-ID: <87va1ho222.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 17 2019, Duy Nguyen wrote:

> On Sun, Feb 17, 2019 at 2:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Sat, Feb 16 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>> [Re-CC some people involved the last time around]
>>
>> > A new attribute "precious" is added to indicate that certain files
>> > have valuable content and should not be easily discarded even if they
>> > are ignored or untracked.
>> >
>> > So far there are one part of Git that are made aware of precious
>> > files: "git clean" will leave precious files alone.
>>
>> Thanks for bringing this up again. There were also some patches recently
>> to save away clobbered files, do you/anyone else have any end goal in
>> mind here that combines this & that, or some other thing I may not have
>> kept up with?
>
> I assume you mean the clobbering untracked files by merge/checkout.
> Those files will be backed up [1] if backup-log is implemented. Even
> files deleted by "git clean" could be saved but that might go a little
> too far.

And I suppose if we have some mechanism for "don't backup but error out
if it was detectes as needed" we'll have the equivalent of inverting the
merge/checkout --force behavior now (& my "garbage" patch), i.e. we'd
stall on potential clobbering and need to carry on with --force.

> [1] https://public-inbox.org/git/20181209104419.12639-20-pclouds@gmail.co=
m/
>
>> My commentary on this whole thing is basically a repeat of what I said
>> in https://public-inbox.org/git/87wop0yvxv.fsf@evledraar.gmail.com/
>>
>> I.e. we have a definite problem here somewhere, and there is some
>> solution, but this patch feels a bit like navigating that maze in the
>> dark without a map.
>>
>> We had users report that the likes of "pull" were eating their data, but
>> now with this iteration of "precious" only impacting "clean" the only
>> problem anyone with the current semantics is still left unaddressed. My
>> memory (I may be wrong) is that "clean" was just brought up (by you?) as
>> a "what about this other related case?" in that whole discussion.
>>
>> So as noted in the E-Mail linked above I think the first step should be
>> to enumerate/document/test the cases where we're now eating data
>> implicitly, and discuss how that relates to the semantics we desired
>> when the data-eating behavior was first introduced (as noted in E-Mails
>> linked from the above, my own preliminary digging seems to reveal there
>> isn't much of a relationship between the two).
>>
>> Only when we have that list of XYZ cases we're supporting now, and can
>> see that XYZ is so important to maintain backwards compatibility for
>> that we can't change it should way say "we eat your data by default
>> because XYZ is so useful/backcompat, set 'precious' ...".
>>
>> But right now we don't even have the list of XYZ or tests for them (as
>> my RFC "garbage" attribute patch revealed). So this whole thing still
>> feels like jumping three steps ahead to me in terms of addressing *that*
>> issue, but perhaps you have some orthogonal use-case in mind for this?
>
> I'm not addressing the accidentally losing data in this patch. My
> answer for that would still be backup-log, if it ever gets merged. But
> this patch is about _known_ files that I want to keep when doing "git
> clean", no more.

Indeed. My concern is that we're making incremental steps without a
clear idea of the end state, and once we get there we might find that
some steps along the way box us in or weren't what we wanted to solve
the overall UX issue.

More so in the CL / commit message not describing where we are overall,
where this patch fits in (backup log, etc.) than this whole thing
(backup log is already 24 patches) needing to be sent as one giant
series...
