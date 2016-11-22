Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5E21FF30
	for <e@80x24.org>; Tue, 22 Nov 2016 01:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbcKVBZY (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 20:25:24 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33446 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbcKVBZY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 20:25:24 -0500
Received: by mail-qk0-f182.google.com with SMTP id x190so4241878qkb.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 17:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SnOpqQ8gZk8nhCoN9XI80ZWSy1s6vIKkoA+VyKpUhiE=;
        b=TvTAud+hhVar1c4vyxTPc0ae+k1QbQNrZA4F31o80eFY5KllagE+HzdhCZAECczpmg
         ZarnnmdhgAfp20eEqsDt8A61DAjFjvgqx2LLBAKQn2F5sThWV5qihMichewuMBC5aJaK
         QvdDn4FA6qpkbnC5Jgq8hMl3k5Q2X44kvvWxcQc4WXHvTj7e7sHEate0HCEw2OXNlRH1
         Yp8urD80NowkeDMbUg0T6iMyCIJS+UNFv9o0wJDQUHfWZ6opIOiCo++K52bMTtW4iDDm
         8zLWtTvx1ZkukCe+4Kcvx+G2TcrFh5ppJFwMI4TMCUi4/JEP5EoU1A9ZWu5vS2hvV/QE
         2Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SnOpqQ8gZk8nhCoN9XI80ZWSy1s6vIKkoA+VyKpUhiE=;
        b=NV0wtmKK8gE0E2pFgz2Wg2JJKf65fR0AgbwQKCmzRFheHR52W4qUi+XbZIE5ZMjnr+
         al5L1o9piXlTrzCHpSvzW01O2H0KiCnYd/HxP78OKBS3wCstYPcjkuMYGSma7kVJoZ70
         MS3Dw4SAI9ySzN339y1JcRRIOjFWMp1yc/mvkc34jwRn0+MWfuNTuywSNa/mQJNV4epy
         o2Pdu2FtQ4xClDJTMe3J2es88AhHmHY6bOGy4t6PYxEsnb17gnVp5WjHMY5m47VedPxZ
         Npu+Z6U7dulxxxzsywJyisiPvysxMyjWDybImYlZiJKe/Ds8x60UB5+jZhlbUPtDceU7
         T4/Q==
X-Gm-Message-State: AKaTC025dgOjmOfHXUTtrelt31942dffNLJgN8mD214k2ACYzpL6zrvkqh5039DbZuG8ZD7VhIoyO9SMBhpfMOJh
X-Received: by 10.55.186.3 with SMTP id k3mr21412965qkf.47.1479777922872; Mon,
 21 Nov 2016 17:25:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 21 Nov 2016 17:25:22 -0800 (PST)
In-Reply-To: <20161122001658.GE149321@google.com>
References: <20161121232709.8906-1-sbeller@google.com> <20161121232709.8906-3-sbeller@google.com>
 <20161122001148.GD149321@google.com> <CAGZ79kY+0WHFgXfVmEmw7H-qwuUcWcSssRyMzg2XqsGSDq+FCw@mail.gmail.com>
 <20161122001658.GE149321@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Nov 2016 17:25:22 -0800
Message-ID: <CAGZ79kZL9_FUbePBf26diOykPaux5PHOosnaOwzfRevoeLqZFQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] submodule-config: rename commit_sha1 to commit_or_tree
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 4:16 PM, Brandon Williams <bmwill@google.com> wrote:
> On 11/21, Stefan Beller wrote:
>> On Mon, Nov 21, 2016 at 4:11 PM, Brandon Williams <bmwill@google.com> wrote:
>> > On 11/21, Stefan Beller wrote:
>> >>
>> >>       switch (lookup_type) {
>> >> @@ -448,7 +448,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>> >>
>> >>       /* fill the submodule config into the cache */
>> >>       parameter.cache = cache;
>> >> -     parameter.commit_sha1 = commit_sha1;
>> >> +     // todo: get the actual tree here:
>> >
>> > s/todo/TODO
>> >
>> > Makes it more clear that this is a TODO
>> >
>>
>> The // is more annoying here. I'll review these changes closely
>> before sending out v3.
>
> Well I prefer // to /* */ but that's not the style we use :)

background: Initially I assume we would need to do work here as that part
is exposed to the user in error messages, such that we maybe want to
go the reverse direction and not state a tree but instead the commit containing
it. Since then I decided that it is not worth to optimize for some
hypothetical future
and hence I did not go with the internal todo note I put there. Then I
forgot about
it and it just showed up in the patch here.

Having looked through the patch again, the rest looks clean to me.

Stefan

>
> --
> Brandon Williams
