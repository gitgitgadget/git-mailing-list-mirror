Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6241F453
	for <e@80x24.org>; Wed, 23 Jan 2019 21:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfAWVXH (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 16:23:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33758 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfAWVXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 16:23:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so836864wmh.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 13:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3Ep+RH+H7Mx2WbGS22wVXD+flnkCtVRvGkoWsu9x02M=;
        b=pGLgfgifBuMtesyc+YDH67wjCvTvSZKcWD5qLO+JggPkTP1rLDwQW3arPEegWgWSZX
         0tIJHm4fv9UmErYay9UHeoR7qDRHuWrK+oNRgFn1vW2EHk7W1j7dqE8afWMijPGIOTSo
         SfT3czVlgDPSHWWjFfr2CMd1t6TYSfhi9JryMZkcWssScVaTK5CDOr1rVWc57ges8utb
         bqxnir1lznJsVUjgjerp7jsZtYRiSf8aQ3uY+XrzLJ4BkaXofKf83QNMseebdFoCBfzI
         6qmnPtHl+RHM8s0+1dtNB8iangPoWK+vWBQwG/bDDaTAYkXQA5Td8qoQhrs3yRlqeRoJ
         80qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3Ep+RH+H7Mx2WbGS22wVXD+flnkCtVRvGkoWsu9x02M=;
        b=TGtQXXnjkwxpjzW+d2Od+hMMEWa3ETV2ZdhdYuz0RoCnky7QgZmJPmcfcLmg+/4Ai9
         I81ria7fpv4Gp2C2qLov7liqyBcBCXtVjkmQCOh00bjdxun/nbjJ254s2MlhdiBgg3m/
         uqIMk7RPdE/bLo6w8lzUr1VjH+QikA3iZX2c83vLe4a92oeUDgoxXvGJn9jJch66CBQR
         Xcfv4+nMWqzdErUvWA2ZQFLwYivmGurtRPDN/Iv0yuySbt/VFIpYII9Qb5uqpE/d2NRP
         hgTuE8HLTfN606hCEH2MR723K6hHBB5UagM7tQFYmtvTZU+l/2vsnYBEf91n0DHgiAVr
         +1eg==
X-Gm-Message-State: AJcUukdPDlrg4y/QpJoUfiAoOhKGAfC8HNF0UW9+GR9UhjRqbkCbYfNU
        DligZgJxBbayjfxHwWRcg5I=
X-Google-Smtp-Source: ALg8bN6l1EaGeTj/uyZz6OEtkuImjFFRm/s6lHpgyVTE0oov4ahfC7DGXr/AhCAr5n6t4V6f3iYnYA==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr4504617wmf.144.1548278585377;
        Wed, 23 Jan 2019 13:23:05 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l20sm214674572wrb.93.2019.01.23.13.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:23:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, asottile@umich.edu, benpeart@microsoft.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 0/2] Fix regression in checkout -b
References: <20190118185558.17688-1-peartben@gmail.com>
        <20190123200201.7396-1-peartben@gmail.com>
Date:   Wed, 23 Jan 2019 13:23:04 -0800
In-Reply-To: <20190123200201.7396-1-peartben@gmail.com> (Ben Peart's message
        of "Wed, 23 Jan 2019 15:01:59 -0500")
Message-ID: <xmqqr2d39ih3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> From: Ben Peart <benpeart@microsoft.com>
>
> Minor update to comment from V2.  Also wrapped commit messages to be <80
> chars wide.

Perfect.  Thanks.
