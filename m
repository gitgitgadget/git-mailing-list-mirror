Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20DEC1F406
	for <e@80x24.org>; Fri, 11 May 2018 14:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbeEKOxz (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 10:53:55 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34746 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeEKOxy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 10:53:54 -0400
Received: by mail-lf0-f43.google.com with SMTP id r25-v6so8351678lfd.1
        for <git@vger.kernel.org>; Fri, 11 May 2018 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=m92pyBYxxyYM7StVkbqDuOhVDcIj6zPHDnFntPbCCSM=;
        b=GcFywg5kLa4Yn46HmdBERu05NiPVYJqM7b6gtwxgCUiVYiggDS6r1JqrezWs+b3ezP
         jvZNgRWMkmcWY8dYDwXN9UVNSqbz96E2tFaYpGSOYBQHq+ejnWHpqfCulzJfYyFiHOhM
         XSalW3SUyVk4eyJ2DUvJ7nNektOxOTwoc9TeexpdkMlTBFA1sC88TOQfJGj2h5sTWn5b
         zNwnh+1AkynKFsKClw0Fi4TJOWyzTKjv4+rNhjWcDqMonGwdwE1QD9MREnWsVEgG7T28
         i+/60b5cxL5Nh6f/jzXTp1OxTG1rZxyotA6rwiTeHqygqbcjjscRozA/RaQqT74AUVKY
         9DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=m92pyBYxxyYM7StVkbqDuOhVDcIj6zPHDnFntPbCCSM=;
        b=qLjygy+HrM/L6fJ6ZvI0zgrw01biEdiaEBi/4c/6EYdW3mzxKnYnp0kYOjs2FIZD1w
         S+tu/Uu/xmKP6KjwTe3//GK11M7H1er5jeIbsNaRUhV8CHLHI0gb/Ba/Da/Bo5gijEAq
         akUQX1LTWnHtIwiW9MeZmqpXFxsszlw1XrlUlCGefwbxW/beoWCk/LiMnRY+WFP9PLPL
         sNvcEAqIe+JUyDztpNXT3AN1JtnQ7kIMvLbmnbLpRT9gScCfHCPg7J6RIFwOiHE5TJ9P
         WTwFIhWoKpIpIIdP7c+Z0iNCPZvz3ejX/fHnQahsQU9oxsqJ32BHkOt7BS7e2rz///GW
         /rPg==
X-Gm-Message-State: ALKqPwejepo4D392Paq2KEVWdfKMoHgT2D5wNVVFwxrvM94Q3Lxbsv04
        pTc7EyTNMtkOokTE5p3C2h29sDvQzkSEZjQCXJa36w==
X-Google-Smtp-Source: AB8JxZogmrWMWCFNjLE9p2aXi4UW92gbAVo+BYvrg7wFBiZlKJcEoJoIs/COOqkSIYYvvX5KjmNgjQ7BmQ7RT27YgEg=
X-Received: by 2002:a19:1ad5:: with SMTP id a204-v6mr1874410lfa.43.1526050432872;
 Fri, 11 May 2018 07:53:52 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.65.201 with HTTP; Fri, 11 May 2018 07:53:52 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 11 May 2018 09:53:52 -0500
X-Google-Sender-Auth: Mu1t-xlLMhcaFABD3roYgdVI1K0
Message-ID: <CAHd499CKJTnjvPSMqoFZDWw-6PYX4_AxLr0yC6CaMi7VO9TBzQ@mail.gmail.com>
Subject: Patch add: previous hunk across file boundaries
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that when stepping into a new file while doing `git add -p`,
pressing `k` or `K` does not go back to the previous file. Is this a
bug? Is there a setting for it? I googled & checked out the git docs,
I didn't find any specific information on this.
