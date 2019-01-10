Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3191F803
	for <e@80x24.org>; Thu, 10 Jan 2019 19:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfAJTFV (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 14:05:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52208 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfAJTFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 14:05:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so123119wmj.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 11:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AYisRLdvx9B3YUfQyYE+IXrzJeR3OMC7ZD336t5tAak=;
        b=s1arf/Z7BidSQjzRSJMLdSrvjE11i/5WjPiZs7Exjcxx0tlP5/beLSjNXMLjmL0Rsd
         SRD3NFMearziWOH+z0ZL3H9dReO5Gj3gU0AKAMWlYqsWqE9DIiAlY8sd01/bW53CqhLo
         350p3o7hOu3fMuyKuYuTVQw0yzP6RPTPD1hbP50PYPOWLMqBEMSPNrTVYdw1ZABaFeku
         wQH+8kA/Hb0Syi3VsVvpCKMOSZDuTOBgACp9CqtiCHCJleQFBIXDbIcZlsOEN/I7wFns
         PL69oNMAtZCF4moG9z0CxJtBot1jEeQetVWq7gUkIbr0d2KiSiyXG1MRHnAQ5M5Wv74r
         /ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AYisRLdvx9B3YUfQyYE+IXrzJeR3OMC7ZD336t5tAak=;
        b=ae1Bwel8HXj9tXu65LKVz0sWN1ojVpIbtjiKTi1Yd8+l7ocUFIXLnfQmJfrDXKp98i
         VunKeH/f5d8syw8QJWrqpenDMkv5T1+fEB0WywS8Bi+khn9AVxWN+xcWw2hfG+jRiHlH
         fRTTs8XwHk/o9HYv0NYV9AKt9NIQwCaq4iTZ0qPMBhFKC5K1V7bia+GM4JzHIDfUmVSO
         XnjV7dkLAo0SvE1c/bjUKurzQv52nVgl3dthNgyxAUPlaCQL8qeDhl2T/kAbjUPGY0Dn
         0NlFL/GCHQ+0400spFqQ6qgkS0n+yLWIcCUDIF+9ewJ3oHdgB2A/uNpG4ll7ZJzNshGB
         RnyA==
X-Gm-Message-State: AJcUukdg/9O9zBc5S1fGZK1w8M60sL9h6IRFjsAUMrKviTPhxx/vl/rr
        R38XFWBSgKVKVPPLawwZt+s=
X-Google-Smtp-Source: ALg8bN7ATP3TGjGFUC8XtwD8jTW9LIqtUNaWQp1IJ//TKw2r3A+EqM0CJwZMeaT+uyOt5Wyp5HA5zw==
X-Received: by 2002:a1c:dd04:: with SMTP id u4mr54038wmg.84.1547147119295;
        Thu, 10 Jan 2019 11:05:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q14sm51877751wrw.39.2019.01.10.11.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 11:05:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
        <20190109102836.GA6743@sigill.intra.peff.net>
Date:   Thu, 10 Jan 2019 11:05:18 -0800
In-Reply-To: <20190109102836.GA6743@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 9 Jan 2019 05:28:37 -0500")
Message-ID: <xmqqwonc1ggh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jan 07, 2019 at 03:34:10PM -0800, Junio C Hamano wrote:
>
>> * jk/proto-v2-hidden-refs-fix (2018-12-14) 3 commits
>>  - upload-pack: support hidden refs with protocol v2
>>  - parse_hide_refs_config: handle NULL section
>>  - serve: pass "config context" through to individual commands
>> 
>>  The v2 upload-pack protocol implementation failed to honor
>>  hidden-ref configuration, which has been corrected.
>> 
>>  Will merge to 'next'.
>
> Sorry I didn't catch this before it hit 'next', but I think we were
> planning to scrap this in favor of:
>
>   https://public-inbox.org/git/20181218124750.GC30471@sigill.intra.peff.net/

Ouch, I 
