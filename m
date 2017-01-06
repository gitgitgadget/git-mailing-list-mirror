Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819341FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 21:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755383AbdAFVDi (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 16:03:38 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36222 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbdAFVDe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 16:03:34 -0500
Received: by mail-qk0-f182.google.com with SMTP id n21so476968114qka.3
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 13:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=El3cp/oLgQaiFdyjXjTBrHAkOGWugwgiUqSaCRf5s8s=;
        b=V4oyTO5m/wFUe9WcmnbRfZXoEz4S8O744vEK8U/0ji2YKD3puQpKG1syuFP2b2LNzM
         qqjSWivsKi5gJv4K6OgP436sc6zUYufQldvN3x5DmYs/anOxtiBY15rLgToCEJfmhn+i
         86jX8VyLCs/DtX8KMpf9HIsjHNk4z9hd241EWNEPC0f35mjKfqo8feAHn/4c514K41iu
         ajbMNcGPjJDfKYcSPz+PcWrG5j95DZNT6EXQBqpqa94TTP+8Nec97N0uUPrFiOTgkpyv
         CPD8Gi5ONCzTVRS63u1K38gq3QjZ3kVjr7fx+m8w2NrBVdU1xLw2dBnOnSUkCGtwguXC
         NZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=El3cp/oLgQaiFdyjXjTBrHAkOGWugwgiUqSaCRf5s8s=;
        b=c+S7WhbzZGBTXng/e4hCkQRIJ1hrgdRtjZQRGGhnUpLS79P20gs0Qi0T6hfohj2Jud
         H1BwUWo5nB6PAbfKqSfAQu1kwwN9kLusR9/4LRP4FxPUttgEikqi/4RIVCAnWyqigqkn
         yYKgRzXucNr+/HqAKoIK6TTvaGZusUGsMt7jqpps/p9o6qK6hHKw+k7Jk6UPOtbaOjj4
         KeY8HHcC8iElHfqhtaZSKe8uZXreBPsz8ZQXVFdV2smv81t/BbFTXrnziA9HyxyX4FXM
         S1nPJiCgOdfskWsZUSztV2ynlCYrNoOT70r2jW8IS+FZtbgB8q08M3ZmSfDQ9wGx5h2L
         aO5A==
X-Gm-Message-State: AIkVDXJkfv7zFpa4ALqTVDCMJaFjCGnD7Q9t754J63+MEpLchsr9GF+s9JVl01XFnJmimsQI9tzGUSDPJ96i7HQd
X-Received: by 10.233.216.7 with SMTP id u7mr74633870qkf.220.1483736590360;
 Fri, 06 Jan 2017 13:03:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Fri, 6 Jan 2017 13:03:10 -0800 (PST)
In-Reply-To: <xmqq8tqv6051.fsf@gitster.mtv.corp.google.com>
References: <20161229194309.2373-1-sbeller@google.com> <xmqq8tqv6051.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Jan 2017 13:03:10 -0800
Message-ID: <CAGZ79kaM=Uosm7KAvAP-8w59Tyfc7LZiV3ZOr=PZnBgMCzr2AA@mail.gmail.com>
Subject: Re: [PATCHv2] unpack-trees: move checkout state into check_updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 5:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> I'd add Ren=C3=A9's Reviewed-by: here.

done

>
> I think moving heavier and initialized variables earlier and more
> lightweight and ephemeral ones like "i" later does make it easier to
> follow.  "errs" has the significance and the lifetime similar to
> cnt/total, and logically should be higher, though.  It is not a big
> enough deal to reroll (but as your futzing of the variable definition
> order was not a big enough deal to do in this patch, either, so...).

I will send out a series, that is based on this patch shortly;
as I fuzzed again with the small variables, that series doesn't
apply on this version but the version to be sent out shortly.

>
> Queued.  Thanks.

please replace with the following series.
