Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A7B1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 04:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfIIEBB (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 00:01:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42808 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfIIEBB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 00:01:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id c9so14617403qth.9
        for <git@vger.kernel.org>; Sun, 08 Sep 2019 21:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zvyfTJ8vqsMjIFEsT3f5iKqgM1IPSpciUy95V0ujEI=;
        b=KQ4LhuGm9vggRf92BA9xeRH5X5k4S7mllp9lZ9uY0968e/BSQhhhmBww6nBreU8SzV
         WeMYY3PrIqoF69/7riKbcqri8s2jVKUKejiL/Nxpd6yq1xN7mWSwnlBygQECXSHELVII
         lj0iTUyw8a6gYP5B/rHkLYX75HWNgg79WnuXuPagNU77nozHXr9XRv9xVJhC6pUecPAr
         iZduVReg1qZ0e9/rv7r60a1xpkU+BjruvYidINfBzrn3znTRhz3X58rKjH0bZruWv8k/
         h9Q+cFl5UhVE3RlyEwrGq2GsKmtp4FkphafwJiSOng+qd/QT1ubBXYnV1eekcyTF9JpL
         sqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zvyfTJ8vqsMjIFEsT3f5iKqgM1IPSpciUy95V0ujEI=;
        b=Ws6NagYb9OTHAjMM/MBBZJf9y+T1+4amvzfz7PO6y+sDzYIOuh+AG0eFJwtx/7XXvc
         SZLG2279rlcM4wJVOWU/WINRMF9dMc/TWexzvMlkfTwFYAgI3ex0fIVaQNdmA49SwNe4
         YcgIXWzSNnVnA2QcT0/ECjHoDLtfU7fQiBjGLPO6STxsBViWFIS0PszDVYmpng37iJNx
         ovxaDVxV8vDKyu32y6nXU15TWl3NMMpBKtkmRVc7AzSSTnBJcnKQVqf0itEDFC/N9jxI
         lt0JGgNyHZo2iY7RobscAdIfKEpRuiZJ/iLGKPuxBdOC0UeDLUpp/tthFVexjLy+JHgb
         nQFA==
X-Gm-Message-State: APjAAAUFB+xTwuvm9xe3bVaMUDw/7aA2v6xrkNzJFLksENOkZkhXuKpS
        FYI3hgPTVmh7ippKZiqf/DXDXib9gaKlIUojA7k=
X-Google-Smtp-Source: APXvYqzFIOgYB4oywTkrpCQlr1MD0ogSi+TzVdpGuakVlfdrqPfb2DPY529Mlkx4DY7nfa/oHmF+OdFTkoR9u6Vs8C4=
X-Received: by 2002:ac8:3364:: with SMTP id u33mr21523843qta.187.1568001660408;
 Sun, 08 Sep 2019 21:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190907213646.21231-1-ericdfreese@gmail.com> <20190907213646.21231-2-ericdfreese@gmail.com>
 <20190908100543.GB15641@sigill.intra.peff.net> <xmqq8sqyn6ek.fsf@gitster-ct.c.googlers.com>
 <xmqq4l1mmn8i.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l1mmn8i.fsf@gitster-ct.c.googlers.com>
From:   Eric Freese <ericdfreese@gmail.com>
Date:   Sun, 8 Sep 2019 22:01:33 -0600
Message-ID: <CAAikoA+MvORDJ6y=VSk_1s6v7110UeOfU2X2G7=9ChV+m+COxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] for-each-ref: add '--no-symbolic' option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 9, 2019 at 4:34 PM Junio C Hamano <gitster@pobox.com> wrote:

> I guess with "%(if)...%(then)...%(else)...%(end)" you might be able
> to do either one of --include/--exclude without supporting the
> other, e.g. "--include='%(if)%(symref)%(then)%(else)not a
> symref%(end)" would be usable as "I do not want to see symrefs" in a
> system that supports only "--include" without "--exclude".

This has made me realize that I can get the behavior I need by using `%(if)`.

Exclude symrefs:
  "%(if)%(symref)%(then)%(else)%(refname)%(end)"

Only symrefs:
  "%(if)%(symref)%(then)%(refname)%(end)"

However, this still prints an empty line for each ref that does not match the
condition. This can be cleaned up by piping through `grep .`, but what would
you think of adding a new optional flag to git-for-each-ref to prevent it from
printing empty expanded format strings?
