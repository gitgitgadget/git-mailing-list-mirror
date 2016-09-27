Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C5F20986
	for <e@80x24.org>; Tue, 27 Sep 2016 12:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbcI0MLI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 08:11:08 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34886 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933012AbcI0MLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 08:11:07 -0400
Received: by mail-wm0-f42.google.com with SMTP id l132so172763551wmf.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DzYjqnZc34gH6LO2MwjDRnLCJNcdGMKIdIoCh23yXso=;
        b=bbkc774Lm28Je1K2biL6fT6LXAEy+CC+XZS3d8YHNhstI/ueEqDKxhPMUh60lDuQow
         llei5mavoi69zK7qfceoZl6D9imRvhj/lkaqY7kRXLOpiVnxGJ+vHVmC5DG5W/xz+UGG
         NyEje61B7TdHWfkOqZzLzCHz1I0YdhznhUOT4htP1kKTIDOJIJpXa4zk9goAaZvbhwwX
         rcPNYlrxyN8TTqLfmnU4q3bAuCwnC3aLENET203fycV2IvgvL+xCJ7YK9Sx1r25UafBa
         zC7i9y3JFGo9vp7cvczfjKvtHN6RK3Gjvt99BB6hQsdigACGWHCpgfdxNSjmGW/LRYFg
         6HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DzYjqnZc34gH6LO2MwjDRnLCJNcdGMKIdIoCh23yXso=;
        b=OOVJNHKumms2Sx0CVlmR3tpQNOf50wo7aMerpQ6nZsTAikdukK2UQvRvofJJAIJ8Gu
         kFlof9Oor9ZVUbf+lDQDfitV9bB1NwaWsW6ZVJs8FgvvE3OlsqfFxeDIFUmS61j1DtGP
         DdY47yvOn2XgDJhCnjkbtIjhdATr77/AoyZQO61kiLtQ0SFI2/ywJ54VW+FTj53mbvXL
         AebWT02UXd8CtCJl7DazGuY1j3KLEhi2uyJ9y5mqwbsF4hlGbsX6z8AFTHgsnFKHEAhb
         xse3JsCKwF0Q7GEBcnDl4qfq2ffeOxLiIcQThkojEJIOnLrtg8KRb7oD/qpxP4NAVmpJ
         XF7g==
X-Gm-Message-State: AA6/9RmVPViSoh530Nbkw5/bFvUrkvHnUh68voukW5iw29Nl8Paf2AZbjVjnWk1sW+gczw==
X-Received: by 10.194.188.113 with SMTP id fz17mr26612948wjc.179.1474978252467;
        Tue, 27 Sep 2016 05:10:52 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id z17sm2826251wmz.23.2016.09.27.05.10.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Sep 2016 05:10:51 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 07/11] pkt-line: add functions to read/write flush terminated packet streams
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160927090031.jjb3dmhspbbnizja@sigill.intra.peff.net>
Date:   Tue, 27 Sep 2016 14:10:50 +0200
Cc:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF15F1E5-4DA0-459F-84EE-EDCB5FA23EF7@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-8-larsxschneider@gmail.com> <507a29a1-99ff-c13e-cf1f-76631345a822@gmail.com> <77315FC2-47F3-433A-8D70-5497FB04CBBE@gmail.com> <6D8B988C-8E54-4AA6-980C-A6BA40983D88@gmail.com> <20160927090031.jjb3dmhspbbnizja@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Sep 2016, at 11:00, Jeff King <peff@peff.net> wrote:
>=20
> On Tue, Sep 27, 2016 at 10:14:16AM +0200, Lars Schneider wrote:
>=20
>>>>> +		strbuf_grow(sb_out, PKTLINE_DATA_MAXLEN+1);
>>>>> +		paket_len =3D packet_read(fd_in, NULL, NULL,
>>>>> +			sb_out->buf + sb_out->len, =
PKTLINE_DATA_MAXLEN+1, options);
>> [...]
>> After looking at it with fresh eyes I think the existing code is =
probably correct,
>> but maybe a bit confusing.
>>=20
>> packet_read() adds a '\0' at the end of the destination buffer:
>> =
https://github.com/git/git/blob/21f862b498925194f8f1ebe8203b7a7df756555b/p=
kt-line.c#L206
>>=20
>> That is why the destination buffer needs to be one byte larger than =
the expected content.
>>=20
>> However, in this particular case that wouldn't be necessary because =
the destination
>> buffer is a 'strbuf' that allocates an extra byte for '\0' at the =
end. But we are not
>> supposed to write to this extra byte:
>> =
https://github.com/git/git/blob/21f862b498925194f8f1ebe8203b7a7df756555b/s=
trbuf.h#L25-L31
>=20
> Right. The allocation happens as part of strbuf_grow(), but whatever
> fills the buffer is expected to write the actual NUL (either manually,
> or by calling strbuf_setlen().
>=20
> I see the bit you quoted warns not to touch the extra byte yourself,
> though I wonder if that is a bit heavy-handed (I guess it would matter
> if we moved the extra 1-byte growth into strbuf_setlen(), but I find
> that a rather unlikely change).
>=20
> That being said, why don't you just use LARGE_PACKET_MAX here? It is
> already the accepted size for feeding to packet_read(), and we know it
> has enough space to hold a NUL terminator. Yes, we may over-allocate =
by
> 4 bytes, but that isn't really relevant. Strbufs over-allocate anyway.

TBH in that case I would prefer the "PKTLINE_DATA_MAXLEN+1" solution =
with
an additional comment explaining "+1".

Would that be OK for you?

I am not worried about the extra 4 bytes. I am worried that we make it =
harder
to see what is going on if we use LARGE_PACKET_MAX.


> So just:
>=20
>  for (;;) {
>        strbuf_grow(sb_out, LARGE_PACKET_MAX);
>        packet_len =3D packet_read(fd_in, NULL, NULL,
> 	                         sb_out->buf + sb_out->len, =
LARGE_PACKET_MAX,
> 				 options);
>        if (packet_len <=3D 0)
>                break;
>        /*
>         * no need for strbuf_setlen() here; packet_read always adds a
>         * NUL terminator.
>         */
>        sb_out->len +=3D packet_len;
>  }
>=20
> You _could_ make the final line of the loop use strbuf_setlen(); it
> would just overwrite something we already know is a NUL (and we know
> that no extra allocation is necessary).
>=20
> Also, using LARGE_PACKET_MAX fixes the fact that this patch is using
> PKTLINE_DATA_MAXLEN before it is actually defined. :)

Yeah, I noticed that too and fixed it in v9 :-) Thanks for the reminder!


> You might want to occasionally run:
>=20
>  git rebase -x make
>=20
> to make sure all of your incremental steps are valid (or even "make
> test" if you are extremely patient; I often do that once after a big
> round of complex interactive-rebase reordering).

That is a good suggestion. I'll add that to my "tool-belt" :-)


Thanks,
Lars

