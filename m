Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD521F6C1
	for <e@80x24.org>; Fri, 26 Aug 2016 10:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbcHZKNm (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 06:13:42 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33402 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbcHZKNl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 06:13:41 -0400
Received: by mail-qk0-f178.google.com with SMTP id z190so71547037qkc.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZUSeL9ZOsCh9riTz7niLMBi+cXXIdVz7Hsxqk2krwpQ=;
        b=DroZGk4fPZK8tR2mm63fTgX9jRm+WO9tfO1FTAngNKcaNHs0IyOPVnAGEdyQKdHIOk
         D9tsc/tgEC7dE6fllqhJuHOKRFIO565xOcd0JcO3sYXCI/9PK43t5mPZlWz97g35xZvS
         9EOct4iRu208Bi7zTiT3blh34RdYxWklirJXnsui2wqbW36s9l4kkbCL8j4xg/Z02o4S
         fuhMJPHIiFTHzhcJERWGET8GdfjntjPg9APpOgpLNco/q1UAQB1TZ9RhqP+Okzc2eZud
         zEi3giu44X7KBmJ9bnupr3mt+/AzFUtAoR9zxrZ8TCMav8RlYPOQRCXS+/7zk85Qbogf
         89vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZUSeL9ZOsCh9riTz7niLMBi+cXXIdVz7Hsxqk2krwpQ=;
        b=FVkLYqjMkSeRLnvw++jliTuKnUFI8nEtMu0BU+kYFo3iL+Jg2IbuxKuWc3Tpgyx0Nb
         7GTQuaipkY2gH/hmpBcSbFFwxO65/YN9laG2atjLm9ugiF8tv8DfoldecySWEsJAGCYi
         iCzX6GipoiiFL6v7dqXM3HYsMO054RV+339Wq3hBk4dPTSO5wn/7fJllzg2WKODvDDdR
         w5I5QFtEDJU3nOBs3VW7EVMfg7ZGCUuPTr+T3ccD/ynNy+6qTV0vvsDT0nzdrSu9uYjc
         Ny10yJidbqzHKrGIi+UtyxIe9c8bRFFsrVt0k6HRXPzeih6JSUqQupR4rQO8xFRasuxb
         btOw==
X-Gm-Message-State: AE9vXwOuXNiBg8URJ+ISt5TyXaCKBT7zHibFQy+x7743+rpqZy9I60/A7l4d/NNVpFfDJA==
X-Received: by 10.55.41.86 with SMTP id p83mr2283295qkh.93.1472206419937;
        Fri, 26 Aug 2016 03:13:39 -0700 (PDT)
Received: from sfobsh4h12.ads.autodesk.com ([132.188.72.183])
        by smtp.gmail.com with ESMTPSA id a193sm9948911qkc.24.2016.08.26.03.13.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Aug 2016 03:13:39 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush terminated packet streams
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqzio0jxh7.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 26 Aug 2016 12:13:35 +0200
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8C981C6-22F5-4922-BBF7-F71961B3271B@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-7-larsxschneider@gmail.com> <xmqqzio0jxh7.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Aug 2016, at 00:27, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> packet_write_stream_with_flush_from_fd() and
>> packet_write_stream_with_flush_from_buf() write a stream of packets. =
All
>> content packets use the maximal packet size except for the last one.
>> After the last content packet a `flush` control packet is written.
>> packet_read_till_flush() reads arbitrary sized packets until it =
detects
>> a `flush` packet.
>=20
> These are awkwardly named and I couldn't guess what the input is (I
> can tell one is to read from fd and the other is <mem,len> buffer,
> but it is unclear if that is in packetized form or just raw data
> stream to be copied to the end from their names) without reading the
> implementation.  I _think_ you read a raw stream of data through the
> end (either EOF or length limit) and write it out packetized, and
> use the flush packet to mark the end of the stream.  In my mind,
> that is "writing a packetized stream".  The words "packetizing" and
> "stream" imply that the stream could consist of more data than what
> would fit in a single packet, which in turn implies that there needs
> a way to mark the end of one data item, so with_flush does not
> necessarily have to be their names.
>=20
> The counter-part would be "reading a packetized stream".
>=20
>> +int packet_write_stream_with_flush_from_fd(int fd_in, int fd_out)
>> +{
>=20
> Especially this one I am tempted to suggest =
"copy-to-packetized-stream",
> as it reads a stream from one fd and then copies out while =
packetizing.

OK, what function names would be more clear from your point of view?

copy_to_packetized_stream_from_fd()
copy_to_packetized_stream_from_buf()
copy_to_packetized_stream_to_buf()

or

write_packetized_stream_from_fd()
write_packetized_stream_from_buf()
read_packetized_stream_to_buf()

?


>> +int packet_write_stream_with_flush_from_buf(const char *src_in, =
size_t len, int fd_out)
>> +{
>> +	int err =3D 0;
>> +	size_t bytes_written =3D 0;
>> +	size_t bytes_to_write;
>> +
>> +	while (!err) {
>> +		if ((len - bytes_written) > sizeof(packet_write_buffer) =
- 4)
>> +			bytes_to_write =3D sizeof(packet_write_buffer) - =
4;
>> +		else
>> +			bytes_to_write =3D len - bytes_written;
>> +		if (bytes_to_write =3D=3D 0)
>> +			break;
>=20
> The lack of COPY_WRITE_ERROR puzzled me briefly here.  If you are
> assuming that your math at the beginning of this loop is correct and
> bytes_to_write will never exceed the write-buffer size, I think you
> should be able to (and it would be better to) assume that the math
> you do to tell xread() up to how many bytes it is allowed to read at
> once is also correct, losing the COPY_WRITE_ERROR check in the other
> function.  You can choose to play safer and do a check in this
> function, too.  Either way, we would want to be consistent.

OK. I'll remove the (I just realized meaningless) check in the other =
function:

+		if (bytes_to_write > sizeof(packet_write_buffer) - 4)
+			return COPY_WRITE_ERROR;

>=20
>> +		err =3D packet_write_gently(fd_out, src_in + =
bytes_written, bytes_to_write);
>> +		bytes_written +=3D bytes_to_write;
>> +	}
>> +	if (!err)
>> +		err =3D packet_flush_gently(fd_out);
>> +	return err;
>> +}
>=20
>> +ssize_t packet_read_till_flush(int fd_in, struct strbuf *sb_out)
>> +{
>> +	int len, ret;
>> +	int options =3D PACKET_READ_GENTLE_ON_EOF;
>> +	char linelen[4];
>> +
>> +	size_t oldlen =3D sb_out->len;
>> +	size_t oldalloc =3D sb_out->alloc;
>> +
>> +	for (;;) {
>> +		/* Read packet header */
>> +		ret =3D get_packet_data(fd_in, NULL, NULL, linelen, 4, =
options);
>> +		if (ret < 0)
>> +			goto done;
>> +		len =3D packet_length(linelen);
>> +		if (len < 0)
>> +			die("protocol error: bad line length character: =
%.4s", linelen);
>> +		if (!len) {
>> +			/* Found a flush packet - Done! */
>> +			packet_trace("0000", 4, 0);
>> +			break;
>> +		}
>> +		len -=3D 4;
>> +
>> +		/* Read packet content */
>> +		strbuf_grow(sb_out, len);
>> +		ret =3D get_packet_data(fd_in, NULL, NULL, sb_out->buf + =
sb_out->len, len, options);
>> +		if (ret < 0)
>> +			goto done;
>> +		if (ret !=3D len) {
>> +			error("protocol error: incomplete read (expected =
%d, got %d)", len, ret);
>> +			goto done;
>> +		}
>> +
>> +		packet_trace(sb_out->buf + sb_out->len, len, 0);
>=20
> All of the above seems to pretty much duplicate the logic in
> packet_read(), except that this user does not need options handling
> it has.  Is optimizing that out the reason why you open-coded it
> here?

No.

> Or is it because you cannot tell if you got a truly empty packet or
> you got a flush from outside packet_read(), and you wanted to make
> sure that you won't be fooled by a normal packet with 0-length
> payload?

Correct!

>=20
> If the latter is the reason, it may be a viable alternative to
> update packet_read() to take PACKET_READ_IGNORE_EMPTY_PACKET, i.e. a
> new bit in its options parameter, so that a normal packet with
> 0-length payload is simply ignored there (i.e. even without
> returning, packet_read() would repeat from the beginning when it got
> such a packet).  That way, the above would become=20
>=20
> 	strbuf_grow(); /* enough to hold max-packet-len more bytes */
> 	len =3D packet_read();
>        if (!len)
>        	/* we cannot get 0 unless we see flush */
>                break;
>=20
> which may be a lot cleaner?

Good idea! I will refactor it that way!


Thanks a lot for the review,
Lars

