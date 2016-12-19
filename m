Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 423CA1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760018AbcLSRdH (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:33:07 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35775 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759595AbcLSRdF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:33:05 -0500
Received: by mail-qt0-f171.google.com with SMTP id c47so153603013qtc.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 09:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=THgCIIS9jN3Bvlxlo67Wcq8/qBzV4MFDCiBA1zXaFOU=;
        b=ToXiWtCTeWE0MJljZkyxO3j8D65naLMtTby2Yy7SARiGYZMNUcfzxW2nvYN05ei3Ji
         /SIo+EuDmR6OxUa3LS1Nd9H+qB0KPrBprQNC1T7gEXsUy/gEhWxbGMAUBXbrG0H5pYLa
         1sqwFfaOw6f1qs8x7KfGtxS83S8zCsRP7KZj+fwXDCvklubyV/xVKwwcyDve3kWt805l
         sJkunlmNJQ3Pxp4OmX2q130POwi2sWs9/Z3uJeQTzLJxZoiplnWzctjQ2kogwT/Gwjl7
         o2GeQKbOBxurAlBhLaCRRcvS7ANMW/sSVBA4Sf8yL3DL/4zmSxpAnIg7SyrHkz0N9evC
         RmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=THgCIIS9jN3Bvlxlo67Wcq8/qBzV4MFDCiBA1zXaFOU=;
        b=JyYSUoZCptBuL5likwkWCkl92DVtkNjLptQSFHQIhXnuYghdqEXTF50MfmERYar3o7
         SVTPSk6+ZP2RIJxtrX32rSf+/gczWfkpHk9c1u79ioPbbi/hX7AJx74LpSGcR/Xn5g3l
         HDbqiTkY8Y8pSRtevg+zqUuBJuUT54zFmdw1LzYraVZ2LACnYIqqWVlK0Wzs6vyCJPRy
         Q7pH1HJRCQDqeW99SU78xHyRaVTBFl4K75LpAKRDJPF0S+Idp3Nd5VyfNffqoJvG3Ztu
         gVLKGDR5r87N0P2uwc9jSQbYJMzixs+U29vgnXYWbB++IJ16NW3SRpP5zXPWu9QWWJZ9
         3YRw==
X-Gm-Message-State: AIkVDXIHnMjrS6iubbH9WVfT8iE3zs8+aFQFt8rinr6pMxUYzPNth80IHm4mtZPoPwBnhh9vXcrlngGMVO97lFr8
X-Received: by 10.200.37.221 with SMTP id f29mr18082679qtf.123.1482168784137;
 Mon, 19 Dec 2016 09:33:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 19 Dec 2016 09:33:03 -0800 (PST)
In-Reply-To: <1481670870-66754-3-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com> <1481670870-66754-3-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Dec 2016 09:33:03 -0800
Message-ID: <CAGZ79kYNhz6mSqa0vtjCOcRWydgXGdgXZW6BsAHheTnWUaJMuQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] dir: remove struct path_simplify
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 3:14 PM, Brandon Williams <bmwill@google.com> wrote:
> Teach simplify_away() and exclude_matches_pathspec() to handle struct
> pathspec directly, eliminating the need for the struct path_simplify.
>
> Also renamed the len parameter to pathlen in exclude_matches_pathspec()
> to match the parameter names used in simplify_away().
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Looks good to me,

Thanks,
Stefan
