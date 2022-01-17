Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E77C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 07:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiAQHPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 02:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbiAQHP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 02:15:29 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E5C061574
        for <git@vger.kernel.org>; Sun, 16 Jan 2022 23:15:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso29320068pjm.4
        for <git@vger.kernel.org>; Sun, 16 Jan 2022 23:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=YL3ksqfSgn0DzXW39YIqse/F/9RA1p22xqz2T7z3gbA=;
        b=FtDbuYxGykWRsYOtC/M+BLkH/Qt+nFIXFqCh/GZxC0H2+cZXO6/JRZJ4HpMGeefzpP
         RyZJ0DvIIZ48Z2IHr2Xljt0oqVv0aVypuPCR6oiDgRdiB/p6wh95clSETjjKR4gHM0RO
         +6AfSVqfHDoZcBvf5IiqiTTNXUyele5uJVcftaYmIGI/+AxMe0nhl0jtRCZZ6LhKnTmo
         GevTHgVIz/Ln8ixrwrRXHtcTobfaMjn5oCp3rDwHfYtF4Tnt58AnJzD736M0oCuTDtOs
         VboC7w7Sp4aD36gc37djrAsgdg++zXwyqqsS/hofv0WHlx8NeAF5di8P1y8wu6Q3wEPU
         OqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=YL3ksqfSgn0DzXW39YIqse/F/9RA1p22xqz2T7z3gbA=;
        b=jwolGkqDoOB69UUOa3fqirrZrW3Au1xWDC2TVSpq5da0mBgiz/Ime9aXPCAvaqtNwP
         6W48TrphyE2fQgRb6G7Q/wf/vDMTcTyaNQ6gw4bjQGSs9/yB1EPiSHzzXayQ4OpJimQ/
         /bQsYcGtJ5aa8ZOU/rHqJBh+YyRNfI6mRgNnWXztjxUO2v6cD8kn04Rg97nOV5dBc2Iq
         I22mbeKP44Pjr7z4KqP3YIAv0VQi+Isw+jaZ7MfG/BLT8aBRJs/lPUwOfytAcO8uxUm5
         FDCpJQLYynu38G9pMQseCwI0QevRQ1Xzz93NGjLnlH8LV4/3IaKa1bBMcu3t/laBTe0O
         FPIA==
X-Gm-Message-State: AOAM533Q6+tJLPA5XY8tOyzuxuAg2A6qriG1/70wQOM49bQuQ1Kwdiot
        qQHWefxAT0uLi5tr17Wy7xEqoVl+etuTRQ==
X-Google-Smtp-Source: ABdhPJx07nuW0007gXdSFVIy9HrW5bFPb2SO/Y+iSSiyR68k5jasclEYT+lmjhJyqee8OXLIUM5y4Q==
X-Received: by 2002:a17:90b:4381:: with SMTP id in1mr23615122pjb.40.1642403728872;
        Sun, 16 Jan 2022 23:15:28 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id u126sm11006274pgc.22.2022.01.16.23.15.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 23:15:28 -0800 (PST)
Message-ID: <e176d1b3-482b-899b-af24-ac03c65d103d@gmail.com>
Date:   Mon, 17 Jan 2022 12:47:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
Subject: [Newcomer] Suggestions for microprojects
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to starting contributing to the git project but can't decide 
where to start.

I have read the coding-style and contributing guidelines stuff from the 
website and am eager to start writing code. Is there any small patches 
that I can make in the codebase that could help me get started with it?

Thanks,

Jaydeep.

