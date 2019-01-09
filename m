Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1C51F803
	for <e@80x24.org>; Wed,  9 Jan 2019 21:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfAIVht (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 16:37:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39092 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfAIVhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 16:37:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so8533025edt.6
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9VvOONY79P+cjTkPKCeV5KAS3q0ojFe6iI8OEby1R0=;
        b=j1pusNqqiAN3QhQj5VB9u42+Mdh7kuFbVaccPlLHa60cXV+xra8MUw8qwThsWXMwq9
         K7jn4KLYlVUpukC8sEjeCW9vNuCWrtbR5CP3WUl92R++0gzot07l/q7V4IPY77I8P8cC
         AF18SLGckYS4FO5E4cea3TswlGNQQPLyRSBccSV8gy1+3PQMWppH0p0F2GxQ/tibWTxD
         WxgRlOk4HTcRupODKNtBWR8G1RCt2ZYbiXDImqlHdS+NnyHXgRHPZS906fKK6cEj1Q1e
         TocH/2WOoc/kV2Cd40jlG2Z6nTIIZI2waOczGTOVEp+c72KbZxCuF00Q8g1+UCVlpHfJ
         WZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9VvOONY79P+cjTkPKCeV5KAS3q0ojFe6iI8OEby1R0=;
        b=D0IEN9mAlCT2M6sBaPohPD0UCrU+xuTpXZYkIbjFQ8LWfcPca2kybC8WknJnshTryj
         XsSWnuQw5+nCshNEAfYkvF8yvTfmbAQqiXAvyJz+TnXbGxc7xdtC3V9EtZmZL+ttz8hf
         ExY8EtzhOGiwH0b4aqZWSpxdxHXcpL7Q6jJKz7bsg6zdJ/J+VQSD3cfa+KC9jKH7ZKV2
         H08/lmlx/vIFhL0aPElskOq1p2/IsRK5aJjb6bqt2ex0OkZP15nAWMx8oWmWM6rUI4ns
         JNBiuJL+U80yOmG/Jf/s20PaHfdyPGDnGAPZOXMy+wyFZQ68Wh0gn0SQFg9g8W6+s9QK
         L2BQ==
X-Gm-Message-State: AJcUukeQiYNfvils6TIJUtHLOOMWPO9SOJO8hecRBvbYK1aWXqsqx6vV
        2mmvDVzwVc54zp5Liic760lSu9r2e+g5mJLTzMJ8Ig==
X-Google-Smtp-Source: ALg8bN7AVMCyW6p5HEk+IhhBlJg+CBkssQes+lb733iLHA3CV23Q4MwvZ/UhpUNQkeVueQYw3MN6FCzGUroKFnTOxqU=
X-Received: by 2002:a17:906:d0c6:: with SMTP id bq6-v6mr6196657ejb.99.1547069865482;
 Wed, 09 Jan 2019 13:37:45 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com> <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <20190107083150.GC21362@sigill.intra.peff.net> <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de>
 <xmqqy37v59qz.fsf@gitster-ct.c.googlers.com> <20190108180522.GA4610@sigill.intra.peff.net>
 <xmqqmuob58gu.fsf@gitster-ct.c.googlers.com> <xmqq8szv56e4.fsf@gitster-ct.c.googlers.com>
 <20190108211632.GB22946@sigill.intra.peff.net>
In-Reply-To: <20190108211632.GB22946@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 13:37:34 -0800
Message-ID: <CAGZ79kZzg4_=Go+6btvyygzXOdEJ7VHwNmP+BDqedv+8hqdhCw@mail.gmail.com>
Subject: Re: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Yikes, the conflicts with sb/more-repo-in-api is quite irritating.
> > I think I'll postpone the later parts of this series and ask this to
> > be sent after sb/more-repo-in-api matures a bit mroe.
>
> There were several conflicts, but it was mostly just tedious textual
> fixups. I pushed the result to:
>
>   https://github.com/peff/git.git resolve-oid-more-repo
>
> But I'm happy to wait and rebase if sb/more-repo-in-api is close to
> graduating.

The merge looks good to me, though I just looked quickly.
The series itself is also a pleasant read.

Stefan
