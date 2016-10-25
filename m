Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71132035F
	for <e@80x24.org>; Tue, 25 Oct 2016 12:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934494AbcJYMwx (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 08:52:53 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35564 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934152AbcJYMwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 08:52:53 -0400
Received: by mail-yw0-f169.google.com with SMTP id h14so603369ywa.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wrkP4ZiTD4V6gHg/WxKRWk/JgxBRVxNkCdi+U8b8pek=;
        b=XB16ieSHti8I/mz+IiMdvKSvRlghddtbVkgHhveZcZbkj7PRiQjtqACFGGwVtdLmxJ
         0fRfpY8zNypukADyRZh0+0o+DAYDg1Z4DXfPEjbqNdp5PCIMzzc69Lcbj5+iW7tue1t8
         hdHh5Q/RsSvEOOfy+ghNgMI+mdbu2lt+FeOhOpNlFSsUE4SA6W2FG0bm/qhYtkHHx0do
         vbjytDJPVuVoTZXOB3NIs4SSW00nLP9x48qSYyFS4cKTkENo4SVe0g9DDoGnpKMTvbzU
         cjPpNT4m0ASC9kFDV2wCE70nEDZ9tQXpaS1q1MGvYSTXEaNtNDYPJ1vCuAiFjdORjXkJ
         llXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wrkP4ZiTD4V6gHg/WxKRWk/JgxBRVxNkCdi+U8b8pek=;
        b=A5FQtlQsEjQiNbmBZ+glHdEZ7e1DAp7y9hJMsF3ZecNpd0XbCJnhOqSSfzXNKFjSeY
         iSpXHjmdxjz8N0y3LB3/zO1nGHyLsUzlYYFS7HjC1EaTmkfc0VWv+EdIRukRf6aB7m8K
         jC8yRzaoyuvhmihG76PQyzXXvZf8tbIiEvpl3xqHRmssQSgDUJH4x3Oy/j05FIRyJZQZ
         Kv0mWXBwlS+KQFrtlB/F9wpqmwEM+VVudnsbDQUVD4LQ6gDjG69cwc1znHA5udIuVHN4
         ge/tMlzv64inIRnMA2nTNdW3iNgfA7Dev1pIE+orILSZ1bb/BGESJpPDBrGpRmY40o9f
         d+Lw==
X-Gm-Message-State: ABUngvdtYWEFyCHALBCgNo8vxQ0AqK3dnQZhT0DeWCb4iCyTlC54celKjnNCAZjuttvDPNe5vZD3xXm3Jfn+rw==
X-Received: by 10.107.44.17 with SMTP id s17mr16049629ios.212.1477399972137;
 Tue, 25 Oct 2016 05:52:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 05:52:21 -0700 (PDT)
In-Reply-To: <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee> <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee> <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net> <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
 <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 19:52:21 +0700
Message-ID: <CACsJy8B_AQxm1=vF8i4FPtinq0id1QZPrqp9vvAmAgUns_kgGg@mail.gmail.com>
Subject: Re: %C(auto) not working as expected
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 9:28 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 10, 2016 at 04:26:18PM +0700, Duy Nguyen wrote:
>
>> > If we do a revamp of the pretty-formats to bring them more in line with
>> > ref-filter (e.g., something like "%(color:red)") maybe that would be an
>> > opportunity to make minor adjustments. Though, hmm, it looks like
>> > for-each-ref already knows "%(color:red)", and it's unconditional.
>> > <sigh> So perhaps we would need to go through some deprecation period or
>> > other transition.
>>
>> We could add some new tag to change the behavior of all following %C
>> tags. Something like %C(tty) maybe (probably a bad name), then
>> discourage the use if "%C(auto" for terminal detection?
>
> Yeah, adding a "%C(enable-auto-color)" or something would be backwards
> compatible and less painful than using "%C(auto)" everywhere. I do
> wonder if anybody actually _wants_ the "always show color, even if
> --no-color" behavior. I'm having trouble thinking of a good use for it.
>
> IOW, I'm wondering if anyone would disagree that the current behavior is
> simply buggy.

Silence in two weeks. I vote (*) making %(<color-name>) honor --color
and turning the %(auto, no-op, for both log family and for-each-ref.
We could keep old behavior behind some environment variable if it's
not much work so it keeps working while people come here and tell us
about their use cases.

(*) I know.. voting is not how things work around here, unless you
vote with patches, but I can't take on another topic.

> Reading the thread at:
>
>   http://public-inbox.org/git/7v4njkmq07.fsf@alter.siamese.dyndns.org/
>
> I don't really see any compelling reason against it (there was some
> question of which config to use, but we already answered that with
> "%C(auto)", and use the value from the pretty_ctx).
>
> -Peff
-- 
Duy
