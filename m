Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3079FC43217
	for <git@archiver.kernel.org>; Wed,  4 May 2022 18:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376918AbiEDSWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376703AbiEDSWp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 14:22:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE3077F17
        for <git@vger.kernel.org>; Wed,  4 May 2022 10:46:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso5834795pjb.1
        for <git@vger.kernel.org>; Wed, 04 May 2022 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uNmjpIGb+MIZmVvW8FfadHGvn3GWM3BTtVy+k53Pro8=;
        b=XZj5vVIHOHDeWU35oVm+k3vjlGY6sviIYEM2towU8sH4+fNnPCSL784JQLV31OgO9N
         /nYA7jh8acD8jJj6ko3RuLaxOn/lvW007H1SCP2JkuG6zZRo0uzNBtAJrks9BW7sOXU7
         /OCIH1ZvOCJEuVM7mKWbuG9KaTqBcL5Vd7AN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNmjpIGb+MIZmVvW8FfadHGvn3GWM3BTtVy+k53Pro8=;
        b=jG/N3nA010cs3OicfM7DVnY91d4CYYRXqeVkjW8OWcBvR+av+QN5kCd89GmX3qzb5T
         0FPiuDi5nA0RuLd4vUaB2LooPv53yFy9Ta7OI3A59ZJjXvDsHiWG76xkndnkjmj8P16Q
         vvp7EGNmh7fE8R8+eKlgF0AwFjyVHmZyh8wXIoh7p3DUuKqfcx59p+2872pBxrUrtOYP
         cyKl1P1FYQMy1LN3lZ9kIU0YBOD2Y46oaFKF6+M04qdzkNs1VKlOc+CTqNCh90+9KBHh
         tOc/GF3EPL/I93jzNvp2WTDsB4AbIF1TunEiVoY4D4blShmCI7I70eVcxcZc2+yOBlOt
         qVBA==
X-Gm-Message-State: AOAM533ddAnzIwK8csP1P1V8a+Q7Rau5VRpYOPNe/UvJVfFkLVGN1bAM
        /9bcIaHp+Nn8VpWMLjcJ2i86TOBT73GLYKYk
X-Google-Smtp-Source: ABdhPJyzMBa36tC1hLp8a0bgMcYLrh8snq3Hr6aHrmYWMxH+9GSY/PaN3amAmDFeXoZtWpRNPfDNmw==
X-Received: by 2002:a17:902:7888:b0:15e:be95:516b with SMTP id q8-20020a170902788800b0015ebe95516bmr6871202pll.104.1651686375407;
        Wed, 04 May 2022 10:46:15 -0700 (PDT)
Received: from nitro.local (wsip-70-166-189-147.ph.ph.cox.net. [70.166.189.147])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090a5d8e00b001cd4989fee6sm3507847pji.50.2022.05.04.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:46:14 -0700 (PDT)
Date:   Wed, 4 May 2022 13:46:13 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jason Pyeron <jpyeron@pdinc.us>
Cc:     git@vger.kernel.org
Subject: Re: is there a short cut - cloning kernel - resolving deltas 3+
 hours and going...
Message-ID: <20220504174613.alb64lkapl3x4lfu@nitro.local>
References: <15ea01d85fcf$356462f0$a02d28d0$@pdinc.us>
 <163301d85fd7$ec1b0230$c4510690$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <163301d85fd7$ec1b0230$c4510690$@pdinc.us>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 04, 2022 at 12:56:38PM -0400, Jason Pyeron wrote:
> > I am on a 4 core ARM system 1GB ram...

This is mostly where the problem lies, unfortunately. Resolving deltas does
require quite a bit of CPU power and a 4-core ARM system is just not that
powerful.

> 1. https://www.kernel.org/cloning-linux-from-a-bundle.html
> 2. do that on a better system
> 3. copy the .git folder over via NFS...

Indeed, copying over a pre-checked out repository from a trusted place is your
best course of action. I've considered providing something like this directly
from kernel.org, but this is fundamentally different from git cloning and
requires a whole different level of trust that I'm not comfortable with.

-K'
