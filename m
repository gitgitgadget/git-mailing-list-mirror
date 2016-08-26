Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8161F6C1
	for <e@80x24.org>; Fri, 26 Aug 2016 09:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbcHZJku (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 05:40:50 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33827 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbcHZJkt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 05:40:49 -0400
Received: by mail-qt0-f196.google.com with SMTP id c52so2717854qte.1
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5dvIAgrxYoP+/URnEloHxaCCbELdyAxJmbF+QIGQ29g=;
        b=R8s07acXQxFW/ops4lV6puOvD6BaaqFtANA/PdQHfQxFO5OcSQE0ZlRAv4wETymMBu
         Mfo5fA3na7rHnyefXwRscoLLhdA5GZxryLMCBeSm64wbOyR0LsDF6mjhDLuDWSG9A2Ib
         HbgJ+lLiSD0bV3DAK71okIrdIcAjKk5/3kYL5rUs39RFqqJNnxN3Nrcz1BnuUL4kw6L+
         XvyiLOA/5HpQAcz/jlumBefk1e3jVA91skYP3RfEqAXkD2HipPBr+NX1MiCWUp3JWmro
         xBf0lnHtksE0Eeai40HpqiVox8AL3R9u3x6DFCMbL1Ak81EHlgLY+6JMzxjZAzWz+kim
         jfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5dvIAgrxYoP+/URnEloHxaCCbELdyAxJmbF+QIGQ29g=;
        b=QsY1K0c228gnItajtikluuMRVTX+DcxRG3X0uGUthUaFrVCVKQoko3MnlcP96QbqCr
         xyLaCol9NKsRjQ6ZCFcj9yG05IPtrlhDAS956/wjokuVISnZu/optl+/klEujBQXu7kB
         xyzYyzvFW+zOqAu4c5upxEi3zmaWc++KNcE15hm3yt9HQpnNTTjGdVkhVvgonypUOMxH
         gRojz1cIF68hG01uAC9MrFzlgKRMQZeyvFAXEQcwYYHJ8fdxQGffe+IpYGQL4Iovjecy
         CSBkoY5sUHpEEfdpK9ZAapQf1Za0WVF15k/crwPnFpW1JQUpSKabPVKd8AgmyMl8JGU6
         o5ew==
X-Gm-Message-State: AE9vXwOgWOR2crrnZyBFV8qCFA6niqgysyfLCKQotekq9f5H7kdQY7pb6+yU6c+jkfCmmg==
X-Received: by 10.200.53.214 with SMTP id l22mr2086557qtb.117.1472204448838;
        Fri, 26 Aug 2016 02:40:48 -0700 (PDT)
Received: from sfobsh4h12.ads.autodesk.com ([132.188.72.183])
        by smtp.gmail.com with ESMTPSA id r5sm9858993qkf.34.2016.08.26.02.40.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Aug 2016 02:40:48 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 05/13] pkt-line: add packet_write_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq4m68ldrg.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 26 Aug 2016 11:40:44 +0200
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BD3A97F-A9FD-45A6-AF82-E01CC6B9BA89@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-6-larsxschneider@gmail.com> <xmqq4m68ldrg.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Aug 2016, at 23:50, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> packet_write_fmt() has two shortcomings. First, it uses =
format_packet()
>> which lets the caller only send string data via "%s". That means it
>> cannot be used for arbitrary data that may contain NULs. Second, it =
will
>> always die on error.
>=20
> As you introduced _gently in 3/13, the latter is no longer a valid
> excuse to add this function.  Just remove the sentence "Second, ...".

Agreed!


>> Add packet_write_gently() which writes arbitrary data and returns `0`
>> for success and `-1` for an error. This function is used by other
>> pkt-line functions in a subsequent patch.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> pkt-line.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>=20
>> diff --git a/pkt-line.c b/pkt-line.c
>> index cad26df..7e8a803 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -3,6 +3,7 @@
>> #include "run-command.h"
>>=20
>> char packet_buffer[LARGE_PACKET_MAX];
>> +static char packet_write_buffer[LARGE_PACKET_MAX];
>> static const char *packet_trace_prefix =3D "git";
>> static struct trace_key trace_packet =3D TRACE_KEY_INIT(PACKET);
>> static struct trace_key trace_pack =3D TRACE_KEY_INIT(PACKFILE);
>> @@ -155,6 +156,17 @@ int packet_write_fmt_gently(int fd, const char =
*fmt, ...)
>> 	return (write_in_full(fd, buf.buf, buf.len) =3D=3D buf.len ? 0 : =
-1);
>> }
>>=20
>> +int packet_write_gently(const int fd_out, const char *buf, size_t =
size)
>> +{
>> +	if (size > sizeof(packet_write_buffer) - 4)
>> +		return -1;
>> +	packet_trace(buf, size, 1);
>> +	memmove(packet_write_buffer + 4, buf, size);
>> +	size +=3D 4;
>> +	set_packet_header(packet_write_buffer, size);
>=20
> It may not matter all that much, but from code-reader's point of
> view, when you know packet_write_buffer[] will contain things A and
> B in this order, and when you have enough information to compute A
> before stasrting to fill packet_write_buffer[], I would prefer to
> see you actually fill the buffer in that natural order.

I did that because when packet_write_stream_with_flush_from_fd()
calls packet_write_gently() then buf[] is actually =
packet_write_buffer[]:

=
https://github.com/larsxschneider/git/blob/d474e6a4c2523b87624a07111eb7a4f=
2dcd12426/pkt-line.c#L185-L192

Therefore I would override the first 4 bytes. However, the code evolved =
for
some reason in that way but looking at it now I think that is an =
obscure,
likely meaningless optimization. I'll use a separate buffer in=20
packet_write_stream_with_flush_from_fd() and then fix the order here
following your advice.


> Do you anticipate future need of non-gently variant of this
> function?  If so, perhaps a helper that takes a boolean "am I
> working for the gently variant?" may help share more code.

With helper you mean "an additional boolean parameter"? I don't=20
see a need for a non-gently variant right now but I will
add this parameter if you think it is a good idea. How would the
signature look like?

int packet_write_gently(const int fd_out, const char *buf, size_t size, =
int gentle)

This would follow type_from_string_gently() in object.h.

Thanks,
Lars=
