Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A331F454
	for <e@80x24.org>; Tue, 25 Sep 2018 15:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbeIYVKa (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 17:10:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43480 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbeIYVKa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 17:10:30 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so20674712ioa.10
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvE5TUUYfgD//OESdRu3BkeX0BzZ7NthZCF93Jbu2Ks=;
        b=Zr+uCH9Hb0vq1omuO/Qxjj5gpbCp89kHegAbDh0vfbCfX6p9uS+BiIcfNYIWHhlabW
         axYoOaWWZeQNTWPO8vM4Ya7yaZ5/iedJFLjJ5a292w+Ap45b6WXzMuSBY88BY7DmWjOi
         Ptblrw6guB0N9lZSmTYu9Uj2VTj82yTCAKBQqG3zBPVUnzo4eAE85gfRIsuW1XWh33eK
         r/OnB7oq1L7He++1R/BOPmsaZUiebq3LNl2R9Xv8E3kz0ohES+tFrKBypsiK9HsNFTYj
         TP983y6miFTlB+jBHBb1JSB0WZot+pVqetp9vSbA/JfxM8gxsMIpB4VC1OAZEzqN2aW4
         CBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvE5TUUYfgD//OESdRu3BkeX0BzZ7NthZCF93Jbu2Ks=;
        b=Vv0FWLZy2RED23ghzIFXb4YxxpPiCZsFy+VIvE+HzaIEkr8oZILc3BmZ7PFoib5Ddd
         MCFgpsN/TAfqbY4V6W6q0IH0bgHs+tjZ1Rg9XhpqtAIIfTFhsEa8+z2fS9bkJKElzNis
         2+gzG8xuEZdtdUVTpDSLRWJVtrXbDIZEbUr0V4zuXvhnNfkfabLcHMtCpx/ZLLNiHCg5
         y86duDc0AhjtWgLaSyL9AWlELoos5y17i9ui3SaPRAwtN+bvhJbIj5xDwRS+R5+JRXqJ
         aiDwpsCKjEE5PCLhUjStVju32H0Lns689jbZU9OCaqoD5x9BZ+AIjMb6IF5d++b0k4aq
         K20A==
X-Gm-Message-State: ABuFfoj/VS63KwSXNBbkl0UMAHQq4FhoFSBzaobR1S26IQlPEDhZPnmr
        XfY3XY+g1aVDIeqFHMGJAv1UQmI/8KyMOgL6BI8=
X-Google-Smtp-Source: ACcGV63TSLHhs50gIcSxUDVvQIIVJdBHsx4fJojlhUQLLGlzWdEHcfMFz0QC8PIhGoQvtr61JygshHySubGMsByUnJE=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr1192668ioe.282.1537887755032;
 Tue, 25 Sep 2018 08:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180925115341.19248-1-chriscool@tuxfamily.org> <20180925115341.19248-9-chriscool@tuxfamily.org>
In-Reply-To: <20180925115341.19248-9-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Sep 2018 17:02:07 +0200
Message-ID: <CACsJy8BzWnapt_pifkFoFApJGB+Lv_KzQOz7fzd+xOHvn-mHfA@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] Documentation/config: add odb.<name>.promisorRemote
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>, dev+git@drbeat.li
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 1:54 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> From: Christian Couder <christian.couder@gmail.com>
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ad0f4510c3..9df988adb9 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2655,6 +2655,11 @@ This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
>  environment variable, which must be a colon separated list of refs or
>  globs.
>
> +odb.<name>.promisorRemote::
> +       The name of a promisor remote. For now promisor remotes are
> +       the only kind of remote object database (odb) that is
> +       supported.
> +

Nit. If this is the beginning of "odb" section in config.txt, maybe
move this to odb-config.txt and add

    include::odb-config.txt[]

here since we're moving towards splitting config.txt for easier maintenance.
-- 
Duy
