Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32331F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbeDJVZk (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:25:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38244 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeDJVZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:25:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id i3so93856wmf.3
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Q3ktq1a/nLcuBuE+0ixg58MPSaik+leHzz96xLGUvl0=;
        b=uSppxjxfxIxzU6YAOkDvWAX2u1rp7ens52odkzJ6Q4/FXKD+EgVrKoFnpehpDOsRpT
         XfBHMvRLTAtNE2sF8uKJz6LIAVPIkb+zWp4SnFNpEcJhlPJvh6XkW6XsWkUmnwe3pLGR
         QvpD4ivSwLKxStVo53XkHyoyfE5PaZzdtTcjPXSbyDQplttUzD1m8Im7BJTklg2nN+AJ
         XWf0egDji47slT3tGqxAZTD3s6Lw20xa0I/ABORwYCruDF8enyGk76chnH4jYE6kXv+P
         zBdwdF1o9SyV6/g+KHmUT64QyG2rEDAl2QQ3obf/n33eifHoU5I9Nyde19ObU5Jk+C/c
         9/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q3ktq1a/nLcuBuE+0ixg58MPSaik+leHzz96xLGUvl0=;
        b=kUqRFrz0tqXl5n/H1Ilwno0OsDaR4taEvPg9janh+937bCpoY5+hsJ3LSHH1dvAnCO
         8vhHL/yNBpFLd6nR2SuM8rxWacdD0/1lgovUAbptvY5y1flij40lGSIh1/zlrh892gU+
         hgZegVbikAFkrFKs5k6hP3CJed2ew7gyxm8kyUBeblKp7CMD9/f58zW6EirusugKh5Gz
         OjVpxdifyw2Wu6PD21OcXDlEj4tTazL4h7yBcDD8hHAEVDqvbj6OM5TIGw+DGjy6dCQC
         d510v/zu6FvZAs2xcfjIbbPYICAXbbb23oDTzqCNOBiCNWG6CgQby8szcT7eOTP7mkQM
         FuQg==
X-Gm-Message-State: ALQs6tCydQP88UckcdMH8YF4cBq9iEJNAHEcVkvLKZep8x7Q6ElkDFvS
        cd0q2md3gi45p+E16GpbMy0=
X-Google-Smtp-Source: AIpwx4/mh509ENHXAVOq3QPBule/lVtHhs3oS74xnBW780co1hXgtkQBA37juK+pn/nidn2fz9X8VA==
X-Received: by 10.28.116.26 with SMTP id p26mr762290wmc.102.1523395538234;
        Tue, 10 Apr 2018 14:25:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r11sm2690088wrl.42.2018.04.10.14.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:25:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] doc: add note about shell quoting to revision.txt
References: <20180410183224.10780-1-asheiduk@gmail.com>
        <20180410183939.12146-1-asheiduk@gmail.com>
Date:   Wed, 11 Apr 2018 06:25:37 +0900
In-Reply-To: <20180410183939.12146-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Tue, 10 Apr 2018 20:39:39 +0200")
Message-ID: <xmqqy3hu21pq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/revisions.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index dfcc49c72c..c1d3a40a90 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -7,6 +7,10 @@ syntax.  Here are various ways to spell object names.  The
>  ones listed near the end of this list name trees and
>  blobs contained in a commit.
>  
> +NOTE: This document shows the "raw" syntax as seen by git. The shell
> +and other UIs might require additional quoting to protect special
> +characters and to avoid word splitting.
> +
>  '<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
>    The full SHA-1 object name (40-byte hexadecimal string), or
>    a leading substring that is unique within the repository.
> @@ -186,6 +190,8 @@ existing tag object.
>    is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
>    literal '!' character, followed by 'foo'. Any other sequence beginning with
>    ':/!' is reserved for now.
> +  Depending on the given text the shell's word splitting rules might
> +  require additional quoting.
>  
>  '<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
>    A suffix ':' followed by a path names the blob or tree

I've seen this suggested before and thought it is a good idea.  GOod
to see it is finally happening ;-)  Thanks.
