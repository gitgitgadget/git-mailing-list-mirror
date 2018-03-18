Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292C61F404
	for <e@80x24.org>; Sun, 18 Mar 2018 02:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeCRCWA (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 22:22:00 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:47098 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752548AbeCRCWA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 22:22:00 -0400
Received: by mail-qt0-f182.google.com with SMTP id h4so8963728qtn.13
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 19:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ASd84+mDbl/k1wjjMgQ7+ubxre385kKDNu4IBXmVfok=;
        b=o9jxTS6W7RcgaJ9JPN0E604FMolpdui+jAY/tqI+drWn8xU6tJzJXGrdIr6f8KPOnF
         VQG4ehVgBklbkFJVBeDc/zR7U3k7IhshsOehZMwRafutHi8pVeXSVRQGyG3YhJkx4G7U
         WSoPlTQCDBj6IziZJ45q2MsuWTIZgVbebDDGNtVXUgw/80YyFdySODIk9tfjn7yvDYO5
         IG+mJSo8VoeYWt30TF/z/zd6S09i8knw6oH8VzPnwSYBR98glRwuGp2o9n/pdqHIrGLq
         asCS6vRM01nhBiEPQczzqm/ryoLtHPvDhFAujkK9uQWJUiFvZUCr9gE+Enok5LfZWe3F
         cANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ASd84+mDbl/k1wjjMgQ7+ubxre385kKDNu4IBXmVfok=;
        b=JLI1dR+Qd8chj/1Vunm1pTFXWXMg7/WY5qus/xcSCDwMN6tPENaluUYb8mbI9yywUX
         qfAIgixgvxXLZ8o11JWDtsfmH4xhsC4xorlp4Qwf0lvXNdBkWLqXcmoT0RIACaqLvmP5
         jTOZT2khdW4A7mCdZ43o3puJwUyKJ7zp8asVn9q/tuGkVpMpltJWo7tsNUr+XmUYR4vb
         dQKZUKGYaFHgei3UzXzu7Rv1dcQ0UmEASomxQ51Dn01C2FKcO1K6Td5+NzghCx8dfptB
         pn1dg+vZhMQ2rAc/YzX9CMQ3QyqPFznjj/J2Rl7bNO3CmL33MT2jxi4zB6IJ0RuNU9Zr
         8I0w==
X-Gm-Message-State: AElRT7HsuOR+UQc5DZwbES27qCOXo0fgt0ZQjS6GmJr+5qMNh8PNk/68
        SDdWlfmnPNBr78Dt88SfR8v8kRa9KZVuaQQXSUI=
X-Google-Smtp-Source: AG47ELuWlkZt4qHkuqeKQUCvMwLwr3mwO3lPL0Q45Ada56XaWbOxvfGVmufswIj/Wi41LXU+LumQF4vv5JnKn3TotbI=
X-Received: by 10.200.69.131 with SMTP id l3mr11403025qtn.50.1521339719347;
 Sat, 17 Mar 2018 19:21:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sat, 17 Mar 2018 19:21:58 -0700 (PDT)
In-Reply-To: <20180317075421.22032-23-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180317075421.22032-23-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 17 Mar 2018 22:21:58 -0400
X-Google-Sender-Auth: Id1btGJ6FNiTqEBBeyU2t9Wqb-k
Message-ID: <CAPig+cSA16Da2Q=8Q7iUVF4smAyhJMe5qV-tvevePzj8BjEuKw@mail.gmail.com>
Subject: Re: [PATCH 22/36] t/helepr: merge test-read-cache into test-tool
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 3:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> t/helepr: merge test-read-cache into test-tool

s/helepr/helper/

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
