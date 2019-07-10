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
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D7A1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 08:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfGJIs5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 04:48:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38964 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJIs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 04:48:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so1347220wma.4
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0O8icHXaG00YMxzBw8TgYi4R5sxEbY/8kyzWr+ntYKk=;
        b=Amq/N2E0qc6JNFJ1bukAMQ70uMQqGEgrGrwIz+axbAosf0+SmzKJbEY26yIMi+S7g2
         l/9vOX8pOMtgXyTCZiLGg6gTJjHMPe0vlVNfB+UBm64u0W4SI4+2w9Rx4EB3oofHLQRD
         hMZVGE1PIQh0mYmWNKJF3NrN79vJDrvQl4KhtoSVnTk9PWLXBo28PFOkJ7ZMwM4CiHt8
         CFoIjt/b9mMOBkXP4n6UtTqMDDR7MpwCNzTVxD8hxBZAWbq6TKhqPFAwjM7UAIpN+eod
         HY3h3HaezWe5aUX2oeUobtNONhFUxk8UTQci9jeCFIkjQVnw6e1rGQJC3kYEQAO6+mWQ
         L41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0O8icHXaG00YMxzBw8TgYi4R5sxEbY/8kyzWr+ntYKk=;
        b=sHReiXZ7h9eDmGLGhSRAKX5aqoyZ0nEVt4SxRWA9eI8y1eWPTut3ARQr/sy7Ks6vx4
         YKpmiJyOkSAvWRYKGfc6NeuQdt05HHVjoUw8E7eNgMEo8oilcne9FKiJdESR3e4DAvH2
         oDgxEEWpSUy6UIWb8+X+iE3kqEDKBgOHypzVjeSCy5TJVU3M9AGsU/TBUc/Qj0x3FoAq
         KPbHdWL1bduem9vKC2Jza8kLr/lHnrGYGBMp/sQJBupO4YWO9GmOg5k5jN/DMLPsg0Th
         mcRLgvqKixeIYgvV1rDJ8rCcTYuUb97HJFL3R+gbsO5zWlc2XDY8ZP8RtlRx4kjg/qqv
         Bsjw==
X-Gm-Message-State: APjAAAWJd6EeU5tkKtlDiynua4QlTeH0r8A6SFaI+tugoL4FQC9VIdHQ
        caP3OLjfzTFfIQBuTnj5C0g=
X-Google-Smtp-Source: APXvYqyx7JEEB54076k8pNacHsbgSbLj5nx2eG/1abeUUAk4TtKITlK5/qvzXhT3awEL0ryB/Rsygg==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr4187938wma.78.1562748534766;
        Wed, 10 Jul 2019 01:48:54 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id h19sm4401211wrb.81.2019.07.10.01.48.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 01:48:53 -0700 (PDT)
Date:   Wed, 10 Jul 2019 09:48:52 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/14] apply: make parse_git_header public
Message-ID: <20190710084852.GE15477@hank.intra.tgummerer.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190708163315.29912-8-t.gummerer@gmail.com>
 <xmqqimsbuhdy.fsf@gitster-ct.c.googlers.com>
 <20190709212359.GD15477@hank.intra.tgummerer.com>
 <xmqqa7dmvlmn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7dmvlmn.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/09, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Maybe it would be even better to name it 'struct gitdiff_data', as
> > it's really only used for those few functions?
> 
> Is it really the case where "these three are only used by the
> codepath you made public"?  If so, I agree that "gitdiff_data" is a
> perfectly good name for it.
> 
> I however had an impression that it is the oppposite, i.e. "the
> codepath you made public only needs these three, but these three are
> used by other (still private) parts, too."  If this is the case,
> then "gitdiff_data" is a misnomer, if we were to embed an instance
> inside apply_state.

Yeah, that's correct.  What I meant was that since we're only using
this struct for the private 'gitdiff_*()' functions, which are called
from 'parse_git_diff_header()', 'struct gitdiff_data' would be a
better name than 'struct parse_git_diff_header_data'.

I do agree that it wouldn't be a good name if we were to embed it
inside 'struct apply_state', and as mentioned in the previous email
I'd have a hard time coming up with a good name if we were to do that.

> It seems that it is not a good idea to do such embedding, and if
> that is the case, "gitdiff_data" is a fine for the three-field
> struct.

Yeah, I think that's the best way forward, thanks.

> Thanks.
