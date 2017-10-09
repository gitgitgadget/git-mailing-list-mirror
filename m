Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7EC120404
	for <e@80x24.org>; Mon,  9 Oct 2017 18:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbdJISUx (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 14:20:53 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:50769 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdJISUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 14:20:52 -0400
Received: by mail-qt0-f171.google.com with SMTP id f15so44841348qtf.7
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4MUv7X3+TvpciSYRKM0gApF/eyBjOxub/v8SmWydw78=;
        b=hNRqHK1YXcfCvU/0M0cLRczPq6Rda5EAxBL87BeuUyOhI/knVoFG3a3/yRzhM8x0Tk
         viG4ujgNvWWZEf6hQsu+eEfUp0O4gYXbzbGU58Oes1yYONmI9EglDpfhQxoWlBtMCv6m
         SHwwe057oek0B87CkymoGqiwI7OTSK3zowq8MOslj0CS69XBaLAhv0kxtkrKJ7FcqyCD
         65DDoYhbQIFAAUK4R92uNjIrL5WuP3Q7FaMD8jXpWjZPxeq2nmIJ3bX84IEQc49jNGaw
         gTv8knr9+VJ7GTyWHyOuqvSA060Y9HlcVhBjz/pulTv1DdLp9DdCH1B7czRFJ8Vs7WMt
         LBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4MUv7X3+TvpciSYRKM0gApF/eyBjOxub/v8SmWydw78=;
        b=KnmqWEVy99GStEDVf58qKlh2bAgieDfzqMcysFuPqCD/CVrDulRJYqF8HM1zw6z62Z
         oPxvQqTfYfJZiAByTkV7SUXIAnpLD1Oq1+LLaAmcWYacFJj0PCcUAzumbimvlO5cm/YH
         7cnDI57qrN4dzEcZfwzA3Uyizu/gf6Z8vIt683I3rcL7KY/UOxSjvLt/SHGv01pr/587
         xsLPnPkOFWhSXYLfwjCURgmCHywhA/JGnrVaUO0iIyM0+HsFEtBeDuyqCiSgjhb3ncL7
         NYmAeL4v9pHCmeFSzsVrjGm/PAFZniTTQicrsDWNBTiyMdCcPIv6PC4WJsLNxtgU7Ie6
         bOjA==
X-Gm-Message-State: AMCzsaVMTGYXcXazCeRNhpKko8I4Q//c+EvSwAzGs5IOvBkecLZA5hwd
        BgOMtIRra/zGRYqHO3cCTyYA9tHKP43ohkZmbiy74w==
X-Google-Smtp-Source: AOwi7QAhFGmIqMfu4twK1toNXtxdCFr77gev4AVdATQefyHs9GKK9+enyDBeqq+QD9k/x1LoPcsG1vxl7dkicbdyEKQ=
X-Received: by 10.237.60.37 with SMTP id t34mr13103014qte.224.1507573251625;
 Mon, 09 Oct 2017 11:20:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 9 Oct 2017 11:20:51 -0700 (PDT)
In-Reply-To: <20171006223234.GC26642@sandbox>
References: <20171006222544.GA26642@sandbox> <20171006223234.GC26642@sandbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Oct 2017 11:20:51 -0700
Message-ID: <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper
 repository setup
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2017 at 3:32 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> NOTE: The argument in this message is not correct, see description in
> cover letter.
>
> The setup of the repositories in this test is using gitlinks without the
> .gitmodules infrastructure. It is however testing convenience features
> like --recurse-submodules=on-demand. These features are already not
> supported by fetch without a .gitmodules file. This leads us to the
> conclusion that it is not really used here as well.
>
> Let's use the usual submodule commands to setup the repository in a
> typical way. This also has the advantage that we are testing with a
> repository structure that is more similar to one we could expect on a
> users setup.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>
> As mentioned in the cover letter. This seems to be the only test that
> ensures that we stay compatible with setups without .gitmodules. Maybe
> we should add/revive some?

An interesting discussion covering this topic is found at
https://public-inbox.org/git/20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net/
