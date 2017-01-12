Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C601FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 12:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbdALMUR (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 07:20:17 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34518 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdALMUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 07:20:16 -0500
Received: by mail-io0-f195.google.com with SMTP id c80so2194962iod.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 04:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/QT/mbM6XFmw+5mqtZ/2egV/mJ9NZ3Byxw0u6u8Wpto=;
        b=kOlnxvJW0GTdVNXlbSeAEFd3oaGaNHdAM0ZHR4+mNC9efDuGS3iPocR2goLEoVd9L+
         EOVQfO9jLbovKpRMsUnZuueIYgRSYtnWlmT6IFZ5bybUu3rIyV9SNowBHmMI7n5ayA6h
         zmSqzH1MQq9MRmvDyqTjd78RvjJ3KTi0BC8d19Wh5prPqPcBf54Z/NLHQYL/UmWjwXDM
         LyqubG3eBhEYDgvsptAjobj1pShCNGPe/1H+PFin64voAbxppU0mk2Q0ZjCkwEd1Hb+0
         j9wA9ChhiXSwXlL13+OKdObZy3rZj0OL0NDp4RvSa5AcqltF7XBgfgrb1AsQTordkKmd
         FGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/QT/mbM6XFmw+5mqtZ/2egV/mJ9NZ3Byxw0u6u8Wpto=;
        b=EGyGfW296G63K1PKgLdGYaFXQmY+AzJPGlo+ayFAZ9qp0hpMQ+6+VcakGIQhZ4v0lv
         LyxSNFqi7sxwjAUDEvf/Av9Yz+h90Kpcglgau5S5eTm3r28GxshwzcHmia852GY3WEsq
         s9LkTEigm4++VoeW7vF2rQWcbEx4Co6l3y3h/cMNuX2z6gWYKK2BQ4Fde8PPA1c3F2cC
         lZ3OIBF4/5YAygRy117bN1dJ0/DqbJUS61Dp/DT9iYo1qUL8E0gpNcFNotn5+uavd51F
         QFzjwZVTuimiA+JYoDWqJMWYit+fy4KpP5q3tUyYxAtQMtp4D3b8MMbd2VdzDBu7PjdP
         flGQ==
X-Gm-Message-State: AIkVDXJbOCDy674TG9EY59nNBNRs8zcOYKvvKr5ZtCafcr2Xb1cSsWxE0MEUogQdvjaLxNIBaUvJ/qPXDKhoOA==
X-Received: by 10.107.44.83 with SMTP id s80mr12375999ios.212.1484223615399;
 Thu, 12 Jan 2017 04:20:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 12 Jan 2017 04:20:14 -0800 (PST)
In-Reply-To: <xmqqh958uoot.fsf@gitster.mtv.corp.google.com>
References: <20170108101333.26221-1-pclouds@gmail.com> <20170109103258.25341-1-pclouds@gmail.com>
 <xmqqh958uoot.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 12 Jan 2017 19:20:14 +0700
Message-ID: <CACsJy8AbdDxsSUDSx7=kezjPOCQnhpNdwKyMvb-xQ+d7wd99Tw@mail.gmail.com>
Subject: Re: [PATCH v4] log --graph: customize the graph lines with config log.graphColors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just FYI. The broken internet cables in Vietnam seem to hit my ISP
really hard. It's nearly impossible to make a TCP connection. So I'm
basically off the grid, hopefully not longer than two weeks.

On 1/10/17, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> +	end =3D string + strlen(string);
>> +	while (start < end) {
>> +		const char *comma =3D strchrnul(start, ',');
>> +		char color[COLOR_MAXLEN];
>> +
>> +		while (start < comma && isspace(*start))
>> +			start++;
>> +		if (start =3D=3D comma) {
>> +			start =3D comma + 1;
>> +			continue;
>> +		}
>> +
>> +		if (!color_parse_mem(start, comma - start, color))
>
> So you skip the leading blanks but let color_parse_mem() trim the
> trailing blanks?  It would work once the control reaches the loop,
> but wouldn't that miss
>
> 	git -c log.graphColors=3D' reset , blue, red' log --graph
>
> as "reset" is not
