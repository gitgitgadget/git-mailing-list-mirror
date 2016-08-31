Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33E9F1FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 06:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbcHaGWE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 02:22:04 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:36153 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbcHaGWD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 02:22:03 -0400
Received: by mail-yb0-f172.google.com with SMTP id 125so14064310ybe.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 23:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PCJ3wskX5Sc6eN1+3oLMuoDlsUwWyGHs7KZogcQYKMc=;
        b=Txn6RAK5p5lWP5/MciON7/cva/QZDqdjpp9KI/ThEtrNWpjVGPahSTgxKXX74tYxaX
         g9JFf6Ve4R9S9nUOHMiG8pgl0YZTSPMPSm8vIF+zLM96Bl+YN9dDTxq0vMc+Ale0R9/1
         QdxBswPecET4sGiD3/NG3w/K/dU9qU2IMvI28Ny98ZfuHGBqrBVQEXtb00T9lS1FvIQ0
         /HA3TSorK+Z6ji6fRE7re0TgptuKIJ04UDgtT/tRENifU0i2CNohYENWcoSbczf2D52h
         D1k0tTZxcTmPiCibjs7kaLm1g2OjTWRnzBsZ/eNdCu+DEWgQHAwZAlScyvWcjpNY15sM
         gVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PCJ3wskX5Sc6eN1+3oLMuoDlsUwWyGHs7KZogcQYKMc=;
        b=mumFYcvUb7oeMP3kaghCgw3wETG5p9mGJvpFCzTBeQf3POzyvh6IDo1zOj/+CZRY6T
         vUYQOlv46cHtHIlqCwIXiOgU9nuVIPi7LQdT5FmdGceL9whWhHiM5M42n0bQHO1QhxYy
         UIN4n2KE5djTVw293Ea/AZQKBr0B1zsKKa2uClAhxel/aD64TJ/cuTziKjBBKj0sV1tc
         3wYxkS+bL2ROKncjiCqrA68ykBnkrJ/n1HGR+LtvFln8QmT1NCwRo38PcjU4T4ncKaFW
         NflSl7j3jENcSQn3osQWXeeCJ3wJ18r6jUyF31oEVjImdmZdH5LbEq9CYEH257YrWXsO
         ZhQg==
X-Gm-Message-State: AE9vXwP8Bvrq5uq649P6UzAyNk4rM95uZGDGD2ym0/3Y0mfKq9EjkNGotbWze0L+AyZlBe8/1O+XO1RgxcEnSA==
X-Received: by 10.37.60.67 with SMTP id j64mr6344541yba.111.1472624522682;
 Tue, 30 Aug 2016 23:22:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 30 Aug 2016 23:21:42 -0700 (PDT)
In-Reply-To: <CAGZ79kYAHXct0Fz-sw0-FbN5-Mij-C4Qwak_S0mxKHyW=U5jWQ@mail.gmail.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-9-sbeller@google.com>
 <CA+P7+xpDqkTFLUJBhSwWiVnXw-iy1fmGBWzVBLmybOcPOmevBw@mail.gmail.com>
 <CAGZ79ka6nwYjBRcUKAxCqAodq=Hw6f86J0Mq6GWyKgMO_PNi4A@mail.gmail.com>
 <CA+P7+xpmyx+QsdOpS7JC1i9Z6cdsy_=MK7J_rGYiukPsqAJBVQ@mail.gmail.com>
 <CAGZ79kah4sY0NJkaqDiUqcwsCHn0SECkMjN8SoXQ8vGi6zRkuw@mail.gmail.com>
 <CA+P7+xrokr0ZGidQFuvpN+-J_WDjkaUropcnPGVjZHafc12AnQ@mail.gmail.com> <CAGZ79kYAHXct0Fz-sw0-FbN5-Mij-C4Qwak_S0mxKHyW=U5jWQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 30 Aug 2016 23:21:42 -0700
Message-ID: <CA+P7+xoc12ns8OriSQQwhKJPSTuG8hniOcUkbGbW3fZYZiqViw@mail.gmail.com>
Subject: Re: [PATCHv5 8/8] clone: recursive and reference option triggers
 submodule alternates
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2016 at 10:04 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 24, 2016 at 4:37 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
>> Yes that seems reasonable.
>>
>> Thanks,
>> Jake
>
> I reviewed all your comments and you seem to be ok with including this
> series as it is queued currently?
>
> Thanks,
> Stefan

Yea based on what's in Junio's tree, I think we've squashed in all the
suggested changes, unless there have been more suggestions I missed.

Regards,
Jake
