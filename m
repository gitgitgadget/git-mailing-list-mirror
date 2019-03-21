Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0B220248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfCUJNS (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:13:18 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38053 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfCUJNR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:13:17 -0400
Received: by mail-ed1-f49.google.com with SMTP id q14so4368291edr.5
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4ySnXbZfu0zJ5WF79Q34uGtb2vcJXxlkZ3tgrFn6anI=;
        b=E00NGjimjlK0XgcxcTW8ClRL76r9rMYydeRrxcphKOF1sPq6Exnumo2cXuMiqSFQu+
         +c3w/zDx5gKtL2MYg0fFVoryFJPGqe+3r+H/nZQHXyaJpuM5mTRjkzL5bUN6+5fncDLV
         LI91i4lRCKzYPwIQPlo9zTNGy1O8yD5rjvJhdvOfKxfgP4VmUCRN2abt5zstn+3SGi9U
         V6o6tuPAkMuKFcB3uACmq0KeuzHgVFDVPrwuUwL3GH5Sa5U/C8j9pE0oyV5dv62X/fBZ
         kHteDeLKGvCxvoJSNtYtNRJEWKEYTG/HQaXBgaAZWzIuzatNfMiu8Wn3ja6WbJ9/DcwA
         YUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4ySnXbZfu0zJ5WF79Q34uGtb2vcJXxlkZ3tgrFn6anI=;
        b=OlFVfmtT5aoEq+EiZof+p74vgMZEBfghwsMjqsyL0ArPaki20fVvCJrszHoBqunZcR
         5HfyGjiDspetTib94GXtgcrapMILvC3y52rQ6uMwYhW+wHre7qvg+gHRorgU4K/zqaOg
         DMhT2Bzcrq0yNanF+EYwZDFQR+wD6FTJAr5q0imGGJdlwHZef6XnMuCP3P+lvFeEfiGs
         DoTmrtohU6iQlRd+iflR0Dva/QswjP/Iz87dV5Qk9YZ66RvTpOT/50vhai449MoKUniC
         CESCIQ6EpHrEMSxc42KtCDebN54kU9rW+zgjA6TCN7lSdKpATyYTNG0M2+6mzMVPYH2/
         mu3Q==
X-Gm-Message-State: APjAAAUqISmEXoQUUl7vPwnjq3HeXYPZxipdUzoowplLW4ySXvjJ+Wtu
        jVw2lC5MbD/eT8QIKjQz5CVDvvQB
X-Google-Smtp-Source: APXvYqx6S1tmWRFJWiQoZm1nYcxs/Zqwbcllcnsg6hCiR1o05nvuwYr+de9TJ0ZkiogkFMsxIGsABg==
X-Received: by 2002:a50:b6a9:: with SMTP id d38mr1746626ede.98.1553159596070;
        Thu, 21 Mar 2019 02:13:16 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id y12sm564624eju.43.2019.03.21.02.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 02:13:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com> <871s31dv6o.fsf@evledraar.gmail.com> <xmqqef71uk8t.fsf@gitster-ct.c.googlers.com> <xmqqpnqkst2e.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqpnqkst2e.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Mar 2019 10:13:14 +0100
Message-ID: <87va0cd1zp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 21 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Wed, Mar 20 2019, Junio C Hamano wrote:
>>>
>>>> Here are the topics that have been cooking.  Commits prefixed with
>>>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>>>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>>>> the integration branches, but I am still holding onto them.
>>>
>>> I have re-rolls & re-submissions of some of my stuff as a WIP, but one
>>> thing that's fallen between the cracks & should be ready for queuing is
>>> my commit-graph segfault bugfix series:
>>>
>>> https://public-inbox.org/git/20190314214740.23360-1-avarab@gmail.com/
>>
>> Thanks.  I quickly looked at the difference between the updated one
>> and the old one; will take a deeper look later.
>
> It does not seem to play well in 'pu', unfortunately.  In my local
> tests, 'pu' without this topic passes, but what I pushed out to
> public has this topic on top and t5318 does not pass for me.

It works for me when I apply the series on "pu". There's a conflict with
Stolee's ds/commit-graph-format-v2.

There's a single merge conflict with it around the "commit-graph
version" error message that needs to be resolved. Here's how I did that:
https://github.com/avar/git/commit/1d69f4ea62973de977466a2e29d116716692a05d

I.e. this conflict:

    	graph_version =3D *(unsigned char*)(data + 4);
    <<<<<<< HEAD
    	if (!graph_version || graph_version > 2) {
    		error(_("unsupported graph version %X"),
    		      graph_version);
    =3D=3D=3D=3D=3D=3D=3D
    	if (graph_version !=3D GRAPH_VERSION) {
    		error(_("commit-graph version %X does not match version %X"),
    		      graph_version, GRAPH_VERSION);
    		return NULL;
    	}

    	hash_version =3D *(unsigned char*)(data + 5);
    	if (hash_version !=3D oid_version()) {
    		error(_("commit-graph hash version %X does not match version %X"),
    		      hash_version, oid_version());
    >>>>>>> commit-graph-fix-segfault-and-exit-3
    		return NULL;
    	}

Needs to be resolved as:

	graph_version =3D *(unsigned char*)(data + 4);
	if (!graph_version || graph_version > 2) {
		error(_("commit-graph the graph version %X is unsupported"),
		      graph_version);
		return NULL;
	}

I.e. there's a test that greps out "graph version".

I can also submit a re-roll on top of his series, but figured describing
the merge might be easier...
