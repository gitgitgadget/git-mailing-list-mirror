Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 613C61F404
	for <e@80x24.org>; Mon, 10 Sep 2018 20:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeIKBGP (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 21:06:15 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35770 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeIKBGP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 21:06:15 -0400
Received: by mail-wm0-f43.google.com with SMTP id o18-v6so22817959wmc.0
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HE0wmaS42EsAMCqZTdn0rt7L+SfolXUiUpRTrC5lFNQ=;
        b=XY1tYyBevDYOG01kESSYwS6Cj+Qt8YQ4xdIpQHHHDWhojWv2LJMLDvnl8lz9gtLgeB
         cdhIEXBna6I0X92mdlanBov7Fhm5tqtfvhLX0REOfsG8Bsdh1hy2g7w9yWQhVoyssBzf
         8ooqSHtz/X9t+KUiKx8ZhB79TtEI2TLgzUaj1eb4V/hBrKiAiB8qE6dB9xAfFiwkS/k/
         frUl8eGfdknXSD29MTQUWddVOnvCHtcnQ/QTic4yjvZ3/ZO1nR16kp2oRAAtUmb95fhn
         RmDP3ppeTvvYQeY6PLtOSCDC7mc4orKrULRFLYmwiGkN/cH864lxzj8Io14Z2gCAQUq9
         Ymig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HE0wmaS42EsAMCqZTdn0rt7L+SfolXUiUpRTrC5lFNQ=;
        b=Ij9P8xDEKUDuwROyuF2SXTu4nDNtPHTM2NfGeWGA5GWr625mZeUgP2O980e8hJVrI+
         qq+ik/hSh618k3UxxcC7DZvGAG4u9XabFLbbp6rxLU+VYwcLDg82dLTbLD2o4XlAORvu
         hEvLBtAldy2hf3dzTEt7Ihil0sWZga4cMZkC9K7YDVg4bK3APA3wn0eE9I8ALt457Gp9
         Sw1L4oPd5p0KvbAz1GCn9KGTCeSWpj0ZhuJVhS1ZEnOI+XujSrGoXH8jZrRZ0UkPc1wJ
         r/GXoe74WwSbKP6W3C+mBawGF8pDUeNE1gtuT/7DEwpadjbqhLPnNiaAVLdWZTGzxSbZ
         RZvg==
X-Gm-Message-State: APzg51D/8rBcjceUp2330nGLxWJ35na8HMCGPKy/2M9BrRbHCRe57aPO
        uYV4T+aI5MYS19N6abkpwi8=
X-Google-Smtp-Source: ANB0VdYbhnpvAmhW2quyv5NEzxftl0M1aDUNyS2w9LttJleTVkqlm8W8pDRKUMLgvLS3RPMaTmSDtA==
X-Received: by 2002:a1c:3314:: with SMTP id z20-v6mr1694580wmz.95.1536610229673;
        Mon, 10 Sep 2018 13:10:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q5-v6sm20650553wmd.29.2018.09.10.13.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 13:10:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stas Bekman <stas@stason.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
        <20180908212256.GB31560@sigill.intra.peff.net>
        <xmqqr2i1thbs.fsf@gitster-ct.c.googlers.com>
        <20180910171422.GA26356@aiede.svl.corp.google.com>
        <xmqqa7optdbs.fsf@gitster-ct.c.googlers.com>
        <20180910183557.GD26356@aiede.svl.corp.google.com>
        <xmqq1sa1tb4p.fsf@gitster-ct.c.googlers.com>
        <b6446834-04e1-ca65-350e-5847e689e2ea@stason.org>
Date:   Mon, 10 Sep 2018 13:10:28 -0700
In-Reply-To: <b6446834-04e1-ca65-350e-5847e689e2ea@stason.org> (Stas Bekman's
        message of "Mon, 10 Sep 2018 12:52:29 -0700")
Message-ID: <xmqqk1ntru4r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stas Bekman <stas@stason.org> writes:

> [include]
>     path = .gitconfig
>
> Not realizing that the two were not in the same folder. And probably
> assuming that .git/config was referring to the root of repository, and
> not relative to .git/, which is a reasonable assumption.
>
> Of course he had no way of resolving this as git wasn't telling him
> where it wasn't finding the file. i.e.
>
> Can't find: ~/myrepo/.git/.gitconfig
>
> which would have instantly told him where the problem was.

Yeah, I think Peff's idea of introducing a variant of include.path
that reports missing file would make sense for such a use case.

The code needs to turn a relative path to an absolute one by taking
the value as path relative to the including configuration file, so
we should already have the path to use in the error reporting, if we
were to go that route.
