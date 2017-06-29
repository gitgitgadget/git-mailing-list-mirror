Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0EC520281
	for <e@80x24.org>; Thu, 29 Jun 2017 18:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbdF2So7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 14:44:59 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32929 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdF2So6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 14:44:58 -0400
Received: by mail-pg0-f47.google.com with SMTP id f127so51961141pgc.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 11:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hTDlgRAwjRxP6hp10Y7tGDs2Sx7v9V/ppV3A2I8RewI=;
        b=RwEnngp4gPq3ITDuZJhBeQuQ1seQrqsJIH/nAjHIFfQtkVD1NNyavJK5ziRETW66cg
         I5P7q3cLnlql7vBWvubN7fc7nv/QhntWrDL/UNcXf6B640/L/JB+svNKJvRq0DDApKvb
         hoOuG2/bn6sig7+oCiIUQZZswHpt2aAOZeCBQiAJN1X+w3IlQ3VTllUoyJGyRBrnB6Xp
         j9DPkFhH2j2oUkzdF0CUTQsuyvsoM5B1rkWzTp21T+l0oxQyQa5eabueozcHbolb9NPS
         klMrnWJZZxILeKBqDKukUFKPw3FQX0Z8wCbbuQ7ev+l3tpTiQAAoBRVsFTxbZWdKVr32
         5LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hTDlgRAwjRxP6hp10Y7tGDs2Sx7v9V/ppV3A2I8RewI=;
        b=cy/9EPCJdaZIJ5o7H4/Rb5MZ6mkPEbcDSB8hS3HnCflYmwqleZIbm6aGr1z+cz9Htn
         qPjbk1p/AxgMjge8NRsam1hF25dTYExfh/ujMytK9qKa8GeCe/vs9LflTl1yBUhArs14
         2MXal1On75k+QA+/u7Jr70AxtqOCcSz+1eV0B9xatXds+ufTiuEZL8HvwuxPqCXtzxm1
         CSk+8C98nAlrEVBuHw0t3lc+yx5u52jg24Ej1+yOhGtDSfaPDPjSVozBfYHlmOLhmKKV
         NcblWD7AWnWxI7/0qn/BkWkmOt7BxjsvG+2PFfyxQt3+xebwakvPU8NtQge9jdxGqTNa
         UP0g==
X-Gm-Message-State: AKS2vOwZLIpNDV2Jq/s0dKVlH4YqAiY2LJyXrSfcyaKLM3aLKNUKa3gt
        fHOhJCNN1BmXdQ==
X-Received: by 10.84.149.139 with SMTP id m11mr10632517pla.138.1498761897234;
        Thu, 29 Jun 2017 11:44:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9846:b2e3:b31e:8976])
        by smtp.gmail.com with ESMTPSA id r63sm10905433pgr.65.2017.06.29.11.44.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 11:44:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Laurent Humblet <laurent.humblet@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Warning suggestion for git stash drop
References: <CAFirYm_LLCUNdppZ7kKGwijJNNvhCaQtoJzRBVRsvhF+=bqgrw@mail.gmail.com>
Date:   Thu, 29 Jun 2017 11:44:55 -0700
In-Reply-To: <CAFirYm_LLCUNdppZ7kKGwijJNNvhCaQtoJzRBVRsvhF+=bqgrw@mail.gmail.com>
        (Laurent Humblet's message of "Thu, 29 Jun 2017 11:23:03 +0200")
Message-ID: <xmqqefu2tyzc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Laurent Humblet <laurent.humblet@gmail.com> writes:

> Would it be possible to add an optional Yes/No when doing a 'git stash
> drop'?  Something similar as what happens when pushing on a remotely
> checked out branch (with a config setting to turn the warning on/off).
>
> I know that you can always get your dropped stash back using git
> reflog but a small warning might be a useful feature to avoid unwanted
> stash drops on a regular basis.

I sympathize with this, but the same principle also would apply many
destructive commands like "git reset --hard", "git rm <path>", etc.
and also "/bin/rm -f" ;-)

I however do not think a good general way to do this without
breaking people's scripts.  When they do 'stash drop' in their
scripts, they know they want to get rid of the dropped stash
entries, and they expect that the user may not necessarily be
sitting in front of the shell to give the command a Yes (they
probably wouldn't even give the user a message "the next step
may ask you to say Yes; please do so").

On the other hand, just like "git reset --hard" and "git clean -f"
does not have such safety (i.e. the user is aware that the command
is destructive by giving "--hard" and "-f"), "drop" may be a sign
that the user knowingly doing something destructive.

So I dunno.  




