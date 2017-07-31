Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7D981F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbdGaU0n (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:26:43 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34510 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdGaU0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:26:42 -0400
Received: by mail-lf0-f47.google.com with SMTP id g25so114649390lfh.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=DZ/e/GKxDWw0a29hzdkFwrIWbMXu2Ely8HLI4dyW+kI=;
        b=PJCYkET57dxjz5nIu50l06kto4tVsA9wGTBMXyuBf4f1niT67fNNKmmL8bEP6lncs1
         79jvyb3nn55LJvuS09+e2aAq1da6msCtFGHepexJLoYZvNEMq8dY5vjA/HUymgIsyhV2
         4GuihWCYWB0gED4oMJQLBW4anizc0EMVMvQsXv37WQdmXiPIxSmOtC3eFnqUdP+W8imR
         5M1cXzh5Nxj6S4xGS9UQhDEU9h5WS6qDX0vGVkdb2x9vDJiVKgN6c9TvA+3BSxbGqY9A
         0lUM4dz2wuhNn7db/4JVDvTcIrq4rcdBNolsTlazy3HK0Ib0uzVDObskUctctIpzFz+2
         tTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=DZ/e/GKxDWw0a29hzdkFwrIWbMXu2Ely8HLI4dyW+kI=;
        b=F7CzUYiNVIKFR7Q+SLS49osuitEmSrQWKfaQ8R8YtKeLvU26cIohuTHe+UWEgrv+SU
         0bL2RVl3rfpZK34cA2N1CBQXsytZ6Agnfendl9Q0C8jYDn/s5nbsVapgjpHMFr2vSXwz
         tvIGQlxU0dQkUvp+AahZPehcdVIrDJ4LkrtGTMLb6zX96SV9xCjnD1dAr0cl56OudcKM
         67dKvMeO2Jz8uCqgliXYBaWwXm0jJRvU8X2v0MBxA9dTU0dwsYafZcIsAMHC6M2ZO030
         8IjnXAo86+pD+VDks2LOJ51s1QRo8HWeVI09BJOoV6YaQNqX8U9bB4wnpXjJmwRgHel9
         d9ag==
X-Gm-Message-State: AIVw112ZanK6SmPklearN9MzeLPO+wp209/KFLFAqXjZftCv59P5XHZg
        tPgOm6Jv5S1ieptfO/WQC6WwXQCb/Y6E
X-Received: by 10.25.204.149 with SMTP id c143mr4919462lfg.195.1501532801377;
 Mon, 31 Jul 2017 13:26:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 13:26:40 -0700 (PDT)
In-Reply-To: <20170730232427.vrqrrhlsap55ax7t@genre.crustytoothpaste.net>
References: <20170728171817.21458-1-sbeller@google.com> <20170728171817.21458-3-sbeller@google.com>
 <xmqq379gmco6.fsf@gitster.mtv.corp.google.com> <20170729175833.4idan3befldn5vgp@genre.crustytoothpaste.net>
 <xmqqini9k4cx.fsf@gitster.mtv.corp.google.com> <20170730230019.ch74ska6wgbrh7ql@genre.crustytoothpaste.net>
 <20170730232427.vrqrrhlsap55ax7t@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 13:26:40 -0700
Message-ID: <CAGZ79kaBUpVwymjmzmOtHgfiWyxPQZCtFOX_Zm5v7N-H+C9cNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 30, 2017 at 4:24 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Jul 30, 2017 at 11:00:19PM +0000, brian m. carlson wrote:
>> Yes, basically, but a bit more generally.  There will always be cases in
>> which we need to specify an object ID or an arbitrary string and the
>> behavior will need to vary based on the hash.  That can be something
>> like, in this case, the two blob contents that would have the similar
>> prefix.
>>
>> So in this case, we pass the helper the string "263 410" and get back a
>> value for either the hacked SHA-1 hash or the SHA-256 or whatever we're
>> using.
>
> I realize this was worded poorly.  So for my example, in this case, we'd
> do:
>
> test-helper-hash-string "263 410"
>
> For SHA-1, we'd get "263 410".  For SHA-256, we'd get "313 481" (which,
> as SHA-256 blobs, both start with "17" in their hex representation).
> Presumably we'd read some environment variable to determine the proper
> value.

This is what Junio proposed in the first message, except that we defer that
to a shell script as for each test we may need different things, so a helper may
be of little value?
