Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96321FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 15:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965225AbcKWPFD (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 10:05:03 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35932 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965157AbcKWPE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 10:04:59 -0500
Received: by mail-lf0-f53.google.com with SMTP id t196so6077533lff.3
        for <git@vger.kernel.org>; Wed, 23 Nov 2016 07:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hP6S5RFvSh2uAoQ01avG+mqXnTc3fbevxjnfy9iAcj0=;
        b=NOqZ78CRUfZT3IS6mwBaBwwZDCUOdNEaCPoyTKa7MuFfZboY6++2nJWcD7ACe/sXTI
         FKBZxdn8AfnzkxZfpGyuMTbqKYw2nJifd57ml8naLAPL8MdP1Sv89d9K1DCBw9nKYsed
         U3vCgBixjeWl72EQiP2YtSkLk8D8mfPjI5t6KqP0dK5IYIrT9gNgDtN+xvTvQrBm+hby
         N05FBjlzvH5sliTziLjxwhM9iwaR01Q7fVX7u3HHjFmX7tvbra137oCpOoG6HXW3sxLG
         2DFJDYBa/m2yuZlcjpwTPpr/Y5nMOFen38yFFsuefXsu3GC82XDZJR5djgf3SrsVgwZ1
         HCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hP6S5RFvSh2uAoQ01avG+mqXnTc3fbevxjnfy9iAcj0=;
        b=NImHWsde1wVZ0Pf6nAYp1zZdjeNHBOgX/Ku3SPRdyKbT0DO7XtJOpAIN41B7tF5ugY
         qR+ycj3b79/oESMIx+B83JBl3bsm0Q5uClDqXPzpgXsrb/VUJQ4xTNVpam4XpguKOUit
         bSUq6w4JV81LiBZvqNg5w7STsf+LDu2rbQ5aRf2zK8dECiBtvWC7TQt17WquKa/9tl22
         gyL+/eBts8xM39bIU6HuyvK+gU33E0N8pU395Py0zMu18lJq+Gnh5sJ+Mv9LfUyl2KyX
         iXpgAb26vup11eC2FY9hpHKWNiA4EkGXKUSWuxesQJhFfJcgIvU3DYqSngWXoym0XIEa
         XOag==
X-Gm-Message-State: AKaTC00Vup46KKixiEPcSBTZz7eajSqXXH7qKSGwH5bpvNgL+k0+dLRFbrWApjVDnhaGysS8nVnL6GloHLjNtw==
X-Received: by 10.25.74.85 with SMTP id x82mr1055913lfa.154.1479913498055;
 Wed, 23 Nov 2016 07:04:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.25.142 with HTTP; Wed, 23 Nov 2016 07:04:57 -0800 (PST)
In-Reply-To: <xmqqziljngod.fsf@gitster.mtv.corp.google.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-16-chriscool@tuxfamily.org> <xmqqziljngod.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 23 Nov 2016 16:04:57 +0100
Message-ID: <CAP8UFD0iToVxU+maNL9BFXacp3sER+AfrqAnQXWf7EAwURKmdQ@mail.gmail.com>
Subject: Re: [PATCH v1 15/19] config: add git_config_get_date_string() from gc.c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 8:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> This function will be used in a following commit to get the expiration
>> time of the shared index files from the config, and it is generic
>> enough to be put in "config.c".
>
> Is it generic enough that a helper that sounds as if it can get any
> date string dies if it is given a future date?  I somehow doubt it.
>
> At the minimum, it must be made clear that there is an artificial
> limitation that the current set of callers find useful in cache.h as
> a one-liner comment next to the added declaration.  Then people with
> the same need (i.e. they want to reject future timestamps) can
> decide to use it, while others would stay away from it.
>
> If you can come up with a better word to use to encode that
> artificial limitation in its name, renaming it is even better.

Ok it will appear like this in cache.h:

/* This dies if the configured or default date is in the future */
extern int git_config_get_expire_date_string(const char *key, const
char **output);

Thanks,
Christian.
