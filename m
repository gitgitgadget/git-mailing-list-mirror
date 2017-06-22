Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2031FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbdFVTib (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:38:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33812 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbdFVTia (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:38:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id d5so4373066pfe.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FLCtmahLcOwzyl/BKJm+/waUAOcK69RYwvK4cvndCx4=;
        b=ZFsLXrE9EC5D+0iqu8S+LIfBiekqXSFi6vQjpA1Fd4bn6MLylx96XGmdfWteJHE/cg
         HV9vIWcNPUCcPcJA2vaQ5BOmXz1AZgycn3aGQxeSdbT2rQkdXByUKmhr/YsFFHouvJPz
         qb9mpCnd55sXkTvzuUMkNfssrif5fQ6Cxo8Zrfz+OMto6Xyqis2BNWeNHPiRjtqUkzo1
         /pdljKjq0vR0MnVmGouMaxQ3NPQwW78W6J1VB5xgKtvK7stsvOT9OTlODUY1A7lEN7ak
         GwlwojnnI+KlALU9LXdCgnk3FJOAaTCHG8vISjbi/X+NVZppBHDyLFvjVZPKnDjPT96l
         2LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FLCtmahLcOwzyl/BKJm+/waUAOcK69RYwvK4cvndCx4=;
        b=gGoJ2nIM33hkEtclX+wHMGITmOdKHy7ElGKyroCsrbhYkRDOZgkaQYFTP4cc2fl18E
         05ljLu61w75f9wOUHL99cRYS7s7Xqf6Rj//+XIDuLstFvIUbXNVbnpo3zv1kuSmWOC8C
         412D31Jf8PCydILFoV40YyvYK5Om8npwnSeEEe/PpNyZIdDWtj8lC8thZ2XWW1W9svKK
         U3/ypX4NamkoAMMxGOX+oKyK48NPEnPthzV2kXuhM/WGjm7wpcBJdWZ1CJ4JOmQp1ITR
         mj2VEVPHmXDG+l1xawKCFJuXkWWHL4hAzi6NtKhqhOozne3L35JMc+BdGrwxyy2QzIL4
         joMg==
X-Gm-Message-State: AKS2vOxVwHLJANDF2Jc7lGdeayeQ9zVG7puzmyiKVWknDzLEV9tqjD3A
        V013ieyw/jqfZp9xDQU=
X-Received: by 10.99.111.193 with SMTP id k184mr4402140pgc.7.1498160309589;
        Thu, 22 Jun 2017 12:38:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id q127sm5100409pga.62.2017.06.22.12.38.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:38:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/5] Move unquote_path() from git-add--interactive.perl to Git.pm
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
Date:   Thu, 22 Jun 2017 12:38:28 -0700
In-Reply-To: <20170622102622.26147-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Thu, 22 Jun 2017 11:26:17 +0100")
Message-ID: <xmqqd19vke2z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  I had some comments, mostly on the structure of the series,
but overall it was a pleasant read that takes the code in the right
direction.

