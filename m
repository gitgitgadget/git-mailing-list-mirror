Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5A51FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 12:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932287AbcIKMd1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 08:33:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35306 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756143AbcIKMdX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 08:33:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id a6so9674690wmc.2
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BCK1V1UmhGuoFbM7NrhqGKe8kpt/F9Maog1LmAk4ovU=;
        b=eeo0Hf9GgxUYgQX5FqHtsEhHu5wDYr4HFjQIFhzIzVoRHvLVTTZfPbDjFFsYVzF/9A
         7KQLb4P6KlVMGXwjFoOeiFWooRx2Wso2K97aqYVq4QQViDJQqcEWFQ37WW95G5tlgNRT
         ttN+AmuTpRFoPf3V2X2/iZX6oMN/Jx0h4GKH4i6uU8Za2TPVH+bWdKC6CIw61y8auNp1
         gT+woLCD4wu7wVlPGp0zT7O1a9GD/IDotTkdgQY8oqUJIC5W1bdXu+ezrQvDq0n7mz4+
         3ObBZ8xr1wXKb4TYJczMh7xk8y0562ZV/QsaQB3AmNn1FrigjFhf3TCg10EASpCJG5t8
         jGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BCK1V1UmhGuoFbM7NrhqGKe8kpt/F9Maog1LmAk4ovU=;
        b=crZLyrUJDusRU92SV95bbbvJRZYWGIyLgw5dlT+028UeyDmx9RF0wHEIsEctBMKraB
         Tqot8FDH5PDmwBKOBmHLPxU35adhkYEX5rOn89gm5NK7LcdjL0DR4ExhIFWNzJGQ08gk
         Q73XVqcwLiT1W3oPvz3L1yphjvMA/5EXfTzozYIbC+f6bv+W68UjK3PoPNiEnp19O9bS
         Fsp9WeIFQI+RwO/c9Db2nXmor9n9ukkSV4WztMIYXLFTG6XD2icNw59JxQ5zKf4UWKqG
         hvZCTSxxqCJB2nDyokRllN8fCKhmVwO9x2i+cdYXcOseblPjsDqixJxo3B0cCmgLNVD8
         OcZg==
X-Gm-Message-State: AE9vXwOpjRIz6v+mEruQitwWF3SfLnpAZ7WFv8hMgwa+y9IzpujhXW3I4pp4Ubxtgf8ZSw==
X-Received: by 10.28.38.131 with SMTP id m125mr6506542wmm.38.1473597201758;
        Sun, 11 Sep 2016 05:33:21 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BADCF.dip0.t-ipconnect.de. [80.139.173.207])
        by smtp.gmail.com with ESMTPSA id r9sm12775263wjp.15.2016.09.11.05.33.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Sep 2016 05:33:21 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 06/10] pkt-line: add functions to read/write flush terminated packet streams
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kYHX6-hhKW_6JEd1hBNi8R+sBY-RjZARfHDMnyLKFZnsQ@mail.gmail.com>
Date:   Sun, 11 Sep 2016 14:33:19 +0200
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CCFB3A0-2C3B-4142-8E62-47C3DD6AE7A3@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-7-larsxschneider@gmail.com> <CAGZ79kYHX6-hhKW_6JEd1hBNi8R+sBY-RjZARfHDMnyLKFZnsQ@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Sep 2016, at 23:49, Stefan Beller <sbeller@google.com> wrote:
>=20
> On Thu, Sep 8, 2016 at 11:21 AM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> write_packetized_from_fd() and write_packetized_from_buf() write a
>> stream of packets. All content packets use the maximal packet size
>> except for the last one. After the last content packet a `flush` =
control
>> packet is written.
>=20
> I presume we need both write_* things in a later patch; can you =
clarify why
> we need both of them?

Since 9035d7 Git streams from fd to required filters and from buf to
non-required filters. The Git filter protocol v2 makes use of all that,
too.

=
https://github.com/git/git/commit/9035d75a2be9d80d82676504d69553245017f6d4=



>> +       if (paket_len < 0) {
>> +               if (oldalloc =3D=3D 0)
>> +                       strbuf_release(sb_out);
>=20
> So if old alloc is 0, we release it, which is documented as
> /**
> * Release a string buffer and the memory it used. You should not use =
the
> * string buffer after using this function, unless you initialize it =
again.
> */
>=20
>> +               else
>> +                       strbuf_setlen(sb_out, oldlen);
>=20
> Otherwise we just set the length back, such that it looks like before.
>=20
> So as a caller the strbuf is in a different state in case of error
> depending whether
> the strbuf already had some data in it. I think it would be better if
> we only did
> `strbuf_setlen(sb_out, oldlen);` here, such that the caller can
> strbuf_release it
> unconditionally.

I tried to mimic the behavior of strbuf_read() [1]. The error handling
was introduced in 2fc647 [2] to ease error handling:

"This allows for easier error handling, as callers only need to call
strbuf_release() if A) the command succeeded or B) if they would have =
had
to do so anyway because they added something to the strbuf themselves."

Does this convince you to keep the proposed error handling? If yes, then
I would add a comment to the function to document that behavior =
explicitly!

[1] =
https://github.com/git/git/blob/cda1bbd474805e653dda8a71d4ea3790e2a66cbb/s=
trbuf.c#L377-L383
[2] =
https://github.com/git/git/commit/2fc647004ac7016128372a85db8245581e493812=



> Or to make things more confusing, you could use strbuf_reset in case =
of 0,
> as that is a strbuf_setlen internally. ;)


Thanks,
Lars=
