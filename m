Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE042018E
	for <e@80x24.org>; Fri,  5 Aug 2016 17:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758688AbcHERbw (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 13:31:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35551 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758664AbcHERbv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 13:31:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so4671851wmg.2
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 10:31:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0e3qeRSg1iqXej2ZdzTO0Ux+6NPUZq9a3i9BeO+z57I=;
        b=GLNTwQYPpKCOp5G0lceE/N1DNFKzaDu/g5Gi66HRdrVmYgreC+uiuy9b8Yyssy6SqV
         aAw1VP03LMGr1a5nV7xNESWcoihr6v/YpqL3xkRguQxyoO10PjjD1QaTr64B5Yr0625p
         07zChKbrWS8PCGIYp/9iA3eH52ZdNimeIDlKGEdgEtvN56n17zUoxStpFwgwLvmyXC6/
         +X+1+ryE8Xmf55pHa7sar4Rg6WxRPyKUCl55tCEU2vhKiX57Rx34BBGRkn+lSiJs1vCb
         StxPw5thgms7MR30ceXdyf4Qm0Bc6XXy5OP5pAAMizkm9jAUwXiQIx9BoE1pe88ystHE
         vyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0e3qeRSg1iqXej2ZdzTO0Ux+6NPUZq9a3i9BeO+z57I=;
        b=A/MW8mye4bgRWkxp7EXCJjTDIuMBXCgmHPyAv8/4LGzhjqiClPHf/t27wUMWBACQqF
         x3p3ur7tDifSQKno3lxSg+W4ge/zulUhuam6MNfoA90+8PCKWVaRRADF6cimyArgB7Es
         j3IsslTs3axAfRubueRp/nQ84EUjK++qd07SB70v+vKNw7I0y8LpFtQqKrstlzGh1uKk
         +BYDywZLDVI8ua4DHIk+vtI5Qx5ZHNbLbAHOolU7hjMLoUww/H8hL1pgqPZ9jKh9onzp
         +/BWKuJGewUSdLJoMnTKEsifpX7THAQpyhe3u2XEzTn2cwaHWpcU7u3A9uas+ICtDBKh
         94cQ==
X-Gm-Message-State: AEkoousOQo/vOE4nFye5fMEBK+4PDIX3eV+YUcOeZ0B523u2KroDigsFY0rLyOyt1y3ung==
X-Received: by 10.28.140.10 with SMTP id o10mr4780103wmd.36.1470418309931;
        Fri, 05 Aug 2016 10:31:49 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id h7sm18800408wjd.17.2016.08.05.10.31.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 10:31:49 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 01/12] pkt-line: extract set_packet_header()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqeg645x6b.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 5 Aug 2016 19:31:48 +0200
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Content-Transfer-Encoding: 7bit
Message-Id: <02E1DAD2-8CE7-4A5C-AD28-9E08F2414BDF@gmail.com>
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

"Sigh" means, a series preparation patch that renames "packet_write()" 
to "paket_write_fmt()" would not be a good idea? It is used 59 times 
currently...

- Lars

