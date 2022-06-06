Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D0C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 16:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbiFFQEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241420AbiFFQEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 12:04:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C2215897F
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 09:04:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h23so18774760ejj.12
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to
         :subject:content-transfer-encoding;
        bh=LZhsBs3bCQr/yQmzM92Esa4DT3yB5CXywiIyNAiRmD0=;
        b=qbCesXVAdP4vdIsO3bguy2bREwq9HMrcLyC5pZgOYRJCfV+QcMs+5kuA+0zYoEwA8X
         lTLH0blw0mm6KodOcOGDwfr61kW7I0arbrm9xjIJHavWByFSJqdsGMsX6nIc+1+teTXk
         57JHCoxrDqkVf9ve7MWTCxAUob6Qw7ruPKb55FALCZT8+f0fYJ5VgHcl9jmd4oSeSU+Y
         5U5ov78FrSu66BXXQgfG2rm8/TPELoTD3m3Acl//VK6+4T6aQlg9GBN7yoPDkXU31jey
         ELBADI+r9AyNU43xesxX+wKv16crkEvOf4keo5/HnjbDKFYK85ejT+B96wiu+GBrCqSl
         1Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:subject:content-transfer-encoding;
        bh=LZhsBs3bCQr/yQmzM92Esa4DT3yB5CXywiIyNAiRmD0=;
        b=wncmh+HkWNDX+32874QaudETPMjLC99c3tYoX8RZzfte1Zeg4inmiBkBwTxtjjS5uN
         7KIb+wP45fzfuuyrc/fj+qWTQkDQ19p/v+skeWzqw+9HCMs0vpOzkuP8kM+KPowTc1y5
         0sp1BZLhjwBwn6yB4SuBxvPV11TJ07Gd6BTclWSSd2BZwGg4K6i5JdPLSBC/lpfEUD0F
         vZI5lY8EtQpCK6jebhQeWpFKH361WcfD7gmtTzltnSvT6Mvn73jYM5SIARC7Tj65K2i8
         7JHweBxC0l3/D6PtEffzghzGRGwbx9nDJ3vJNTX/OekXolT7ayhXM0XDlPvqdS1eLKt0
         iy0w==
X-Gm-Message-State: AOAM533MvDVP0U28KcIqjwFKKpBModSbmx65HgMfeHlcmoU1CtdMskhA
        2WKF7T9B2WLJQCubRRb/ss/mQ0Z6nPk=
X-Google-Smtp-Source: ABdhPJxxUPJVt4qFUnHZpaOSt7gx/LWiMuoHF0nWAhWeWuuOt0hEd4mr2KBqtZWG7DdTaVKzggMuKA==
X-Received: by 2002:a17:907:9494:b0:6fa:78f3:eb9b with SMTP id dm20-20020a170907949400b006fa78f3eb9bmr21667424ejc.704.1654531453002;
        Mon, 06 Jun 2022 09:04:13 -0700 (PDT)
Received: from [192.168.115.146] (55d48e4e.access.ecotel.net. [85.212.142.78])
        by smtp.gmail.com with ESMTPSA id ge16-20020a170907909000b00709e786c7b2sm5581245ejb.213.2022.06.06.09.04.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 09:04:12 -0700 (PDT)
Message-ID: <68627d29-8ffd-2e22-46ca-c28c9e980177@gmail.com>
Date:   Mon, 6 Jun 2022 18:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-GB
From:   "R. Diez" <rdiez1999@gmail.com>
To:     git@vger.kernel.org
Subject: How to watch files in a Git repository
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all:

I would like to get a notification e-mail when certain files or directories change in a Git repository.

In the good old CVS days, you could just 'watch' a file with your favourite CVS GUI.

Some online services like GitHub offer their own notification mechanism, but I would like something generic. I am not looking for a hook solution, because the Git repositories may not be mine, so I may only have read access.

The idea is that I can set up a cron job to periodically pull a repository, and run a script to generate the e-mails from the commit history. Any new commits which match the desired branch and modify the desired files and/or directories would trigger the notifications.

I've searched the Web, but couldn't find anything straightforward.

If there is nothing of the sort, I could write my own script in Bash or Perl. I can handle cron and sending e-mails, but I do not know much about Git's internals. Could someone provide a few pointers about how to code this? I would expect there is some command to list commits, and all files touched by a particular commit. And there would be some way to interface with Bash or Perl, which does not need parsing complicated text output from Git.

Thanks in advance,
   rdiez
