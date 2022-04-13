Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D0C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbiDMU5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbiDMU5d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:33 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86861716FB
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:55:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t207so2447718qke.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ruS+2lJgnooN2pzHba4g51vrhi8gyMB5Utsy1vxMQWA=;
        b=uXVBgKOZ7WCcFQGWpXcLKgXUqIndJrpVF8vRwx84vNRy97syexkWBDBTpklr8jzMMP
         ES9MHNuIEM8bKnOul/S35YtOzLa/HoC5jPGNvA8lbrumTq327Yq/U5h3QCX6DQZwF+H1
         eYxtLL8tYCe/sCyJfqkpFFeZu0Rba+9hRh3Vawzm++AJ64tSxVp5X2jRdC/0IDOL6BWe
         8FuiSacegA8TSnpeptjE8G7ArUXdXp+G9muPouSpSuT52TxzCYK5gWhRJrCOSQ8Gid/O
         ZesyaurqwgtHOaAZOEdQ4HNUTXXVyDu2lsJwY22g18JOFt77fj4aj7T/AoVpFEJvQnt4
         PTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ruS+2lJgnooN2pzHba4g51vrhi8gyMB5Utsy1vxMQWA=;
        b=hsfskkR997cBx324LyCgWKaug0P46sKU4Sutlywe/AvDhT+u9rE/PwBZOMQ1bUNcZ5
         1yLtAD1uBod3enTUyRh1+u+FDMdl98VCBnjXqz6LrhJZhdS6Dw/20sjtAa+LAMMweQ3R
         dAuL7YwASwwc7rFW2A1IG2wNmQMHEt2qHw2kNtjIEnpwh4eGkqZHBV8Fxh1Di9uv7Un5
         efTM67Qgt18Tzx/Y/cTl2Tt0dsNO5Vsl6gqqUSlbJgG7UOG47mXikFeiKADqKIFHX/Sw
         F8w/RVXF1kuHUUBNpxprI75gGlZ/ocO+ArxQcv+2kFoQ1pc/gKcioh4MZlTVSc0pLJSu
         jeEQ==
X-Gm-Message-State: AOAM531CXwHeAR8cofWDE2ZPw6cNKqRte2+RA6+qCXQhjEDSA1fK7ivh
        hO6tT4LZksxYRMds35O15JSb3A==
X-Google-Smtp-Source: ABdhPJypfoqNEa0OYgM05yo/jFyvx2TeKcP+lU3UMwrjcKLvC63RALQsIdnAz5LxL0726nlFg3qw3A==
X-Received: by 2002:a37:614a:0:b0:69b:6f6c:c412 with SMTP id v71-20020a37614a000000b0069b6f6cc412mr8270654qkb.55.1649883310424;
        Wed, 13 Apr 2022 13:55:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e7-20020ac85987000000b002e1b7fa2201sm6577qte.56.2022.04.13.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:55:10 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:55:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        git <git@vger.kernel.org>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC] Contributor candidate introduction
Message-ID: <Ylc4rWZf380FlEbj@nand.local>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <Yky7xb7nQRR8Vqtj@nand.local>
 <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
 <Yk21JvirO6FyQ3Va@nand.local>
 <e312b18b-f0d6-8980-9cad-74602043a1db@gmail.com>
 <CAP8UFD1x-JEX8MAmpabK4RbKgmVm1VQYNJdX3fP8Op5WMfUgVg@mail.gmail.com>
 <YlCcQw6FuWufLe74@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlCcQw6FuWufLe74@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Plato,

On Fri, Apr 08, 2022 at 04:34:11PM -0400, Taylor Blau wrote:
> Instead, let's keep the project as-is, and have the accepted student
> focus on one of the first two bullet points, taking into account that
> we'll first want to spend some time thinking about whether or not the
> current .bitmap format is appropriate given the proposed changes.

If this sounds interesting to you, I would encourage you to submit a
proposal similar to the ones in

    https://lore.kernel.org/git/20220406200440.27010-1-chakrabortyabhradeep79@gmail.com/
    https://lore.kernel.org/git/20220409184350.1124-3-shivam828787@gmail.com/

Feel free to take a look at mine and Kaartic's responses to each of
those, two, since they may influence your planning / which sub-project
sounds most interesting / etc.

Thanks,
Taylor
