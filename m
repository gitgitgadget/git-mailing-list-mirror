Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D027220372
	for <e@80x24.org>; Tue, 10 Oct 2017 02:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754268AbdJJCfI (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 22:35:08 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38350 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdJJCfH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 22:35:07 -0400
Received: by mail-oi0-f67.google.com with SMTP id t134so8067420oih.5
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 19:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lMgcCVHSZ7xmeR99HMBd4W6yEMzQxS2ZIK/Dq6c82HU=;
        b=t1DFNgAais8KIIchrIOhcBOt7qjJL4d+M8E1mx194Wc9LubfV6WFw/Oo0L00LbHd98
         j7Wzt055JsfFwN4YjvplJfzbcQk51xkcPjxwb8cLZ1I1kqruwFSpKl4Bwhi5QTPgDPNG
         C9crXgSbB9LM4X9zVBVbJczm5nYwj8Lyr6SYEajYMgfmdxpdg7yDSPQsz7cTi6eCTQA1
         r5Pt/vGy/MqoIU5QYwDxorj88Od4vN8few6+Ms+QvB3wfeLucXzM+oBdKtJQHFqzPv6B
         nHdzDlmOAORexxWRsMi1VjxUMrZf73fmxwnrerZyYrw/oh0o5ZVTVag2ZKhxt8sWyZTn
         pfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lMgcCVHSZ7xmeR99HMBd4W6yEMzQxS2ZIK/Dq6c82HU=;
        b=fXcikARrMzWeK57hhXZm1FzgoF9g4S1O2X/GMUjff3wERv1N1nc2kpxH9H0hPFxQxx
         q5FWTG3fwBOtzV7uW+H9dLoLQKIxghjx9jvrejYuAyJITPuSRH6BVwhHrIuRHAhCNeei
         bczdaKG6SK+m6h0zQtBFwGv/3yhJjVDKDNNW/GzptuONHnsJ5Px3m02oZSOMTf9Q4D6r
         wj6KC/REqJTP+uMBmIu0ED3cJ0sSNKp9P+9+AboCbUaXNXj5fVlZcxYz/L9ispTuwjKz
         tvYHK+33L82ingoumJybvELmZSK92pe97F0mjMcYX6PQ+nRgVobf8qmeW9IWAhG6Xkga
         UwXQ==
X-Gm-Message-State: AMCzsaWIX14QWkRWDo+bcxZqir9K3ZkLwyXskS5N2oSJyZcBGwS9nllk
        9V6tzLUnStZRd0Amc5zVGkFFV6AOXRF5yfLySsQ=
X-Google-Smtp-Source: AOwi7QB7Zx6PEZSyP6s5g7joixO63+ASSXOwk2CyAdgWmQxSQh55ZJWZO9CbTa8k1OA0Gy+6GxFthvSmSEFZC/MhKpM=
X-Received: by 10.157.43.36 with SMTP id o33mr686396otb.456.1507602906439;
 Mon, 09 Oct 2017 19:35:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.6.10 with HTTP; Mon, 9 Oct 2017 19:35:05 -0700 (PDT)
In-Reply-To: <xmqq7ew3rdxa.fsf@gitster.mtv.corp.google.com>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
 <CAN0heSqFSiev8BeZVu3KBA5vswsbQrrOH=tYYOSs_h_eq=8-3Q@mail.gmail.com>
 <CAGZ79ka7xo96MHaAUbkDuFjWMQaaD4j2UrRndcinAg6uzaP6Kw@mail.gmail.com>
 <7894534.MaGmRTisnX@cayenne> <xmqq7ew3rdxa.fsf@gitster.mtv.corp.google.com>
From:   Changwoo Ryu <cwryu@debian.org>
Date:   Tue, 10 Oct 2017 11:35:05 +0900
X-Google-Sender-Auth: ORMxQw8DFHQ4gGOQhGZmuyz0af4
Message-ID: <CAEe2ifX5+OUOWw75pFZN86pT1iwYk2vb6u+uEMYLDpxYzmJLEQ@mail.gmail.com>
Subject: Re: [PATCH] submodule: avoid sentence-lego in translated string
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-10-10 10:26 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:
>
>> On Monday, 9 October 2017, 09:47:26 CEST Stefan Beller wrote:
>>
>>> I always assumed that translators are aware of these issues and sort of
>>> work around this somehow, maybe like this:
>>>
>>>   "submodule entry '%s' (%s) is not a commit. It is of type %s"
>>
>> Translators can be aware of the issue if the coder commented the
>> internationalization string with some possible candidates for the placeh=
olders
>> when it is not clear unless you check in the source code. Much effort wa=
s
>> poured into translating the technical terms in other parts of Git; it se=
ems
>> awkward to just step back in this occurence.
>
> I do not see this particular case as "stepping back", though.
>
> Our users do not spell "git cat-file -t commit v2.0^{commit}" with
> 'commit' translated to their language, right?  Shouldn't an error
> message output use the same phrase the input side requests users to
> use?

Users know the limit of command-line translation. They type "commit"
to commit but they see translated "commit" in output messages. It is
actually confusing. But the untranslated English literals in the
middle of translated sentences does not remove the confusion but
increase it in a different way.
