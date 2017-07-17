Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1FB20357
	for <e@80x24.org>; Mon, 17 Jul 2017 19:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdGQT4i (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 15:56:38 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32885 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdGQT4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 15:56:37 -0400
Received: by mail-pf0-f182.google.com with SMTP id e26so40394pfd.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sZhKwChL38mK4UOOtf7AKJ9cUmxuyEM+EMHhs1e+HXY=;
        b=UhoWmmSM0Xk1/fRjm7+tiLh1P2yKUi0jsaX/ZN0+5lkD4s7nTHyUsdNki0PKWTpzTx
         XcHv4NF19WkrXL4fsIUUAUgVf1YfI39soren7rZxwlwYNXZCNxJniaRO5bgQZ6YAw+gI
         9gd/h4DkyXUHk5wDIGmp2cViiA5uQZSQcLqcYDplERr9Js2tizhU/XAnbG8ms3YEgwA+
         5F/vBK8mGp6H21gqKnhOsv0/zwhpJgQSF7u1c7s9hG5/zJuNBzHcOv3YBPi9xJU8E9Po
         ZCRXhussLGD64tvSFTobiVLq6jDLZj6qy1TK+eTVSlrCNxPord5UzjuPIp1SwioT+t1Z
         OaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sZhKwChL38mK4UOOtf7AKJ9cUmxuyEM+EMHhs1e+HXY=;
        b=n3wPTtAhQGQV1Gif/SV72GdcFd+dBDN42L9RddNsyiMHUubzdQx/ipRNNwcN3rad/s
         A2ru40grwfX15hCcOxscQhCHQva67ZJohYROxNLbVePEoUl3HifInVGURGatbcnA4a9T
         VQRvEnpnqB+3Ue1HozXOaJQK4KzcRPLfVp/o27R43S+Y+Puov0JeLz8KXN4dMyjkmeFu
         MW9FsZHy8o1WG/FdFsEYwBfMamopRERb9SsGzVDxXnWASRO6+ehud+K89Rp6Y/F1xN7a
         zcUd3HRujxevU96DauGo1eJue4/IIgy/NtlPaPLQF0FsJ1UCpaJtGizrYQ3ndg+8fshs
         Jqtw==
X-Gm-Message-State: AIVw1137hsX9RMoY5mnPdpOERAqphkaQ8KWy+qH313BHiAuAfaOnX/ag
        FpwLa9nlTPkyjwlflUFxw5IZUWhRlofh
X-Received: by 10.99.54.9 with SMTP id d9mr19074331pga.195.1500321396971; Mon,
 17 Jul 2017 12:56:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Mon, 17 Jul 2017 12:56:36 -0700 (PDT)
In-Reply-To: <CAJo=hJuHsKY5YkmoBqCNvv2tvRdJFtD02JrnUko7iJbpSJWHgQ@mail.gmail.com>
References: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com>
 <CAGZ79kaFmxRSp1YBXc=6YEeDGUO-VLBF0yk+Bb0np7x80z_Vog@mail.gmail.com> <CAJo=hJuHsKY5YkmoBqCNvv2tvRdJFtD02JrnUko7iJbpSJWHgQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Jul 2017 12:56:36 -0700
Message-ID: <CAGZ79kb-+NhP7E_=mXEEQJPQjYkU18gP8OkuMOS08aD+xbeMgg@mail.gmail.com>
Subject: Re: reftable [v2]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 12:04 PM, Shawn Pearce <spearce@spearce.org> wrote:

> A block must have at least one restart in it, the first ref_record
> must be a restart. So number_of_restarts in the tail of the block can
> be 0, which implies 1 restart (number_of_restarts + 1), and the first
> restart is required at the first ref_record. :)

Hah! I assumed the first entry to not be recorded because it is always
a restart by definition of the file format, so it could be omitted in the
restart_offset list, but that would complicate the implementation, such
that including it makes sense.

>
>> When starting to write a block, we need to know exactly how large
>> the ref_records* and restart offsets need to be to put the
>> number_of_restarts at the position as promised via block_len.
>> This sounds complicated unless I missed the obvious.
>
> Correct. The writer needs to compute the block size before it writes
> the block. It does so by buffering the block contents until its
> approximately full, then fixes block_len, and flushes the block.

So that is another trade off for determining the block size. "How much
can I buffer?"

>> Going by this, would it rather make sense to omit the block_len
>> and then scan backwards from *block_size-1 to find the first non-NUL
>> and that will be the number_of_restarts?
>
> Not quite. On small reftable files the "physical" block may be shared
> with a log block ('g'). We need to be able to reliably find the of the
> ref block ('r'), without padding between the two blocks.

I'd need to reread the proposal to understand this bit as I assumed that
each block starts at a multiple of block_size. However we could choose
block_size such that there is no padding between 'r' and 'g'. Ok,
makes sense.

> The time field is also prefix compressed as part of the ref name's
> prefix compression. So there is no need to move to the complexity of a
> varint or anything else.

I agree, that is why you explicitly said that the key is
    ref_name '\0' reverse_int32( time_sec )

Note (as found out in discussion with jrnieder@): The size of the integer
is determined by the suffix length encoding and the preceding '\0',
such that the file format allows arbitrary integer size. So instead of
pretending we can only do 32 bit here, just say 'uint' ?
