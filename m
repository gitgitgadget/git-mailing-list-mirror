Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1EAC2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 17:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778AbcHERl5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 13:41:57 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35123 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756687AbcHERly (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 13:41:54 -0400
Received: by mail-yw0-f196.google.com with SMTP id r9so21892997ywg.2
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 10:41:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XVSACf+ZEl3JEtptRHyn60DN6o0GeHiV0DMt6l2Qk6s=;
        b=0lzGiejJHCR1n0me49B1y4SzfPrp9LoCG+Un3nw6iTw2kMy6BMv7tTjMGqyb0PJkF4
         qqbnXh0awAe4emMvAnJjzg6bhDOV8ny537MdvMJhDGej8NUOn81S65C89wcmmzLUQBV/
         tVquIoJMmh6mYYEKX3cGRqeEs5fyp+F1k7BJMpWwfO616Hwbd1GJvbwb7DDN9Xecl0Z1
         AG5UHqpZSseCs7j5ewzzUcdLmXhCdrCEncQZ3DjVZ4XfTEY1Ly1Oy3r0Mz3oAEphGeEZ
         jzVh/s9Xbi+//GkSiEK9DzaMJ2DZWpX3gSkzepFDQDlMwiK/7+2Ibp7Wntmsh0NFfo9E
         6SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XVSACf+ZEl3JEtptRHyn60DN6o0GeHiV0DMt6l2Qk6s=;
        b=f68woOWLy+q2ZVQNIqA2EnbSYqXXV6jX610jn8maTKxf5RmOOsn9R95B7Slu9uDWa8
         65nfUmW1QngP45CvonaTsFPBQ/Ruv2yNDe+Xc335fPXpBVa5chhfPc0Mx+aYVW7bV5Fl
         +nOm1Kyw6NUAN919B4PhTYrSkFnexp4nzqj2RNSS6wfKLTjBX/BwW5Vtp6gGP46kUumT
         1l7yoX/x6fSOsyy4bWhXQjt4Rh+VKQ9z4g1+RnzS7gLDOgymVMlu3gUXZoF/VRLbHC5t
         PQEyixhUwVKPRbMIge0rrkfNqTKbh8bsHgxKN//blDo4Qy5SLl8ItPgJDez9TFZaSecJ
         WIbg==
X-Gm-Message-State: AEkoouskI+yddeW5nvOF/Bysz6XGWY9eFpAEXx4mRlx/aTaQM/EXN9bIXeKKU5wY8hi0OGRgXk+wcLxW99kfhg==
X-Received: by 10.129.105.136 with SMTP id e130mr58584089ywc.176.1470418913488;
 Fri, 05 Aug 2016 10:41:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Fri, 5 Aug 2016 10:41:32 -0700 (PDT)
In-Reply-To: <02E1DAD2-8CE7-4A5C-AD28-9E08F2414BDF@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-2-larsxschneider@gmail.com>
 <xmqqd1lp8v2o.fsf@gitster.mtv.corp.google.com> <20160803211221.t2zdhvwjum2baeqs@sigill.intra.peff.net>
 <xmqqeg645x6b.fsf@gitster.mtv.corp.google.com> <02E1DAD2-8CE7-4A5C-AD28-9E08F2414BDF@gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 5 Aug 2016 10:41:32 -0700
X-Google-Sender-Auth: EaINm_57Pja_XqdF1UfgTiM6Fjc
Message-ID: <CAPc5daV3Tke4qHjtpri=6QCRaOax_K3uYhpFzRcd271=GHj1+Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] pkt-line: extract set_packet_header()
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 10:31 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 04 Aug 2016, at 18:14, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> signature would look more like write(2) and deserve to be called
>> packet_write() but unfortunately the name is taken by what should
>> have called packet_fmt() or something, but that squats on a good
>> name packet_write().  Sigh.
>
> "Sigh" means, a series preparation patch that renames "packet_write()"
> to "paket_write_fmt()" would not be a good idea? It is used 59 times
> currently...

It would be a good idea in the longer term, I would think. I just wasn't
sure if you are willing to volunteer, and in-flight topics will tolerate, such
a change right now. I have a feeling that all the current callsites are
fairly stable and no in-flight topic touches them, so if you feel like doing
so, please go ahead ;-)
