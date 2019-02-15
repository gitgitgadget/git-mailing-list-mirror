Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1021F453
	for <e@80x24.org>; Fri, 15 Feb 2019 09:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbfBOJ0m (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 04:26:42 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42912 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfBOJ0m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 04:26:42 -0500
Received: by mail-pl1-f172.google.com with SMTP id s1so4659152plp.9
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 01:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2vthIsePX454tXsVeYmshqRTjq4y5UqUOiGEVGwUFCg=;
        b=OlzRfmQBvQgxh3lRfHqaj6uq52aJUlNOd/ON9eDb/g1QP0IN/4+cLFT0rFOx7Izz45
         9rrJ2RBGve3MhdS57qp4Spez/zbWhJv475fzj13vfzZoccQ2PGULypUBRAreuXMxKytR
         CQ/83RviLZbbS1GjQX9tDU/GmnGZoAvAwh+9ZigUYiElQgn9WSQ6N/huhft+VOTjAaCZ
         Er1qsXkF8Z6R+eH2dpGnfjPKDRHzVCR9jdUpORj1SV9NdEK48DUqO9fvdv7fqP43VCNJ
         ElkTOzGTSFKfPXoA2Wv6G1vO1l85FMpZZh42Eu7tC/AtnRriNDwYJfVMfj7fzVo6bEuT
         3rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2vthIsePX454tXsVeYmshqRTjq4y5UqUOiGEVGwUFCg=;
        b=oPRGeL9LCiW3oPxux1BYEuVMFJHlshnef3q/LVlQG5XofV2AJP8EkOK6v++ImAZeKJ
         1s4ABSlv5LiQbKHzkd9tK6f//AdnEDb5YDLRJr16pxGAEduVusLkVmzFxnqe7FB9pyK8
         UnvcDXGJb/n4rgF1QE427u17UreR3ItZPKgSICDLSOqpVrVD9Qcve110ugM4amxvZ/3c
         FnybaBU6Y5GLtsppk3nisrufbVyHHzQV05zeYokif3oP3XUk1MssbDkFJjreudwtNsc2
         qj9yPD7Bzo8RqrFatvV08ZdueEo9TPvvjQOm5svhAoACkcr5MhqHLTr9cUSVtiz8X6JH
         6Czw==
X-Gm-Message-State: AHQUAuYB3vMc1YLqMowjnW+Cn8Eoe7uq7JcgRlUsdOMcDeYxJ1qe/n6e
        fpfE6BK9UplVishmkBd7FTpqCso9
X-Google-Smtp-Source: AHgI3IY/N0o9YSMxBhKFI0kMYrGCrtssmZfMQupoDmFITRIloKq4j5kda1c7QYSfaxdEiFsZnyhW3w==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr9336295plt.188.1550222800690;
        Fri, 15 Feb 2019 01:26:40 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id p12sm11918531pfj.81.2019.02.15.01.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 01:26:39 -0800 (PST)
Date:   Fri, 15 Feb 2019 01:26:37 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 0/1]  Document git-submodule's default behavior
Message-ID: <cover.1550222580.git.liu.denton@gmail.com>
References: <cover.1549965172.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549965172.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, Junio.

Changes since v1:

* Incorporate Duy's suggestion of "The default command is '...'"
* Fix additional discrepancies between git-remote and git-submodule (on the
  submodule side)

Changes since v2:

* Revert "The default command is '...'" back to original text
* Drop "git-remote.txt: be specific about default behavior" as a
  consequence of the above
* Drop "git-submodule.txt: make subcommands underlined" as this was
  unwanted

Denton Liu (1):
  submodule: document default behavior

 Documentation/git-submodule.txt | 4 ++++
 git-submodule.sh                | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.20.1.522.gd8785cdd01

