Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4410B202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 02:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbdJXCwY (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 22:52:24 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:52194 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdJXCwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 22:52:24 -0400
Received: by mail-qt0-f181.google.com with SMTP id h4so28719059qtk.8
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 19:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h216+eLYL8u2EeaKIOgwOvVDZX4UAsjv+Z12k3ISCX0=;
        b=JxlRC4o9bH5L9CQe5CsU7KldmqCyXd07c+a5YfOJ8gt2diRZQ2ibQXF+6FE/r+F4tZ
         DW8TBGbR9LRd5HQGhMRFVVQNj6w9WRgM77Fk3LjbmmKMPRq/J9Q27JWkeqTerTnIAtx3
         ZDJ4qGMYGQ/Dve2/Qq8LTspPRmaEajifblCFE38pN0Gj/C+qega40UfmQe0AWHsYnJmF
         DU9HgTrAtB/T6oyVSsoaZL9dFGfywMAkPZxHC/UjuThjZbQ6qTyYItWZv0SQHwPme9Bn
         s7dgPHGCeP08vEnyWeno2yueri4guGTxEC/jlNPh28cZanaXWOxWMbUCz5T0jziUDEuA
         DXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h216+eLYL8u2EeaKIOgwOvVDZX4UAsjv+Z12k3ISCX0=;
        b=Y/nNxgyVVs7BHW/wDa1sGefXl7MlddUG4BfWJA5HOGJI0V2xnzQumdG1WSHsvBQnCi
         etO5eNJzzVezbgCjwRCg+EA2EPi/qk7EMQ3PdoSYKmPY/N2JfJQ79HzNSniO0TlbQYP8
         b35RMxo0+gvC0nleI6Pb5lS5J7boXRGLA1vYJfZV38WiM+/0lQWfVyOb45lcmpgZSn4X
         iu5+DktmvOYbjQSOHg8IxEFfj9AuyWzO3qfqL1Du492+Eb0ouV64stuU2eK1EDnpUX2j
         H9DSD8CDl67J9ErFom58ndmcpL2prl5ISEGGAHy7vk5Y2UIm0tDYtBad3rQf2V4jkX6b
         VUFw==
X-Gm-Message-State: AMCzsaVS+hv5iu4ZH7iN2zX3BY0wb4sjZlbFnQQK/oRmka2jCH7ADwUX
        ZS2WrvT1diK5IPtCHGEMUdJ2NPEJKA1F8K2USam+Aw==
X-Google-Smtp-Source: ABhQp+QeIPaSdJMcH87dCgmfKY+ZrVlpVwVcw1hGpXgbClcVMLUw8SF/nZGBEaY69TpnmlGJs7I8S8tZN+JKhGXnOaE=
X-Received: by 10.237.37.132 with SMTP id x4mr21291000qtc.224.1508813543171;
 Mon, 23 Oct 2017 19:52:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 19:52:22 -0700 (PDT)
In-Reply-To: <xmqqlgk19upq.fsf@gitster.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com> <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com> <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023212916.4aarismli6io4ro6@aiede.mtv.corp.google.com>
 <CAGZ79kYwARXNWRS4AgwTP7peZiWiwCBvWFiEr9TbpbWjgysfZA@mail.gmail.com> <xmqqlgk19upq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 19:52:22 -0700
Message-ID: <CAGZ79kbba9KuDX7HsxhW3jXs7ocWfZg=KSHE-GsXjntnT4PWdg@mail.gmail.com>
Subject: Re: [PATCH 1/5] connect: split git:// setup into a separate function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I think once this option is given, all we have to do is pay attention to
>> this option in diff.c#moved_entry_cmp/next_byte, which is best built
>> on top of Peffs recent fixes origin/jk/diff-color-moved-fix.
>> Would that be of interest for people?
>
> Two things and a half.
>
>  * I was hoping that the next_byte() and string_hash() thing, once
>    they are cleaned up, will eventually be shared with the xdiff/
>    code at the lower layer, which needs to do pretty much the same
>    in order to implement various whitespace ignoring options.  I am
>    not sure how well the approach taken by the WIP patch meshes with
>    the needs of the lower layer.

Good point. I'll keep that in mind when redoing that patch.
(I might even try to clean up the xdiff stuff and reuse the code
here)

>  * I agree that -w that applies only one or the other and not both
>    may sometimes produce a better/readable result, but the more
>    important part is how the user can tell when to exercise the
>    option.  Would it be realistic to expect them to try -w in
>    different combinations and see which looks the best?  What if we
>    have a patch that touch two files, one looks better with -w only
>    for coloring moved and the other looks better with -w for both?
>
>  * As moved-lines display is mostly a presentation thing, I wonder
>    if it makes sense to always match loosely wrt whitespace
>    differences.  It is tempting because if it is true, we do not
>    have to worry about the second issue above.

Well, sometimes the user wants to know if it is byte-for-byte identical
(unlikely to be code, but maybe column oriented data for input;
think of all our FORTRAN users. ;)
and at other times the user just wants to approximately know
if it is the same (i.e. code ignoring white space changes).
If Git was *really* smart w.r.t. languages it might even ignore
identifier renames in the programming language.

So I think an "unconditionally ignore all white space in
move detection" is not the best (it could be a good default though!)
but the user wants to have a possibility to byte-for-byte comparision
(maybe even including CRLFs/LFs)

Thanks,
Stefan

> Thanks.
