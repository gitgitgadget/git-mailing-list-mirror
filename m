Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF47C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbiBCVdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiBCVdy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:33:54 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E2C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:33:54 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p125so3361775pga.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tvoMDnkT/D9TGm0oT1qoYHektnEg3j+Grtkl6HdVZx8=;
        b=Pw3wulIakbVyVYopW/4kNGcQzyEjaNq7wTZzjNiD+1phDVAAsy4aIgYACY/bHMkB8q
         asbxBsSqUflTtrcvsewLaYxgQpqTy53lWrIVmVUWHjG5EvdYHWW0DfC2fzeN+DIxZQqY
         yZjN6B3tIEUYgIBExqPvlii+6TGdonKBoK4cs0p5TsRBqkxxJYwFO1Clmou/oq8OXuVW
         2qMtcpd/DqLQl5kzpWTnprU3kaOwKWJeuQcLQic/OByzMAQRn6SbykllGB4jPFjIeodz
         Pl2oEfrvUiLbUqteshty0NTU6Px2nnhyUe3LqoaYqmyDo2NEzWCbtAfGlnloNM6l2Q3I
         7LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tvoMDnkT/D9TGm0oT1qoYHektnEg3j+Grtkl6HdVZx8=;
        b=CqLI/cmDKSowDX4hvSqM2IyzXB3L4h3+fQGn/oFfIb4G57EfQPPJZcZGBSglGyaTLY
         qGVHoZ+tC2bFGxL3JcDHjnNqmmNc1j3Xyto271vx7EK2LXNCYwBJyoU+ND0izBJYptCP
         +YBLjXgn3coY3Jma7uXTahLbwtOKcorGQPdQACDkZG3xapRTvl7aM5W3bXq9p+duCwOP
         R5kX1YqqxhulYbdtr+YMLwcQcPUMUUHmcAuvTVXrV+KEdfpORiMDneEZQfdTA1GVDUdd
         PDzX8gGhJvSSTOwbfT0En1N7CTVc3Xd2tkC/gAHMYN3WtrRAnED1f/T4nT3ZMcF338XG
         kzfQ==
X-Gm-Message-State: AOAM530o1DfwySMe5suyn7uzls9Me86X3Hbyyjj5iTiJxiX4A7DvTeE4
        GZhRco+pMBZOucdUYeysTKvc90jkUNA=
X-Google-Smtp-Source: ABdhPJyJiCemjYsO72Qnli2czJFEoxQ+RY1Ztf+/ew7bsa+TLcrOEgHxlbMInptgbV4lwCQ3G8Wo2A==
X-Received: by 2002:a63:e302:: with SMTP id f2mr743pgh.451.1643924033687;
        Thu, 03 Feb 2022 13:33:53 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id s2sm19119697pgl.21.2022.02.03.13.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:33:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
Cc:     rsbecker@nexbridge.com,
        =?utf-8?B?J8OGdmFyIEFybmZqw7Zyw7A=?= Bjarmason' 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [Question] Translation Dictionary
References: <016401d81547$728834e0$57989ea0$@nexbridge.com>
        <02f101d81901$c1ac8400$45058c00$@nexbridge.com>
        <xmqqwnibvmtf.fsf@gitster.g> <11498572.Kui42GGras@cayenne>
Date:   Thu, 03 Feb 2022 13:33:52 -0800
In-Reply-To: <11498572.Kui42GGras@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Thu, 03 Feb 2022 20:59:08 +0100")
Message-ID: <xmqq1r0jskhr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël AVILA <avila.jn@gmail.com> writes:

> On Thursday, 3 February 2022 19:15:24 CET Junio C Hamano wrote:
>> <rsbecker@nexbridge.com> writes:
>> 
>> > I would even suggest that gitglossary(7) might ultimately be
>> > deprecated particularly on systems without 'man(1)'.
>> 
>
> I'd rather gitglossary and `git glossary` did not compete and they could share 
> their translations.
>
>
>> Yes, I think the entries in the "git help -w glossay" are good
>> things to have in the dictionary.  I thought there are folks who are
>> already translating our manual pages (perhaps with po4a if I recall
>> correctly but I may be misremembering)?
>> 
>> Thanks.
>> 
>
> Yes, there are. You can find the project at 
> https://github.com/jnavila/git-manpages-l10n
>
> The Portuguese is fully translated, gitglossary included.
>
> This makes me think that translating gitglossary should come first, in order to 
> set the standard for the other manpages.

Yup, and if we can come up with a way to mechanically share the list
of items (i.e. what to include and not include in the glossary) and
their translations between "git glossary" and "git help glossary",
that would be great.

Thanks.
