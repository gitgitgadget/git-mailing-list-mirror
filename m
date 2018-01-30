Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FEEA1F576
	for <e@80x24.org>; Tue, 30 Jan 2018 07:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbeA3HMR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 02:12:17 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:43372 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeA3HMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 02:12:16 -0500
Received: by mail-qk0-f169.google.com with SMTP id a5so8888687qkg.10
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 23:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LofZMuI/t69dtm5Prd2Ti/BPqHLwBb9F2LTpQdNWKis=;
        b=PDxtkRsBsEw74vjUQUMupWNCXltijRa/eEbmrPNYdMoWi9LxgOfyT9Y5qHSPt+v19C
         TBQbIIWpLya1ICQdDKXLYApRMsdQ6iExAXuv8d3o8bYX7NUCisYGJxvXExE7W20EeRaG
         NEZjIYCUyEfdkDxqUvlgfw+VDWORLwNZDkOsT5l0rR3dqMDFrK96nVejqfvfY1VawzCC
         4hxv2oHZNVUTZWb03gZ4I5csSgFZAKCZbos9Zz+H+dg0WlqFiVON8LX7ESdnJ13OPvIp
         HA8ZsNA1+D22w6TdRQ+QK1yaYWx8JY7JyeS3xHoDknx4I0gXi8JoWHNPhVsHb0srfX1B
         BSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LofZMuI/t69dtm5Prd2Ti/BPqHLwBb9F2LTpQdNWKis=;
        b=Wnxfhi6rtj9a7WA1uHaINDc5rOFj8Qqd7Jnqy+dnVpiqDN43nBzs3OfHFoRGzUshQP
         2UaUDlNdFPbLCumwrSaWNnkq6LKdorR17xqhYuaXeqlWLt5o7toFNArNyBJv6Vs9dZL8
         2jmKqPysmONq/2nqHY7YAOxOBZH84RSGG0qXLXjE5txmlRYE97RjmLP3QqxmCbaZ2ZuJ
         TqPki+Q0cNjlAT6kkwVfEP+XZcKf8ERY/HpsA24iPRuMa1GgBPd2bsFVVDhbGn78gFHG
         MEffP6FTzuSTdqZpMkg1u/iakHQ2iT9PceYw+tHXxfzDNsYD3XJrrniqJsxIVrbjQStb
         qomQ==
X-Gm-Message-State: AKwxytedo9jIhy9fYC//FnQpXXfACvuwTYmn8yDKI7ggTp96g7bo+nHH
        yO0CkY51tK/4kLetuwSCvzGVqpaJnHLb7YB2Qvs=
X-Google-Smtp-Source: AH8x224u34aSmCB2p3XnydCBSBT/StKk850tELAI01IdfVJCnOQkppc3yok+vMv382w7SM1RR9gxJI3AWpKGkqD3imk=
X-Received: by 10.55.123.69 with SMTP id w66mr39930037qkc.326.1517296336163;
 Mon, 29 Jan 2018 23:12:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 29 Jan 2018 23:12:15 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801292146270.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
 <CAPig+cQbG2s-LrAo9+7C7=dXifbWFJ3SzuNa-QePHDk7egK=jg@mail.gmail.com> <nycvar.QRO.7.76.6.1801292146270.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Jan 2018 02:12:15 -0500
X-Google-Sender-Auth: nVZNhNZxdZnNTVvtge5O4yioXKE
Message-ID: <CAPig+cRjU6niXpT2FrDWZ0x1HmGf1ojVZj3uk2qXEGe-S7i_HQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the revision
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 3:50 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 19 Jan 2018, Eric Sunshine wrote:
>> On Thu, Jan 18, 2018 at 10:35 AM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> > +static int do_reset(const char *name, int len)
>> > +{
>> > +       for (i = 0; i < len; i++)
>> > +               if (isspace(name[i]))
>> > +                       len = i;
>>
>> What is the purpose of this loop? I could imagine that it's trying to
>> strip all whitespace from the end of 'name', however, to do that it
>> would iterate backward, not forward. (Or perhaps it's trying to
>> truncate at the first space, but then it would need to invert the
>> condition or use 'break'.) Am I missing something obvious?
>
> Yes, you are missing something obvious. The idea of the `reset` command is
> that it not only has a label, but also the oneline of the original commit:
>
>         reset branch-point sequencer: prepare for cleanup
>
> In this instance, `branch-point` is the label. And for convenience of the
> person editing, it also has the oneline.

No, that's not what I was missing. What I was missing was that
assigning 'i' to 'len' also causes the loop to terminate. It's
embarrassing how long I had to stare at this loop to see that, and I
suspect that's what fooled a couple other reviewers, as well, since
idiomatic loops don't normally muck with the termination condition in
quite that fashion (and is why I suggested that a 'break' might be
missing).

Had the loop been a bit more idiomatic:

    for (i = 0; i < len; i++)
        if (isspace(name[i]))
            break;
    len = i;

then the question would never have arisen. Anyhow, it's a minor point
in the greater scheme of the patch series.

> In the Git garden shears, I separated the two arguments via `#`:
>
>         reset branch-point # sequencer: prepare for cleanup
>
> I guess that is actually more readable, so I will introduce that into this
> patch series, too.

Given my termination-condition blindness, the extra "#" would not have
helped me understand the loop any better.

Having now played with the feature a tiny bit, I don't have a strong
opinion about the "#" other than to note that it seems inconsistent
with other commands which don't use "#" as a separator.
