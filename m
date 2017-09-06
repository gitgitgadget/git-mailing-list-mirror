Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AB361F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 17:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbdIFRnF (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 13:43:05 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36119 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdIFRnE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 13:43:04 -0400
Received: by mail-yw0-f175.google.com with SMTP id w204so23779880ywg.3
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bFkrijcueVRfwqtj6GK0hF3vQbkdVvv/PQH8yHqCRDY=;
        b=XJ5qfAUeG74d4LJWOQR4AxF+DeDbDca2LnLqgc4tmVnCHUqZRnfP67mP6EU8+0O1Es
         dp+roC0ISZu4x61+7nHvV+OnGpDIAr/Rf7a7fn7w02RhSxaiFMydbZjx0DMNBnNhhQ43
         bQwIVBfmds3EkqfWLMKMR1wvrz6bnw2Dt9XOQlMrpVZWeVO3L+yhdYfnT7hEll2fAtQA
         AH8QIjExszlqHR1nE3Ve1vneGNe3NXdK+BAEpDrR8y4X16LrpcKBZGqkZfawVqKF8+MP
         35tzvdhVBJZzW+PN4DgaZ3uvvkbTq4FBempSPEeA05gOd40qMtczPNsA2d4AU0wsoOdf
         JLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bFkrijcueVRfwqtj6GK0hF3vQbkdVvv/PQH8yHqCRDY=;
        b=MAzR9Byu32GollVwkb0EPfaw7ssYfgc0WY+BnrBRQkbgt1cEHd0IEU7o+4ZP+HuJv0
         gsMRB0LVQZACQvBsWBDR4PgVwWExXV/5fby0TnDC/CSnrtH3Jy2OGPUkRCzKadwt9CJl
         FRpshGFRLM9LvPHnruvBTZWiHlDPS9lF4m2vSgOzbq+N8P2xHcAdY6TPUjxzDIRkzRWV
         lVaoZMyxUJqp2mzTIe6lNFSlRUymglPPQ7FwuyToeffVq6RANMTFDkdFG3bC5DnXZpDX
         V6pFfvyI5r9la1eY/ESh1cT7ONxZ+2di0oenax2QUll7K5916NYLmOPgOHUtrT3sOM2V
         eJ6Q==
X-Gm-Message-State: AHPjjUhUDDYekUQukWJvV2nvpmBuMotFBWQWrpai+tK0qA0IU0un9+B7
        wO2cIiZneyHyvMlc6IhRQYn8RHnTRFFdi7E=
X-Google-Smtp-Source: ADKCNb6daIybcf/YwTqTD73IAELD35mZe/YaaG9S1CP87CxgToAGgUSnjOGBM11GmjPwM2dZWIxY1/Pe64lJSLJsJ1s=
X-Received: by 10.13.251.132 with SMTP id l126mr2580872ywf.175.1504719784110;
 Wed, 06 Sep 2017 10:43:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Wed, 6 Sep 2017 10:43:03 -0700 (PDT)
In-Reply-To: <CACsJy8BiRM5HE5vkt6pa+dsNmoPjEbRM+UTA3323kPe9rwu9VQ@mail.gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-12-pclouds@gmail.com>
 <CAGZ79kY8cW+6+60bgSAhS69nBWZbn1LA7gT3t4Ddii+MB2V_cA@mail.gmail.com> <CACsJy8BiRM5HE5vkt6pa+dsNmoPjEbRM+UTA3323kPe9rwu9VQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 6 Sep 2017 10:43:03 -0700
Message-ID: <CAGZ79kbw9_hAOTQz6hBsydcMoeK45pkjM-RoNedqzztCZSqbYQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/16] revision.c: --all adds HEAD from all worktrees
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2017 at 4:19 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> So, probably no worktree iterator (yet).

Ok, thanks for considering it.
