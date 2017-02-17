Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0A4201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964844AbdBQXKy (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:10:54 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34228 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964822AbdBQXKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:10:53 -0500
Received: by mail-pf0-f196.google.com with SMTP id o64so4957723pfb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tEWjUFhPnOIJx83MN7hvpxkxG1DnRkPyPE85qssblFM=;
        b=tPCxo3sJf0mMmLxW9m95zUj0rXiFXq4OdeDqzqzLChpEvEQAm2g1g8hQ2yjn2M0/c0
         cYlsdM+b9E99nPZdFxQbLT3x1rRNDsRTcCiGOEhGxImoR66GKzwR9LuoVmV/k0PP4XqB
         eZ4+f+1XaVNDKA7Plj8zxnBV8GDLLvcQ0FIUKL1MH5ureiUtwcBDKm4mfesV75DJcocl
         zXoCpEHnsZoMBwFVBUSINF4eNLfCA6MPTx4nM6cPxx1hC30yp7UoVYa5Bn+8Iy4UKW8h
         nv2juYdA+9FbX+FgkXQA06A3xY2Bm7wfD8vMAMluc8r08+7NTLpiEqSkbl4esdXLXUaa
         pwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tEWjUFhPnOIJx83MN7hvpxkxG1DnRkPyPE85qssblFM=;
        b=s1Iyz+zVg/JVibT8l4i9DIVUOyyXFJu3Hx0B3T+RvHBIChKER6Yn66zLmTfqXQWiYM
         NmIaaqz7zmLnlW8FM7zT7MQuANs2pxsYevmzGPw8Xg6flx6qrerUNsOKy1zzdNNQmbd0
         eAnM/l6VDOoACGKoGrQvjw0NWGvWV8KBDnPN1WPnSjOWbRYIM7rj4Yxixkph+qw0rwS7
         EZXtS2wJ6h4CB5cCei+o0jbeeSmDzR4EOwyZC+kM1+uo7i1X1Ww12PqnMnmnNdO1x9oT
         VYI9p7LcG3oEV/UGDz3/7LyeBOTBFrv7BpkC+rGGcPl1RSgwat5RySVYB3q5zwRa6UUg
         Db/Q==
X-Gm-Message-State: AMke39k04WDSvTblrFyKxuZZGk4iy8qIcUNpJm1uHSsRbBJA4HTWxZPrnBq9sL2MttHGOg==
X-Received: by 10.99.189.9 with SMTP id a9mr12880957pgf.190.1487372666755;
        Fri, 17 Feb 2017 15:04:26 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id m6sm21414742pfm.22.2017.02.17.15.04.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 15:04:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
References: <20170216174924.GB2625@localhost> <vpqlgt6hug6.fsf@anie.imag.fr>
        <20170217110642.GD2625@localhost> <vpq7f4pdkjp.fsf@anie.imag.fr>
        <20170217164241.GE2625@localhost> <vpq4lzs7o0s.fsf@anie.imag.fr>
        <xmqqd1egu1dl.fsf@gitster.mtv.corp.google.com>
        <20170217182326.GA479@localhost>
        <xmqq4lzsu0wo.fsf@gitster.mtv.corp.google.com>
        <vpq7f4owtbi.fsf@anie.imag.fr>
        <xmqqd1egshv1.fsf@gitster.mtv.corp.google.com>
        <vpq1suwvab9.fsf@anie.imag.fr>
        <xmqqbmu0qwyg.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 17 Feb 2017 15:04:25 -0800
In-Reply-To: <xmqqbmu0qwyg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 17 Feb 2017 14:22:31 -0800")
Message-ID: <xmqqbmu0pgg6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> That approach may still constrain what those in the former camp can
>>> write in the "cruft" part, like they cannot write comma or semicolon
>>> as part of the "cruft", no?
>>
>> Right. Indeed, this may be a problem since the use of "#" for stable
>> seem to include commit message, and they may contain commas.
>>
>> So, maybe Johan's patch is better indeed.
>
> OK, so I'll queue that one with your Ack for now so that we won't
> forget.  I guess we still want a few tests?

It seems that there is an expectation in one of the tests that needs
to be adjusted.
