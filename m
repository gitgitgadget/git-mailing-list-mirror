Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63AF211B5
	for <e@80x24.org>; Tue, 22 Jan 2019 17:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfAVRyS (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 12:54:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54543 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVRyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 12:54:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so15093598wmh.4
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 09:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QSfZs35ekZTyQp4fGm+wer89aolhTKzrsSno3gF1HIk=;
        b=Y7VDo3p10l90ZFW0I5ZuG4uFYVvUNWqabUt1nVU55lhvqaTJABmxnu6snaFaywVAt4
         kP9InAnOxUfnh+WkrkRknQWCCzBDbHhnRbPIypQiZh2rWfdsy2nWWeNdmf2L875GqjYy
         BaCipCcGH/TKlAJp7vKnx+W88gmKdC3NYVBExNX1m2Enefo44ZuGiA6SNgACnykjU7O+
         XYmkV1Rb+d7h8cZLKbmc4z+SQtTMh/KxTNOnlsyF74fFK4Si8Yhk9eyB5J4vLIhRKnCF
         99em0FcgkS0n3/+uQvNSnnvjvoMZRMVK+UV/o276ltp/sOBgDQDlC1n6zihKemtWqgud
         +FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QSfZs35ekZTyQp4fGm+wer89aolhTKzrsSno3gF1HIk=;
        b=jfrYjtY9KhRbXTsnRxL4FRU/JV2llkJ5G5t8XO/cZnIDoR3KHp0Ydb/HX0XJ505f3i
         /q/EOnPJ1dtLT+PFY7hy6IvWdq333IUHxjT64vSv/Tq7UbxU1Mt9Ahm5zzAcezO9zQqe
         SIHbc7SwRZ+OtzHG9UCSfKhnxxosxPbyIdgdagEG8uQYX+HGLaxJOLb1aaPa3UTBc5M0
         PbdOATNeQ9VMITVXpkXZzvwxH0TCRPEmiSsUneV5YAjiRflp6c6uvMajDwqE+yrgI4Qk
         WEJiLv9q/kUG5UG3Pb+j+GqDhteL88eiD7gEViWgOiuYoQV6ioeBsGMNAxnYClGh1QNA
         /arw==
X-Gm-Message-State: AJcUukf6q65WDyuGzDzFcvG7I4QH6qiKNvkNt9u5Yl1PUbL3x27rGyhN
        psQ0IXh6dfx1zYLk3wovBbI=
X-Google-Smtp-Source: ALg8bN7U/MQuI6UsIGyccIsIhZW7mmEov6FlUF+ljI9lCCNO4JHZVo5XroKmV7/6vje4t/M7qmG0ww==
X-Received: by 2002:a7b:c951:: with SMTP id i17mr5011434wml.70.1548179655646;
        Tue, 22 Jan 2019 09:54:15 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h2sm110198190wrv.87.2019.01.22.09.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 09:54:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, git@vger.kernel.org,
        David Kastrup <dak@gnu.org>, Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/3] Move init_skiplist() outside of fsck
References: <20190107213013.231514-1-brho@google.com>
        <20190117202919.157326-1-brho@google.com>
        <20190117202919.157326-2-brho@google.com>
        <87k1j247ui.fsf@evledraar.gmail.com>
        <xmqqzhrxlvfj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901182155020.41@tvgsbejvaqbjf.bet>
        <20190118213018.GA28808@sigill.intra.peff.net>
        <87h8e54n6y.fsf@evledraar.gmail.com>
        <20190122071251.GB28555@sigill.intra.peff.net>
        <87ef953tyn.fsf@evledraar.gmail.com>
Date:   Tue, 22 Jan 2019 09:54:14 -0800
In-Reply-To: <87ef953tyn.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 22 Jan 2019 10:46:56 +0100")
Message-ID: <xmqqpnsoh92x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> It needing to be bidirectional is a very good point, and I think that
> makes my suggestion a non-starter. Thanks.

Yes, it is a bit sad that we need to carry the mistakes forward
while moving to the new hash, but bidi convertibility is a must
for the transition to work smoothly, I think.

Thanks for a good discussion.  FWIW, on the original issue that
brought it up, I think using "object name" from the glossary to
move away from saying "SHA-1" would be good.

