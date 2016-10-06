Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F049B207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 21:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935099AbcJFV1l (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 17:27:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32858 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933642AbcJFV1k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 17:27:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id i130so2045171wmg.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6O7bYfYT0UOXzkFRiP71jYCQV5IZs2wCs2r1V6pEVm4=;
        b=HNQczrSupjRd1IkgydwBzWxnD1sNTqOnB/cHtbpevorGePO/NAvtzjEzb6ndxhptjf
         WsQNT8r7Oo9DgGToeXnl0gns6N6xqmxp6oIUGdWi1VcRbACVmbSyLde2YZEzln2XxMHR
         akYajzoLKzLqLcwjsJlyJ8izy1aWLh953F2ziNYL4BpwvGnZ1e8KrkkZEmbJ4hxgpSNO
         PszCdCAKBVOgoPbT/QScfL98YFO06HwxY3tGcOZwL1USHUQogitlzsDt+3Hse+DZ/xaH
         OjZpIohO/UChVAFn10b+U1lIjJwPmSsaUOrLkkNdeJyjuk1pDvghEc2z1KbkZvnkwOCK
         gneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6O7bYfYT0UOXzkFRiP71jYCQV5IZs2wCs2r1V6pEVm4=;
        b=H1nqs6IHwvGMEIYPbNOwLNy0/rW47Pp7EkmiIhN6t9nLeUYMo4nlkMPraAxQJcmRiE
         0BNxn1yDyWYnsvzLHeIEtUWfTDGVZRryDZtgdPGgfH8nbziWEmS093dYzw611stLp7Ej
         zdGOFVmFJhqzOhUurEwok8QT3yL82U9ZeErMhU75bDo7HBWaO5Hk1D6PYVTBL3rVHKnW
         ZXQ4xeJZraT4L7tWNgWtZHwSBj+0SNyYCG3InDI+hmCone89HSoLcGonmT/61HkAEkWp
         B06G4lXwZ+Wtvg0DOpitj+YBehPr40a+5U435LLU+Gvq5IrjBqMJkwmskiZlNSmToCyW
         UIgg==
X-Gm-Message-State: AA6/9RkQMPPI3+JK9QOUYaVNA60NesV2Y1ff2BT3Q4fZm5NN7qfKW6ghhe4YQLbgjSdBWQ==
X-Received: by 10.28.130.198 with SMTP id e189mr9539476wmd.35.1475789259412;
        Thu, 06 Oct 2016 14:27:39 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA237.dip0.t-ipconnect.de. [80.139.162.55])
        by smtp.gmail.com with ESMTPSA id q8sm16487157wjj.7.2016.10.06.14.27.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 14:27:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <d4ad73af-d14b-03dd-0634-d8919a1d2ddd@gmail.com>
Date:   Thu, 6 Oct 2016 23:27:37 +0200
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2A14809-8AC0-456A-80C5-7B7F426A4026@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-12-larsxschneider@gmail.com> <2a604438-b6cd-876d-0ec2-90027dea99b9@gmail.com> <EF3723DE-B34A-4314-94C9-E3EB38EAB92A@gmail.com> <d4ad73af-d14b-03dd-0634-d8919a1d2ddd@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Oct 2016, at 23:00, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> [Some of answers and comments may got invalidated by v9]
>=20
> W dniu 30.09.2016 o 21:38, Lars Schneider pisze:
>>> On 27 Sep 2016, at 17:37, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>>>=20
>>> Part second of the review of 11/11.
> [...]
>>>> +
>>>> +	if (start_command(process)) {
>>>> +		error("cannot fork to run external filter '%s'", cmd);
>>>> +		kill_multi_file_filter(hashmap, entry);
>>>> +		return NULL;
>>>> +	}
>>>=20
>>> I guess there is a reason why we init hashmap entry, try to start
>>> external process, then kill entry of unable to start, instead of
>>> trying to start external process, and adding hashmap entry when
>>> we succeed?
>>=20
>> Yes. This way I can reuse the kill_multi_file_filter() function.
>=20
> I don't quite understand.  If you didn't fill the entry before
> using start_command(process), you would not need =
kill_multi_file_filter(),
> which in that case IIUC just removes the just created entry from =
hashmap.
> Couldn't you add entry to hashmap in the 'else' part?  Or would it
> be racy?

You are right. I'll fix that.


>>=20
>>>> +		if (pair[0] && pair[0]->len && pair[1]) {
>>>> +			if (!strcmp(pair[0]->buf, "status=3D")) {
>>>> +				strbuf_reset(status);
>>>> +				strbuf_addbuf(status, pair[1]);
>>>> +			}
>>>=20
>>> So it is last status=3D<foo> line wins behavior?
>>=20
>> Correct.
>=20
> Perhaps this should be described in code comment.

OK


>>>>=20
>>>> +	fflush(NULL);
>>>=20
>>> Why this fflush(NULL) is needed here?
>>=20
>> This flushes all open output streams. The single filter does the =
same.
>=20
> I know what it does, but I don't know why.  But "single filter does =
it"
> is good enough for me.  Still would want to know why, though ;-)

TBH I am not 100% sure why, too. I think this ensures that we don't have=20=

any outdated/unrelated/previous data in the stream buffers.


>>>>=20
>>>> +	if (fd >=3D 0 && !src) {
>>>> +		if (fstat(fd, &file_stat) =3D=3D -1)
>>>> +			return 0;
>>>> +		len =3D xsize_t(file_stat.st_size);
>>>> +	}
>>>=20
>>> Errr... is it necessary?  The protocol no longer provides size=3D<n>
>>> hint, and neither uses such hint if provided.
>>=20
>> We require the size in write_packetized_from_buf() later.
>=20
> Don't we use write_packetized_from_fd() in the case of fd >=3D 0?

Of course! Ah too many refactorings :-)
I'll remove that.

Thank you,
Lars

