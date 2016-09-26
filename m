Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9D5207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032305AbcIZTVQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:21:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35297 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965069AbcIZTVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 15:21:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id s64so10506255lfs.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qm1epYD12CwssMZvsyoNrr3apyQrHkfUYWWkUQYJCW8=;
        b=slqGaHsv1D9//JwZanYIRsnnXVHiPAJ6H42vKpr1G0GOJygSroqyTVma7iS6/JwWCo
         XCM6VI52hbfMpAvdcoptRij3XnsgVF0fiokLbBw00zFYeuKUjNecUYRVArdw141yiiNz
         Grn05hmlSo9eQhaRzWU4qzcYsY2KqcWeGi8K37cnaK23Ar4v8MgkUnTncstYMzMkbgq3
         cw3NMM6B3AKz6EE57uXADW8a8/kBNgEZcjNZdQQzU5xP/FcE0mHLWOgk97KYGDeSh7hD
         xeEIsLFvlUWtYWrEmz39CLPIMBLj30LXuWWepgMoP/RKXvhV7i8lRUx7tgFJIHO+RBrZ
         oShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qm1epYD12CwssMZvsyoNrr3apyQrHkfUYWWkUQYJCW8=;
        b=ZEp10DQ9w6/WHLq+Jh/WbKve7SqO+AW0SX+mMNluVjoufDy6p5mWqWTmIhZa+gIxnZ
         RGQaRHArd3qWfhoieGs9whlxXGF/YPofvIJAlvjWcBozf2+6HfQq8mAVCQjWwE/UHwrQ
         SvqZ5uk8dHGJr+DCmMA8Sb/krjuehGN8VimwInSCmhmknN+7AEDZteHyWlADh58QUKLl
         5fKniv0co+6XdBFPtytq8spq9kXAzOlMa21OXtZUr5UKgXxn6+NVTN1nsGp7dz/2mVWp
         HSa3lWCgBghE67U+HMmvp0E+K9YnkuYBNQeev10lkIrrd4N9jbFhklQVAEmTe4iq+xt8
         bURw==
X-Gm-Message-State: AA6/9RlvE9F78VtZ2fQqTFeiFYPiTsDFSUbSgMeCoiTplWMTMbzpAWK5PI1nsi3JBhzPqA==
X-Received: by 10.28.163.2 with SMTP id m2mr16700085wme.62.1474917673288;
        Mon, 26 Sep 2016 12:21:13 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4342.dip0.t-ipconnect.de. [93.219.67.66])
        by smtp.gmail.com with ESMTPSA id 188sm12757541wmo.1.2016.09.26.12.21.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Sep 2016 12:21:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v8 06/11] pkt-line: add packet_write_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <55c5a86e-4055-f36d-bbf1-e8bae919088a@gmail.com>
Date:   Mon, 26 Sep 2016 21:21:10 +0200
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CF26590-7B88-4DB6-B6D4-A6CFE0FD6ABF@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-7-larsxschneider@gmail.com> <55c5a86e-4055-f36d-bbf1-e8bae919088a@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 25 Sep 2016, at 13:26, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:

> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> ...
>>=20
>> +static int packet_write_gently(const int fd_out, const char *buf, =
size_t size)
>=20
> I'm not sure what naming convention the rest of Git uses, but isn't
> it more like '*data' rather than '*buf' here?

pkt-line seems to use 'buf' or 'buffer' for everything else.


>> +{
>> +	static char packet_write_buffer[LARGE_PACKET_MAX];
>=20
> I think there should be warning (as a comment before function
> declaration, or before function definition), that =
packet_write_gently()
> is not thread-safe (nor reentrant, but the latter does not matter =
here,
> I think).
>=20
> Thread-safe vs reentrant: http://stackoverflow.com/a/33445858/46058
>=20
> This is not something terribly important; I guess git code has tons
> of functions not marked as thread-unsafe...

I agree that the function is not thread-safe. However, I can't find=20
an example in the Git source that marks a function as not thread-safe.
Unless is it explicitly stated in the coding guidelines I would prefer
not to start way to mark functions.


>> +	if (size > sizeof(packet_write_buffer) - 4) {
>=20
> First, wouldn't the following be more readable:
>=20
>  +	if (size + 4 > LARGE_PACKET_MAX) {

Peff suggested that here:
=
http://public-inbox.org/git/20160810132814.gqnipsdwyzjmuqjy@sigill.intra.p=
eff.net/


>> +		return error("packet write failed - data exceeds max =
packet size");
>> +	}
>=20
> Second, CodingGuidelines is against using braces (blocks) for one
> line conditionals: "We avoid using braces unnecessarily."
>=20
> But this is just me nitpicking.

Fixed.


>> +	packet_trace(buf, size, 1);
>> +	size +=3D 4;
>> +	set_packet_header(packet_write_buffer, size);
>> +	memcpy(packet_write_buffer + 4, buf, size - 4);
>> +	if (write_in_full(fd_out, packet_write_buffer, size) =3D=3D =
size)
>=20
> Hmmm... in some places we use original size, in others (original) size =
+ 4;
> perhaps it would be more readable to add a new local temporary =
variable
>=20
> 	size_t full_size =3D size + 4;

Agreed. I introduced "packet_size".

Thanks,
Lars=
