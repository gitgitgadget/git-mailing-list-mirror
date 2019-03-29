Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1EDA20248
	for <e@80x24.org>; Fri, 29 Mar 2019 19:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfC2THp (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 15:07:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35232 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbfC2THp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 15:07:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so4038306wmd.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AiWLe63OXrubu7HfSuJd/lMdLXfXcKKRZl3gBkDOpS8=;
        b=TFpvZYLIF03L3H7euf7upxeOYJkC/0vA3pX6Hx4bOf31cy5M6FTixeGxzxKhCrZIP8
         R93KlFOgCR2z/fLziXmbHHFnbPcJZtCXEb86ciDHiJVisnIlPhPQk25Y5hK8f86ZHLAn
         VMZQDpSkKFz44akhJ3a+kdmLYmbXmWwam19zixgkt9VaWL5mttvGl2C+JD+Sm6DDCsc3
         upzj+24r7KyYnCwP//xLyEpoW1Y09ux8l8n/6U/mQAMhxX5YCHMzVo/oOFZTHu3YG/Lm
         b1Ir4h4hr3TvA/C+/yWxEDi0iSgeM6TfkAqYoxU7U0+DqNC77CgSluO2NstiaE89Knxl
         M64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AiWLe63OXrubu7HfSuJd/lMdLXfXcKKRZl3gBkDOpS8=;
        b=nrq8mBYxDg3mDRi5zefVPsC+5G3Yh/37Q0t/HpNw338JRD95o8CyJw6/0io5P/CzGR
         Tv5mx3fRC9yyNpt11sCnT/n98lToZNUN7wN+OZ+uuTtqB5IQ+UNZNZxY8idWbmHf2YvL
         SSrCTWdJ5h0SdGVo82+FVgijfK2n/mebMtr142uhbzBLapu59715rgQhritorn3+7v9o
         ynckzlutdixB4+/XXCHTpmk4KajqjkZvkkcJh8VB5dxsi3sVBrEn8vl8FzoH4fJ4b7Lf
         DdCKRwktE67JnEg4+5WJPUkX1ye33WOm3X2uoIZ+U/GVRWZRHKOw8GFUANVV6XzVADc5
         itSg==
X-Gm-Message-State: APjAAAU/iIRM7YlhQcWnMY/LnQucwDFZKXVBI6as091hK9GokUdUe1Ez
        8+SdvsG6cHvpB4SbrnK1dqk=
X-Google-Smtp-Source: APXvYqwlJL60aqDlC9lZWle8W/fT3pJddvgGpuLKd279e8r7iBIfGW25+wG/Hpoust5S7P9rYSWm+A==
X-Received: by 2002:a1c:230e:: with SMTP id j14mr4698111wmj.120.1553886463812;
        Fri, 29 Mar 2019 12:07:43 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id o2sm2202932wrs.89.2019.03.29.12.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 12:07:42 -0700 (PDT)
Date:   Fri, 29 Mar 2019 19:07:41 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [GSoC][RFC/PATCH] userdiff: added support for diffing shell
 scripts
Message-ID: <20190329190741.GM32487@hank.intra.tgummerer.com>
References: <20190322160615.27124-1-jkapil.cs@gmail.com>
 <CAP8UFD3K4ft7UVSFeaQzKVVGFPwcLcpTKB+sqFN9X9_j_A093w@mail.gmail.com>
 <CAMknYEMBYxp1QJ3Ds9dmuS4ccHKtExx33d_Kv63UOwaUMm5oUQ@mail.gmail.com>
 <CAP8UFD0cWSTZPqqVwTFyYL06S+6aT_EiLPW6jUE0AH9puxevmg@mail.gmail.com>
 <CAMknYENJ+U4urtSEtwDSLpdwGe=x=uq_HdSs-cT9Z+PT5ZQiLg@mail.gmail.com>
 <20190328213010.GI32487@hank.intra.tgummerer.com>
 <CAMknYEM3Tff7Z5HcdNT9-RDTf53RHi1_scpO8JVo3pAD3-0xSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMknYEM3Tff7Z5HcdNT9-RDTf53RHi1_scpO8JVo3pAD3-0xSw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/29, Kapil Jain wrote:
> On Fri, Mar 29, 2019 at 3:00 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> >
> > I had previously mentioned that this project was attempted already in
> > my email at [*1*].  Did you take a look at the thread I linked to
> > there, and the regex used?  I still feel like that previous experience
> > is something you could learn from.
> 
> I saw it, and the regex i have used is a little different from that one.

Right, so one thing you should definitely do is to compare the regex
there and the regex you have, and understand why there are differences
when they are trying to do the same thing.  Using that knowledge you
should be able to improve the regex in your patch as well.
