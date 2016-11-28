Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F7C1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 16:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbcK1QTV (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 11:19:21 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33336 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbcK1QTT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 11:19:19 -0500
Received: by mail-lf0-f66.google.com with SMTP id 98so9941584lfs.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 08:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZlNuwQt1E5dVd+Rug1Es6QCMwYZHk0GFsBnfWDdffyQ=;
        b=iNbngpqpX9unR0iarLJec9fQsO/zxCOndBmZv6gGFlLu8KDNVTkGIBzO2QLtIzZkRm
         IOTxzW+DMKGZhbcId1PJgLkrTl8YZxZ+svqw7iAJWCFMpQXqKhMnqS1BtJjj8BPnkLbG
         xYy8Mm/dkltjQiXD8SZ/QLbQFKoUCab8qj87AFxQQE+1/KbKcNP/t7BtzwdQAE1e8Y6Y
         w2n7vLJkyEsQ8ptBY61dqCq15ppSS8MeZ0fI5bppSzyFqvQOt+MH96wCZ1fv7nyuirGK
         mvZK824n6rXXZg3n7FmARWybGe7TR5SfJPIV1y9qapud0XwLYBt34GwNFd9J0IC++YEJ
         CTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZlNuwQt1E5dVd+Rug1Es6QCMwYZHk0GFsBnfWDdffyQ=;
        b=VpQoTPtfbLJMX8XZ7M/Wn8/0kJ0ORO76l27fjQb6xAQHAsDJZhlxyDRFs1OHSJ7yN8
         0MbbDlMoGbz9+Vuc+ebg56Tfy+YmrjUDg4xL5gUFnefl0hXJpyQVlQfjurccHJLsJpd0
         uNKdRN2lmQHnFe7my+6PKUfF4o3CIdNsAQ9z97ZYak2MCssG9iRekTnNpZv3JC6f9eKs
         GAxGLQW3NgLthLGF3BoeLM8L0AjStOAqnFOdvfNAfHItBzrI3t5rA52M3q957CsTR4A2
         2s77d2zLHFzRdcX0HKUwwm7wVuitl8HSvrflUcX+aRsK676x87ka7rXnXsNxopzdRPhj
         Z3Lg==
X-Gm-Message-State: AKaTC024snRAzbqXG2dkr8O4eO7ToIP6Ur/A0wZknF2rsCrKf2rQb4FMeD391GamFSNqto82OlVj1yN8x4IFbQ==
X-Received: by 10.25.18.167 with SMTP id 39mr8352420lfs.81.1480349957907; Mon,
 28 Nov 2016 08:19:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.25.142 with HTTP; Mon, 28 Nov 2016 08:19:17 -0800 (PST)
In-Reply-To: <xmqqlgwam76c.fsf@gitster.mtv.corp.google.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-16-chriscool@tuxfamily.org> <xmqqziljngod.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD0iToVxU+maNL9BFXacp3sER+AfrqAnQXWf7EAwURKmdQ@mail.gmail.com> <xmqqlgwam76c.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 28 Nov 2016 17:19:17 +0100
Message-ID: <CAP8UFD0Q4yTfnhLW6XbfqbxBvMc_QmZTEn4XJb-9fj6Uvq6hkw@mail.gmail.com>
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

On Wed, Nov 23, 2016 at 6:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Ok it will appear like this in cache.h:
>>
>> /* This dies if the configured or default date is in the future */
>> extern int git_config_get_expire_date_string(const char *key, const
>> char **output);
>
> Those who imitate existing callsites never read comments, and you
> need to spend effort to get the name right to protect the codebase
> from them.
>
> "get-expiry" may be shorter.  Neither still does not say it will
> die, though.

What about something like this then:

/* This dies if the configured or default date is in the future */
extern int git_config_get_expiry_or_die(const char *key, const char **output);

Also git_config_get_int(), git_config_get_bool() and probably other
such functions are indirectly calling git_config_int() which die()s is
the value is not a number, so it feels a bit strange to have only one
function with a name that ends with "_or_die" when many other
functions could die(). In fact it could give a false sense of security
to those who just read cache.h.
