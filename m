Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26CCC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 19:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjBCTna (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 14:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjBCTn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 14:43:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE392194
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 11:43:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d2so2379091pjd.5
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 11:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ta7N5UWWEIpViLnoue6pTfugPnzVHGSmAl47l6sijk=;
        b=HyVSd1pekxJr1iyd/buWiwYLCryTYQEvynX6+S9Hs+ePljf3F870B96eOraEa0fwAb
         eFyyxdBiOvL3i1033O3stKF/dRt9vGSPZ1PwfiQxgojEnKteJ0jPm4Fu+Tz6fmmoCdHF
         Ic+f9Ks05+lf14/kxm0haU8kTrlZHIwhoxbXMK074ER3h4lMpH2ANT6b9lu8dL2CuQEt
         +Oihdrli6ayFTyRmS/eSBrD1HpR7PsyvN8836sVkb8xbPyw1T6AyQ6kpMPIVcYFqQC9+
         oDkX2/mt8f8+0jZOXgFP7ckoncf4u1OiZBrgSH6LINhHRuxK5EzyxoUE/ERfH+mlNToI
         0OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ta7N5UWWEIpViLnoue6pTfugPnzVHGSmAl47l6sijk=;
        b=FeKiVPzdwa1n6G3NrkfTYCRVxFFhrPFbu1SPpDPYZ06lslgw/8WbPdRl73C/kO3COK
         Sl5mMwiUjNyoG4V3EoX8nP1AeFuKxbnlnG7DiwnY3QsNrEL/uyhABkN9xma/5EN5/iTa
         ZaI9Yme34+ycwOy2fQYwSVa5x6Kj/VrbWPsp8si0HxrL6eWoPrwT2ykZ3TFX78uYaIwx
         UEkaCL5izVUt7T9BsQ2wPycAKJslFgU0XxZrziMnkJk1DYBRUEM4GutaSUIIrJE3DkKM
         yizyhVNqpn50GIbcBlmgOD2C09EaxTOORg+/d4NnHubnvKR+5K/PkzumAHOJ8H9CwxhU
         8UJA==
X-Gm-Message-State: AO0yUKXKdZHXClU8wYbzJYVD56cWH7nxvBFY8L2nq9UZb5HrlHJ/Qcjd
        JCeZgREVaikigSk1ytw5fjo=
X-Google-Smtp-Source: AK7set97QfQx9isDQbTdyAWy2G5AGapnhHYGin5g19EHLi/HEswGcCKj514pZweoTfTDTYM5zqPdgA==
X-Received: by 2002:a17:90a:358:b0:22c:b496:88e with SMTP id 24-20020a17090a035800b0022cb496088emr12292752pjf.12.1675453407516;
        Fri, 03 Feb 2023 11:43:27 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id mz4-20020a17090b378400b0022bfcf5d297sm5498752pjb.9.2023.02.03.11.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 11:43:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: The sad state of git.wiki.kernel.org
References: <20230203182255.lqla3hsme6riy4w7@meerkat.local>
Date:   Fri, 03 Feb 2023 11:43:26 -0800
In-Reply-To: <20230203182255.lqla3hsme6riy4w7@meerkat.local> (Konstantin
        Ryabitsev's message of "Fri, 3 Feb 2023 13:22:55 -0500")
Message-ID: <xmqqedr6o7q9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> Today, most information found on the wiki is probably outdated and therefore
> potentially harmful. I would like to solicit ideas what to do with this
> resource.
>
> # Should it be migrated to RTD-style docs?
>
> We have stopped providing new Mediawiki instances at kernel.org quite some
> time back, replacing the offering with Dokuwiki. Today, we don't spin up new
> Dokuwiki instances either and everyone is steered towards readthedocs-style
> documentation instead, which is a much more sane and manageable medium than
> wikis, especially when it comes to technical docs (see
> https://korg.docs.kernel.org/docs.html).
>
> However, it's unclear if this is even needed for this wiki, considering the
> existence of https://git-scm.com/doc.

I tend to agree with this point.  Presense on RTD is nice, but what
is left in git.wiki.k.o is not something I'd consider porting it
over; the contents of git-scm.com/ might be but that is off topic
here.

> # Should it be archived as a static site?
>
> It's possible to turn git.wiki.kernel.org into a static site with a large
> header on every page that it contains historical archival information, with a
> link to https://git-scm.com/doc

I do not know the size of regular traffic to the git.wiki.k.o; if
many people visit (on purpose or by mistake) there to warrant such a
redirection, then it is very much appreciated.  No current contents
with just "redirect in 5 seconds---please update your bookmark" may
be fine.

> # Should it be archived and put out of its misery?
>
> The last option is to just archive the site and put it out of its increasingly
> irrelevant existence.

Archiving so that people can retrieve the contents for whatever
reason may be needed no matter what other things are done, I would
imagine.

Thanks.
