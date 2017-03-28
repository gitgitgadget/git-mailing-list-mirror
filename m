Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112AB1FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 13:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755584AbdC1NE4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 09:04:56 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35648 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755574AbdC1NEz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 09:04:55 -0400
Received: by mail-lf0-f44.google.com with SMTP id j90so37509893lfk.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=X1RgPlh8uTVbxqmdAeAKbhSLMBaR5JAmqsYkEhjP/44=;
        b=kDiURX0mOnDC0jVS5rqitTe23TBmkwYwwwGNUFztwD5ge2sSmCoBdraqLQSWumQnd8
         WN4bpaCwkUgYrtNCqglTG0HSEX31a3sW7OGKD5hAE+tXC+UQ7cmRsZ1thEdNpSjidFFN
         oDLr4P+QiVlKWypbeJLYWFu5Z4mHnrgitbjQehrPcb3fEqGTRWVu67V4df9wreYroX91
         Mt6o1aNppFue/gbm1BsmYcU+zIpPvxzNmp2PGeK3ijlsNXuRwd3nP2PBfO/ZSgOsmz4I
         RM8vpAjNEAkDwJ+Xxqcv2biuFbidKkYFf5EhJ8Ew3Npi/pHuas0EEoGRFFTRuOVQDb8j
         SDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=X1RgPlh8uTVbxqmdAeAKbhSLMBaR5JAmqsYkEhjP/44=;
        b=oY6Q/2PXlWqlZ7U83fWAG2dIl6zBT0u1cr4nk0EupZkbxSXHUmRQ4lqBWx3AACVfvt
         C36OqEeJSTSziq3PRq3YuhUzmuoWk7D7411IEkk+8ZR8tht+NQHwYtRr2T6nsMMdCDt9
         DlWDI3BRX/AOilb1IsJZqvwZmHqXZQAnfqRiLaJI3yCO4rg0TuRi0CvBx+9qM15QHJUv
         ovQmj3yXD7kGdj2h/YR2LwaYJnYmr8PjX2wLo3QmpSOJ1l8xgRe9IIU86XZvsYT2E24q
         BVK5ADKwFGbA/Bw9u0r/VcLeZGdcgNhygqbpg3y7m+s9hxrhKNbIWyeVUxLPqBGt4nRc
         NrEA==
X-Gm-Message-State: AFeK/H0EIEb9jxqQwMMvLzyq6TkKs0/dIRur2P5OboArUUsnIufkzldYDdlFl6vp4/EJhk0BWYO/IfgtOuX5pg==
X-Received: by 10.25.163.193 with SMTP id m184mr11830921lfe.114.1490704296104;
 Tue, 28 Mar 2017 05:31:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Tue, 28 Mar 2017 05:31:15 -0700 (PDT)
In-Reply-To: <20170328104652.XsS8a6ysu%pickfire@riseup.net>
References: <20170328104652.XsS8a6ysu%pickfire@riseup.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 28 Mar 2017 05:31:15 -0700
Message-ID: <CA+P7+xr+vJP=usEhnR2gZdNY+k8035sX9FgFvvrrL5j_xCu=Mg@mail.gmail.com>
Subject: Re: Microproject | Add more builtin patterns for userdiff
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 3:46 AM, Pickfire <pickfire@riseup.net> wrote:
> While I was working buildins shell patterns for user diffs. I noticed that
> the tests t4034 passes but I can reproduce it manually with:
>
>     mkdir cpp/ && cd cpp/ && git init
>
>     cat > pre <<EOF
>     Foo():x(0&&1){}
>     cout<<"Hello World!\n"<<endl;
>     1 -1e10 0xabcdef 'x'
>     [a] a->b a.b
>     !a ~a a++ a-- a*b a&b
>     a*b a/b a%b
>     a+b a-b
>     a<<b a>>b
>     a<b a<=b a>b a>=b
>     a==b a!=b
>     a&b
>     a^b
>     a|b
>     a&&b
>     a||b
>     a?b:z
>     a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
>     a,y
>     a::b
>     EOF
>
>     cat > post <<EOF
>     Foo() : x(0&42) { bar(x); }
>     cout<<"Hello World?\n"<<endl;
>     (1) (-1e10) (0xabcdef) 'y'
>     [x] x->y x.y
>     !x ~x x++ x-- x*y x&y
>     x*y x/y x%y
>     x+y x-y
>     x<<y x>>y
>     x<y x<=y x>y x>=y
>     x==y x!=y
>     x&y
>     x^y
>     x|y
>     x&&y
>     x||y
>     x?y:z
>     x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
>     x,y
>     x::y
>     EOF
>
>     echo '* diff="cpp"' > .gitmodules
>     git diff --no-index --color-words pre post > output
>
> Surprisingly, it shows (which is very different from the expected output):
>

The diff test code uses "test_decode_color" function which decodes the
color commands into human readable text. From the looks of it, you're
trying to reproduce the test outside the test suite. However, you're
not decoding the colors using the test library function, so it doesn't
look right.

Thanks,
Jake
