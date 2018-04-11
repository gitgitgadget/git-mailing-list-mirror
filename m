Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D652E1F424
	for <e@80x24.org>; Wed, 11 Apr 2018 08:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeDKIST (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 04:18:19 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:36240 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeDKISQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 04:18:16 -0400
Received: by mail-ua0-f172.google.com with SMTP id v4so603748uaj.3
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sH7yfKuRAVYO/woDj6kOcmiWNrpeGVuj6+iDJWBG38A=;
        b=WXVLC2hchwYSmE5Sp7pSCf4w/Ju7ylWkZ5mV+E+n00MeBwWdAv4EEddhHP0AKlh5Kd
         kuJHvpopVtBnsXUu5CT2m0s7keiRCBtgYy9/1JlCYMJOnRrGi4ycboZJIND9yNRlxjxu
         ok1Gy8evh1BnrH8RG8BkJ13IH7qicNJcKowpp2pVGT77VJi6AyOt35mm5lR8tEcPVvk1
         fbKt0ECVv0jqYf8QpiKrPRZXs2/Tdmm2uMw9tbCAAt+ZnnQ0ScCluIDIBed6F3Jfdd6n
         oMW7rKMU4OegBaPafCFXE6p0l+XgPM3WDloWjQ97FoSTyYbBPzx0/u6tcEbcnCNqALg6
         dPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sH7yfKuRAVYO/woDj6kOcmiWNrpeGVuj6+iDJWBG38A=;
        b=kOPPfW5TeWUxlgulx8yaVOGTyNXDAH53fA/vF9GgqNJAiZERAPQTCbjIeR4O8BZrTD
         a3qq77s2fPo01oAEklGsIBK5pPfw6UC3FSYfxjC1+osyD6jcgayPJWHOdNJJec6d1NrS
         0xqaiCh0fhTTw0wv3Io/QFRa/hhX3TllglBMnUjrgLFeroOzaJuVFuo7W81L29ZZkBYi
         HqFyjQAhvtLInFBLtCxWDymp1Luk+2Tc4Ea/xhKAq8W9AUcm1T69ncinnZYhd+tipUXc
         1NYtB7Z+g/Nadpxi2ok+JLoypg2EOwqh3mYLaRTOyaJ9Up6Bj70bNlYEAi5mXqRKQNPH
         d8lQ==
X-Gm-Message-State: ALQs6tBTazez2533+pfPUbJLT52kLsHiaMuwhJnf3Tq7Gh8g+S3lp7qS
        ZVegq8ui/Ifc20QbUPUWDiyXDoPILRF2BkHWT0c=
X-Google-Smtp-Source: AIpwx495TLWBGu+lLdBXTZLHKZIdmfYO0HkJG+ebhRAblE9/RAM4FvDMH0odJabpMikBI648v04lK25HKZh6ylazQAY=
X-Received: by 10.176.112.17 with SMTP id k17mr2666856ual.111.1523434695800;
 Wed, 11 Apr 2018 01:18:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.60.94 with HTTP; Wed, 11 Apr 2018 01:18:15 -0700 (PDT)
In-Reply-To: <53251802-5c5e-6fd2-25d0-40d534e6bd6f@gmail.com>
References: <CANqewP332-+esYWDPBtPif==wnb4PiNd89R1qTZsuWZAFSV0ew@mail.gmail.com>
 <53251802-5c5e-6fd2-25d0-40d534e6bd6f@gmail.com>
From:   Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
Date:   Wed, 11 Apr 2018 17:18:15 +0900
Message-ID: <CANqewP1W2dPotMFhWRLRkjteUpmH9z0fRWCQG_h5bF95EAy60w@mail.gmail.com>
Subject: Re: core.fsmonitor always perform rescans
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-04-10 23:34 GMT+09:00 Ben Peart <peartben@gmail.com>:
> As a performance optimization, the fsmonitor code doesn't flag the index as
> dirty and force it to be written out with every command.  Can you try
> performing a git operation (add, rm, commit, etc) that will write out an
> updated index and see if that fixes the issue you're seeing?

Yeah, that resolves the issue. Though the repo I'm working on uses
submodules, so doing this in each of them isn't a easy work.

> I'm considering adding a special case to force the index to be written out
> the first time fsmonitor is invoked and am interested to know if this would
> have avoided the issue you are seeing.

Yes please. And maybe we should also flush the index when the script
returns '/',
which means all files?
