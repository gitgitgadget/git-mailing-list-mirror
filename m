Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A10A207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbcJCWRc (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:17:32 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38759 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbcJCWRb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:17:31 -0400
Received: by mail-it0-f46.google.com with SMTP id o19so111202687ito.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 15:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YLDmtDkQLd0cEfIQfCttdueO7YwZ1XNavF7FTWXwCNg=;
        b=K41teyqk/M3GulTZbJDaEcwtpltvo4tPVeXlMBqJ6QNMFntgwJGW7CV6UHDrgj0gXS
         N0aoQ2tOVRFawv7BTRunmOy6oTi6mTApqiY3U5YCFoawURodVaNG5mKTkQD70kNLXM+c
         N1u88iUFhakirEa8J0p5ZJDoRzffV2U4/xaM4y7jgLTYbusIv7cUGxB1Vua3rIFeNb3t
         wZTnM+D6frvtOHigzmTAQKrzQFBCWnZan9gQhV1VoTU3kwlFYUCifHZWrBfQHcs0LaiI
         NE1VUQQYbnL4bnDH4bjfnVM9FjXKqnXfF1euWtoTD3Ktu+TmjKeuVP5NnQzUj24yBJzk
         dzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YLDmtDkQLd0cEfIQfCttdueO7YwZ1XNavF7FTWXwCNg=;
        b=LTzdpjnW3LWWN89aanlJk0MaAzmAOsNTKtDo9sG06LiWdaBPlfyNhTRqpa4MMsD96y
         aPJQBkTLa2Shf34GZBaQT7xN0pEkPkKVWbi+xOZU55hjKpxGDqZDK9aCWj1cP0cLrlrC
         UyGmTqP3ijchlzMAlXExi8tyN1CWVFEClOlejBA5NyQPm9EiIUyloyOjlChImNKVKTcy
         l+2MYcYPw0PyuRnW1ZYGbvetGY3NhXHbnmPmLKH0uIV9yv/kZnw6L6SKqxpzJRo6vDrN
         BuMtx+6qwq3K7559nPUlAtAl8aBKX2VkuDYRmYBi5T5o2jWZt+tMGex6DO3ud6E1w0u5
         Lutg==
X-Gm-Message-State: AA6/9RllIhSZxfnSxX6iqKvARODdxlW8IUZCBbWOodIVMHlGL0AZetsXyf0Ntf1pF7lpGJqRKB2KxjbmNpTgEieR
X-Received: by 10.36.50.149 with SMTP id j143mr922689ita.91.1475533050620;
 Mon, 03 Oct 2016 15:17:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 3 Oct 2016 15:17:30 -0700 (PDT)
In-Reply-To: <xmqqh98t5c69.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com> <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
 <xmqqk2dp71d2.fsf@gitster.mtv.corp.google.com> <CAGZ79ka8dO1AHJftKAqD6LvxJSP+8yGGa7Citcdxxrnc5DMeYg@mail.gmail.com>
 <xmqqwphp5f9q.fsf@gitster.mtv.corp.google.com> <CAGZ79kYt+Z=ff1b2G+wWRAGGS=je+dpksfmMXj0fWwYVvHk8Cg@mail.gmail.com>
 <xmqqh98t5c69.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Oct 2016 15:17:30 -0700
Message-ID: <CAGZ79kY+yB-AxRUt0rArGw6DaLDsMZDjKt2jQh9B=P-79T+qYQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2016, #08; Tue, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 2:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>     // Note: git_attr_check_elem seems to be useless now, as the
>>     // results are not stored in there, we only make use of the `attr` key.
>
> I do not think git_attr_check_elem would be visible to the callers,
> once we split the "inquiry" and "result" like the code illustrated
> above.  I actually doubt that the type would even internally need to
> survive such a rewrite.

So how would we go about git_all_attrs then?

I think those (only builtin/check-attr.c as well as Documentation) would
need to read these names off of git_attr_check_elem.

So instead we could do a

int git_all_attrs(const char *path, char *result_keys[], char *result_values[],
                        int nr, int alloc)

Internally git_all_attrs would use nr/alloc to resize result_{key,value} to an
appropriate size and then fill it with keys/values.

Although I do not think check-attr needs to be fast as it is a debugging
tool rather than a daily used tool, but it would fit into the current
line of thinking?


>
> The point of "future-proofing" the callers is to hide such
> implementation details from them.  We know that the current API will
> need to be updated at least once to prepare the implementation of
> the API so that it has some chance of becoming thread-safe, and I
> think we know enough how the updated API should look like to the
> callers.

I don't think we have the same idea how it should look like, as e.g.
it is unclear what we do with the `const struct git_attr` in the
git_attr_check to me.

> I was hoping the minimum future-proofing would allow us to
> update the current "attr" API users only once, without having to
> update them again when we make it ready to be used in threaded
> environment.

Ok, so let's first define how the future proofed API should look like
and then we can go towards it.
