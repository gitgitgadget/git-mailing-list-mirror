Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569FF2021E
	for <e@80x24.org>; Fri, 11 Nov 2016 08:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbcKKIK6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 03:10:58 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36715 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753762AbcKKIK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 03:10:57 -0500
Received: by mail-yw0-f169.google.com with SMTP id a10so5419632ywa.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 00:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=t2MyIETr/uDMCTz/pHQzw5Pjk55T+AHtPPM7zvYGUNM=;
        b=xpXF2PB8uWFHwRSkVOXJB9xg8eYWNPolmJhPSsP74oF+m3MhsPenx2rYM+BftVTje8
         vtZAdWKv19vCTHjMiBVRoNjfPgxbCSX7G7MXPd9i0uKWUxZzqsY6mDAhJvWSx0vfVmN3
         MViteIUuJ3VOPgNJ8nkQUscJ2CNxH5PxWh/yYKdIVQjm7E/WwzHmFgpDYubBzp1VSTqd
         ZUgB4qmqn9tDMgxxQrYHTn4B/yVYebRfuoilXmmJNo/kxYxSGHP5fvNM81WmuL/F0UNS
         kgTEG3o7B/jVym2rgQRLG63+/5OwV+Ut9ojodKpyZ5T6XcJ49KnIB1voJ/R4P0nxsjQs
         L6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t2MyIETr/uDMCTz/pHQzw5Pjk55T+AHtPPM7zvYGUNM=;
        b=YyQjjygrQkiO2ioWhc92nWvFhkRnIg3F+0sKOjqeeG6Vhukc6FUoF3CmHf/I/HSjV1
         Aa6Q5SKrcfJFONgOOYcdy5oLoEM6G0im/F5CTS8/AhCCJN1nc0Zt3k35BRPqMipi1FoB
         qc6HMxUTUHD6FjpdIpljjIfOK1LNOwlyuEmmtp+1edYsbI3hakC6sApHoY1bR76/gJbg
         wmNnsvATo/DxVCFPiRJ7FQWeObCPEcmJZnEwEaDnqUbA1mHo2JO6s/VymAWknh29W+ny
         vmwBU2hNF6TEGRh+LAgAQQ7WjYzaYBxmMDY7M0gpY7MAhK27b4u99Gr3gREOylJ5U/qS
         iGSA==
X-Gm-Message-State: ABUngvcGkwVHPsB3Ey38cGpTMqUO3AOihzZVmx1+VXoyS2CiedTcsFLfo2lgAzjt5a2CH9+NXGo0grX/tSuFjQ==
X-Received: by 10.13.223.151 with SMTP id i145mr1453223ywe.321.1478851856206;
 Fri, 11 Nov 2016 00:10:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.113.66 with HTTP; Fri, 11 Nov 2016 00:10:55 -0800 (PST)
From:   Qi Nark <narcotics726@gmail.com>
Date:   Fri, 11 Nov 2016 16:10:55 +0800
Message-ID: <CACNr1V_fRfqvHUN=AQC8-Dj7ZAE7KXRAt+5skL3ZrcKu7SCLgA@mail.gmail.com>
Subject: [credential.helper] unexpectedly save credential to multiple
 credential files
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. git config --global credential.helper store
2. cd to a local repository directory, git config credential.helper
store --file ./my_cred
3. execute some git command which need credential like git ls-remote
4. input my username & password, command done.

As the result, **BOTH** the ./my_cred and ~/.git-credentials will save
the credentials I just input. But, shouldn't the local config override
the global ones, and only the ./my_cred should save it?

Thx.
