Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C466F1F42D
	for <e@80x24.org>; Sat, 26 May 2018 20:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032382AbeEZUpp (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 16:45:45 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:41999 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032376AbeEZUpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 16:45:45 -0400
Received: by mail-oi0-f44.google.com with SMTP id t27-v6so7411929oij.9
        for <git@vger.kernel.org>; Sat, 26 May 2018 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Vb2ANm7mqlcoXKUe1cKjklaSr0si3rWsPS+ienoejuY=;
        b=innvptMbowhnBrOgsbMyExAZB4MP9Igymo3XxCvF7YlO8xE1gvsCKQMkxkrvns6s+E
         K2PYn0YfH6H4W4ra6Toi15+ER9uCMwW0t5/mI6vQGIdJGhWbMzy8uNmllsKEdSrvV+aK
         WYnn0DHWGhEnuBWhEiaoF59aEx29ve4QN1ZQamWjtE1ozDbnVTVdmb2jJqFlKZ3JrxKg
         ssZSHV/HxhOtDCn7CVpW7bmPj5WjJSvh7XaBLMizJRYD7b9F5RSAnB4LnNX8ZfiYyz73
         bfyg45q5XzZu54g32FGAVB1mc91aNs6wkyZ652htpY+npr1E+W8CKts+xCC9kvZ80cs7
         eRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Vb2ANm7mqlcoXKUe1cKjklaSr0si3rWsPS+ienoejuY=;
        b=CDZ8GhFQzg2SS6/utC9cpitAjWdeHUiCAQVH5olneqmIiODHJMneVyirr8CWcHUc4i
         wS8zfqW4PrZtkjvcBGba5y3+QI9gGfQUvFRY9H0regeshHUswhF/nJU9eLZSxFY42yi2
         oaq099ayHDwWlB5iwAjFU3t8aMXCh2efRvTVWeu5xZMVw/iPOsjUhY8DMIPmAm6IlFQk
         vWuD4j31yp6p/kCdW1LswrYo35Jc5aGioAXISm20C/7YFXKokW/9X2B7xTjsgmEIqC6Z
         ZFQP7+MHB0ftltQth2pjOWLuy5868dQCcBc4pgQ1fI28MfahCEWLP3aatOO0eDfQ/hma
         VnbQ==
X-Gm-Message-State: ALKqPwe/L3pZ0W0I+WqMgJB4CazRq4bOHTcedRSWwlqlMa2qSsMxY0i/
        WP2iSd1FD0Tujz6obdHlnjtX19EU
X-Google-Smtp-Source: AB8JxZqE40FJvAjeuG4eGavL4aiqwhoDIXNdsZR7CSSWHHpaD+YQ+0W/hSSuf0D2Dovbkp2Dkbkz0w==
X-Received: by 2002:aca:e889:: with SMTP id f131-v6mr4455568oih.324.1527367544282;
        Sat, 26 May 2018 13:45:44 -0700 (PDT)
Received: from [172.16.100.100] (cpe-70-113-92-26.austin.res.rr.com. [70.113.92.26])
        by smtp.gmail.com with ESMTPSA id p3-v6sm16329423otp.2.2018.05.26.13.45.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 13:45:43 -0700 (PDT)
From:   Jeff Felchner <jfelchner1@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: 2.17.0 Regression When Adding Patches Without Whitespace In Initial
 Column
Message-Id: <C6CF9BE4-FC46-4B39-A862-AEBB5CD600E2@gmail.com>
Date:   Sat, 26 May 2018 15:45:42 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since 2.17.0, when saving a patch (using add --patch but probably =
other ways as well), if the whitespace is removed from the initial =
column, the patch doesn't apply.

Full walkthrough (including comparison with 2.16.3) in the video =
attached to this link:

=
https://www.dropbox.com/s/s1ophi4mwmf9ogv/git-add-patch-whitespace-bug.mp4=
?dl=3D1=
