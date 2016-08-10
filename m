Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B2B1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934200AbcHJTPz (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:15:55 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34166 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932916AbcHJTPx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 15:15:53 -0400
Received: by mail-qk0-f193.google.com with SMTP id x67so4151559qke.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:15:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XXDN0pgqp4y75pd6xUenlz2XTU3sT7+X1gziS/n2X+0=;
        b=DwgIRnSQtAmT887QVZ44jF+OutpZ9FhqNFcr9AxbUILratLqko4kDU+FlRevPlHX88
         CBuxJuLYZVH1kaI5MllrxwNYwPwJ+2dtoAm87dDJ3W4mgqlbT2PL+92UMYpE96zugAJ9
         eigExQSvPUuv3mCM0RKbQfXB11YjDpaFkM+3FJCxyHtsTKZDAP3kvk1o/i/OvJYgHIgq
         mbJiGwkyeg0bcoMGFqVbwXEQRDs5Gikf/0yZ5Mywj4Y1Xz4T5F+M1oiJscIKp2QmyVTn
         MOo/92DIWqYphUFLXfCV+0ckAFeqEwq89SNuw58OtdKin/HKVq1yTMNBfld4QwsthC/9
         tuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XXDN0pgqp4y75pd6xUenlz2XTU3sT7+X1gziS/n2X+0=;
        b=UUOCjOo9BHM6l2SGozsgEoBXaGI7pd2VSgUe+UE+rluGB/5pm9nNpj5WFN4F55tnQd
         hBWum8WhOVfxOBdR+h8xHn3MT4zzZdfmP6WTXj9vGrmw6WFHqiJ43gyhi3+XRnpjQKUE
         F+GM4RNYUbA63gSwO6Hlf54zOwuUsAxnKaeMYeqWSTkPx+NtgSfYVdjqTsDBq5MTFa3u
         K5CX18Vld1uTZxyjFda5TTI7oKFsnY+PQor/ib5bY961WlMBwQ01iIrIDD3OGDPp5rM1
         2MNwAZu1mC11eQcIOct+7HnCmlVyUoFaHFA0Xp0yl2LdAgM4D7sVnvnXwXxBgu4JvF0P
         u4xw==
X-Gm-Message-State: AEkooutD5Ma6CU+tYNXhqAaYlAgQhnms3Yf5YNE4j0B4S+F3U7D1WjLh4aqIfuxzcT4kOQ==
X-Received: by 10.55.118.135 with SMTP id r129mr6543616qkc.124.1470856552366;
        Wed, 10 Aug 2016 12:15:52 -0700 (PDT)
Received: from nov34rcf12.ads.autodesk.com ([132.188.72.181])
        by smtp.gmail.com with ESMTPSA id p70sm11782475qke.1.2016.08.10.12.15.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 12:15:51 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 04/15] pkt-line: add packet_write_gently()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq8tw45vtg.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 10 Aug 2016 21:15:50 +0200
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Content-Transfer-Encoding: 8BIT
Message-Id: <350E338E-BBBA-4FE4-8209-4C05056E2AAD@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-5-larsxschneider@gmail.com> <20160810132814.gqnipsdwyzjmuqjy@sigill.intra.peff.net> <434CB5D7-3FC0-4398-9028-135701121E55@gmail.com> <20160810134003.q6mzgkcrwmkxv5fw@sigill.intra.peff.net> <xmqqtwes5ysb.fsf@gitster.mtv.corp.google.com> <13CB2673-7C7D-4982-9725-27D4091AAD84@gmail.com> <xmqq8tw45vtg.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 20:21, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> On 10 Aug 2016, at 19:17, Junio C Hamano <gitster@pobox.com> wrote:
>>> 
>> OK. Does this mean I can leave the "packet_write()" to "packet_write_fmt()"
>> rename as is in this series?
> 
> I didn't really check what order you are doing things to answer
> that.
> 
> If the function that is introduced in this step is a version of
> packet_write_fmt() that does its thing only gently, you would want
> to do the rename s/packet_write/packet_write_fmt/ before this step,
> and then add the new function as packet_write_fmt_gently(), I would
> think.

OK - will fix. I did it that way because I thought it would be easier
if we decide to drop the big rename patch.

Thanks,
Lars

