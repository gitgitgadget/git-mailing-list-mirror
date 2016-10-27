Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9153C20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942775AbcJ0WjB (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:39:01 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34391 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942458AbcJ0WjA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:39:00 -0400
Received: by mail-oi0-f66.google.com with SMTP id p136so6993341oic.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=k0iTLfgUklS3uYM+R2wKJvyAjJoo148qetEPYElMJNc=;
        b=ZDTCfvvujFR4W8H58ygEnDa9N8YP70V+NyBF2fsuUrqCKkS/n0tr9geta9l8VGynNC
         6ShMQbKruR5d3uxiicGBDT39sYzmKr7jpZcMH09ktp87YZJLVYZTV6tDvt6RWVo0jdt7
         JrxnkJFVPt/8mp4YyFFn0LcTD0cLdxG3+UEE0cjqy13ngQdSxyUYi+s/FhM4w80jh6x7
         jfXcVpVLs1u0NBN6Mt7D90wElY9/o/2xCMOvpcFIOySOwNhPJJdzI9ZqwffqsW5/2IBN
         Pj9hz86RDIn25WdBdpUfm16BPjO1JoQiV4+4Cp+eQd1eC9TPUaHEZIdJ+aOMKyidZUAS
         U5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=k0iTLfgUklS3uYM+R2wKJvyAjJoo148qetEPYElMJNc=;
        b=cba73d9KwRP+6gMfOKaG+KWXIRTFA40dej2Jtes8xShs4h6xdoMsuKVjahWxJneaAF
         7z/fbmzem/id33bm0Z99mxlGUBO9AHSgIH6IKk4YqNRUi+72oQfhOPqgCN8/w3QezV4x
         a4gEbrX56yPdn11vMVOflXPaEscgGNWefeZRMzS+NJOzVbZy4Mr1ZOkEcUX8ehFQ/mQW
         2nDS4S4Aklc4/+qhyzrhE8qcLTkggZlAlA6Ju8sjrVqh22Zs12UNCuHuzecJgw46cbqf
         i8+0DdpkBH2n1N7hBzX6aUUSkV2gm3hVPC2ivnE9WH1VsfADYY08Pr41jqztJMp5TGWt
         ayPA==
X-Gm-Message-State: ABUngvfsV/dQHnM+IIPF6fr016CoFGRbEieLRc9PZ0egX2rxWpmgMNxyT+uj7qhjkXz8Wd8APM+G9XOc3k8vHQ==
X-Received: by 10.157.60.24 with SMTP id q24mr8579648otc.84.1477607939814;
 Thu, 27 Oct 2016 15:38:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.142.104 with HTTP; Thu, 27 Oct 2016 15:38:59 -0700 (PDT)
In-Reply-To: <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com> <20161025181621.4201-3-gitster@pobox.com>
 <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net> <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
 <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net> <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
 <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net> <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
 <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2016 15:38:59 -0700
X-Google-Sender-Auth: y2FH0gclhNwLk71SpFFsDIMXWPA
Message-ID: <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 3:24 AM, Jeff King <peff@peff.net> wrote:
>
> +cc Linus as the original author of 144bde78e9 in case there is
> something subtle I'm missing, but this really just seems like it's
> an outdated optimization.

I'd *really* like to keep O_NOATIME if at all possible. It made a huge
difference on older kernels, and I'm not convinced that relatime
really fixes it as well as O_NOATIME.

There are people who don't like relatime. And even if you do have
relatime enabled, it will update atime once every day, so then this
makes your filesystem have a storm of nasty inode writebacks if you
haven't touched that git repo in a while.

If this is purely about mixing things up with O_CLOEXEC, then that is
*trivially* fixable by just using

     fcntl(fd, F_SETFD, FD_CLOEXEC);

after the open.

Which is what you have to do anyway if you want to be portable, so
its' not like you could avoid that complexity in the first place.

Note that you can *not* do the same thing with O_NOATIME, since the
whole point of O_NOATIME is that it changes the behavior of the open
itself (unlike O_CLOEXEC which changes _later_ behavior, and can
always be replaced by FD_CLOEXEC fnclt modulo races that are
immaterial for git)

             Linus
