Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC771F404
	for <e@80x24.org>; Thu,  8 Mar 2018 22:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbeCHWE1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 17:04:27 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41874 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCHWE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 17:04:26 -0500
Received: by mail-pf0-f195.google.com with SMTP id f80so469369pfa.8
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 14:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ad88IARriH/DlU0PJcY+WQ3/v8wLdbxcp5YN40RzvO4=;
        b=QqCtAImIV332x3GtlQB/TDqLE1HgYHKzubhAXza7bWVk4B9ARP5eIRSo0qRHPkWj97
         41A96Ul6anf1HnxErdn+PI9RNUs9Hyip0S1gOCjcm3Tyl5x6nVExeU5agMfQl9F/otJm
         Ayj520HRvQkRxJsNt2+ZrSntR6diSp8ykiEHHlcKsmR0f4rJucCM+peTsCliucug8fKR
         Ad2ob+beHtjjSHYNhRQ/ILMLhSLLmwjpQ4QU3ZWOYiX685+WTOBDKQb8MX7tEQTwmLsI
         lq78LxP/dZP0q0bOL25+Pcc27oNH+A1xvHXS+DRpPwOYNGEs4IYyEzRHdrIGrMsaOmg5
         IqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ad88IARriH/DlU0PJcY+WQ3/v8wLdbxcp5YN40RzvO4=;
        b=IB9svl09P9Ajf8MwmXVnkJ666sm9byIiSV8Nopp+CSHAFeXTbrjsNutBq9p2vSsK0Q
         ERr2t4GJexx/ZEr6KAebSicRgJ8HGcYu/mGp55RJNf4xsnvETScADFf6ls9Kw+a8/D+d
         J0r8Acgi15JRv9xcXBcGOkgjl0MIN+I1B9b4VJ0qj5eEZCGCK5RcA0gDHT7OBOTO+ITB
         WV+ovGO5itwuXH/rJ5lxbnPIij+3VPbbL62lGIUHxMIkMGrcF38EeKTl970DwxIEY9Ml
         AetDbyLJTwUHBoTZ1vnvvagkT6/CquqH9j9EEnC05H/ErPGGyIxQvFFzHGRxcuWfyBvB
         9Y2A==
X-Gm-Message-State: APf1xPC0foWOKQuKS+50DD+Wo8qG4vVIbCNDHhuuJP8egxChL7WpVb5r
        oDEEC1Q9l9VeJqctDppF02Yvt1Ya
X-Google-Smtp-Source: AG47ELvuHql0wuubqnZqPpLhf1T8Epf+R/hDzz4ssZrw3bdIiNzco3/MP+J6Mps4Iukv1xYVAaangg==
X-Received: by 10.167.128.143 with SMTP id v15mr27890750pff.36.1520546666108;
        Thu, 08 Mar 2018 14:04:26 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x5sm39391958pfm.49.2018.03.08.14.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 14:04:25 -0800 (PST)
Date:   Thu, 8 Mar 2018 14:03:56 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     public git mailing list <git@vger.kernel.org>,
        "Carsey, Jaben" <jaben.carsey@intel.com>,
        git-for-windows@googlegroups.com
Subject: Re: recent glob expansion breakage on Windows?
Message-ID: <20180308220356.GA171451@aiede.svl.corp.google.com>
References: <e0ba9fb9-056e-4979-415b-f8eca47e2490@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ba9fb9-056e-4979-415b-f8eca47e2490@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+git-for-windows
Hi,

Laszlo Ersek wrote:

> Jaben reports that git-send-email is suddenly failing to expand the
> "*.patch" glob for him, at the Windows CMD prompt:
>
> ---------
> E:\...>git send-email --suppress-cc=author --suppress-cc=self --suppress-cc=cc --suppress-cc=sob --dry-run *.patch
>
> No patch files specified!
> ---------
>
> Whereas, moving the same patch files to another subdir, and then passing
> the subdir to git-send-email, works fine.
>
> I seem to have found some $^O based perl code in the git tree that
> expands the glob manually (in place of the shell) on Windows -- however,
> that code looks ancient ^W very stable, and doesn't seem to explain the
> sudden breakage.
>
> Is it possible that a separate perl update on Jaben's Windows box is
> causing this? Or does the breakage look consistent with a recent git change?
>
> Has anyone else reported something similar recently?

This reminds me of https://github.com/git-for-windows/git/issues/339.
There, Johannes Schindelin writes (about a different command):

| This is expected because neither PowerShell nor cmd.exe nor git.exe
| expand wildcards. Those examples you found were written with a shell
| in mind, and the shell expands wildcards (hence Git does not think
| it needs to).

That may or may not also apply to send-email.  In what version did it
work?

Thanks,
Jonathan

> Thanks (and sorry about the noise; this list might not be the best place
> to ask)!
> Laszlo
