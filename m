Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4644A20193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964919AbcJ0Vz7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:55:59 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34157 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936489AbcJ0Vz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:55:58 -0400
Received: by mail-ua0-f171.google.com with SMTP id 51so22546305uai.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=ifXQJN1Qy3mNRnar00O+E1a6lcbkRomx5h2PaDDmcr0=;
        b=R3Oz/KAatZYdoNqA9K0pSy22shCO3xLXstb5p7CsfZ+hPkJ1AqUX8I/SzYaZl61BGL
         hqfLVFlFluE7oy47L59ybWVlF9HvELHBX/TSLpXixxJ5luhJh567J68v8BmLfiOymp2y
         +07/TQbYe3zGi79jTACBRtTW4CwTvv7A91wYG/AB6A7TjEuGPoXoCGW+3vM/DnrP6tHW
         I/MPgxtHFt1uhK7kXtzdmcVvS5mXm4g80M2Zpx102n4IcgfbQS5D/WjLPNvL1+2q3etU
         +fI8+dBubEhXxg39tjt7bSqNyf/SdLRg2updMwmdhgzHhoGgX5nBR1U9cQKYiZ/dLx6Q
         nlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ifXQJN1Qy3mNRnar00O+E1a6lcbkRomx5h2PaDDmcr0=;
        b=BI8TW5yX1gax2KfQHXsEZqwbQBqidf821o6lfgh0qYRYt6GbL2OVJhu0gKYdvXr0dU
         2I2UPRTzpRXJYmhGoDvIeF8Mj3639d7GBqTQPGGBlrT5+zjlKvypDgtFlXEroQvAjf0N
         7qO6KLR3EC4wwJwYlzqjFKaLZ2Xj4Hd9/0K7iPMINCdt6IjQ67Sq6exkLRwPi0IK/IHZ
         cnDToKVzW4IJF3ct1Q59SUmzZff69JcuuzRKMdOVJGq3MdafAPZWB4CgmmWiAMYFM22y
         /2mK217V/FTqOEjVRXx4VRw7gZ9YKsyySSTdRgwnrLTmrPkKE0G5CuXRMXbtFMxmT8Ij
         IG+w==
X-Gm-Message-State: ABUngvdjD9GOK3R65tYpHyy8hCZ6E3FwlPZ/Sh5xXkiV/bSrJw1wVtIAhdWk8jqKL3FZkwUfiGgGvGfetzoqDw==
X-Received: by 10.176.0.169 with SMTP id 38mr9537087uaj.34.1477605356873; Thu,
 27 Oct 2016 14:55:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.205.131 with HTTP; Thu, 27 Oct 2016 14:55:56 -0700 (PDT)
From:   John Rood <mr.john.rood@gmail.com>
Date:   Thu, 27 Oct 2016 16:55:56 -0500
Message-ID: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
Subject: feature request
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users should be able to configure Git to not send them into a Vim editor.

When users pull commits, and a new commit needs to be created for a
merge, Git's current way of determining a commit message is to send
the user into a Vim window so that they can write a message. There are
2 reasons why this might not be the ideal way to prompt for a commit
message.

1. Many users are used to writing concise one-line commit messages and
would not expect to save a commit message in a multi-line file. Some
users will wonder why they are in a text editor or which file they are
editing. Others may not, in fact, realize at all that a text editor is
what they are in.

2. Many users are not familiar with Vim, and do not understand how to
modify, save, and exit. It is not very considerate to require a user
to learn Vim in order to finish a commit that they are in the middle
of.

The existing behavior should be optional, and there should be two new options:

1. Use a simple inline prompt for a commit message (in the same way
Git might prompt for a username).

2. Automatically assign names for commits in the form of "Merged x into y".
