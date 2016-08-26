Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 603691F6C1
	for <e@80x24.org>; Fri, 26 Aug 2016 09:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbcHZJRk (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 05:17:40 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34597 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbcHZJRi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 05:17:38 -0400
Received: by mail-qk0-f196.google.com with SMTP id r128so5458967qkc.1
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3HlbFqEYk4yc/hesKDdSsnCfCJge6BBX8uyCApuiH4U=;
        b=JaKzgl5JsX6k9pBRUeROv4PxBd1sLJxG6P6JqEJlZgfwKSkx7Na2dxWa58ff7ZN1bg
         gfeWofCvZv79zlj+3bTEVss+oyf5IXf1sL0k/p3rng/vy4+TFJTbn72gg4g888mv2SVm
         iXpCVum2Aa8GPeN12cnbAadADRgZxHxNmrKaEPvm3P7w/dhchcQmBQJ/t1dT83Dgmq/9
         OCqLXxm2RsXg/KVdKkZ0CwmHHOiLAcDB8IjNfGXiW7SvkM/LNzg73KA3rZm1GnT06glQ
         ajSyoaAMJ8ulsO7sVfrozz6qW+IAyBNkTK3XoR/T5C+0PhiQ3XlMNVzI72+nckJo5KCa
         W7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3HlbFqEYk4yc/hesKDdSsnCfCJge6BBX8uyCApuiH4U=;
        b=LmIWrR2yqyY7vC4yfRirnIkUlbn6177U+IfpmMvPwrmVC1FvlHHHKqqcsBYHKWVm7i
         VEr5lOsRIE/YUglj/O9ta7U5KZkd4V65Skx+A4VYV7TBsfBPkhx1uyOHCAy1ayWY1aG8
         2g4XsiZRG07Dk25QttiRtgvO8BnfdjpYPikk9GVCjt4qiG5B2rGUntmaT1obWrm1sVbF
         ZyYKdvuKkNac+2f6YP9J3rnFXSlzpUwKipmE4qCv/S1Px0KmhNEVNCdgj86IkTZyGzdl
         J6hQBemZbB/VD6U3ews+3SPNSYFDFr4Fv+nYlCDu12++dKyukfxecj91daXqaOMCrDUk
         vXWw==
X-Gm-Message-State: AE9vXwNrR+JPfGVlujesBD7rfh8ceIxexDEWA0dsj9j2sZcrjfKjhtt7tb/HrHKHqYMh5w==
X-Received: by 10.55.156.135 with SMTP id f129mr1911554qke.155.1472203058000;
        Fri, 26 Aug 2016 02:17:38 -0700 (PDT)
Received: from sfobsh4h12.ads.autodesk.com ([132.188.72.183])
        by smtp.gmail.com with ESMTPSA id i123sm333974qke.19.2016.08.26.02.17.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Aug 2016 02:17:37 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 03/13] pkt-line: add packet_write_fmt_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq8tvkle6o.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 26 Aug 2016 11:17:34 +0200
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A26AA14-E393-492C-ADE0-3206DF78AFF6@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-4-larsxschneider@gmail.com> <xmqq8tvkle6o.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Aug 2016, at 23:41, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> packet_write_fmt() would die in case of a write error even though for
>> some callers an error would be acceptable. Add =
packet_write_fmt_gently()
>> which writes a formatted pkt-line and returns `0` for success and =
`-1`
>> for an error.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> pkt-line.c | 12 ++++++++++++
>> pkt-line.h |  1 +
>> 2 files changed, 13 insertions(+)
>>=20
>> diff --git a/pkt-line.c b/pkt-line.c
>> index e8adc0f..3e8b2fb 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -137,6 +137,18 @@ void packet_write_fmt(int fd, const char *fmt, =
...)
>> 	write_or_die(fd, buf.buf, buf.len);
>> }
>>=20
>> +int packet_write_fmt_gently(int fd, const char *fmt, ...)
>> +{
>> +	static struct strbuf buf =3D STRBUF_INIT;
>> +	va_list args;
>> +
>> +	strbuf_reset(&buf);
>> +	va_start(args, fmt);
>> +	format_packet(&buf, fmt, args);
>> +	va_end(args);
>> +	return (write_in_full(fd, buf.buf, buf.len) =3D=3D buf.len ? 0 : =
-1);
>> +}
>=20
> Even though its only a handful lines, it is a bit ugly to have a
> completely copied implementation only to have _gently().  I suspect
> that you should be able to
>=20
> 	static int packet_write_fmt_1(int fd, int gently,
> 					const char *fmt, va_list args)
>        {
> 		struct strbuf buf =3D STRBUF_INIT;
> 		size_t count;
>=20
> 		format_packet(&buf, fmt, args);
> 	=09
> 		count =3D write_in_full(fd, buf.buf, buf.len);
>                if (count =3D=3D buf.len)
>                	return 0;
> 		if (!gently) {
> 			check_pipe(errno);
>                	die_errno("write error");
> 		}
>                return -1;
> 	}
>=20
> and then share that between the existing one:
>=20
> 	void packet_write_fmt(int fd, const char *fmt, ...)
>        {
> 		va_list args;
> 	        va_start(args, fmt);
>                packet_write_fmt_1(fd, 0, fmt, args);
>                va_end(args);
> 	}
>=20
> and the new one:
>=20
> 	void packet_write_fmt_gently(int fd, const char *fmt, ...)
>        {
> 		int status;
> 		va_list args;
> 	        va_start(args, fmt);
>                status =3D packet_write_fmt_1(fd, 1, fmt, args);
>                va_end(args);
> 		return status;
> 	}

I agree with your criticism of the code duplication.=20

However, I thought it would be OK, as Peff already=20
tried to refactor it...
=
http://public-inbox.org/git/20160810150139.lpxyrqkr53s5f4sx@sigill.intra.p=
eff.net/

... and I got the impression you agreed with Peff:
=
http://public-inbox.org/git/xmqqvaz84g9y.fsf@gitster.mtv.corp.google.com/


I will try to refactor it according to your suggestion above.=20
Would "packet_write_fmt_1()" be an acceptable name or should=20
I come up with something more expressive?

Thanks you,
Lars=
