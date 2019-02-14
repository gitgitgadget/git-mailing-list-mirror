Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99BE11F453
	for <e@80x24.org>; Thu, 14 Feb 2019 09:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438063AbfBNJvH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 04:51:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51142 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfBNJvH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 04:51:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so5539729wmj.0
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 01:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yLkgVMukWWSozBBe5sG5OlstPq7hEzJYwMNpl1Z7OXc=;
        b=K/727RXEp5iTCXsMyJSur9ahK5BJS3GnRXsh020Zix5OyOgnAuXY6VtquF0UNqdY+e
         Jx4FobFiD2MDiyg2KgjMyMUE4E/NfjePaVbW1EKxpHOP5YuC2Vu1wU3iJ5QipVPXg9EI
         JAl9/kbFh+cxHKbD5WBLuomUC2eH0waHlQmFD78KGzEH/Cjaa15nvuIwMcvB6q8GgYRP
         Fp10SsKETjLoGKy0wJBh3YsFJ0zJB6hZnX6XvtU//VIgd35PhwaI1BYImeL8sNKZcrvv
         auzgpFUg5LGmEqkRGLs2L6lHTvoHBtDP08NYi4gcdBvB8Qa47/9rB1S8JlPVu20Bvw7C
         Ab0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yLkgVMukWWSozBBe5sG5OlstPq7hEzJYwMNpl1Z7OXc=;
        b=MmmEGvFDB4nJaUg6YrmChtJWL6GSvoM1JcbAMk21e0IUFM/1wM7D1zt4+ER2xj5jNj
         htesJ27BqawXLzEu1BnHnvvBum9afl2E+3p5CaO2Hn2fkY/KPDd2JDNzA6jtEWu7tr1B
         EvznzE1GaqRJQ9zhTMf7vQOZlIPtor0LJzaSiDan41pLHeGM55lghnDr2V7GxW/6k9Ag
         6HlXFyAzMEJYK5Z8F45LiT7Ht9ZPiSG1yq6eewPUpRgRml3ezQbwjpZC8kraogpb8Dji
         MyrJRN6Bf9eaUmGtJmuBf5ANxXChmAwUbON2tBn8u+Ubsmk23cED0ApS7GsZFnjZWFaG
         FvIQ==
X-Gm-Message-State: AHQUAuYPK6buxttFGxpiwOWEwXFz76tlGdrfP4OxdaNZz59/CodD+oJ3
        D241f4aQjaa3OzSQJBWA0Ms=
X-Google-Smtp-Source: AHgI3Ib/fwc4pE1zIxP3BJhl9KrsDvdD3qmVLuJM9UaHN7xSdxn7IiKhlu/6KmLl9U2jjc7LpuEdXQ==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr1965632wmb.24.1550137865073;
        Thu, 14 Feb 2019 01:51:05 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id d15sm1594616wrw.36.2019.02.14.01.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:51:04 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, hsed@unimetic.com
Subject: Re: [PATCH v2] tests: avoid syntax triggering old dash bug
References: <xmqqo9a9stbs.fsf@gitster-ct.c.googlers.com> <20190213115951.12096-1-avarab@gmail.com> <20190213214844.GI1622@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190213214844.GI1622@szeder.dev>
Date:   Thu, 14 Feb 2019 10:51:03 +0100
Message-ID: <87d0nuk8ag.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 13 2019, SZEDER G=C3=A1bor wrote:

> On Wed, Feb 13, 2019 at 12:59:51PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Avoid a bug in dash that's been fixed ever since its
>> ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
>> released with dash v0.5.7 in July 2011. This failing test was
>> introduced in 5f9674243d ("config: add --expiry-date", 2017-11-18).
>>
>> This fixes 1/2 tests failing on Debian Lenny & Squeeze. The other
>
> Do I understand this "1/2" right?  There are two tests failing on
> Lenny and Squeeze, and this fixes one of those bugs?

Yeah, so there's one bug left now, which I haven't tracked down.

>> failure is due to 1b42f45255 ("git-svn: apply "svn.pathnameencoding"
>> before URL encoding", 2016-02-09).
>>
>> The dash bug is triggered by this test because the heredoc contains a
>> command embedded in "$()" with a "{}" block coming right after
>> it. Refactoring the "$()" to e.g. be a variable that was set earlier
>> will also work around it, but let's instead break up the "EOF" and the
>> "{}".
>>
>> An earlier version of this patch[2] mitigated the issue by breaking
>> the "$()" out of the "{}" block, that worked, but just because it
>> broke up the "EOF" and "{}" block. Putting e.g. "echo &&" between the
>> two would also work.
>>
>> 1. https://git.kernel.org/pub/scm/utils/dash/dash.git/
>
> Could you please link directly to the commit fixing that issue?
>
>   https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=3Dec2c84d=
3c4dba4b74440d72bdd1de416a9acd2a9

Should have done that, but I'll hold off on a re-roll for such a minor
cosmetic issue since I see Junio's merged it down to "next" already. The
dash.git hash is noted in the commit message, so it's not a practical
problem to find the commit, but yeah, would be nice if were a clickable
link.

>> 2. https://public-inbox.org/git/20181127164253.9832-1-avarab@gmail.com/
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
