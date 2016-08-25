Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317771F859
	for <e@80x24.org>; Thu, 25 Aug 2016 23:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757243AbcHYXbA (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 19:31:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34315 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756165AbcHYXas (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 19:30:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so9266758wma.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=ZWrNZL/8t7JKOUrij5VbxeCZU0bTbHtnrlbS3CXLkaw=;
        b=QDk5vjqxglfogFh2dT8oqBs1Je2PehK1COxjRbszK2qOo5OTUjOvIhCOW5xK/GK/4g
         tYJeA3jDzuzSumscaEUYhBXAgsfjp2PkOZmRA53paitTYIfIJU/KDHAODB+xzr68rJNv
         imMCloka34xynI5hWSZGHcwLlRNCQc2/YokN2UVRhwWZT9ssRnODp3xCFZ/E/VVRNCcI
         BT3983AxhPD5w+48zinLJ76XKqEzSok+gCps1UGtWNtWwACSdPsBe9O+Ua+aukrOybvW
         fAsTtHvX6aYW/eHVKAH/EapQZyvuLjwcYlk7xqSG2gQL8y514w/XUpp5UMfUsgtzBS4x
         RpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=ZWrNZL/8t7JKOUrij5VbxeCZU0bTbHtnrlbS3CXLkaw=;
        b=O9Oe6kPVu3ut2KDdhX19RK9qx2/74+3YsS7oNh1bDRZoXzkMnb60cxb5xq1aEU9N5i
         itvEUSsBm9QNZ89nnthyKUkwp/tIku0OAMYlosUl9XkJzMYB0uAU4kWj0Ljxjjhw5Bj4
         v8/X55KcjbiOR2JH+xMcgTN7H7qt7pYQa5OeoicMqAVxt+9RmMFr+gNqbIxCA3ep8e7I
         BMmTyTsN5Azaz3B1ejccLCwnUCsHq2P2Z+xIcnPsgr5ZUCEMlZXlB+2zcslRmObeRSKy
         7/o/ERX8937vBgqgKTvKUjdl3jgzC0/PLM4MhNusbg3PPS115oTZ57RhJv/3lf0l8EYD
         7VkA==
X-Gm-Message-State: AEkoouvvWVvzAeK8KKDnwBPbn7KlRnSJkMfpSEiCO/hUXLPnjdthw9c9kOpnqP+WtdZk1Q==
X-Received: by 10.28.148.148 with SMTP id w142mr32951591wmd.48.1472153659256;
        Thu, 25 Aug 2016 12:34:19 -0700 (PDT)
Received: from [10.20.236.170] (tmo-114-227.customers.d1-online.com. [80.187.114.227])
        by smtp.gmail.com with ESMTPSA id r16sm40236501wme.16.2016.08.25.12.34.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 12:34:18 -0700 (PDT)
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-7-larsxschneider@gmail.com> <CAGZ79kaVg40H-LeDtFfDYqDFDDbr+um3ZYj8oAaqGu+q6k5e+A@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CAGZ79kaVg40H-LeDtFfDYqDFDDbr+um3ZYj8oAaqGu+q6k5e+A@mail.gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <269094FB-81F3-4220-BE7A-F957EDF6F808@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
X-Mailer: iPhone Mail (13G35)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush terminated packet streams
Date:   Thu, 25 Aug 2016 21:33:34 +0200
To:     Stefan Beller <sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Aug 2016, at 20:46, Stefan Beller <sbeller@google.com> wrote:
>=20
>> On Thu, Aug 25, 2016 at 4:07 AM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> packet_write_stream_with_flush_from_fd() and
>> packet_write_stream_with_flush_from_buf() write a stream of packets. All
>> content packets use the maximal packet size except for the last one.
>> After the last content packet a `flush` control packet is written.
>>=20
>> packet_read_till_flush() reads arbitrary sized packets until it detects
>> a `flush` packet.
>=20
> So the API provided by these read/write functions is intended
> to move a huge chunks of data. And as it puts the data on the wire one
> packet after the other without the possibility to intervene and e.g. send
> a side channel progress bar update, I would question the design of this.
> If I understand correctly this will be specifically  used for large
> files locally,
> so e.g. a file of 5 GB (such as a virtual machine tracked in Git), would
> require about 80k packets.

Peff suggested this approach arguing that the overhead is neglectable:
http://public-inbox.org/git/20160720134916.GB19359@sigill.intra.peff.net/


> Instead of having many packets of max length and then a remainder,
> I would suggest to invent larger packets for this use case. Then we can
> just send one packet instead.
>=20
> Currently a packet consists of 4 bytes indicating the length in hex
> and then the payload of length-4 bytes. As the length is in hex
> the characters in the first 4 bytes are [0-9a-f], we can easily add anothe=
r
> meaning for the length, e.g.:
>=20
>  A packet starts with the overall length and then the payload.
>  If the first character of the length is 'v' the length is encoded as a
>  variable length quantity[1]. The high bit of the char indicates if
>  the next char is still part of the length field. The length must not exce=
ed
>  LLONG_MAX (which results in a payload of 9223 Petabyte, so
>  enough for the foreseeable future).

Eventually I would like to resurrect Joey's cleanFromFile/smudgeToFile idea:=


http://public-inbox.org/git/1468277112-9909-3-git-send-email-joeyh@joeyh.nam=
e/

Then we would not need to transfer that much data over the pipes. However, I=
 wonder if the large amount of packets would actually be a problem. Honestly=
, I would prefer to not change Git's packet format in this already large ser=
ies ;-)


>  [1] A variable-length quantity (VLQ) is a universal code that uses
>  an arbitrary number of bytes to represent an arbitrarily large integer.
>  https://en.wikipedia.org/wiki/Variable-length_quantity
>=20
> The neat thing about the packet system is we can dedicate packets
> to different channels (such as the side channels), but with the provided
> API here this makes it impossible to later add in these side channel
> as it is a pure streaming API now. So let's remove the complication
> of having to send multiple packets and just go with one large packet
> instead.

I tried to design the protocol as flexible as possible for the future with a=
 version negotiation and a capabilities list. Therefore, I would think it sh=
ould be possible to implement these ideas in the future if they are required=
.


> --
>    I understand that my proposal would require writing code again,
>    but it has also some long term advantages in the networking stack
>    of Git: There are some worries that a capabilities line in fetch/push
>    might overflow in the far future, when there are lots of capabilities.
>=20
>    Also a few days ago there was a proposal to add all symbolic refs
>    to a capabilities line, which Peff shot down as "the packet may be
>    too small".
>=20
>    There is an incredible hack that allows transporting refs > 64kB IIRC.
>=20
>    All these things could go away with the variable length encoded
>    packets. But to make them go away in the future we would need
>    to start with these variable length packets today. ;)
>=20
> Just food for thought.

Thanks for thinking it through that thoroughly! I understand your point of v=
iew and I am curious what others thing.

Cheers,
Lars

