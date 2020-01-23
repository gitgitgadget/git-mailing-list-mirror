Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C22EC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 14:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E392073A
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 14:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQFz/4n0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAWOvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:51:08 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:41710 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgAWOvH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 09:51:07 -0500
Received: by mail-lf1-f53.google.com with SMTP id m30so2479722lfp.8
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 06:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cVupsEbXthgeAzF+oudvAJC7+Gz4YN8DQO7Jbhur7wI=;
        b=XQFz/4n0pWnZDVcBHN/jfYTlN1lrLJ2dZF1Egsk+cEqnq6L9EUYMcrk+woJaoP63tq
         /w5J3LxoozhE2ke8ZKxYcGtJPtuVc0rZtwgonUFe3aiamz0est/76SRgPqery+lHlsaR
         c20/32xaD7bvYODUI0nFSsoMv6Syq1xK6I1c90QCrGhDc0aSd/MZjBxO3bkezB+rSKSM
         Z6t5nVcn6W+F5SeljiAsOgFpPTPWLL2J+vIIE63Kn71AsXt27FXIE7vMoyo1szG/GGGR
         WpuQ75FylcfA/3YL7UdpxVIUxMNLKCI32v0MQuR/GTs+RVLIP6DDRoaVHOMxMYECsznJ
         kIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cVupsEbXthgeAzF+oudvAJC7+Gz4YN8DQO7Jbhur7wI=;
        b=f0tRAGNoQMInr61GF9pEbEq6I9g/d7KNRO3RVv0wIPd/C7+QzHKDtK9JlpIE1hjhQl
         g7oshLqaVKsc+Ho2UMicjrwjsdlFIyey3b/57LJrJe0QSvtFCtrUitURH/ZfJ/YlK8QZ
         0AmSGd4fuK+ohBd7ATG/gSNbpW7CtFPawatt/YKAdtolPvWetfTqXHF9M8HV2iLteSSn
         RWSoZEjfXgCM+KB3FpBf9+QUGt/mhIZbFV1bZhcyH1ma1OHVe+rq2koct4ZTjDqRqdmQ
         TR3yzaN6/8eCk+/2TLbf5SfbKMTL+COPYiIXjI2elZ8ntSRfpOalyAwuwUDyX92hSPGu
         +amQ==
X-Gm-Message-State: APjAAAXI/7NL/g7kO2qIwtiF9Iem7EyOL3YD69HFIz8U/qrGHbgncKZj
        l//gsU05unqEwUa3310aZL5kpja+/0UkPASRIOvcpK9D
X-Google-Smtp-Source: APXvYqwZ/IlUBMDf/pSBapHjhIdFa5CzgXyw+J/BWF4gYF7jqY9JLmXbr9t4TiITwnfD1g4ANyOy0sd3n6Z84V0PGnI=
X-Received: by 2002:a19:f811:: with SMTP id a17mr4943799lff.182.1579791065029;
 Thu, 23 Jan 2020 06:51:05 -0800 (PST)
MIME-Version: 1.0
From:   Tomas Camin <t.camin@gmail.com>
Date:   Thu, 23 Jan 2020 15:50:28 +0100
Message-ID: <CANKW80qZ_Fa-h5eQaVhstdyB2cOSTqZQyt9jGtfRuvLnwTCWmA@mail.gmail.com>
Subject: git subtree cache
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed an unexpected behaviour with the cache folder used by git
subtree split.

In the cache_setup function a cachedir folder is created and named
after the pid of the process, however I don't see that folder being
deleted anywhere in the script.

As is I'm seeing the number of cache files constantly growing as new
cache folders are created when using split.

Is this an expected behaviour?

Regards,
Tomas

```
cache_setup () {
   cachedir="$GIT_DIR/subtree-cache/$$"
   rm -rf "$cachedir" ||
      die "Can't delete old cachedir: $cachedir"
   mkdir -p "$cachedir" ||
      die "Can't create new cachedir: $cachedir"
   mkdir -p "$cachedir/notree" ||
      die "Can't create new cachedir: $cachedir/notree"
   debug "Using cachedir: $cachedir" >&2
}
```
