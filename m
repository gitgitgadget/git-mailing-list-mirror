Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76BEC207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 16:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdFZQ2v (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 12:28:51 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36321 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdFZQ2u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 12:28:50 -0400
Received: by mail-wm0-f48.google.com with SMTP id 62so2391028wmw.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rcZ9OuKYk6aHpfgWR07+HaJ/1kqky0q6c/lesxlNuAo=;
        b=J0BzRmSuZwdA9UEFv2BjKUDyF9MlyeNtYOkpbcIKklq44hC042tp2Wg2lvE3YtkQH/
         aPRt4Q4k43m3WJH4aUsyrT410S5wEhcXO9SbrqYB2MRRrgLIunWF7BLQirH0xRbFIKI+
         XxSTRTrlBGS9Wly3SrWt9iD0JkW1CUPnsopLnjCcMTU8tCLj+Udf/oqYU8sruqyUlYKQ
         8IHieCf7vjbGTT8OigjkX4F5g2/sjrZ30dIlj3yXDVfZ4fdQ2bdKKvQsGVcLao75ubKY
         MXca5MqIsnlurN6BT18C3tqu3YGv2gw5v5kkd6u+c/qWMmx+qMRBKazsTeCURZz5xmbG
         1oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rcZ9OuKYk6aHpfgWR07+HaJ/1kqky0q6c/lesxlNuAo=;
        b=mc8c1swbOM6OD/TP1upvnYmTVLzx9b05Xec+SQqYqBkgjWpSPCth+0A4GBDgF0O/4c
         X9VsksXViqE5gHjnNJ45iLacdbjckwHeS4/gvPHVB+/+Jq46+MqtNWY61IqSAOrT22th
         etIoFCIfqhx30/RiqTe6bUeRBZdDYipjCpE69v+s829HZwZ4DC5R7B3Rbj3glYVUIMaY
         rOHdkQH76DCSsYVOVvN0krnZkCEvuxz8ExPRjZZ9RKKMpMCz4VkDpO/ofi9dlE9Q9XA8
         r4jqnYAX3UuDDqQUyc5QXLW0rp/WxDW2CSktEEGJcwj5hWCbIPex6nn3OcVbqfg9rwlG
         tcew==
X-Gm-Message-State: AKS2vOz4+LzWFVWKGLfPVXRjUZMetgRzGMfagElZsFBuWjBf2tNSl55p
        EW8T43/ziyTvC5WZkOc1IJFv+3JBnAJzJffkdg==
X-Received: by 10.28.234.193 with SMTP id g62mr325577wmi.24.1498494528589;
 Mon, 26 Jun 2017 09:28:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.133.200 with HTTP; Mon, 26 Jun 2017 09:28:47 -0700 (PDT)
In-Reply-To: <20170624203927.r35esm7nvcqnarlr@sigill.intra.peff.net>
References: <cover.1497035376.git.jonathantanmy@google.com>
 <cover.1497920092.git.jonathantanmy@google.com> <fb656dfeb96e3c69f612fed924d0d9dec592c772.1497920092.git.jonathantanmy@google.com>
 <xmqq8tklqkbe.fsf@gitster.mtv.corp.google.com> <20170624124813.wajhxkrqhw4xoee4@sigill.intra.peff.net>
 <xmqq7f019qjg.fsf@gitster.mtv.corp.google.com> <20170624203927.r35esm7nvcqnarlr@sigill.intra.peff.net>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Mon, 26 Jun 2017 09:28:47 -0700
Message-ID: <CAGf8dg+9OzDoZW4NaNXi_JJSQhSJZabDHkf_3rSisvuY4HhtAg@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] sha1_file: do not access pack if unneeded
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 1:39 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 24, 2017 at 11:41:39AM -0700, Junio C Hamano wrote:
> If we are open to writing anything, then I think it should follow the
> same pointer-to-data pattern that the rest of the struct does. I.e.,
> declare the extra pack-data struct as a pointer, and let callers fill it
> in or not. It's excessive in the sense that it's not a variable-sized
> answer, but it at least makes the interface consistent.
>
> And no callers who read it would be silently broken; the actual data
> type in "struct object_info" would change, so they'd get a noisy compile
> error.

I considered that, but there was some trickiness in streaming.c -
open_istream() would need to establish that pointer even though that
is not its responsibility, or istream_source would need to
heap-allocate some memory then point to it from `oi` (it has to be
heap-allocated since the memory must outlive the function).

Also, it does not solve the "maintenance nightmare" issue that Junio
described (in that in order to optimize the pack read away, we would
need a big "if" statement).

Those issues are probably surmountable, but in the end I settled on
just allowing the caller to pass NULL and having
sha1_object_info_extended() substitute an empty struct when that
happens, as you can see in v5 [2]. That allows most of
sha1_object_info_extended() to not have to handle NULL, but also
allows for the specific optimization (optimizing the pack read away)
that I want.

[1] https://public-inbox.org/git/xmqq8tklqkbe.fsf@gitster.mtv.corp.google.com/
[2] https://public-inbox.org/git/ddbbc86204c131c83b3a1ff3b52789be9ed2a5b1.1498091579.git.jonathantanmy@google.com/
