Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4961F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 13:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbdFINLo (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 09:11:44 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35947 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdFINLn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 09:11:43 -0400
Received: by mail-pf0-f172.google.com with SMTP id x63so28437594pff.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5m+lTprctuiC2DfN/IAsrJJfiV935OElogXMgGLqsZ4=;
        b=TCid9apTGXZAD8ZmfItX90vE9WHzDrEcRTVELPsZwWc2tNgX9oPB/3wiva3+C/IveU
         UAaVtOI43RbCX1xurz0j/4BWfAAs90hDZrJo6k/xnpsW94kTx5P2YEA67Sgawt4fF/3N
         Yn0VZJNyXyaFi9GmV8bNmKgbMwQ2DsgK0CAUgy72tfWJFPRb/KnqtydMMyujig7+5R7n
         TAKNPce1Q7VKleTf9clD72ttKNdZMI7xyVvHbMQGmu04rkzZQhxenwGWqHUm/bJ/dcfq
         A1UnuwxeEv4v0dorfaSD+cATQb1D/L7n/CTONIJGyNPLqrGJXf64G+PJLBpUzrZsuX6e
         50TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5m+lTprctuiC2DfN/IAsrJJfiV935OElogXMgGLqsZ4=;
        b=anSs8Ej+hG915jOJcjaRROjChM3igNf1Uc4NvnuTaYcBX15OK2ubxfBPrC5N/BXJ/L
         KtZA7kB20CIyGJoPNizZfwkhpBt62MDk71SafJUj4/kb2jy1R5wTW79HX3dqp8LPdD67
         2HqHzBm89IB9L90Z5OF+xjQreLicmDy6LS5P6K5afoNIJsHFlArdM1YrYLYgXJbE6I0A
         Xpptpl5mYPm3hgjl1xenWNnTJKwxsXNtaNua7vnoD/dlRXhubLuKF/R35WMpahyi7NCK
         FYPjWi+BF1BdIv9aRImRb8Q8MYC01lXD4wjY8AJtzl6Yi4bLNrcRfsoVmDP8VxftyBqD
         cJog==
X-Gm-Message-State: AODbwcDp9PkiRVoBuUkJ7jCnOWxVlKy4Ye5SHGzLMbyJZy9PkSxZBZXd
        i7GF0meV8bUB6A==
X-Received: by 10.84.194.226 with SMTP id h89mr26534404pld.58.1497013902318;
        Fri, 09 Jun 2017 06:11:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id s17sm3174114pfk.112.2017.06.09.06.11.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 06:11:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] add setup step to filter-branch
References: <20170603101755.13619-1-asheiduk@gmail.com>
        <xmqq1sqzuqmh.fsf@gitster.mtv.corp.google.com>
        <20170609054955.y52cro2c3bwhl2sh@sigill.intra.peff.net>
Date:   Fri, 09 Jun 2017 22:11:40 +0900
In-Reply-To: <20170609054955.y52cro2c3bwhl2sh@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 9 Jun 2017 01:49:55 -0400")
Message-ID: <xmqqo9tx71bn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I have a feeling that if we were ever to rewrite filter-branch, it would
> probably be worth allowing people to write snippets in a better language
> (possibly even a domain-specific language). I'm sure that most of the
> program being written in shell doesn't help, but if we're spawning one
> or more shell instances per commit (plus the Git programs they spawn!),
> it's always going to be slow.
>
> But I suspect that would be an uphill battle, as our only stable API
> involves starting external processes anyway. You'd probably do better to
> pick a language you like and rewrite it in using libgit2's bindings to
> that language. It's not feature complete, but basic stuff like "put this
> entry in the tree" is certainly mature.
>
>>  *1* The issue is *not* that these individual filter commands expect
>>      <command> written as a shell scriptlet; it is that these
>>      scriptlets expect to be evaled inside a single shell process,
>>      making an update to a shell variable in one command visible to
>>      the next command that runs.
>
> I think you'd need a shell "helper" that's a single long-running process
> and just reads "eval the index snippet now" instructions from the C
> controller. At which point I don't think Andreas's "setup" feature is
> any harder to support. We just send an "eval the setup snippet"
> instruction first.

Yes.  I do not think this particular one makes things any worse than
it already is.  As I said, I do not have a strong opinion against
the topic; as long as people find the feature useful, I do not mind
applying it.

Thanks.
