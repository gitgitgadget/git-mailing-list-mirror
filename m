Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9741F454
	for <e@80x24.org>; Mon, 11 Nov 2019 01:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKKBTY (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 20:19:24 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:46063 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfKKBTY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 20:19:24 -0500
Received: by mail-qt1-f179.google.com with SMTP id 30so13937400qtz.12
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 17:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kV9mftSrwuisBaLmGTQDJ9+XNOuCPmzLevSr1eSQov8=;
        b=Ug1RzMOuuaS48/rGW2Rq3YlYu1ouXGEVxZxIkkcankLdBVMVM+Nxh/0jkp8Eo1lyQ1
         HLhvRMf5cO+Ix2UIDKvHfhPm8/Bj/OiouIwWGr+40pQfR8/lxAUrpnHXv/F25SotBIjH
         j1XiOpzYpgb3zvMqg4szg+BERX4cAyUgdbGmfSMFzuHQd6R8JpITKp5kBceDagJ2HJ1M
         whIWBb5HK40cTqpJDX5XlIJAxtir1BEeMFhjU1WpKnuP2qlZvnAarPKzb73+ndk/llyz
         NHuDcisrKWgcxfstTPxEQqG9PXObx03vWJPGmsc725vQM11MYt6yx7Lr6TRTf1tICNga
         tN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kV9mftSrwuisBaLmGTQDJ9+XNOuCPmzLevSr1eSQov8=;
        b=k9Zzz1bbTO6a7KY9gJIViJSY8Rnmk/dbvwXrjWobpzhWpp2/fBsP8bWxkkjnFmL4S2
         ZwVeHKlO/h/oVgbAfeuBfBjjwGXo2pRXxxN9eCspQkKCfuPpBREoCzzmzD8o0PH9Z8a2
         49l30Ih7R2Z8uyVXDG2Yrtjb41TGZEBj5p7bKS9ce3wmr/a7d3394TMW7rxZ80uuFAI+
         GplOtQuAFEui9LpKTV66Oj22a8AQAxi811hiKUht8LLXepBO67KwiJ7vqa2TEgJxKOy9
         n3aL5+9ANBn7QJUjLuN/ZoWmN+HFEmcAGgHwhsqSNg3Z1FexOk8lU8tqFCPIkesB+uAL
         oktw==
X-Gm-Message-State: APjAAAUWMDcp6Y/SvNVqPi2neKyjllg6MtPXRT9RY3JyHV8E/BnwAW7J
        3ALQu6O/rYXfa1y2fuixS+0=
X-Google-Smtp-Source: APXvYqxRfvtNcXA5/pjiDzlh0Fvc70kpiNf55zbN6HZLzIlhcFMXmmKAS1iYgXpY32DDPtVukGCJXg==
X-Received: by 2002:ac8:80f:: with SMTP id u15mr23879554qth.193.1573435163234;
        Sun, 10 Nov 2019 17:19:23 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id w5sm2736632qkf.43.2019.11.10.17.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 17:19:22 -0800 (PST)
Subject: Re: Split commit graphs and commit-graph read
To:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <CAGyf7-G3NDp--2nUbri_0EqvSLF21M0gsFCOKDCWMY+e68Htog@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <87f16645-6af4-9703-1d0d-eb64728d2849@gmail.com>
Date:   Sun, 10 Nov 2019 20:19:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <CAGyf7-G3NDp--2nUbri_0EqvSLF21M0gsFCOKDCWMY+e68Htog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/8/2019 6:41 PM, Bryan Turner wrote:

Hi Bryan,

> Just a quick question about a behavior I've noticed with the commit
> graph. (Amazing feature, by the way!)
 
> If the _very first_ write done is split:
> git commit-graph write --reachable --split
> 
> You end up with something like this:
> .../objects$ ls -R info
> info:
> commit-graphs  packs
> 
> info/commit-graphs:
> commit-graph-chain  graph-6612fcc8fd04d3af2cc268a6bd9161ae40f5fcbf.graph
> 
> info/commit-graph doesn't exist, but I have a 1-graph "chain" in
> place. (And subsequent write --split calls write additional ones; I've
> got a few now in this repository, but still no info/commit-graph.)
> 
> git commit-graph verify seems happy:
> .../objects$ git commit-graph verify
> Verifying commits in commit graph: 100% (98768/98768), done.

This workflow seems expected.

> But git commit-graph read isn't:
> .../objects$ git commit-graph read
> fatal: Could not open commit-graph
> '/path/to/repository/objects/info/commit-graph': No such file or
> directory
> 
> Running some tests with commands like git for-each-ref and git
> rev-list shows that the "split" commit graph is being used (setting
> core.commitGraph=false makes commands noticeably slower), so
> functionally all seems well. But should git commit-graph read be
> handling this better?

Unfortunately, you're running into an issue because I designed the
"read" subcommand poorly (and also forgot to update it for
incremental commit-graph files). The biggest issue is that "read"
is not really meant for end-users. It really should have been built
as a test-tool. This point was corrected when I got around to writing
the multi-pack-index since it uses "test-tool read-midx" instead of
add.

To fix this issue, I would probably go about it by removing the "read"
subcommand and creating a "test-tool read-commit-graph" for the tests
that need that output.

If others on-list think that the better thing to do is to update the
"read" subcommand to provide the same output, but iterate over each
layer of an incremental commit-graph, then I can do that work instead.

Thanks,
-Stolee
