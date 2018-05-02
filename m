Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B992F21841
	for <e@80x24.org>; Wed,  2 May 2018 08:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeEBICA (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 04:02:00 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36250 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeEBIB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 04:01:57 -0400
Received: by mail-wm0-f43.google.com with SMTP id n10so22533871wmc.1
        for <git@vger.kernel.org>; Wed, 02 May 2018 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hWlKQG6Xg0z0u6QHK0t+hA+CWivHLs3VHz1zQngAWlo=;
        b=CacKIMAWX/rYl2En/ztzZBdSZQuUNC342tLqMpm0QzLQSTLQ7NDql/sBqxlkYo8FFs
         K8OHwex5+cdlAYvdfKnTk+27yv8g0GUUjgczB8NWciPLUwK7RLHIbAOGxKyT9C7g3dQn
         KIYHUMzStahPHmdZgaYOui5cLqHZE6pAv2XSn5mYTWjbXYZNQXkPvfD1sXtVMTA7dHRA
         kCCL1knrCx4ySlsYwVhWKsE8K496S41O3QftzS+nh2j5TSp37ASxcfobJm53LLcs+nLJ
         UINQZVGYpsmruNzFyyfCJVh7TievHfAkhqgAHibilGc3Pg84sP3cXx5YF69m8tUwQt8G
         8Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hWlKQG6Xg0z0u6QHK0t+hA+CWivHLs3VHz1zQngAWlo=;
        b=LRAF6wdzvDc6XPsDBC8wHJ7gxAw47arltc0prk90951F2U/VygnwXtUBQC103Rz+x2
         zfy3VSdqmGMBpdvCLs3+6wy0C2udDvVTGYAtM1R0MorO6Bub5RNumhk0gbTAYeSdIfyO
         kKtadjqRRkBX4jaLFJm/xNJsjmbcttEHbDGbc9LS6AvkxmiyrRIoqP0PP9NMeZaSEMqF
         fQ00OSRpG6aIm6uBP4bQxPm6p2piqoUdHERr80kTrlXKnGrkMRmg3AbUxJvJFXGODK8o
         dVdVPXp63CwnzChB/h/lEBoNCpXz4DuOaKN+/n4C4fzDicLVj5j7lWsJ8E9JClyzTftr
         x8Eg==
X-Gm-Message-State: ALQs6tDaQY9YuIOEEjsU644IP0NlLaAVFaDEQEb5t1jtvsc64QaR63E8
        jMJeQ/hli9+HTUx4y0N/2FQ=
X-Google-Smtp-Source: AB8JxZr031Wlfkzo5A4ideohXZ1SGFt1HlOrihlazdrbW4VBrWiZfBHPSggT8odDcfkQqhSgMvXT/g==
X-Received: by 10.28.113.196 with SMTP id d65mr10962795wmi.157.1525248114977;
        Wed, 02 May 2018 01:01:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q81sm13764822wmg.8.2018.05.02.01.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 01:01:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shin Kojima <shin@kojima.org>
Cc:     git@vger.kernel.org, jnareb@gmail.com
Subject: Re: [PATCH] gitweb: Measure offsets against UTF-8 flagged string
References: <20180501064015.59977-1-shin@kojima.org>
Date:   Wed, 02 May 2018 17:01:53 +0900
In-Reply-To: <20180501064015.59977-1-shin@kojima.org> (Shin Kojima's message
        of "Tue, 1 May 2018 15:40:15 +0900")
Message-ID: <xmqqtvrqv632.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shin Kojima <shin@kojima.org> writes:

> Offset positions should not be counted by byte length, but by actual
> character length.
> ...
>  # escape tabs (convert tabs to spaces)
>  sub untabify {
> -	my $line = shift;
> +	my $line = to_utf8(shift);
>  
>  	while ((my $pos = index($line, "\t")) != -1) {
>  		if (my $count = (8 - ($pos % 8))) {

Some codepaths in the resulting codeflow look even hackier than they
already are.  For example, format_rem_add_lines_pair() calls
untabify() and then feeds its result to esc_html().  The first thing
done in esc_html() is to call to_utf8().  I know that to_utf8()
cheats and leaves the incoming string as-is if it is already UTF-8,
so this may be a safe conversion, but ideally we should be able to
say "function X takes non-UTF8 and works on it", "function Y takes
UTF8 and works on it", and "function Z takes non-UTF8 and gives UTF8
data back" for each functions clearly, not "function W can take
either UTF8 or any other garbage and tries to return UTF8".

Also, does it even "fix" the problem to use to_utf8() here in the
first place?  Untabify is about aligning the character after a HT to
multiple of 8 display position, so we'd want measure display width,
which is not the same as either byte count or char count.
