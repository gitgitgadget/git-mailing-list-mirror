Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD30C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 15:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347692AbiDKPUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiDKPUi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 11:20:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011D7326CE
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 08:18:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p21so19111409ioj.4
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjwLcDN6I2n+1QmC3eGDr/JHUk4e1e3/uYj4WdA0Ug8=;
        b=LdNotxH5BgG99s349ZUSUBFhol0FdVGl3cFYDQ73pFg4ijWC2PsECHfj1BO8T6znG5
         u5UE6gOlduCSaoLaOBMnrfpnACzE5V4BRMD+z0QMQB8imkvwNpbS0hw5LltuHA0nWGX0
         yW7U6x9aoMWhburxiz320oJC+Ozwjs2i6YR4GcfzjtYNOOd8sbmzLMLNh0YiOdpU2P2G
         pKUy/THDPU4Pz4iNYpWYFDYgx6kx5SM3D5gWT6hLuBcgJ5iGyaE51pjy6QvJbqSzXUEB
         lUPIbyA6r44rm8JmSQhvRRJpOttZIKvVX6lgFK0Ds8wA9fSRIOXzKP7UDvf8iUo/OIv6
         Bx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LjwLcDN6I2n+1QmC3eGDr/JHUk4e1e3/uYj4WdA0Ug8=;
        b=VkUnEGdB+kdZWaKdSTS/9e1o4gp3hRUTjf6gpWMSFJazFL3ojuk83SSBPGxIUsKYqX
         MFOVKeXoXs1MhM88oD6DwMxBu0SSL4QuEnPEO7BM7FjtXWhIlgKtbLjf+C7Y4Tuujka5
         nDvSNglJwIH6FR5sqVan3IfhwKeY0QrgAeLA56rA0j0I8wHhQM2OinvXq0huLmskMEe+
         F2D0K1+5FLlDOg2jQR/8yOipsGv0MO8IsQ0VOgPQkN5z+MCSREy4h19dDx1iM8IfIMxt
         YPClLAyqLx9Pw1uilcAs45QdDziOYzmaXWsnrksW+cZqlzzplyVpcS7E4XPr5ir17zVe
         KaDA==
X-Gm-Message-State: AOAM530ChsbtOK4ba8wkTtY8VCsmUtMs/Im3U6b+KxsD9ukb4+uXntJ2
        VyLn+6jHYZ9D1QZmDDUDdfYdQw==
X-Google-Smtp-Source: ABdhPJw/f9PuYENJtx7eRN5OYyIAr7Bpa3MaKX2XcCD5agdbWNPgWDpXUB4R30PmvAvc2zT7VyWoBg==
X-Received: by 2002:a05:6638:379e:b0:321:5f2c:ca0f with SMTP id w30-20020a056638379e00b003215f2cca0fmr14654738jal.17.1649690303874;
        Mon, 11 Apr 2022 08:18:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n12-20020a92dd0c000000b002cac22690b6sm771233ilm.0.2022.04.11.08.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:18:23 -0700 (PDT)
Date:   Mon, 11 Apr 2022 11:18:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <ttaylorr@github.com>, git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
Message-ID: <YlRGvmPCoWn8DFTs@nand.local>
References: <YkcmtqcFaO7v1jW5@nand.local>
 <nycvar.QRO.7.76.6.2204072346410.347@tvgsbejvaqbjf.bet>
 <CAP8UFD2fN=c2JvvzH94Nu8yqt2MOOtXrn29eFxuie9aZ5YVjQw@mail.gmail.com>
 <xmqq35ino356.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35ino356.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 08, 2022 at 11:12:37AM -0700, Junio C Hamano wrote:
> > I wonder if this could be an Outreachy (maybe next Winter) or a GSoC
> > (2023) project.
>
> Good suggestion.

I agree!

> It would take talent quite different from what our past GSoC
> programs saw, from both mentors and "contributors" (we used to call
> them "students").  If we have mentors who can give good experience
> to mentees, I would welcome to see such a task for a change.

I would be happy to help mentor a new contributor as somebody vaguely
familiar with the architecture of the existing site, though I have next
to no experience / good judgement on current web best practices ;).

Thanks,
Taylor
