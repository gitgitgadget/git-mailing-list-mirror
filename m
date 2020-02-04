Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE30C2D0B1
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 11:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9210120730
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 11:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvfx5HJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgBDLCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:02:20 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:56190 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgBDLCU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 06:02:20 -0500
Received: by mail-wm1-f53.google.com with SMTP id q9so2747546wmj.5
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 03:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jFXH6cwFP1rGgoynwQ9hHvt20fVv8ocXan1UwRhrUwk=;
        b=hvfx5HJi2/GBMxhKRCiOFeSH5J77nVT+WMel8neei3xKesbzeTZyuOP1jee4tWx8ra
         h8Ezc6tQDhyi0oBC2Jyp866I1Q5pmCRb+Z5GOhH5uzYfA3dSiqi/wmKJ1ClwLEO3ZjFS
         +MtPPeMRRg/YPyPX8JVWgSqodgo+nqvIdnv61KmvALGgJx3ZTDacYDyjHAZ8/kbm3ioD
         QlMrjjy4q23Jr2JuvpejR35O39iVTmUpjVhlel5kFoiQ5MKvLnbZ5bOcKBM5FFaXh+LB
         QAa+6qRtkPqni2F44Ko1OXmEY/HDhu7XHuKXuO8Kp2yHhjun2qIDtYoaS8+lTNbWZnEP
         JJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jFXH6cwFP1rGgoynwQ9hHvt20fVv8ocXan1UwRhrUwk=;
        b=ThKUFbQVTI7rSMDNUCF87tuCw1zNTALvJ93vKv2uWJr0JGSkeGH9jUv+HhYEyAgh1n
         JIWGLTx4U3Lkri4iBWiK+ugsHysEYBYIhlxpiEqFIpZjw8EWLCaTjVwuf/E4FUarYrtf
         +PRp9ZuP8rs2tdL2aaAad4Ye9jON343JHQxOSxaQiB2b/SfUYNKiy8vNwywjCmmFsx5L
         jFcFujlWc78nLn5rBI+xqqa0jjwwcrb29thRjuPQ7T2+n7zZMTE/dUuh9OlE34WSpZ/0
         jGatI0T1+1A27KIiC9w7uj5YUnoDOOxuZnjFNDi4ja3m1JJ7mkO4j8Yrs/8bL6+Akjnu
         dC2g==
X-Gm-Message-State: APjAAAUD1APHrPmY+tlxjCrxEOVs2Ns8CLmkvQn9e55v5vfqZ3Hi7gzh
        MbrZ4o3A/8XgmmvutV0u8Di5F1+X6R5HiPQ6bYs14Xg3caI=
X-Google-Smtp-Source: APXvYqwcaHB6WaEqMp2hIjY84CVb4FU2m3zy3GwjA3j8SVRPs0yzlAEMYuC3QmmBmWorHErWqIINNUWE8O84UIYvj8Y=
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr5199453wmg.146.1580814138334;
 Tue, 04 Feb 2020 03:02:18 -0800 (PST)
MIME-Version: 1.0
From:   Ashima Matiman <ashimamatiman83@gmail.com>
Date:   Tue, 4 Feb 2020 16:32:06 +0530
Message-ID: <CABdb18jnV752=rQg=TvWjtAJoxoxU4XtSVf46FetxAxf6mRo=Q@mail.gmail.com>
Subject: Install git 2.12.2 on suse 12.4 from source code
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am trying to install git 2.12.2 on SUSE 12.4 using git binaries.
After the installation, I am facing issue while executing the following command:
git clone http
git clone https
The error is :
fatal: Unable to find remote helper for 'https'

Can you help me with finding procedure for proper installation via binaries.
Looking forward to your reply! :)

Regards,
Ashima Matiman
