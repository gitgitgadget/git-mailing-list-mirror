Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D15D201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756858AbdELWb6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:31:58 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35357 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756599AbdELWb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 18:31:57 -0400
Received: by mail-pg0-f43.google.com with SMTP id q125so16648771pgq.2
        for <git@vger.kernel.org>; Fri, 12 May 2017 15:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Y8OJ6ZrX097u8JLs08VuXINTSt2Y61KyafskEEr3D70=;
        b=dGhDLo+NuUZz9SxfPfwLWL1XqFRqFY1Ap+DhYe4VIWC0/mi9KTONvJ1kBKjV2sUlRE
         xjcHJXAqQbEX/GA1FFwrHxZi7AB61IAaVyAwMK4gqmkcKkq4m66wwKC6w9HmTS02eLWL
         AZEVUzqlNB1tzVE/lbXsGPHtS7A0t7dy9yicXeSVf/dlEiXWpSvX+1uyeQaL+PSBDi1h
         sW+ISmpZ+b3IPKzjXgFtQW6wb3Vhs5DthylLsA1fWOAkxycR/GxaG8dekcLIu0mFTKPd
         cUG3t2Kfm8sm5laaj23XAP4eiX5x4+LkeZ/30UDOW6ldG0+mMUJbfVi8kbMqc0ztngIE
         pO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Y8OJ6ZrX097u8JLs08VuXINTSt2Y61KyafskEEr3D70=;
        b=uYmoM0QAopTBShKbpWiWypHhnmxe8UGxWbNNxL9QVcauXxV1brB3YmNi+MkyzLSPGG
         nBqdvHCFb1FiVnr3qKJy/mFkZwjqNk9r5YV990Eh9GOb4XR7mEAutme7DnrME5FX+9+l
         IY+H4Fz5XsI2w4lADk+H1eUd38/ME2eh20XjuiGuf+UAczZrxjN6FssAqCyo9EKepDI9
         qOH4SK6LyHVsnjmBnbPO7c5pH7o/rPizZf0t4y/iz/MbS7PlPlQeSQ49ZFWeiutYToVM
         76KxrnDZaDZsROpLqnFM/JE7KKmmKIr1h6HuBHHJ/GdQdsaoxM4beZuLGpRm7YM40hi+
         NbkQ==
X-Gm-Message-State: AODbwcCjCvf9MnB/QU2KRvJKHZ27ZLYjwcRiMSEHvkd+GAmb3DG3GXRn
        6L5aFk/umVNyjueIRtfj7A==
X-Received: by 10.84.217.139 with SMTP id p11mr8759919pli.146.1494628316520;
        Fri, 12 May 2017 15:31:56 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:cca2:a63f:8bc1:6a6d])
        by smtp.gmail.com with ESMTPSA id y20sm981230pfb.93.2017.05.12.15.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 May 2017 15:31:55 -0700 (PDT)
Subject: Re: [RFC] send-email: support validate hook
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170511193753.19594-1-jonathantanmy@google.com>
 <CACBZZX74dsTJtAQdrMmEDPKOVdEaiL4dGrmz9OZ3jQhhmr5xEA@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <45b9e2d1-0840-d163-468f-588253cb8527@google.com>
Date:   Fri, 12 May 2017 15:31:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX74dsTJtAQdrMmEDPKOVdEaiL4dGrmz9OZ3jQhhmr5xEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/12/2017 12:23 AM, Ævar Arnfjörð Bjarmason wrote:
> I hacked this up last night, it also addresses Junio's comment about GIT_DIR:
>
[snip]
>
> Changes there:
>
>  * use catdir instead of string concat, I don't know if we run
> format-patch on any platform where this matters in theory (e.g. VMS I
> think), but the file uses that API already, so continue using it.
>  * Just make this more brief by moving the -x test into the loop,
> we're sending E-Mail here, no need to optimize stat calls (you did ask
> for style advice :)
> * Check the return value of chdir & die appropriately
> * localize GIT_DIR
> * "die if system" is more idiomatic than "die unless system == 0"

Thanks - all these are very helpful. Especially the one about localizing 
GIT_DIR - this allows me to move everything into the validate_patch() 
function.

> Or actually just move this into a function:
>
[snip]

I'll send out another version of the patch that puts all these into the 
validate_patch() function.

> I wonder if we were designing this interface today whether whether the
> existing behavior of  --validate wouldn't just be shipped as a
> *.sample hook instead. There's also the caveat now that your hook
> might be OK with really long lines, but the existing validate function
> denies it, and there's no way to override that. I think a better way
> to do this is:
>
>         foreach my $f (@files) {
>                 unless (-p $f) {
> -                       my $error;
> -                       if ($use_hook) {
> -                               $hook[1] = abs_path($f);
> -                               my $cwd_save = cwd();
> -                               chdir($repo->wc_path() or $repo->repo_path());
> -                               $error = "rejected by sendemail-validate hook"
> -                                       unless system(@hook) == 0;
> -                               chdir($cwd_save);
> -                       }
> -                       $error = validate_patch($f) unless $error;
> +                       my $error = -x $validate_hook
> +                               ? validate_via_hook($validate_hook, $f)
> +                               : validate_patch($f);
>
> I.e. if you specify a validate hook it replaces the existing hardcoded behavior.

I'm OK either way.

> Also, just to check, is this new thing still consistent with the cwd
> docs in githooks (see e.g. 501d3cd7b8).?

Anything particular that you think is inconsistent? It is consistent 
with "Before Git invokes a hook, it changes its working directory to 
either $GIT_DIR in a bare repository or the root of the working tree in 
a non-bare repository". (The commit you reference refers to push hooks, 
of which this isn't one.)
