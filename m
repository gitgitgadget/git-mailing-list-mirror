Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE831F859
	for <e@80x24.org>; Thu, 25 Aug 2016 18:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757013AbcHYSrk (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 14:47:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36544 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756902AbcHYSri (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 14:47:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so8487731wmf.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=UwVAbL7XrFCVjYwyOyIJTM+XGDmDKluANA+IXzp37Uk=;
        b=cjmwRzCPwKUQKNpTp2aT/NUHilooQCd4tBz01v8Qs9F+0rLnHaDWlM3zQ3kQF2cHxO
         hfteA5l8bex/3TCrqRHGkxzTLoF1lwIuRZTklVzGI5o6jbcK7KAaly49G7JkjNxTori6
         LZKo37ud+U5A+dEXm554E9xGKu7qIRK3NePAcis3NO91s6K0qlGe2Njj0VVztKaM5P+0
         5wM+Dqrvnt4knHITzxDF+8t4P3g07NvT+NU46ZhyhYhsHaA4+1FIvZ2odsKiCqDnQfEX
         xGn8MBAbVPpIyvEi5kna0Ir5k1AYlJIjlfj2nbF1grrUmL8fSWBdmQQAJclNxun6Tzpv
         Z18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=UwVAbL7XrFCVjYwyOyIJTM+XGDmDKluANA+IXzp37Uk=;
        b=PZTqX+6YkU0r8LP69PgkUxAIgz2iT0Bg1vDj7rl+HMJ5eEPat+qupnw8wsmh88NCdZ
         yGuFSPpnhbAQatArBVx8DdsvTa7zPljJ4oTZCG+3nEoY0xx5MUNsUa2pzWStM6FsxIJE
         4Rqr34FYv7CAhDgPhe61WYu5GrGy0y5J04UTw2saREi48xyfVe3ZWoafQjTnhymvF4RX
         PGhlIuM7w2Kr+lQejUOHij1n44OzEXHrDzOwJ3qh95ikVCXl81TxlK13gtGDVUqUHCws
         wwksmT2csFAK9iJyRPl74dLvpINKBiemK81uWdXxPCrCLancWJ4lOAmT+KS42Qa3KG1p
         tDhQ==
X-Gm-Message-State: AEkoouvbQXvTwKjuLXiQQ4g81SSZ/sHxeRWl37O9C5ImiYu3kh1z5mft/RIrYLoGm+X9lA==
X-Received: by 10.194.37.101 with SMTP id x5mr9847820wjj.95.1472150856473;
        Thu, 25 Aug 2016 11:47:36 -0700 (PDT)
Received: from [10.142.143.80] (tmo-114-175.customers.d1-online.com. [80.187.114.175])
        by smtp.gmail.com with ESMTPSA id n7sm16415232wjf.11.2016.08.25.11.47.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 11:47:35 -0700 (PDT)
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-4-larsxschneider@gmail.com> <CAGZ79kbEoYVM_+MWkajT2pHN1OKZXATe5d+Dv_uSJ7dyPGxUeg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CAGZ79kbEoYVM_+MWkajT2pHN1OKZXATe5d+Dv_uSJ7dyPGxUeg@mail.gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEB25464-5EBC-4CAE-A104-2896290A1E06@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
X-Mailer: iPhone Mail (13G35)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 03/13] pkt-line: add packet_write_fmt_gently()
Date:   Thu, 25 Aug 2016 20:47:30 +0200
To:     Stefan Beller <sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 Aug 2016, at 20:12, Stefan Beller <sbeller@google.com> wrote:

>> +int packet_write_fmt_gently(int fd, const char *fmt, ...)
>> +{
>> +       static struct strbuf buf =3D STRBUF_INIT;
>> +       va_list args;
>> +
>> +       strbuf_reset(&buf);
>> +       va_start(args, fmt);
>> +       format_packet(&buf, fmt, args);
>=20
> format_packet also takes care of tracing the contents,
> which was a bit unexpected to me.

To me, too :)
http://public-inbox.org/git/20160810143321.q7mjirgr5ynml5ff@sigill.intra.pef=
f.net/

The series is already pretty large and therefore I decided to leave this as-=
is.

> Do we also want to trace failure?

You mean in all new *_gently() functions? Good idea!

Thanks,
Lars=
