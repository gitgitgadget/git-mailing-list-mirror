Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3CA1F406
	for <e@80x24.org>; Thu, 17 May 2018 02:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeEQCsr (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 22:48:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40008 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEQCsq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 22:48:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id v60-v6so3986498wrc.7
        for <git@vger.kernel.org>; Wed, 16 May 2018 19:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gtDHMFFYNdBBzO5F/OxorxGBQfxHq1idJEBimMscORo=;
        b=U5swn+/s7RiWT10Jp1Ivrn7V7wi02ZGLojnVwB3qQL8oMs2mAifnibL4mHHUyOF/xh
         AnqUaw1FAOUjuipm3n9vL2LfpNiFw6rfvQFrJRVOnf6dMaNs1a81Of/AOtSUzZLbJTux
         wTPl+ndVW9jlDrgFq11ia57SL/AaagGQEllAs0BRePvzm0z47tY2snLqzb+Ju90D0Ljz
         PzyA6JVhOz6XNJGKa383A6VRpxUVE9Js/asd4sXlu0em6mztZL27z7ABBAp2LyB7XNyv
         /FKdidYVKVHmQrRcOqEk4EPsJvzFOvjaHaCVgRxVnv5vVhGBr40QMRTn4ZA9vODwSWSN
         OyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gtDHMFFYNdBBzO5F/OxorxGBQfxHq1idJEBimMscORo=;
        b=gl9k8tkyFDWgAWXaDw4jAdqZlBItvIjd/+tVWq0/iLaTLYwoE7klwVnI2tG9slYQpm
         L5jjAz6GmASx+9o2fr+TYsp2t9La1hoMd7fodiLylxazjlg8ElelEFeMyLym6HqLCt8b
         Gam4vD7bhubC/tACfUFNeHoQX2fcln3vFvmf46t0KXI15GMGb1/H5WcFzFBn6dOHGRRY
         B12r8HTrK/Fmq4xcy82Cx3mMCChlDjOm6zGGd1biNO8qlEA+gt832qa9d9hVkdEAAg5B
         9VFVqEnjWbwU1gi+xvxxJX9olQpPLyRdhT7CMCsNAI6v8efMmubxkhzM3Y4xyMep8THQ
         DciQ==
X-Gm-Message-State: ALKqPwfoItWyj3/gaWnWGSjyzG7HUPwTr+ycfcpMJr/PrPwunyN4+Cbq
        4DcirmvOnu2yAVtJVo8k6aA=
X-Google-Smtp-Source: AB8JxZrmyBYcsevR/E6zAx8zXQcDNjFSoqZtLYosxSGCdB+Nj8E/dVcgw2DTFRTwiICZUSFe5z6d+A==
X-Received: by 2002:adf:9978:: with SMTP id x111-v6mr2369835wrb.135.1526525325078;
        Wed, 16 May 2018 19:48:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z63-v6sm5911010wrb.34.2018.05.16.19.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 19:48:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Casey Fitzpatrick <kcghost@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com
Subject: Re: [PATCH v4 0/3] Add --progress and --dissociate to git submodule
References: <20180503105346.1758-1-kcghost@gmail.com>
Date:   Thu, 17 May 2018 11:48:43 +0900
In-Reply-To: <20180503105346.1758-1-kcghost@gmail.com> (Casey Fitzpatrick's
        message of "Thu, 3 May 2018 06:53:43 -0400")
Message-ID: <xmqq7eo36lpw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Casey Fitzpatrick <kcghost@gmail.com> writes:

> These patches add --progress and --dissociate options to git submodule.
>
> The --progress option existed beforehand, but only for the update command and
> it was left undocumented.
>
> Both add and update submodule commands supported --reference, but not its pair
> option --dissociate which allows for independent clones rather than depending
> on the reference.

This round hasn't seen any further comment, and I think all the
previously raised issues have been resolved in this version, so
I am tempted to merge it to 'next'.

One thing that I noticed is that "git submodule -h" does not give
any hint about --dissociate even though it talks about --reference
with these patches applied, and I think it probably should [*1*].

We can make such an update as incremental patch on top of these, if
people cared enough about this, without a further reroll of these
three patches.

Thanks.


[Footnote]

*1* It's not like we must list each and every option available---it
is perfectly fine to omit less common ones to keep the "-h" output
manageably short.  But I have a feeling that "--reference" and
"--dissociate" should probably be at a similar level of importance,
and if we list one we probably should show the other, too.




