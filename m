Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EFDC77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 01:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbjELBgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 21:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbjELBgt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 21:36:49 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B53E6D
        for <git@vger.kernel.org>; Thu, 11 May 2023 18:36:48 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-55a26b46003so142466577b3.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 18:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683855407; x=1686447407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=go0CzKclkFozb3xrj4/uXnUBbDYFLo68xWzDyu0QNLQ=;
        b=ZyAPmTYI4nNKJEr1Qfficfc9m7bbSRcKdalmi7p/ThXx0LS3e9RgOE9wJjdKYgPBNw
         NGP2zf20oQZPc4t+JC9bCWxd/9tyy8rHTLl5POKR9Cu4IyUSPNtZaoasNFp/px+DOb6u
         QDmPvzmOCEqKC8gBWcajrwFRzh+vwOVQpmuOyHgmWz7Jctgbb3XglGDHK1bETSjRnPQf
         S1dwN12YNoS8ZzF9P3/uMw4juSXjY9fZ+4YI3jU3l1RlI7n4WM1EIi04RQZnk3U01+6J
         IsdCXMg0eZiMnpJF3AgfBtNZ6DvXsLAn3Ctge3k3uI+e8Q6HLq99uDnXCTGFehbjQfMM
         zYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683855407; x=1686447407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=go0CzKclkFozb3xrj4/uXnUBbDYFLo68xWzDyu0QNLQ=;
        b=ViN36jQXEfnUXT62fvsHstgggA6cQ2MBbvcOWMqic4tWDFiGTUcXQIm0UE6Q7eN3Zx
         uSnnnXXF5u1Ga3qVwM9ps/SwnRxv3JH4ZjGzcamQ7GacnpQJ22lAOSYTLQJXCagvUx7X
         LMGdu8bZ06xHDzgBSTp9E/8mGwF9clynlZtrwRy2TtfbuW8fXLIAX/UNP5biJ32c1L9B
         KCwb5Xl2fyWK9LfFBU/3KNcc9W2SC0ojD8f4T7A3fAPPDgvju3BhTJwV6BXmH+wTuL4j
         F/5tPyXw26wh+fBYO9bsOUQJ6E5nHJUPcnoatfzeouHAOarJIa9RjzluQZE55TQcLUux
         kVGA==
X-Gm-Message-State: AC+VfDzKgjs9oYLmxMyQaT8/cxN0oYNHS2ACPjUyqK8T1jg+aSxtzENj
        LpuzSD3s0vX96MGt+Xr51wN5PPu4/6u72LFqUXU=
X-Google-Smtp-Source: ACHHUZ7pOf+HME4FekVMHKBWUK61rKPoICz87MqW4IWViJx+b5FTH/20815UMynVqnLly4nP2i2xZcr+02F6rY4yzek=
X-Received: by 2002:a0d:ddcd:0:b0:55a:501f:2a51 with SMTP id
 g196-20020a0dddcd000000b0055a501f2a51mr25180457ywe.22.1683855407703; Thu, 11
 May 2023 18:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo7mqs7rp.fsf@gitster.g>
In-Reply-To: <xmqqo7mqs7rp.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 11 May 2023 20:36:36 -0500
Message-ID: <CAMP44s0GAiFhoHFo4Ex464utf2Jm1F-LEdX2PZdUGEdp5x6Liw@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2023, #04; Thu, 11)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * ds/merge-tree-use-config (2023-05-10) 1 commit
>   (merged to 'next' on 2023-05-11 at e0dab53028)
>  + merge-tree: load default git config
>
>  Allow git forges to disable replace-refs feature while running "git
>  merge-tree".
>
>  Will merge to 'master'.
>  source: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>

Why was this series merged after only 11 minutes of review window? Are patches
from GitHub favored over all others?

As I explained here [1], this is clearly the wrong approach because it ends up
calling git_default_config *twice*.

The simplest fix is [2], which simply shuffles one line of code.

The proper fix is to reorganize the way merge_recursive_config() works, so
git_xmerge_config is called only once at the right time (before any
option parsing). That not only fixes the reported bug, but also makes
merge.conflictStyle work for both real merges and trivial merges, along with
fixing other issues.

[1] https://lore.kernel.org/git/645d672447ebb_13d3fe294f@chronos.notmuch/
[2] https://lore.kernel.org/git/20230511215608.1297686-1-felipe.contreras@gmail.com/
[3] https://lore.kernel.org/git/20230511235951.2309462-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
