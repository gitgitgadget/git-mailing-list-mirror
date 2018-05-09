Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7221F424
	for <e@80x24.org>; Wed,  9 May 2018 17:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935413AbeEIRsf (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:48:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46055 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbeEIRsd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:48:33 -0400
Received: by mail-pf0-f195.google.com with SMTP id c10so25980959pfi.12
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=if52SRi1P+w7wz5k0ehJXHCP2qxjpKkPOo6oJSniME8=;
        b=qr64JWALW0+xCmGkRHrN8F57yd881NIAq0bjCRbxC1QLGaEwE+tWBtD52h90vQXqj+
         X3jv6usOjSyiudwlwWcTY5ox2eDAPOCfPCcidnYAFh/80H9VZbg0O/coIIkz5ZDvSdwF
         Ae7z9vOpwM9kN5T5n0sjCZL+MMznSJX1xmIHLaYkL0OePV1EMJ+WgnZvhUCzf73aNrVm
         HpOvYWoJz/233KG0HNARTw+TLshH9RsVFdVF6JqimPy4DFEETfnKhL9CGpClLUuYaxiV
         bbTLpq1Uv5pek7QF2wNN+N1rqvZaGD4ys8cxolq0C7dlx4JG7+SRprszp1pQ5CuLvJvV
         UOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=if52SRi1P+w7wz5k0ehJXHCP2qxjpKkPOo6oJSniME8=;
        b=ZKhmFd6ZX74gPquVU/W73YmjbIKlFXigE+9Mm9I3M9LhSH14ME1uPpPETnXu4x2ohh
         PH0AoDPmvLrdD+WRjtjP5zo8u7i0j0MLY1OlBOtcVREvKtehhMAJz0rt/AxG5L96W8Uj
         SjV28BFH1blfLo7QsSc68ylRJQsGRL9/gg5tcD8IY0+/mXYUgcw1wndE2JmCHb3WrUxl
         OQOiaiu/RQrVrno5n8nAJcEQqaBTcjzKcbEya/vP9UgBQ5GsTROQqhrgLK4abkBxtozK
         9B/Q9rIAlFvhMIgcki2FGEZM8FXwglR/phnQTMe14ZnOQP5vTR+bJFje81KT43kPLWN9
         TrAQ==
X-Gm-Message-State: ALQs6tBRCBWEyh2vlCOqN5QWsFByD62daR+ELbz6XJIgE/s9cX8moFFi
        x5CigH2QZe+mpQQ0vKuCWO8=
X-Google-Smtp-Source: AB8JxZoSsS3Oej3M1sYyL0GQuhoskC/xL8AODzXYEwWi4aC7dFMLlpKE4W+H+HbIvQ4SByNhYniIMw==
X-Received: by 2002:a63:7341:: with SMTP id d1-v6mr35934340pgn.404.1525888112551;
        Wed, 09 May 2018 10:48:32 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q62sm51832410pfd.172.2018.05.09.10.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 10:48:31 -0700 (PDT)
Date:   Wed, 9 May 2018 10:48:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Implementing reftable in Git
Message-ID: <20180509174830.GJ10348@aiede.svl.corp.google.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
 <CAGZ79kZx=wHKc=2WLz-8pQWv1VhRq+pKVV9=Shq3gEMdkX-Q=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZx=wHKc=2WLz-8pQWv1VhRq+pKVV9=Shq3gEMdkX-Q=A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> * We *might* be able to use reftables in negotiation later
>   ("client: Last I fetched, you said your latest transaction
>   number was '5' with the hash over all refs to be <sha1>;
>   server: ok, here are the refs and the pack, you're welcome").

Do you mean that reftable's reflog layout makes this easier?

It's not clear to me why this wouldn't work with the current
reflogs.

[...]
> On Wed, May 9, 2018 at 7:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:

>> During the last Git Merge conference last March Stefan talked about
>> reftable. In Alex Vandiver's notes [1] it is asked that people
>> announce it on the list when they start working on it,
>
> Mostly because many parties want to see it implemnented
> and were not sure when they could start implementing it.

And to coordinate / help each other!

[...]
> I volunteer for reviewing.

\o/

[...]
> With that said, please implement it in a way that it can not just be used as
> a refs backend, but can easily be re-used to write ref advertisements
> onto the wire?

Can you spell this out a little more for me?  At first glance it's not
obvious to me how knowing about this potential use would affect the
initial code.

Thanks,
Jonathan
