Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790501F403
	for <e@80x24.org>; Tue,  5 Jun 2018 14:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeFEOwI (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 10:52:08 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45674 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbeFEOwH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 10:52:07 -0400
Received: by mail-qt0-f196.google.com with SMTP id i18-v6so2663748qtp.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I+rLJxJ5PwIPRIdOCZPXs8jKeQSg1Zc6YIRb3In93Iw=;
        b=g9B5ayj01cH3uQM9oDZl/2VQeuW2tSDAsGC5Ivru8Zp1mM83gjFhiluociio1JA1q7
         6ModEhe/m5z6IScg3lPvfIB44R2GGslIMEGAGdoZvKxqDOwxgBOYgozYO9P8qD6GbwFS
         YxAI7Lo25PX3//bUDE7KTiaLc1k2WVcu5epWsksNTUzKnKMIK1f34+mNqQqEDswaOwTG
         B5Tn/PBXFwEHdMv0NZxRm0HPbcuPVOwrEudbhY3ieTu+AIn7yWBwPOpf+UzNVpC2DBQ6
         4KnXI5vYLzj3mjLEbDJgzdyTXT5LUlwx9HJPyRgthqYgIBsiavaOvI4DE4zR1UPuXopV
         SWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I+rLJxJ5PwIPRIdOCZPXs8jKeQSg1Zc6YIRb3In93Iw=;
        b=tHD02cv3KBOo9WRQ98O/ZzYh1fPuiGhUa4aK2EcyTOQjQ0jVBin/h47091LQkXqop3
         uGd5P2yRiF+nXkntTEsyzRZ7+xpM48OeHxD+ZjOCoXkdaKI4jPmVQ63ArSchHMM2KarW
         g20GKyBaJYTb2UvP0dYWWUYgTv6c81oxfRk7Yv67A4Cpr00YIJfr2DAxqLdkzQtbKn72
         kCiSpuHxcKZ1EIZzuZVWv/0Os72IWWbvENwDqQrU+X3oCKq3TN4ijljDs0RI2t+/xaA+
         a9RExp8BpKDXboxsFYaYy1VytrH9kyqVsBeeo9vq7zx03F4AqA4Dshy9QWLYBMANkORI
         ZybQ==
X-Gm-Message-State: APt69E3+iAFNAT7NJB3e5V+xz1FeZwcJuFx5Oz8acHN2C/Sj99QgL9Bc
        C7rZv7kE7In0yJpfcUWE+lx+k6DYtJOH7iRFsDk=
X-Google-Smtp-Source: ADUXVKIhM8+Yru8sf0LuXGcN9Bd87Oqf7g8GgxdxcTo1Dn4DqFFfKB00A7QEDMdrOGhnD6cCXQ8IbwKRG4ih8T207fI=
X-Received: by 2002:ac8:65d1:: with SMTP id t17-v6mr11815363qto.347.1528210326847;
 Tue, 05 Jun 2018 07:52:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3ff2:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 07:51:46 -0700 (PDT)
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 5 Jun 2018 16:51:46 +0200
Message-ID: <CACBZZX7N2xy0iX-zqZG2-g-44D1+X1bK38oqMWrWX0ZE1v9C-A@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] Integrate commit-graph into 'fsck' and 'gc'
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 6:52 PM, Derrick Stolee <dstolee@microsoft.com> wrote:
> Thanks for the feedback on v3. There were several small cleanups, but
> perhaps the biggest change is the addition of "commit-graph: use
> string-list API for input" which makes "commit-graph: add '--reachable'
> option" much simpler.

Do you have a version of this pushed somewhere? Your fsck/upstream
branch conflicts with e.g. long-since-merged nd/repack-keep-pack.
