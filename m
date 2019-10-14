Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D7E1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 15:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbfJNPih (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 11:38:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44467 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfJNPih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 11:38:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so20268913wrl.11
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qwfyCja8+jvfIxMO4duo0aiaFnDVkrM4LBDkkzi+zCI=;
        b=XH6HR+IaJmRNWzuBje/W7sbtrwkP30QEj0oiAaTJQzUpL/XFLCd3kzqm8JKUtC8Yr1
         b2oHPP9jhyOqIlsLwUsKnEKgl8Gktfdk0qLg3qB74xYlpfGwT+9Pk/v7zlt3HHRpylVH
         XZE7so9GKPOrixPLh0EpHtgNmfIG6yR+MAbY2gLMyF/mtEkrt7H9LlZ8F3hXeqPI1cwR
         QABICAN3Ou/5MI3HotzlsDAWp1+Sm4YyfrP1An/kXVEM6s63fiafOuIRAg6G7RiXt/Jp
         MueMwsK6IJvpfDnJn+f4PNaZH3c/h5rjWpCeSk8FTxXAI160GlK5Vvv8vAKqySODsnFj
         iHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qwfyCja8+jvfIxMO4duo0aiaFnDVkrM4LBDkkzi+zCI=;
        b=ibjDCeggpGjwjpP+g0v3vqnzoPfTXYciimDwQ5tG3sYhQc0j77fs+snrk6eXnPaPKS
         645WO/ak2+fZ2Xoop4p8WYUYJ73eyYoTT8j3PBY0kIhNBlkW9JvK+3x+RfaN7Xtb45r2
         5zVk1+yB7+uZiIWVYvwgSOKZukBU/980gaxQWBiTTKzJGVymSYvBk6FxhV7ZxmEzVIcX
         jLt1tqkir7Yy0yl0rE3XYauWT4HJom7PgQWcZlMD3RcbI+E/r0RrZplYwXG0MfGZIsO9
         nKqUGbZTQJ23InvZxycJ4G5VwXmEn9G8tP5fvtsjE2AKf9DltJo3YZkzGnlOqqaWKrRv
         VCuQ==
X-Gm-Message-State: APjAAAXVWYzK28OhdRPLq0LImaeqHAZQH7cWi2U+OaBajf4zAsIFI+jn
        3RX/1wkZbFAQu5QWFHX4dsI=
X-Google-Smtp-Source: APXvYqzeUhgJJ68SAZYnbdZV3v/O60Koa+yfCssNLFq7sGvJbRjdvH0lLHyDmFcW3X6wkvdpM8/vew==
X-Received: by 2002:a5d:6246:: with SMTP id m6mr27331278wrv.262.1571067515708;
        Mon, 14 Oct 2019 08:38:35 -0700 (PDT)
Received: from liskov.home (host109-157-47-110.range109-157.btcentralplus.com. [109.157.47.110])
        by smtp.gmail.com with ESMTPSA id y14sm27281214wrd.84.2019.10.14.08.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 08:38:33 -0700 (PDT)
Subject: Re: [PATCH 07/11] graph: commit and post-merge lines for left-skewed
 merges
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.383.git.gitgitgadget@gmail.com>
 <6c173663aac37f1d314db8637cf4a243066b8078.1570724021.git.gitgitgadget@gmail.com>
 <9fe7f2d9-2108-5cf6-dcd7-06d91e74e98b@gmail.com>
 <204c7479-c78d-54ff-5ece-397b4c31804c@gmail.com>
 <20191013065609.GA30601@sigill.intra.peff.net>
From:   James Coglan <jcoglan@gmail.com>
Message-ID: <5661fb1e-d850-f193-6d00-23de9f48e742@gmail.com>
Date:   Mon, 14 Oct 2019 16:38:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191013065609.GA30601@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/10/2019 07:56, Jeff King wrote:
> On Fri, Oct 11, 2019 at 06:04:21PM +0100, James Coglan wrote:
> 
>>> I should have noticed in your earlier commits, but why don't you keep
>>> the output inside the test suite? You can start with "cat >expect <<-EOF"
>>> to have it ignore leading whitespace. Sorry if there's something else about
>>> this that is causing issues.
>>
>> I was following a pattern used in t/t4202-log.sh. I believe it was
>> easier to debug these tests with the setup and expectations split into
>> separate blocks, but I wouldn't be opposed to merging them.
> 
> Some of the older tests used that style, but we've been slowly
> modernizing (I know, it's hard to pick up the style by example in such
> cases!). The usual style these days is making sure everything goes in a
> test_expect_* block, with "<<-" to indent here-documents.
> 
> Another minor style nit that you picked up from t4202:
> 
>>>> +cat > expect <<\EOF
> 
> We'd omit the space after ">" here.

Thanks, I've now made the style changes you've suggested on my branch. How should I go about sharing the current state of my patch series after I've incorporated all the changes suggested here? Should I post them as replies on this thread, or start a new pull request via GitGitGadget?
