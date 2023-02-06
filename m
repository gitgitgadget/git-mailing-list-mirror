Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFCEC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 18:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBFSPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBFSPE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 13:15:04 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26811DB84
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 10:15:03 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id u9so8769507plf.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 10:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7MpNi/Lh3enWR6wmgpbH1JD5eQbfdhINSDKcOgreeE=;
        b=vdTAYvKCRc4Zx8n2xTnhFK2Zqe8pSEF8d7td1F73a2lf8ZLQjqBNGIEL49Z2Ttvbig
         ST+nizzK5lJ6ING6MfJZtxJ4UjTIsat9fU8GDCU+yfg7EJzM1QQ8dyv1q1R7tFhc3CfL
         zFRwyBNKihwkV6ry/qgFTlJ00Iihch+rRqQqBnL+MhMeOFn+s9IiHBiB+I6oxu8gcQI0
         311aXj+GihJiviqAInwkAm5rhgdukxxShv2XUQscU1S5MZ9slNaKbx6XC6If7mabwcP8
         b6hChB8KFgYfLJTywfZfBIgSjjInYJB5DApvPsUX8WVx9GFx7r/AyLmpYHCvUchByeL+
         WWpw==
X-Gm-Message-State: AO0yUKVUSS5+90kSmykunY2hH5By7+23SbyvpLn3TXhJW7LdZZJdVGFx
        8Hu3yzlFYczDDF9RCGdTB93uAMUtWlvGOn/u1w9NsDQG
X-Google-Smtp-Source: AK7set91hYfk0Ce/mMMbX7iIkI4b9qRXwCl2XN3G1C0yPaSRIR5DxOAlT+3hq/Smj3pc5QLV+2btB1QqDY/BuCH6R4k=
X-Received: by 2002:a17:90a:7f93:b0:22c:aacd:86c5 with SMTP id
 m19-20020a17090a7f9300b0022caacd86c5mr3570530pjl.76.1675707303313; Mon, 06
 Feb 2023 10:15:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <19f6b40b-d8e8-e86c-5a9a-b35f42909118@dunelm.org.uk>
In-Reply-To: <19f6b40b-d8e8-e86c-5a9a-b35f42909118@dunelm.org.uk>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 6 Feb 2023 13:14:50 -0500
Message-ID: <CAPig+cTTfsP-hTSd=1QF-zZ9WNpHMgO-+18PTmnggz4SANfmMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
To:     phillip.wood@dunelm.org.uk
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2023 at 11:46 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 05/02/2023 03:46, John Cai via GitGitGadget wrote:
> > Teach the diff machinery to check attributes for a diff algorithm.
> > Enforce precedence by favoring the command line option, then looking at
> > attributes, then finally the config.
> >
> > To enforce precedence order, set the `xdl_opts_command_line` member
> > during options pasing to indicate the diff algorithm was set via command
> > line args.
>
> I've only commented on the tests as it looks like Eric and had a careful
> look at the code

I only very quickly ran my eye over the code; didn't even really read it.
