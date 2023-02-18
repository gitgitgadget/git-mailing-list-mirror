Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D11C6379F
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 17:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBRRAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 12:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBRRAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 12:00:16 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F617155
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 09:00:15 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id w8so1041533ybt.2
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVg1N2AipWh7e8z0SG6BC1LnOgrLW+7+DRzzAln968E=;
        b=jw5EafM/tYLuUswkKHyWwHIoYuGX/s1iZkdJJYDIEwG+wwG5/HVgdxij5lMAZulNKE
         sHMwWvOV4JWROdCcexE7idKE4FG821m0tZQlQ+SZOl/QRxyReK/7KQlgof9L0lC3kcIr
         2K+98kS6r3kxqkoNyCXWv4G5tQkrF4Fkj493K1zCHiarbPx8cZT7djNplALOVO8+yCdS
         12UZlXGWPU9pF3ZDpDGOvXOqR5BtIBQxvmx5N85tc/pv6nsD5XySQXYxhVdIBC1RL/IV
         WHBrHYNNdKHY9bjWGMZF3G+gDF2Nz63HvAsyk1wkK1MFD1xKMjZhjiZfZHnCZuXJarP3
         3Z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVg1N2AipWh7e8z0SG6BC1LnOgrLW+7+DRzzAln968E=;
        b=rNGh4lvOsXbK7svVFNjBPdCJfWM1yycgR5PklfhNe2E75TTnMnd4ZCRsEa8E+MPXPg
         +uH5dgdbb/UxSqZARb8hHznObE95Hi+P23LJPUrHUqi7BQZwvQCh9Azv4Bi4PVwkQYHo
         KflKCygQ+C5bjo0honfWGoBPCxZ78uMXW0J9pd68R0SAY1jojaFKVDUGJrzFoBy4Ipaz
         67lJ/kVu/IZnxKZX8tIb0v1oS1sxD3l7D0C740ycpXrFwBD/FLFncv9CLIFik8tEHZXQ
         w/ohgSfwgOpcOXe+d9Ha1qxfffzrkm8OGYlE5XRN0lcfkStoHt4xCssOW8N8F2ZjMcXu
         Q17g==
X-Gm-Message-State: AO0yUKWxMs7kNzs1j9bdpO+hBC82l8M7mL6Dx9q4MBztFbA2sE1f7qQA
        0hiJiw0S3OB8mU4XHak4GBhX88qGcBujBIXKjJEwFGUCVCs=
X-Google-Smtp-Source: AK7set9ylQs0cf/B9ZvTF/hJLmLDUG/5EeeJ1Lk0WOlOpX+2ZoU5LSFbiKH7o1BjkRU8UlAPK54JRU6kgVWIMBgxB3g=
X-Received: by 2002:a5b:c4b:0:b0:92b:434:7ee0 with SMTP id d11-20020a5b0c4b000000b0092b04347ee0mr1425046ybr.53.1676739614371;
 Sat, 18 Feb 2023 09:00:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.606.git.1587412477.gitgitgadget@gmail.com> <20230217172035.79864-1-five231003@gmail.com>
In-Reply-To: <20230217172035.79864-1-five231003@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 18 Feb 2023 18:00:03 +0100
Message-ID: <CAP8UFD1k4S-J0UXiFS9mdn_TqGc2kb3iaVYUP2ektrJ+uJZMWw@mail.gmail.com>
Subject: Re: [PATCH 0/2] [WIP] removed fetch_if_missing global
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kousik,

On Fri, Feb 17, 2023 at 7:22 PM Kousik Sanagavarapu
<five231003@gmail.com> wrote:

> Are you still working on this? If not, then I would like to take this up
> and write the tests, if it is worth doing. I think it would be a better
> exposure of the codebase and would be helpful for GSoC.

I don't know what's the state of this. I think only Hariom could answer.

I am not so sure it will be helpful for any of the GSoC project ideas
we propose, but feel free to work on it if you want.

Thanks,
Christian.
