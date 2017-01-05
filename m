Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B27205C9
	for <e@80x24.org>; Thu,  5 Jan 2017 14:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969275AbdAEOCo (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 09:02:44 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:32874 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdAEOCn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 09:02:43 -0500
Received: by mail-qt0-f180.google.com with SMTP id v23so51174142qtb.0
        for <git@vger.kernel.org>; Thu, 05 Jan 2017 06:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/iyXg/6mmyAjuNL3qehIug1LaX1wzqnM3mc+9qnZhT4=;
        b=hU4NfvA7fHZTcztspdRan6bPYhs0WcPGpO26yogA6DZTjwya95gVD5nwgnqiS7WdGc
         IgJT9L/vM1ZFKKIrD2+mj7b1zmcV1PuN6AovtH2dneq5P7aWt1b5JnyVXVyhpxHVX38P
         qQC0rv0/BI4Bty5baC60xR2MnlEkDhYijKfkxv0f4bPzIrt2OF2sqtPxLfwP49QhXUrM
         2R019pUmO2frKl7gnv8fXLcU3I3UC91yH0KGtLEIKodeGHZbiNkxyZ5M+8lLNTLXyvEb
         /nfn+loeLMo9vQQrsBBoMkm7K7SMCt07kBnlHPsKTwi8K81lRk8EgXvEjIOT2QD+AjYC
         O3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/iyXg/6mmyAjuNL3qehIug1LaX1wzqnM3mc+9qnZhT4=;
        b=mFt5JIuhEECSUqnpxUgX59vvvy+ShL47EE8xLSMV/tEReffTM1oLl3ulTGzRVXnS68
         IewDFxA1mulZwrIDktRbDHYx8Y4KgSi+B5eLuLptzbwhnesQSG9x2bj2WqRvFC3evXdj
         /U8FsAz7UwtntfyU3x5iT/1E3HyaXaM5S+pqI0ibrfSO2Mj+IourMlf6LVDcUVTdUmVc
         A8rPV3D/ZRdJxFqTQcK5HHvJ+wr97c7DQwSXq5qzW3dymIplSCi0njfpJCCnQstOUump
         yW/pTQj5DiaXa4+xetEoWWbVocWT02SpZVcVnixaNMox4sajuad9nsIbVIo/4j4mg94D
         s6kw==
X-Gm-Message-State: AIkVDXL9maP+sIB6KsK+MX4iqUtcmdcKBHKy8Z4tPEE8Gdej6QNo0kwmdTAJUMUo9iGAcqCXpaaxXrDNqVZ9ox08
X-Received: by 10.200.37.221 with SMTP id f29mr73594701qtf.123.1483624928115;
 Thu, 05 Jan 2017 06:02:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Thu, 5 Jan 2017 06:02:07 -0800 (PST)
In-Reply-To: <4D106F0FF3D29E4FA1D91C1A31CE4C3501B8DEF2E6@email.novomind.com>
References: <4D106F0FF3D29E4FA1D91C1A31CE4C3501B8DEF2E6@email.novomind.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Jan 2017 06:02:07 -0800
Message-ID: <CAGZ79kaLpf1nzSAgRJQamMGk-327LO+qQYihYVVcU+86n92ivg@mail.gmail.com>
Subject: Re: git branch -D doesn't work with deleted worktree
To:     Roland Illig <rillig@novomind.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 5, 2017 at 2:06 AM, Roland Illig <rillig@novomind.com> wrote:
> Git 2.11.0 gives a wrong error message after the following commands:
>
> $ git init
> $ echo hello >file
> $ git add file
> $ git commit -m "message"
> $ git worktree add ../worktree
> $ rm -rf ../worktree
> $ git br -D worktree
> error: Cannot delete branch 'worktree' checked out at '../worktree'
>
> Since ../worktree has been deleted, there cannot be anything checked out at that location.
>
> In my opinion, deleting the branch should just work. Especially since I used the -D option and the "git worktree" documentation says "When you are done with a linked working tree you can simply delete it."
>
> Regards,
> Roland
>
