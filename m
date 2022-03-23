Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFE9C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 12:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbiCWM5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiCWM5I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 08:57:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4EC7C165
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 05:55:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m22so1591787pja.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 05:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=qSFGtPeyyZZcmSxxOZxGj/r6eW2/UXB1m0u0qAW+ADk=;
        b=MYTDoyyZsSGqmyppPddhD0dixfozO1eBR2HIkh0xqQniMnz3ZyDXE0isIA+CtP+nDr
         tlKGLF4ZDYeCZtqjF1ho9vScoII5EQoMMiPVvf3CpLhAO8Vsldu7iftgrqrRDYsKTVNM
         pyf8niww/4IKrmjkWO5e7aBFhGW7bkuF+pwIpo+qKjT1ZJOh5SIzbNmWEbx7aDxSt0j/
         48iBR6zcQpUuM8GH92KAE6rhWxWViBAXmKon6vwiudF0lsTx4PO7KKhgLEWzozyg5R1d
         kWb0x7/f691mwowfmvyuidyACsngQ0a7E8f4DXKZmbOWSp9cMx2z1zdZiLd0ODsvtJ8V
         Wl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=qSFGtPeyyZZcmSxxOZxGj/r6eW2/UXB1m0u0qAW+ADk=;
        b=WfvXJfgVyhFqOoqukb6HxnMjoHqSLapXnJmm/0MNS7C/9oj6a7zlv3NjlqGoAZBZJF
         t9SRxr55XfXjFkN9I80YXnyHW3ZDLwLNRNllGsmgbB2UmSn6Mc/zigNDt469Sw4Hv7s/
         FBDr+P2RHmjBLBQAdvn05W+I7L7bUE6G8m2xMkish+RRXcsBCgFsPzpz4kWY1gBg5aBK
         A1gdiOtyqGNDpeliOY3Wh2DDEL3R+mYK2i+w9DIICbEHHGwzazwRUQh72CIVZm/W1Qz5
         QoHBvQkPdllwaK6XPAcmlPxCz7YoXhuXt1biwsw1t8p54dcAKD9/j9dfbaGaR2M4Enuz
         LfHQ==
X-Gm-Message-State: AOAM533CIs8fW4cEV+Tu8e7V49aPOn9+roJ5FdCQyCK1skY5PlPQ2kas
        7GBGMBr4ycvO5FlVULG49kxxApMBrsVZZA==
X-Google-Smtp-Source: ABdhPJxB7su8oDDUjr4So2v8zwSVGMY4ZSU+WJjqGhRnhuNEIC7YrFHq5pfX0ZjPq7CIkKG/dugmzw==
X-Received: by 2002:a17:902:dac4:b0:154:5d6d:ccd2 with SMTP id q4-20020a170902dac400b001545d6dccd2mr15291514plx.167.1648040137684;
        Wed, 23 Mar 2022 05:55:37 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-87.three.co.id. [180.214.233.87])
        by smtp.gmail.com with ESMTPSA id b7-20020a056a00114700b004f7be3231d6sm26224292pfm.7.2022.03.23.05.55.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 05:55:37 -0700 (PDT)
Message-ID: <6cdeed25-9964-909d-376d-024e1385840c@gmail.com>
Date:   Wed, 23 Mar 2022 19:55:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: lei + thunderbird recipe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This thread is inspired by Ævar's recipe [1] and Josef Bacik's recipe
[2].

As I know that GMail have issues regarding delayed ML message delivery,
I go trying to use lei to fetch ML messages into Thunderbird.

After installing public-inbox (I have to build from public-inbox.org
sources because there isn't yet official Debian/Ubuntu packages), I
begin fetching Git ML messages up until 18 days ago (within
public-inbox sources directory):

	lei q -o "mboxrd:mbox/git.mbox" -I https://lore.kernel.org/git
	-t 'a:git@vger.kernel.org AND rt:18.days.ago..'

Why mboxrd instead of Maildir? Because from formats within Mbox family,
Thunderbird uses mboxrd format.

After initial fetching, I update the mbox by:

	lei up mbox/git.mbox

To automate this, I write simple script:

```
#!/bin/bash

# replace with directory of your Thunderbird profile
THUNDERBIRD_LOCAL=$HOME/.thunderbird/1a14l7jo.default-release/Mail/"Local Folders"
MAILDIR=$HOME/public-inbox/mbox
# add more mboxes name here if you have one
MBOXES="git"

for m in $MBOXES; do
	echo $m &&
	$HOME/public-inbox/local/bin/lei up $MAILDIR/$m.mbox &&
	cp $MAILDIR/$m.mbox "$THUNDERBIRD_LOCAL"/
done
```

and then set up systemd timer comprising of user service unit:

```
[Unit]
Description=Lei update
After=network.target

[Service]
Type=oneshot
ExecStart=/home/bagas/.bin/lei-up
Restart=on-failure

[Install]
WantedBy=default.target
```

and user timer unit that updates the mbox every 12:00 and 18:00:

```
[Unit]
Description=Lei update timer

[Timer]
OnCalendar=*-*-* 12:00:00
OnCalendar=*-*-* 18:00:00
Persistent=true
AccuracySec=1s

[Install]
WantedBy=timers.target
```

To fire up the timer, I simply do `systemctl --user enable lei.timer`.

Hope this will be useful.

[1]: https://lore.kernel.org/git/220202.86leyt8uly.gmgdl@evledraar.gmail.com/
[2]: https://josefbacik.github.io/kernel/2021/10/18/lei-and-b4.html
-- 
An old man doll... just what I always wanted! - Clara
