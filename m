Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93D591F404
	for <e@80x24.org>; Wed,  7 Feb 2018 18:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeBGSLC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:11:02 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33852 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754002AbeBGSLC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:11:02 -0500
Received: by mail-qt0-f178.google.com with SMTP id d14so2855818qtg.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 10:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=k7hkaIQnd9qys6SqOco3VvgyUKkVERD7a+FMyYFyvV4=;
        b=bKBek++Sy8trqANC8U05ooJ7EStjRrmTp577S8uADHH4b25gK8gZDa/46C5u+gaZ52
         MXwKd5IU4jeMiBQ4D2kiTF5y9yZ/H7FuwvqSbAiG7etl08+jLo4eWRObn5h3kP0L1wEr
         ZCqN3BGGRE0uJGcWtJJhsj8GXL/7LRNBSc2Hkaiz05PXSfyYe6m5DLoU+qtynFst/zM9
         cUz17sgjb/AOMblBbyVlNEqkR6LD+I+o6go6NLm4LtBCbi2/q8eauKMc8TGHstlI5KAh
         SSkCwIUeskv2PErtG2WI1WWn5agn6J6h7KFLssswRIrbFdtWQezDdz/4uCnwI22aqipu
         iPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=k7hkaIQnd9qys6SqOco3VvgyUKkVERD7a+FMyYFyvV4=;
        b=ACgL70sg2WaxaE6K5KFAXXU+tNt3Ozo7JoCG/TdgY0s8dGpmn5RRlueQkwW9MXzJdT
         0FoG2+L4jPfX46rV6ZsLPIABFQSdTBYDbROwIuX3ml7WGNl5QWeMcrS/2QAFu5D9SvS/
         ToHAP/XxluOW/cBuqG058OfZ4JrQvAGqEQQBMD2GZtftVK6G34hnR08EvPZVA6euncLC
         mud6qGLsP81mwXGCcqFAl9vzYqLrl6TmJpyODTmfTtbMRHQkG6DgTCiW88MAZ4azqUUu
         lKc2GkFusgMr8MB4kYh8gwf+7YRVpozy2FAvt0XP+QrUyyZfTLuHvB0pHBOZCJYkl47D
         AHuA==
X-Gm-Message-State: APf1xPC8OxkhPODrxQ+JHfEPEltZ7ExQqJQ0eb1sikWKSQjXJWTakQoh
        maoy5UvmxXTWH61eRwgaU9NEsipDVr2RFeIwe5U=
X-Google-Smtp-Source: AH8x227M6XWyfk8HMCCmRhObbFQXWoaONM9AhR5QZ9ndwqrrSAHK8oYtXUPadDXCwE88xkJhS7iORaPu60p0SCd/srw=
X-Received: by 10.237.41.38 with SMTP id s35mr4477855qtd.333.1518027061274;
 Wed, 07 Feb 2018 10:11:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 7 Feb 2018 10:11:00 -0800 (PST)
In-Reply-To: <CAGr--=+V6zBo_0c_pX=PNVq1+8N-Q14+wgYx1j_odSGcRAv0hQ@mail.gmail.com>
References: <CAGr--=+V6zBo_0c_pX=PNVq1+8N-Q14+wgYx1j_odSGcRAv0hQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Feb 2018 13:11:00 -0500
X-Google-Sender-Auth: dcwUZebD-g_dNNB8WKPZJiifhH0
Message-ID: <CAPig+cRbwiDKgtZ4q5fTihHEc5Jyrmc9ZMkVf6jA6NeV7_fE3Q@mail.gmail.com>
Subject: Re: BUG: On some Linux systems, "Stage To Commit" hotkey in git-gui
 stages one file only, even if multiple files are selected
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 8:29 AM, Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
> Steps to reproduce (on Ubuntu 17.10):
> - Open git-gui in a repository with two or more unstaged, changed files
> - Select two or more files in the "Unstaged Changes"
> - Click CTRL+T to stage the files that you have selected
> (Only a single file will get staged)

This was fixed in Git 2.16.0.

76756d6706 (git-gui: allow Ctrl+T to toggle multiple paths, 2018-01-09)
