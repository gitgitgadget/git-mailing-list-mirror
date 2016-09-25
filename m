Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033C9207EC
	for <e@80x24.org>; Sun, 25 Sep 2016 11:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbcIYLDX (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 07:03:23 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38337 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbcIYLDW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 07:03:22 -0400
Received: by mail-it0-f49.google.com with SMTP id n143so52391682ita.1
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e3qoCSJssqRHrp3IQocIwZy4XIWtjZdpB5oXb6g9ei8=;
        b=mMLtyBG7lJKsElSqPPDCjeRt4f/oJvwm0CnXzZY7Bc168F6/OCKSvtSxd7lhxWdbzC
         9nrgqvnJrl6L0uCd3wVG+12UfFmcwrv2pJKBFMjX4aEk+tIia+2JOuss1Iv8kg/KY99D
         ad7HrVZadS2AVAo05A8RDxhJovuB9Gt4Jm0q55tiAJ9W1vjESL5eazuH4fkx1c2z39cH
         yIFojEuoh380LHSdL5ITinrx2QQlXXuQtMQHCikP+FSEy5MvV5PWUnzX6S2+Xv/wpDEn
         QBMzpxg8JXQEW3u0HfplG5WkK2XJ4ZlGjEVQs09MWyoqZFCaK3WAp2L7mcvhbfujKCGY
         rVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e3qoCSJssqRHrp3IQocIwZy4XIWtjZdpB5oXb6g9ei8=;
        b=jwC2LhPk+2X01yNekGhvTMkjvkjI/I+oKCr7HR3yOht2khqBMCdn5IJrhx4pqtm5gK
         qp2cwsSrHexZZ6CBDtuc/7YcJF61GnK1YeKfCtTfN0UlCWCJzNs/pz/1JN7c+ejfrhmb
         5I8SbPxhfHBa6ZufyHMlfAmPbUdhF/+CAMA9k3hWIB0IHhkHkv1N/KNO3RVklyZnWydB
         lSoFuWJryCyvPkhioSCnoVbq1cJKCWy9ykBktV2rEZUPJ1gM++43Eo51vqBzGmoMfJZM
         ZIfEBu5EPWGvlWCaLl3Fg5VYefckYFn6aoPbwqklsJ52/8wwiWhjxXr3JZ4j+UtL02mu
         aUMw==
X-Gm-Message-State: AA6/9Rlhp7gU7sxswBjrTIYtZ9jZ3b4AF+oydQmAsR18qpRfOeKXE+LF8O0faaToWQCDJ6DhBa4cw/HQV6eulw==
X-Received: by 10.36.228.7 with SMTP id o7mr12871639ith.30.1474801401247; Sun,
 25 Sep 2016 04:03:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.138.195 with HTTP; Sun, 25 Sep 2016 04:03:20 -0700 (PDT)
In-Reply-To: <CAGZ79kYF6nYL42VQ_mbVzD+2QFLPELe9-8DOQjbSwArM20SCKA@mail.gmail.com>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
 <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com> <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com> <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
 <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com> <20160923034113.4rnps3nogvzxkfjx@sigill.intra.peff.net>
 <CAGZ79kZ+LTd5PuT4+Z9K6d+GQ-33E=tLY1Fokbp22uNoygaEtg@mail.gmail.com>
 <20160923060643.3ubr5gn7qczzs2ut@sigill.intra.peff.net> <CAKoko1p+M3X_y+DH+65fUDRZjkiZrKE3Z-jjq=RSjqoi7He8pw@mail.gmail.com>
 <CAGZ79kYF6nYL42VQ_mbVzD+2QFLPELe9-8DOQjbSwArM20SCKA@mail.gmail.com>
From:   Nazri Ramliy <ayiehere@gmail.com>
Date:   Sun, 25 Sep 2016 19:03:20 +0800
Message-ID: <CAEY4ZpMm3o2fNb6_3zQYq5x2_EDquGoBPyoafGrrfYQ9B0qouA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 24, 2016 at 12:34 AM, Stefan Beller <sbeller@google.com> wrote:
>     git -C path/to/sub --keep-prefix ls-files

Note that the above can also be written like so (and works
identically), due to the fact that -C can be given multiple times:

    git -C path -C to -C sub --keep-prefix ls-files

nazri
