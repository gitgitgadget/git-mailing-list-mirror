Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE87B1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbcHJVOy (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:14:54 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35884 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932621AbcHJSHF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 14:07:05 -0400
Received: by mail-wm0-f47.google.com with SMTP id q128so109083517wma.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:07:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NyD9z74U5Tt92Q1vmC31haqP3CP9cd+ZmuVQshD0v3U=;
        b=k4uaJylOA0n6q4dHjSM2FzOSIErfRv3r9fyYegHwcjsNgTxqP50zumGV5K3XgL7T/K
         w1NRRLJoE6wjtD6b778b2MYzoXbramTrygroQNK2TNh/xXeNqyyKZa4ZPLAaNUPxO7zY
         g2vknC5+WPUwUfuBouuh5+qIE+uBIk4FR1KDwHG88tKg9kkGECiDORlBSC5tW+wkMIaW
         7QyB7ehwMFqYbshkQKdWIdGATM5uJqlRXoVA3lmgHfebXxV2XVyngDqrspatzt45Cy6k
         sNmcCY1rA0VUA0ERDgqfIHMFi/9aP/U9ws29kzRF/S1Tg1s92sY7VPHWp3OMa0qqI2WL
         ukLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NyD9z74U5Tt92Q1vmC31haqP3CP9cd+ZmuVQshD0v3U=;
        b=LFuCwEU0MCIs/PUjFr+AQXbL0Fdkc7mDftWr9jF0OWa8haxHjZFeL1Oya7zLgC18Vk
         7pTLvad4axprVs6ykMx6daYu3/nM4Xt+HcqqloldnL8p2x7Mbju2/sLbFIIszOEHDB9E
         k3tMDmoZE+JLH9U41UlaGsRuCy4+2fZ2jCWwb17jxEBmgMNFvMeaRhiMkmjmBzetnVp8
         /JCK7q4KjWytKr5LYSkgEpPL6c6xQOYgIAz+4iQvzqbSj/olzLQ/4DR0rcTJxBqut0gW
         mDf59zEvm2zuG5QC+8l2O1LHa/XJcQ6+dUbC2nTeCXNJFnPTNBhqgRr/3poR27Xl1tEC
         AIuQ==
X-Gm-Message-State: AEkoousesvvEMEm/NPDa5PseR9TDCFZ4/OOVBeZA1UiEzatDxrY0q5NYSAQ7J7EZ1yGuhQ==
X-Received: by 10.194.175.106 with SMTP id bz10mr4148272wjc.42.1470837561286;
        Wed, 10 Aug 2016 06:59:21 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id wc3sm43202073wjc.47.2016.08.10.06.59.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:59:20 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 03/15] pkt-line: add `gentle` parameter to format_packet()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160810133745.wagccvvf35o3pbwb@sigill.intra.peff.net>
Date:	Wed, 10 Aug 2016 15:59:19 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Content-Transfer-Encoding: 8BIT
Message-Id: <982CD9A4-E155-4DEE-9B47-BCEA4F0C493C@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-4-larsxschneider@gmail.com> <20160810131541.ovpvgwdxjibae5gy@sigill.intra.peff.net> <F4D9C42A-5B7F-47B4-B334-704D5F6210F5@gmail.com> <20160810133745.wagccvvf35o3pbwb@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 15:37, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Aug 10, 2016 at 03:29:26PM +0200, Lars Schneider wrote:
> 
>> 
>>> On 10 Aug 2016, at 15:15, Jeff King <peff@peff.net> wrote:
>>> 
>>> On Wed, Aug 10, 2016 at 03:03:59PM +0200, larsxschneider@gmail.com wrote:
>>> 
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>> 
>>>> format_packet() dies if the caller wants to format a packet larger than
>>>> LARGE_PACKET_MAX. Certain callers might prefer an error response instead.
>>> 
>>> I am not sure I agree here. Certainly I see the usefulness of gently
>>> handling a failure to write(). But if you are passing in too-large
>>> buffers, isn't that a bug in the program?
>>> 
>>> How would you recover, except by splitting up the content? That might
>>> not be possible depending on how you are using the pkt-lines. And even
>>> if it is, wouldn't it be simpler to split it up before sending it to
>>> format_packet()?
>> 
>> Good argument. I agree - this patch should be dropped.
> 
> Actually, after reading further, one thought did occur to me. Let's say
> you are writing to a smudge filter, and one of the header packets you
> send has the filename in it. So you might do something like:
> 
>  if (packet_write_fmt_gently(fd, "filename=%s", filename) < 0) {
> 	if (filter_required)
> 		die(...);
> 	else
> 		return -1; /* we tried our best; skip smudge */
>  }
> 
> The "recovery" there is not to try sending again, but rather to give up.
> And that is presumably a sane outcome for somebody who tries to checkout
> a filename larger than 64K.

Yes!


> It does still feel a little weird that you cannot tell the difference
> between a write() error and bad input. Because you really might want to
> do something different between the two. Like:
> 
>  #define MAX_FILENAME (PKTLINE_DATA_MAXLEN - strlen("filename"))
> 
>  if (filename > MAX_FILENAME) {
> 	warning("woah, that name is ridiculous; truncating");
> 	ret = packet_write_fmt_gently(fd, "%.*s", MAX_FILENAME, filename);
>  } else
> 	ret = packet_write_fmt_gently(fd, "%s", filename);


I can do that. However, I wouldn't truncate the filename as this
might create a weird outcome. I would just let the filter fail.

OK?

- Lars