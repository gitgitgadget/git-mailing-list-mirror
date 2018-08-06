Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74930208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 20:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbeHFWKi (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 18:10:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35294 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387428AbeHFWKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 18:10:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so15668306wmc.0
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=G0PmshksNCaFPper811/lAuHSHSexwEyxaeTgBDRpD4=;
        b=kX57UYZbZUxadRXWrQxG6gpuNBaLFksMNcc6kNsk43mSWwWTyGQPjedw43a+Io0zf1
         R1WSw+fJm7tHU56Bp2Fi0aFg5y6LVTsFYTugZ8Ivj9aOPXRuTFWCpfUG0SdO85knKu8E
         h4t/V2xBIjGauu6mK8H5wsAGLf6Zo1kc7Vj1MNn2pcgUIbc8XLb1R42Hf6/ifXHbKQCq
         X2gJKA3fbZXJkfeZGpeu8X4P7/gsdZLGbxzKUyTBEyzJ++SzKrGPZIRI6l47oBZNi6uk
         JhZGpjckgfMESpgUbDjgAbjZqrkpLgFqg5GwQgSAb4GRtguOikx1ycqJ3na+sQj3Lty4
         jwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=G0PmshksNCaFPper811/lAuHSHSexwEyxaeTgBDRpD4=;
        b=Y17+cyKk9zjhPHrdhTpDl0xM8Oe6dne4bcnZUjNqGIDueVCj6EwbuNgQQIy1ZDcrUh
         8k3zavP8JZgaRhVfmHoFlat6w0tVinhE+fGUOLss7lweNSgRA2IJ657EG2ZtNVjFAnMP
         9hk5RbQH+HfQERqh1Qudt3/ZZbS+VycM2S+KZPyIdrE1SjadBzdDqkrmS/6pt+qDSpTI
         3UP7Z2oUtTKTszEgRDv2b2iyFVVl9gIZwYiF4WZ8D2Vk4JMv/qWTDID1knsolQRKKe4S
         IAvfrxqHQbA4AIE/tKBhDS/+GKahqLvNy7j6Nb7h+AojoUimej2lyeOxWqYw6BBF2TW1
         w8QQ==
X-Gm-Message-State: AOUpUlGsQ+1NSeEDocmo3NTqckW1BncK5fK3aBMJdoREN7o0uA9FscQ2
        zy5rXR2O0fIQqAp3OH5624c=
X-Google-Smtp-Source: AAOMgpcmvuS+Nw1/RbrdiNtTGEElOpmxoRs7KihQIWI+oJpkrtx18BhhX8Da+IfQzLueWSg/TFH9qQ==
X-Received: by 2002:a1c:9945:: with SMTP id b66-v6mr12238473wme.159.1533585596461;
        Mon, 06 Aug 2018 12:59:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w185-v6sm10213499wmw.6.2018.08.06.12.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 12:59:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] pull --rebase=<type>: allow single-letter abbreviations for the type
References: <pull.14.git.gitgitgadget@gmail.com>
        <d2ba1e6bef9d6d4eabc8eaa60435dcae1105fd07.1533410586.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Aug 2018 12:59:54 -0700
In-Reply-To: <d2ba1e6bef9d6d4eabc8eaa60435dcae1105fd07.1533410586.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sat, 04 Aug 2018
        12:23:09 -0700 (PDT)")
Message-ID: <xmqqh8k7nu4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Git for Windows' original 4aa8b8c8283 (Teach 'git pull' to handle
> --rebase=interactive, 2011-10-21) had support for the very convenient
> abbreviation
>
> 	git pull --rebase=i
>
> which was later lost when it was ported to the builtin `git pull`, and
> it was not introduced before the patch eventually made it into Git as
> f5eb87b98dd (pull: allow interactive rebase with --rebase=interactive,
> 2016-01-13).
>
> However, it is *really* a useful short hand for the occasional rebasing
> pull on branches that do not usually want to be rebased.
>
> So let's reintroduce this convenience, at long last.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Makes sense, whether this patch is adding back what in the past
existed only in the Windows port but lost, and whether the lossage
was long time ago or in just a few releases go, or it is adding a
complete new feature for that matter.  This looks like a good
short-hand.

Will queue.
