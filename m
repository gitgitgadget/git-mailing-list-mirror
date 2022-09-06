Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC498ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 16:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiIFQS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiIFQRh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 12:17:37 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8255D83F06
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 08:46:35 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c9so8451230qkk.6
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=c1UF4ltxJlm3Uunobj7NlzCZQ1RSosMcZWXHB4OcnHI=;
        b=E5IFVZdhuzMLGGIu/6o4ssioQnw/p33TcNLB7a2GB48/wcasllcNqZkOuWUtVdGVEQ
         f9T/ogAV5YZyLDiP4e/GYM3On431cqXt9qQL1k3NXAUZblTIKPXZUlBLPlUNjPTlUYgf
         +LJ24v23Eu0isvbLNbk3YiWXgCFYDH7jK3RnfXojmubOI+cMm9tlUCivILeBUTMKuagX
         x41mDcMwJyGBLwudqc7NSrSLXRhp+jEEhchZ3g5FvPFEDtjuTBCacfwFpOKjQpELspkI
         cG7jCnt21MnDc65el6h3svm1MNgyleNGwYuaDMevPSK7t1nc2R5MOjSFDjlLvFhr0xdB
         eqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=c1UF4ltxJlm3Uunobj7NlzCZQ1RSosMcZWXHB4OcnHI=;
        b=3FhVBjr8JBUOxxdKeC7mc/ENzyKmIyv6E4RXSiutguzSw7Dicp5MAP7Ff+DFLPYVWV
         eZHKY5WJKCZ4x+6Z7nBwj2Arl8YWtCTqfzRw9xK2Q4Wf7GkqEZOqqT8UeancMUEZnfKM
         cDfTdDK7fJEQWa79rMeZ3XqHdFVLlVMsdI7ZYK2vjgITdsP+REDQnY5HXD9vdLiO7hnm
         VuhNd6JZComRUkdqyA3yDjhcicXEOwQckZWAwpCPe6q9YkmmH+Jg0BDzHsXJx8v5nlt8
         TAszc/sOVBt0oka3LLOtt9DPMX/TyTdmX1tnI3MiAj+lX8o+VvRiyRb5pi/NwjgZMQFr
         5WEw==
X-Gm-Message-State: ACgBeo0kn8fsWZw/EGW3qSXLDwI5OAlGeqR0vxZ1YY3y6H6iJ+lEmczp
        nGRSjQwlN4sf0u5RTjDDItewioOluKRf21QV
X-Google-Smtp-Source: AA6agR40Db3AaCkFyvkBxn7WnbtJTfAapjcGwTQjOR/OetbSrLEOBSf/62YGzTjPgD+NMO8bhEjPIA==
X-Received: by 2002:a05:620a:f11:b0:6bc:52e7:9058 with SMTP id v17-20020a05620a0f1100b006bc52e79058mr36964791qkl.738.1662479194448;
        Tue, 06 Sep 2022 08:46:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c4-20020ac84e04000000b00344f936bfc0sm9644918qtw.33.2022.09.06.08.46.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 08:46:33 -0700 (PDT)
Date:   Tue, 6 Sep 2022 11:46:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git Contributor's Summit 2022 - Updates
Message-ID: <YxdrWElo8tKtDv+a@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a couple of important updates for the Contributor's Summit next
week:

  When: September 14th, 2022, 12-5pm CDT (UTC-5)
  Where: Convene (16 W Adams St) Chicago, Illinois, USA
  What: Contributor's Summit
  Who: All contributors to Git or related projects in the Git ecosystem
       are invited; if you're not sure if you qualify, please ask!

Note the new location above. It's still the same Convene location, but
the entrance on Dearborn Street is inaccessible.

We'll be in the "Adams Hub" room, which is on the 2nd floor (there will
be signage throughout the building to help guide you to the right
location).

There will be light drinks / snacks available throughout, as well as
lunch provided from 12-1pm. There will be a podium with an A/V setup if
anybody wants to give a brief presentation.

For those joining remotely: we'll have a Zoom meeting going the whole
time, and ideally the whole room should be captured via the
microphone(s) on site. If you're interested in joining and can't make it
in person, please email me off-list for the meeting URL / passcode.

Thanks,
Taylor
