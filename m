Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CC11F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 12:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbcG3MFT (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 08:05:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34032 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbcG3MFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 08:05:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so19239270wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 05:05:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OzDPKCSQs/U+vxRNr1fDwJDm3gAlTJSQrlObsXj+694=;
        b=aiK6wxo+C7+SnXg/8FF6daJRKxGMNiWZj1ApqkWzDYloNvEr/TVSBX5yZyum2CK3Ed
         MWQLQ/oMUdqhBGlvhuHx6CpP8mq6qSPEhNymq8/lHFfKl5TN9dVbzOQ0Q+LNY6CcBjQU
         NQ4Oc98C0Ejrd9Hm0oubtYpWUnGpjN+HN6WIzlFhJKenZrgwk5oW6l5xWNBqYeSFPKMf
         iYBsG6zigbMS8fZyV69YwkG1cEOR+kNa48aC3pJVNxMdjxybg1pulL7b42umSOHWmwZJ
         1m6qR56NK3l60mlPcW+UH2kB4NusMQVjasOVcoqG4QocZ2WWWkIL7DZ+KK97Bub+S83p
         //fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=OzDPKCSQs/U+vxRNr1fDwJDm3gAlTJSQrlObsXj+694=;
        b=eHObhuqsUGHyB3Netx5bnxfuexULFeR0Qx73XTqoZEHIoJ1bfkpfwf2x4FHIVB2cJJ
         boQ2Wgc+0F+cP3wLDbp2q394q07wUmhJo3NV2PFToWSSq2oCoKDS5/XdXwxqVBilSSDn
         VAhKQkPu+5gVAoNN/QzwKZBC+cFPGNGeh0NsZxiVuS6NSqw5uY0UyIU8Ek5DCEh/6aFc
         0psPp42JBilzMwDL5A57dpXDVBVAXkhW0lVMsdHH6BeiXQEmfdDwsbB3xqKSKuLhMoha
         RDvnKZ3lSvZ0iKqVCZZHtvmB+Ocqrq7Yh3xGG3J8d2V1uyF1TZ8CBuV20wC7baL+7lHI
         uRCA==
X-Gm-Message-State: AEkooutzKLvs/SVkkM3nd/xtOx9oFktY1N+ZfOVEmnZoNJBX2J0ZekRi6PKmDFInLbqaVw==
X-Received: by 10.28.232.149 with SMTP id f21mr45871062wmi.51.1469880313988;
        Sat, 30 Jul 2016 05:05:13 -0700 (PDT)
Received: from [192.168.1.26] (ddi132.neoplus.adsl.tpnet.pl. [83.23.86.132])
        by smtp.googlemail.com with ESMTPSA id i3sm20959870wjd.31.2016.07.30.05.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jul 2016 05:05:12 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] pkt-line: add packet_flush_gentle()
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-4-larsxschneider@gmail.com>
Cc:	gitster@pobox.com, tboegi@web.de, mlbright@gmail.com, e@80x24.org,
	peff@peff.net
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <41184531-d3c2-43c0-d3b8-23cc913dbf86@gmail.com>
Date:	Sat, 30 Jul 2016 14:04:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160729233801.82844-4-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> packet_flush() would die in case of a write error even though for some callers
> an error would be acceptable. Add packet_flush_gentle() which writes a pkt-line
> flush packet and returns `0` for success and `1` for failure.

I think it should be packet_flush_gently(), as in "to flush gently",
but this is only my opinion; I have not checked the naming rules and
practices for the rest of Git codebase.

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

