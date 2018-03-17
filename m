Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DB41F404
	for <e@80x24.org>; Sat, 17 Mar 2018 00:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeCQAxp (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 20:53:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45267 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbeCQAxo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 20:53:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id h2so13175399wre.12
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 17:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bKYc+qok7me/xAlFpLHfWKtb0JxWWb0d0tjUdlobBSY=;
        b=KsqvvM2tbSfZYcD+zqaPDiGCzY36PlnPxzeDD1z8q5BOOXKbEgYK8X1YOQavOISXTS
         +CilLVy4ORCLhdqwAHItkRg/6VtNEkh83wglMc3rQ9UXKrvXN8211geNI/lP2u5iJhBR
         koTfopwCmjFeOGVAmNkOEeUwDAnBUoviWyrNcWW37yCvNyUjErWjQxNINXkxLqOSWeA4
         Gt7MzOzGDnH40/Rc52HcU/QquQlO5P7VKD+UgWBtYIqTg7oI20F5ClxGC//qtSuj/nOP
         PBYFq+vNj+qVrQphdGD4dNWr6CWZUsv5BiR+W1YEol88YqOAowv1ESmLojsHBEPGd09f
         AnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bKYc+qok7me/xAlFpLHfWKtb0JxWWb0d0tjUdlobBSY=;
        b=WXjHZ4VlQcZuZGFHYnAiAMI4Lzh+WWc++lJvqpKUnPSl45dUBkPFWhaXtpBiNaN/E6
         rKX5AAl9dATVijv0z/9TNdkglOslwTjOzZ8bMSkY3ET//LXiFso39GKOQYqBgitIlkjk
         Xt8kVQdey5cyp4xTHLthKneM4G0cKUMI63eW+f8FJpoNdIpDYh2p/pWX+8ftAP1p3RUh
         J3gxQvUfiDuYwuvzq1tSzFuobo0Sj+gsRf6l+ZCfgUMkNcNjPfwUH4zObyGjm77wqRYs
         L6x/w7dwP5kbsRuSXPjNIhNwZlv1JwqBAd7FsbNibT3Ynyti+3J9/37JBJwBRdUYxIqw
         Tx8Q==
X-Gm-Message-State: AElRT7GGniBgbO0NvXXHChvsNd098I1KLucKJ/XNkzniMsn27mXj1uNj
        rMXLMRj2UWP3ywCECjqFdsQ=
X-Google-Smtp-Source: AG47ELtLmdjZZO31CVKDGvFTb4jezk6K/BQeOE2jofpw3AINOyf8tW585NWlV8P0rzMuDvfwInra/g==
X-Received: by 10.223.190.141 with SMTP id i13mr3026684wrh.235.1521248022752;
        Fri, 16 Mar 2018 17:53:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b8sm7858090wrf.29.2018.03.16.17.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 17:53:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
        <20180316143124.5b22d70861344cbcbbad46dd@google.com>
        <xmqqh8pfzo1h.fsf@gitster-ct.c.googlers.com>
        <20180316220824.GC151588@aiede.svl.corp.google.com>
Date:   Fri, 16 Mar 2018 17:53:39 -0700
In-Reply-To: <20180316220824.GC151588@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 16 Mar 2018 15:08:24 -0700")
Message-ID: <xmqq1sgjzfn0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I was hoping to hear quick Acks for remove-ignore-env (and also
>> Duy's reroll of their topics on it) from people involved in all the
>> related topics, so that we can advance them more-or-less at the same
>> time.
>
> I can go along with this for this series, but I want to explain why I
> am not thrilled with the process in general.
>
> The series "Moving global state into the repository object (part 1)"
> had gone through three revisions with relatively minor changes between
> each and we were in the middle of reviewing the fourth.  In response
> to a series that comes after it, "(part 2)", Duy created
> nd/remove-ignore-env, a series that I quite like.
>
> But with this reroll, the result is:
> ...
> So even though I agree with the goal and I like the improved
> initialization code, I am not happy.

Well, I do not think it was the "process" issue in particular,
though.  Yes, it was unfortunate that these three revisions were
reviewed but they each resulted with only relative minor changes
between iterations.  IOW, reviewers that lost fresh eyes, perhaps
including me, all missed a larger wart in the design that made the
"ignore-env" thing required in the structure, which was spotted by
somebody else.  It would have been nicer if such an improvement were
done during an earlier part of the cycle and did not require that
other reviewer.

But we didn't spot it, and now we know a better structure of the
topic, luckily before all the things touch 'next'.  We not just got
a suggestion "it would be better to rewrite it like so---now go
ahead to do that", we got something even better and Duy did all the
work restructuring the series, reshuffling the patches.  We should
be thankful, not unhappy.

