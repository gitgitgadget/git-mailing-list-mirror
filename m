Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AB071F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755405AbcJERgI (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:36:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34666 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755439AbcJERfm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:35:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id b201so20465354wmb.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kfGeOYpjL6Npk4yK58nnkpnDV3PP+4DaOQYTYrZqI18=;
        b=E8bdWNvT3oDAYM7fSQxJ/Tk3aDteo9PWfV0hJmMqE4tOroAYVtzMPakDNvGN2b+Mwr
         LfFlAtLdLXGRp76ysJab9YY0mIo+nrlFPrEtJ2fcjhe4JpEwgSp/bhxJ1NTKDnAIRB02
         EoCjvg5j2WADif7jXrI6D25XkhdvfGBFqlTIwlFtpAYpDmzIfoVQvC9MRoo+Ll2jibBH
         1rolG8xAKcKsxAFj5aRrPE1gtu8r/tO68kg0iqUETZzB7At4iBj2vfuYQtL5KCxFe7NZ
         j/k68lPix3dbKAFZRxgntTpZkDSGACxIoOkmAAinlVifgjBo/5lifF+1CWfVTKvpOqUx
         9qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kfGeOYpjL6Npk4yK58nnkpnDV3PP+4DaOQYTYrZqI18=;
        b=j7ZGZ0ALntuek8frHAx4En+DFMBykU7kWu4y0Pk5N+om5Skom4qMFnjGtzgZ1M8quU
         EviKaAPYQBd/CjeGcMbTkCkfYmJlPevmirHGRm0sC7eEwSnbfP7v8xoRRT/b54bDyJxN
         keis9rRAkZx7CwvhhQlqMN+lLfP7lhRIBH6RDL4docQPXg1Pv3mp4BQWjMtfd2LD/W/y
         Qeadr41oZOTxYr2w/ntwnpGcM46E4uDoyTVWMzyQpTCcjs2AuWQdSJ2tAHIeVQCRmEuo
         rM6r0Ed8msZxeaSw+L6XAfwN8IaCWRAwHrYtogdWE0r1HDUOQ44oZ+rnj6TwM/Kn02K6
         YFRw==
X-Gm-Message-State: AA6/9RlFgrjXUTVBAfU0XxMne9PIVp/7oIWiHtL+Tt3cganLYw5d+0XDI4tybbkh+Cewmw==
X-Received: by 10.28.210.21 with SMTP id j21mr10603974wmg.74.1475688940621;
        Wed, 05 Oct 2016 10:35:40 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id a84sm30979508wme.6.2016.10.05.10.35.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Oct 2016 10:35:39 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 10/14] pkt-line: add functions to read/write flush terminated packet streams
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq8tu3ubzl.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 5 Oct 2016 19:35:38 +0200
Cc:     git <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>, mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <40D4374E-3784-4AF8-B9F3-E0C117A05631@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com> <20161004125947.67104-11-larsxschneider@gmail.com> <xmqq8tu3ubzl.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Oct 2016, at 21:53, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>=20
>> +int write_packetized_from_buf(const char *src_in, size_t len, int =
fd_out)
>> +{
>> +	static char buf[LARGE_PACKET_DATA_MAX];
>> +	int err =3D 0;
>> +	size_t bytes_written =3D 0;
>> +	size_t bytes_to_write;
>> +
>> +	while (!err) {
>> +		if ((len - bytes_written) > sizeof(buf))
>> +			bytes_to_write =3D sizeof(buf);
>> +		else
>> +			bytes_to_write =3D len - bytes_written;
>> +		if (bytes_to_write =3D=3D 0)
>> +			break;
>> +		err =3D packet_write_gently(fd_out, src_in + =
bytes_written, bytes_to_write);
>> +		bytes_written +=3D bytes_to_write;
>> +	}
>> +	if (!err)
>> +		err =3D packet_flush_gently(fd_out);
>> +	return err;
>> +}
>=20
> Hmph, what is buf[] used for, other than its sizeof() taken to yield
> a constant LARGE_PACKET_DATA_MAX?

Agreed. This is stupid. I will fix it.


>>=20
>> +	for (;;) {
>> +		strbuf_grow(sb_out, LARGE_PACKET_DATA_MAX);
>> +		packet_len =3D packet_read(fd_in, NULL, NULL,
>> +			// TODO: explain + 1
>=20
> No // C99 comment please.
>=20
> And I agree that the +1 needs to be explained.

Oh. I did not send the very latest version :-(

Is this explanation OK?

+       strbuf_grow(sb_out, LARGE_PACKET_DATA_MAX);
+       packet_len =3D packet_read(fd_in, NULL, NULL,
+           /* strbuf_grow() above always allocates one extra byte to
+            * store a '\0' at the end of the string. packet_read()
+            * writes a '\0' extra byte at the end, too. Let it know
+            * that there is already room for the extra byte.
+            */
+           sb_out->buf + sb_out->len, LARGE_PACKET_DATA_MAX+1,
+           PACKET_READ_GENTLE_ON_EOF);


Thanks,
Lars=
