Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86ADD207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbdEDJR1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:17:27 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33017 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753762AbdEDJRT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:17:19 -0400
Received: by mail-io0-f179.google.com with SMTP id p24so14726019ioi.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rw7BuV9Zi0NmZRPZV2zyXsY3yI0UxYaEk6iDCODFYj4=;
        b=oYJcNLYFC8f+NY7vl7gtX0neuf2GwWr6FE9pXTxcgNgLWyums1g13CBGLntsDpt0gT
         Dx9ZyinqGPbAK1TavE1dFpMP0W6FI9iTflsoxrVLlEylNTuigiPxvACQcIyq6A2Yzi5/
         MlwLgIVjxTvXegvdsjKR1wciMHuzqoWjNKOAUcJErhWRKVEOAREgOi7gzFQPEoX95kj5
         E7A3q+NRi4QAEOm2HsuRylAkZqDr3sDjtRtyv6bppKNbCCTv1uIR4EnJghjLLStDodkX
         x/W/6bVJUhM/QuXmr/SViGApDNblFuljjT6bJeWX85szkTm0JbnH9bmNxur+pKzRphvQ
         ddMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rw7BuV9Zi0NmZRPZV2zyXsY3yI0UxYaEk6iDCODFYj4=;
        b=KQHIqJVrOPXP0VQTjocSDSkccoMAviyFRlo2PmZmrZThCMhp0421nBD4ATH50tIzw7
         bezD5Wv30JLBpIP6wIMy7NXXcQ/RGPbNek5YP7eZ20Xh7x4XkkIhVGo44xcgMzrmFDRp
         XG9Fp6YPJqCLDRGfU4qUI7qoncYnVf1ahGlEaB4ctrSgT2a4AwFTWx+hOkAv5h+eJ804
         ELFzm9ixifAtaU8dOMAD+kV80aLxLkc3pqj6SG8XET+ny28dyuIq6vg7LT3M2JrkOtlV
         n9b3wxlfl4twrLBYWOMDnwHYxul9W1dSD5icWUHNfp3BmaboPc/Qh1qB+QvnuwT8sbed
         aEsg==
X-Gm-Message-State: AN3rC/5CSr4NVSx3M4TmpOmG6jvDokIMplQ5ScYzJuuoSTh6ew7Lfkym
        kQ/QEH6qKfTu+HUV3By+glbO7D9hfg==
X-Received: by 10.107.146.139 with SMTP id u133mr35510047iod.160.1493889438440;
 Thu, 04 May 2017 02:17:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 4 May 2017 02:16:57 -0700 (PDT)
In-Reply-To: <c8879806-4e43-d033-bd69-918e730e2d05@hale.ee>
References: <b344d0c3-c8b8-da27-79f6-ae750be6830a@hale.ee> <xmqq60i3k6ed.fsf@gitster.mtv.corp.google.com>
 <c8879806-4e43-d033-bd69-918e730e2d05@hale.ee>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 4 May 2017 11:16:57 +0200
Message-ID: <CACBZZX6XdwND2-7cY0zp8+K_uh60tn-i_r9V7HAe2X-a-RJeQA@mail.gmail.com>
Subject: Re: [PATCH] __git_ps1: Don't kill shell if user types `set -e`
To:     Tom Hale <tom@hale.ee>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2017 at 10:26 AM, Tom Hale <tom@hale.ee> wrote:
>
> On 17/04/17 11:24, Junio C Hamano wrote:
>> "Tom \"Ravi\" Hale" <tom@hale.ee> writes:
>>
>> > If a user types `set -e` in an interactive shell, and is using __git_ps1
>> > to set
>> > their prompt, the shell will die if the current directory isn't inside a git
>> > repository.
>> >
>> Hmph.  So the fix would be something like this?
>>
>>      repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
>>          --is-bare-repository --is-inside-work-tree \
>> -         --short HEAD 2>/dev/null)"
>> +         --short HEAD 2>/dev/null || :)"
>
> Nope, that would cause the next line
>     rev_parse_exit_code="$?"
> to always be assigned 0.
>
> I believe the patch we're after is attached.

I see how this would fix things, but this just seems like a rather
crazy thing for us to support, we can take this patch, but it's going
to take quite some maintenance burden to ensure that this code is set
-e clean going forward, and I don't think we should take a patch like
this without some general support in the regression tests to ensure
that the completion code is set -e clean, otherwise this is going to
very easily regress the next time someone not aware of this patches
it.

What's the real use-case here? If you do "set -e" in your shell you
also get e.g.:

    $ ls -l blah
    ls: cannot access blah: No such file or directory
    === Command terminated with exit status 2 (Thu May  4 11:16:03 2017) ===

I.e. any little failure will terminate your shell, are you actually
running a shell like this? For what purpose?
