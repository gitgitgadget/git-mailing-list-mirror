Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2080A1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeCXHw7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:52:59 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43189 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeCXHw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:52:58 -0400
Received: by mail-ot0-f194.google.com with SMTP id m22-v6so15694893otf.10
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackers-mu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UT3bk7KDka+lh39BCurS15MJBxccSxEGNaGgWiN6jjs=;
        b=QArqzDIw71DK+nH+VCs/c+QML8doil6y3eYJUS1uc14jP/kQyGmG5/BPtGXWVGGUxP
         vRCCYdv7nU5YgqQVtkB0HCQ9jrnbHwB5hc9KtsMd5F6K3xTKaAUzVTnWfrZkgo50ciZt
         /Dlwke+noN0Htd1bpZbVvIl5srJSkGk/fr0aFzMhB1OL+ML8OcF0K8zjXclXNERSGDrU
         KPr5w2N9q8xapnNParqxoJhh1kp9fRiizgVVKAPtmHoBSHexO8pq8jNiJZt6vVEO/lV9
         wuKFKDBAAN8sz3h742VLpqLvFWTpGJfRItML4Og97wwsdccJs7UaWuFEwKHcsF4Nd34A
         DQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UT3bk7KDka+lh39BCurS15MJBxccSxEGNaGgWiN6jjs=;
        b=SWmfdQFLBqv6q+MqIgdsRIDWRX91xmr+Ct4pNFgwoFJYadfltxjEXrUS4BrgqCJCKx
         IQKIfTkZXr9SyRJZ0S1zUZVUyRU2z2c+nGlH60aw33nKhEBkadYjjzqa+Dcxh7/UaQqk
         wTu3OibTGbHTdLdNXspfcfO8uHVdb7zLe83/baSRZ8n7sPAdOpQqT+ekHRqhQ+CYyObC
         hf2ThAI/uBApQBo5QGRrxuqrRCqv4HFpJlit1EkoXIL23uh3pmT/u0sB3yvKbYdRnXzs
         +KIDFq8+F5Oj7GoyF3ven/1P50NNhTgMDN6KBRN3+K+WwvB8+45gEoLNxfn8FbpaKIw7
         pI+Q==
X-Gm-Message-State: AElRT7HZdyangI6r9LiSjDEN6hVOP7aa0RCB7VVllswUSteUAP4WSggP
        BcKGOdVp9e0cfrJiok6pEp2A3FQN8a1oBZ/L2aTPuw==
X-Google-Smtp-Source: AG47ELvMgmywT6IOS6iZfBOmMYF2wNQABn06DrtzZ5vSQ4JzZ/aPcake51J47MAKO5ZWweg4PBDa7Qix8tF0quVdNFg=
X-Received: by 2002:a9d:419a:: with SMTP id p26-v6mr14337856ote.350.1521877977445;
 Sat, 24 Mar 2018 00:52:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.197.137 with HTTP; Sat, 24 Mar 2018 00:52:57 -0700 (PDT)
In-Reply-To: <xmqqtvt6h2ic.fsf@gitster-ct.c.googlers.com>
References: <20180323193435.GA21971@voidlinux> <alpine.DEB.2.20.1803232246020.16250@tvnag.unkk.fr>
 <xmqqtvt6h2ic.fsf@gitster-ct.c.googlers.com>
From:   Loganaden Velvindron <logan@hackers.mu>
Date:   Sat, 24 Mar 2018 11:52:57 +0400
Message-ID: <CAFDEUTf_KCn7Sqs+O8JJfBXo_+QfvAmiT2uzmM_ROWfXUdF0Sg@mail.gmail.com>
Subject: Re: [PATCH v2] Allow use of TLS 1.3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 2:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Daniel Stenberg <daniel@haxx.se> writes:
>
>> On Fri, 23 Mar 2018, Loganaden Velvindron wrote:
>>
>>> +#ifdef CURL_SSLVERSION_TLSv1_3
>>> +    { "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
>>> +#endif
>>
>> Unfortunately, CURL_SSLVERSION_TLSv1_3 is an enum so this construct
>> won't work.
>>
>> Also, let me just point out that 7.52.0 is 0x073400 in hex and not the
>> one used for the first version of this patch.
>

It's working with tls 1.3:

ldd for curl (showing linking to openssl 1.1.1 pre2 preview):
 ldd /usr/local/bin/curl
linux-vdso.so.1 (0x00007ffd30599000)
libcurl.so.4 => /usr/local/lib/libcurl.so.4 (0x00007f5a81845000)
libssl.so.1.1 => /usr/local/lib/libssl.so.1.1 (0x00007f5a815b5000)
libcrypto.so.1.1 => /usr/local/lib/libcrypto.so.1.1 (0x00007f5a810dd000)
libz.so.1 => /usr/lib/libz.so.1 (0x00007f5a80ec6000)
libpthread.so.0 => /usr/lib/libpthread.so.0 (0x00007f5a80ca7000)
libc.so.6 => /usr/lib/libc.so.6 (0x00007f5a808f2000)
libnghttp2.so.14 => /usr/lib/libnghttp2.so.14 (0x00007f5a806cd000)
libdl.so.2 => /usr/lib/libdl.so.2 (0x00007f5a804c9000)
/lib/ld-linux-x86-64.so.2 (0x00007f5a81ce5000)

handshake failure against a tls 1.2 server:

GIT_SSL_VERSION=tlsv1.3 ./git clone https://github.com/shuque/pydig
Cloning into 'pydig'...
warning: templates not found /usr/local/share/git-core/templates
fatal: unable to access 'https://github.com/shuque/pydig/':
error:14094410:SSL routines:ssl3_read_bytes:sslv3 alert handshake
failure

With a local server running nginx using only tls 1.3 (had to disable
ssl verification due to self-signed cert):
GIT_SSL_NO_VERIFY=true GIT_SSL_VERSION=tlsv1.2 ./git clone
https://192.168.1.214/git_test
error:1409442E:SSL routines:ssl3_read_bytes:tlsv1 alert protocol version


Now with TLS 1.3, it works:
GIT_SSL_NO_VERIFY=true GIT_SSL_VERSION=tlsv1.3 ./git clone
https://192.168.1.214/git_test



> Thanks!
