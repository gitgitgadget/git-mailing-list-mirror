Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF79B1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 06:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJDNqv (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 09:46:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33931 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDNqv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 09:46:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so2715070pgs.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=3evlNwJ6z71Y9FHdxGP4X2BCWkrQWnAPpBTIkNKgQvg=;
        b=V5SsCtiipNx9m1QV541Tvq8G0jNmFZY7O16QITizURamKPo9S5Tj73idx7IwWW2M2t
         w61azi9LPypUf9FqdKjA3UbQOjEqMYDVz+ZoeG+vPH6IM6TT3R6I/HDvZTQuOo15ED3V
         iDUXbpbrjhYh7ncjHa9Q4nH+boZH7EfHNd24uQCbIHmC+NbYeOCMd7SQ+JLRLsDXB4yK
         nAeNhFHJszOUChmT9BA0KgTSgNxoE1gEIK1QmiWXqk2oHbnHQoZpp9ZDuJc1ZFY+o2mh
         KB4yltluSMWKaywyTxwDFFR1d7KgEw7xhwK84O7eEIBssGSsO6DZpqd3zHz8CXV2CbOZ
         +YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:autocrypt:subject:to:cc:from
         :message-id;
        bh=3evlNwJ6z71Y9FHdxGP4X2BCWkrQWnAPpBTIkNKgQvg=;
        b=SZZLyB/KBXGgsYVemedRrIggeReSUN5k+neACbdaoLuuu2p3fYftZNgZQznWRk8+Yf
         ooJ8xS5d5mbZl7iEo3GxU3p501QL0ELDInO43SvMmR22x8FDVjS7p0gkMr2Fjoz8+tO1
         M5sGXD6GKl1jrzpf3uvx6UvL9j8/YSJeQeLhtfefwgBiozn4w8KLXXXGM9N+gzyV3Roz
         ugC9vJZh1NoG3fqawJYLnKC3GLwSH4rVyh/livpwFFUk1ptno0RR7sVItk28c5vfXJhG
         xD3pcKj1Sl7Fyt4TuOwrR0wwhiiEawlhxg7jIAru2uCyZ23LtLxjpR3K0qLYd2FvAbzS
         ZZ7Q==
X-Gm-Message-State: ABuFfoje9/rTZhabbNFEjyZGkMK5W5VhJxiOkxf72gnsFr4+EnfGKp91
        vKCecee11Nnhv+X+YckrhrI=
X-Google-Smtp-Source: ACcGV63T7JkNoM1UKs9hMSD4StcdnlKGYMgbscIEhLH3mL/QQqrMxZ+V6ElwT3ADPMEx5yTlIh0uJA==
X-Received: by 2002:a63:906:: with SMTP id 6-v6mr4410477pgj.92.1538636104702;
        Wed, 03 Oct 2018 23:55:04 -0700 (PDT)
Received: from [192.168.0.19] ([182.74.112.250])
        by smtp.gmail.com with ESMTPSA id f81-v6sm6286958pfh.46.2018.10.03.23.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 23:55:03 -0700 (PDT)
Date:   Thu, 04 Oct 2018 12:24:57 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <d876e0af6a860621ae80fde71069c5e2e6a71878.camel@gmail.com>
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com> <39F9931A-B297-4525-A131-736B900F37AF@gmail.com> <CACsJy8AScp1v+R62vXWuP-45LLLYwfSBNaZJfR02=d+2CzDqhg@mail.gmail.com> <20180926160938.GA15312@duynguyen.home> <xmqqpnx0mbos.fsf@gitster-ct.c.googlers.com> <d876e0af6a860621ae80fde71069c5e2e6a71878.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=kaartic.sivaraam@gmail.com; keydata=
 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
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a worktree
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <3F40923F-B596-403C-900D-6F411A0D1CE1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3 October 2018 00:13:06 GMT+05:30, Kaartic Sivaraam <kaartic=2Esivaraam=
@gmail=2Ecom> wrote:
>Hi,
>
>Sorry for the delay=2E Got a little busy over the weekend=2E I seem to ha=
ve
>found the reason behind the issue in the mean time :-)
>

Oops, I forgot to mention there's more comments inline!

BTW, is there an issue if =2Egit/HEAD and =2Egit/index are owned by root? =
The owners seem to have changed since I created the worktree possibly due t=
o the cron job=2E Just wondering if it might cause some issues=2E


>On Wed, 2018-09-26 at 10:05 -0700, Junio C Hamano wrote:
>> Duy Nguyen <pclouds@gmail=2Ecom> writes:
>>=20
>> > On Wed, Sep 26, 2018 at 05:24:14PM +0200, Duy Nguyen wrote:
>> > > On Wed, Sep 26, 2018 at 6:46 AM Kaartic Sivaraam
>> > > <kaartic=2Esivaraam@gmail=2Ecom> wrote:
>> > > > This is the most interesting part of the issue=2E I **did not**
>run
>> > > > 'git fetch =2E=2E=2E' in between those cat commands=2E I was surp=
rised
>by
>> > > > how the contents of FETCH_HEAD are changing without me spawning
>any
>> > > > git processes that might change it=2E Am I missing something
>here? As
>> > > > far as i could remember, there wasn't any IDE running that
>might
>> > > > automatically spawn git commands especially in that work
>> > > > tree=2E Weird=2E
>> >=20
>> > Maybe something like this could help track down that rogue "git
>fetch"
>> > process (it's definitely _some_ process writing to the wrong file;
>or
>> > some file synchronization thingy is going on)=2E You can log more of
>> > course, but this is where FETCH_HEAD is updated=2E
>>=20
>
>Thanks for the patch! It really helped me identify the issue=2E
>
>The actual culprit here doesn't seem to be Git itself=2E It was the "git-
>prompt" bash plug-in[1] I was using=2E It seems to be spawning "git
>fetch" for every command I type on shell=2E That answers why the
>FETCH_HEAD was being updated even though I wasn't explicitly running
>it=2E The git bash plug-in seems to be fetching changes for *all* the
>upstream branches=2E That answers why there FETCH_HEAD was populated with
>info about all the branches when I explicitly requested for the next
>branch=2E I've also verified that `git fetch origin next` works as
>intended (FETCH_HEAD has info only about orgin/next) when I turn-off
>the plug-in which confirms that it's the culprit=2E A cursory search
>found me a related issue[2] but I'm not sure if it's the exact same
>one=2E
>
>I could identify the culprit only with the help of Duy's patch=2E Thanks
>Duy! Sorry for not realising this earlier=2E I almost forgot I'm using it
>as I've been accustomed to it a lot=2E
>
>
>> Well, a background-ish thing could be some vendor-provided copy of
>> Git that has nothing to do with what Kaartic would be compiling with
>> this patch X-<=2E
>
>Fortunately, it wasn't the case here as the plug-in was using my
>manually-built version of Git :-)
>
>Thanks for the help!
>
>Tag-line: Sometimes tools become part of our workflow so much that we
>really don't realise their presence=2E It's an indication of a good tool
>but we should be aware of suspecting them when an issue arises!
>Something which I should have done to realise the issue ealier x-<
>
>
>References:
>[1]: https://github=2Ecom/magicmonty/bash-git-prompt
>[2]: https://github=2Ecom/magicmonty/bash-git-prompt/issues/125
>
>Thanks,
>Sivaraam

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
