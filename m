Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112C6207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 20:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033024AbcIZUXj (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 16:23:39 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34574 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933488AbcIZUXh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 16:23:37 -0400
Received: by mail-lf0-f68.google.com with SMTP id b71so9965323lfg.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xk66157v9ic5jtEYfkGk1MKLKvgawpc0h+rcAsFYjqw=;
        b=H5b9Cf9cvNvbVrfRd7TioUd6+gAqJu5h3ndB++1kEb5xP11UVnDhYACCUS+qcVC63T
         MAJePYUX5AmltoRcXugygCPeg+Mehb94CfON4Okm6gan+Dn/Wye39DEGYZotZjc6AnVL
         Th7AtBrxuuTbCHo5bGZE0/RTg6Hz5BubYN4x/LwcxlrilliWpXm9LQH19ovnseEflLSJ
         CppuM9ucHUoj5mklUoo5CpxwwcEyILruTE5b9sWMZZSw1l1oZF5SJXtafAx5k0TQmtBV
         7FwwExpCC8aV9XRkHa8BmhMcEhLkJPOLqB3Z5kIl4VbJ5SOTK9+Pu1HABQvbhMacrqiL
         W3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xk66157v9ic5jtEYfkGk1MKLKvgawpc0h+rcAsFYjqw=;
        b=cZrUdJ557oTJdqr9EmANyEWvXf/EL+LW1RuhLIyuCGw4d5fMNzdtxjzCD9TUPPVeTT
         AZWkPcx5UlHT6n3/+3hiGz9pppqEm0E2tlwO92syKRmqfGv+CS84nGD+FZOHJv2JCgrn
         xptUKUx2oeRBfn0HCIvO/0kLE8KJe+ggkdd6fr9U1nKJS8pMqXVlmbWGOz+XodF5Gwjs
         qTVGAxjK+CozYK961iwyls308J1pdg5NFaLOM/t/5InNfxvY8FgMcB/ebdmFNdiDm0X0
         qBRVKCwesqqXwEUz5mkqxw5BTI5Ja3SxYOQ5+d5sbWA3Sdj4YehZ2mVPFEdkQ6hQ7nCu
         sgJA==
X-Gm-Message-State: AA6/9RnpsvRkM+rsTOI+aCBzyPD9sp3hIsjJAqp1g3g+nkJVVFU1gIDO1DxKZhyZlEDShA==
X-Received: by 10.194.102.132 with SMTP id fo4mr18954539wjb.157.1474921415222;
        Mon, 26 Sep 2016 13:23:35 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4342.dip0.t-ipconnect.de. [93.219.67.66])
        by smtp.gmail.com with ESMTPSA id i127sm12980627wmf.4.2016.09.26.13.23.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Sep 2016 13:23:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v8 07/11] pkt-line: add functions to read/write flush terminated packet streams
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <507a29a1-99ff-c13e-cf1f-76631345a822@gmail.com>
Date:   Mon, 26 Sep 2016 22:23:32 +0200
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <77315FC2-47F3-433A-8D70-5497FB04CBBE@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-8-larsxschneider@gmail.com> <507a29a1-99ff-c13e-cf1f-76631345a822@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 25 Sep 2016, at 15:46, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:

> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>


>> +{
>> +	static char buf[PKTLINE_DATA_MAXLEN];
>=20
> Sidenote: we have LARGE_PACKET_MAX (used in previous patch), but
> PKTLINE_DATA_MAXLEN not LARGE_PACKET_DATA_MAX.

Agreed, I will rename it.


>=20
>> +	int err =3D 0;
>> +	ssize_t bytes_to_write;
>> +
>> +	while (!err) {
>> +		bytes_to_write =3D xread(fd_in, buf, sizeof(buf));
>> +		if (bytes_to_write < 0)
>> +			return COPY_READ_ERROR;
>> +		if (bytes_to_write =3D=3D 0)
>> +			break;
>> +		err =3D packet_write_gently(fd_out, buf, =
bytes_to_write);
>> +	}
>> +	if (!err)
>> +		err =3D packet_flush_gently(fd_out);
>> +	return err;
>> +}
>=20
> Looks good: clean and readable.
>=20
> Sidenote (probably outside of scope of this patch): what are the
> errors that we can get from this function, beside COPY_READ_ERROR
> of course?

Everything that is returned by "read()"


>> +
>> static int get_packet_data(int fd, char **src_buf, size_t *src_size,
>> 			   void *dst, unsigned size, int options)
>> {
>> @@ -305,3 +346,30 @@ char *packet_read_line_buf(char **src, size_t =
*src_len, int *dst_len)
>> {
>> 	return packet_read_line_generic(-1, src, src_len, dst_len);
>> }
>> +
>> +ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out)
>=20
> It's a bit strange that the signature of write_packetized_from_buf() =
is
> that different from read_packetized_to_buf().  This includes the =
return
> value: int vs ssize_t.  As I have checked, write() and read() both
> use ssize_t, while fread() and fwrite() both use size_t.

read_packetized_to_buf() returns the number of bytes read or a negative=20=

error code.

write_packetized_from_buf() returns 0 if the call was successful and an=20=

error code if not.

That's the reason these two functions have a different signature


> Perhaps this function should be named read_packetized_to_strbuf()
> (err, I asked this already)?

I agree with the rename as makes it distinct from=20
write_packetized_from_buf().


>> +{
>> +	int paket_len;
>=20
> Possible typo: shouldn't it be called packet_len?

True!


> Shouldn't it be initialized to 0?

Well, it is set for sure later. That's why I think it is not necessary.

Plus, Eric Wong thought me not to:
"Compilers complain about uninitialized variables."
http://public-inbox.org/git/20160725072745.GB11634@starla/
(Note: he was talking about pointers there :-)


>> +	int options =3D PACKET_READ_GENTLE_ON_EOF;
>=20
> Why is this even a local variable?  It is never changed, and it is
> used only in one place; we can inline it.

Removed.


>> +
>> +	size_t oldlen =3D sb_out->len;
>> +	size_t oldalloc =3D sb_out->alloc;
>=20
> Just a nitpick (feel free to ignore): doesn't this looks better:
>=20
>  +	size_t old_len   =3D sb_out->len;
>  +	size_t old_alloc =3D sb_out->alloc;
>=20
> Also perhaps s/old_/orig_/g.

Agreed. That matches the other variables better.


>> +		strbuf_grow(sb_out, PKTLINE_DATA_MAXLEN+1);
>> +		paket_len =3D packet_read(fd_in, NULL, NULL,
>> +			sb_out->buf + sb_out->len, =
PKTLINE_DATA_MAXLEN+1, options);
>=20
> A question (which perhaps was answered during the development of this
> patch series): why is this +1 in PKTLINE_DATA_MAXLEN+1 here?

Nice catch. I think this is wrong:
=
https://github.com/git/git/blob/6fe1b1407ed91823daa5d487abe457ff37463349/p=
kt-line.c#L196

It should be "if (len > size)" ... then we don't need the "+1" here.
(but I need to think a bit more about this)

>=20
>> +		if (paket_len <=3D 0)
>> +			break;
>> +		sb_out->len +=3D paket_len;
>> +	}
>> +
>> +	if (paket_len < 0) {
>> +		if (oldalloc =3D=3D 0)
>> +			strbuf_release(sb_out);
>> +		else
>> +			strbuf_setlen(sb_out, oldlen);
>=20
> A question (maybe I don't understand strbufs): why there is a special
> case for oldalloc =3D=3D 0?

I tried to mimic the behavior of strbuf_read() [1]. The error handling
was introduced in 2fc647 [2] to ease error handling:

"This allows for easier error handling, as callers only need to call
strbuf_release() if A) the command succeeded or B) if they would have =
had
to do so anyway because they added something to the strbuf themselves."

[1] =
https://github.com/git/git/blob/cda1bbd474805e653dda8a71d4ea3790e2a66cbb/s=
trbuf.c#L377-L383
[2] =
https://github.com/git/git/commit/2fc647004ac7016128372a85db8245581e493812=



Thanks,
Lars=
