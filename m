Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2211C2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 14:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759911AbcHEOzV (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 10:55:21 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36162 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759905AbcHEOzU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 10:55:20 -0400
Received: by mail-wm0-f51.google.com with SMTP id q128so34548163wma.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 07:55:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pPDuTEuLhPWufnxLAHuV8pJ04R2FLJ6bWnHKysNr6Yw=;
        b=kiDhOTjDGVtp8SWaWt6SQ9nY5+VYbzxadMTK2G2o00q4h8WvA+qk4c5Di3xHJLTYHH
         f0JIDXr0F4Yl2/IdL1L1FjXUlIiCrdhv+Z83IOI5i+cPfxEdd9rrmkMXI1z74k/zpusZ
         aPfRswQ16Kq9UfDYbCkKO6wRbEppNXWzwZ7NC+tqfI/U3UPQTtxFcaT832xJeB7rC6wi
         3s02JZB06m6yASs+e2if9lknTUDN9/mFR7jTk3ERFqZQL6cKHpCv1iY/5M5CbYbrxkEO
         nL7BKBc0C/hR/TLvH2z8ai1PDbeKHFxV8vbPOCdP82KH/8AeLxuCCeh/ZliDTHIZASDY
         2tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pPDuTEuLhPWufnxLAHuV8pJ04R2FLJ6bWnHKysNr6Yw=;
        b=mxSOkhdqAHVwi6rlwkFwnQBDKwiJEpOvmR8Lv3FSHEp5HEtpqduWEI7HA09q3fkC6r
         ti4ZCIhVFu4IBE85P/39Q35fJfjJoCsRwvBUY30Fsa57KVZlIdYaU9b3RdSWnfXXrEim
         fNYMqs0p3iuVsttqboSr58fVRMAysVJnhkH9E0QcJytNo99qXLOjE0d9ghq6SMucD2AT
         d9YC6QSXJwO3nZEirqGnkPetEadLmnX/UbJjTjtdhNApEGZEjl8LmHFHi3MPRtHJTHtL
         O4T92K2g0SnF/HsnzeHFxI+rATh81i5SD24Fw3Ohp03Oi+sjzteF5hOKG2y1OlReNKdU
         D2Iw==
X-Gm-Message-State: AEkoouu0bPCMGzKBy/+WHs/DscNgkB6siw6c7/23Gdw8zoKOMAfP8IAxkt7AB0vccpbDpw==
X-Received: by 10.194.101.225 with SMTP id fj1mr78917970wjb.57.1470408918777;
        Fri, 05 Aug 2016 07:55:18 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id m81sm9011261wmf.1.2016.08.05.07.55.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 07:55:18 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 01/12] pkt-line: extract set_packet_header()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqeg645x6b.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 5 Aug 2016 16:55:16 +0200
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Content-Transfer-Encoding: 7bit
Message-Id: <486BA59A-F53B-4893-AE37-8956FCDE7E22@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-2-larsxschneider@gmail.com> <xmqqd1lp8v2o.fsf@gitster.mtv.corp.google.com> <20160803211221.t2zdhvwjum2baeqs@sigill.intra.peff.net> <xmqqeg645x6b.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 04 Aug 2016, at 18:14, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jeff King <peff@peff.net> writes:
> 
>> The cost of write() may vary on other platforms, but the cost of memcpy
>> generally shouldn't. So I'm inclined to say that it is not really worth
>> micro-optimizing the interface.
>> 
>> I think the other issue is that format_packet() only lets you send
>> string data via "%s", so it cannot be used for arbitrary data that may
>> contain NULs. So we do need _some_ other interface to let you send a raw
>> data packet, and it's going to look similar to the direct_packet_write()
>> thing.
> 
> OK.  That is a much better argument than "I already stuff the length
> bytes in my buffer" (which will invite "How about stop doing that?")
> to justify a new "I have N bytes of data, send it out", whose
> signature would look more like write(2) and deserve to be called
> packet_write() but unfortunately the name is taken by what should
> have called packet_fmt() or something, but that squats on a good
> name packet_write().  Sigh.

Well, my argument wasn't meant to be offensive. It was just an idea that
I published the to get feedback. Now I understand that it wasn't a particular
good idea (thanks Peff for the performance test!).

However, besides the bogus performance argument I introduced that function
to allow packet writs to fail using the `gentle` parameter:
http://public-inbox.org/git/D116610C-F33A-43DA-A49D-0B33958822E5%40gmail.com/

Would you be OK if I introduce packet_write_gently() that returns `0` if the
write was OK and `-1` if it failed?

Thanks,
Lars
