Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B10B1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 15:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeDRPeI (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 11:34:08 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:45955 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeDRPeH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 11:34:07 -0400
Received: by mail-oi0-f52.google.com with SMTP id j10-v6so1964651oii.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=naqqh3ERyXUuR+28TW1xcndU/qp6wy3QcBGNJG5o9KE=;
        b=ihlp0Md2PrBlwdokaEUkXxwr83iYdPNEomnc5u6sR7qtnI3Bnn2iRVg+x8hyo4e98R
         Tfu7v5SFaYrxvKr7d+ada3qK6MOgEe2LPdtKioEZhde20Tf/+lk5Pi8TR9mjRh3FMYB4
         5cmA7xrFl0mtQZgy/BBowbIlr0yl6z0mVjre4jpFbq+2M/eCEG+vpsmuL+RR8KLDx9JR
         kFve3hgW+3nc16ut135TRXWwwJwGrBHx4h6RqU3NhkAUkMgcOUWngzxEQ6c9MTnjiMf7
         ZjPrn4DWY913L0NX1cmksoRbZRtf6ff0wLIeWF9CaWu3If4XkA91IwZSuAgKJxNpAOX6
         3wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=naqqh3ERyXUuR+28TW1xcndU/qp6wy3QcBGNJG5o9KE=;
        b=HLluoYS3ihsRqy6tc/hfpnUuhoemuf5FjqJPd2ez+jSkFCxOMIztokllAD/hC3QbAi
         vMR0+1Ns7bTbQTc7X5cM3o+oP5R3eNTfcmstHh7rrMBRWrJZYNpyMd6WfIV60ThX1Qhq
         j+K2Wlevam0u7Wc+vF3mISn8piOw3LEv9qFiSS6iS5RB9cxCSvvD/AIdLhY2Efui1fbn
         mJoQIPuaP9zCB8pdHHX+5BR/Lt6g+HQKirzN/lwfwWc5qPmqQcThbrBQEw0l9fXz2nqv
         gRRlTojhFXIdUppaGrdMrdUyCDzlg/P94ZdJilF8X1mNSGDmONdN+KzwAnnm3lkDKedV
         PFAQ==
X-Gm-Message-State: ALQs6tB+G7TLjF9nSXXlJ17LL1Y+p9V8gWHeZ+auFqxtUPnZDUcLbQia
        ia+uLdr0MVwiuuirRX+uYB9dT7/cyN6N0Q0GUOI=
X-Google-Smtp-Source: AIpwx48/O3oUVwfe7Intfp+JitUbqVzVBdFVPcd4veZlWZGqirrua9iPo0PqIeEnng3LIyZBhWpxe+LlEKQlRiPNa6k=
X-Received: by 2002:aca:5b06:: with SMTP id p6-v6mr1540380oib.216.1524065646664;
 Wed, 18 Apr 2018 08:34:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Wed, 18 Apr 2018 08:33:36 -0700 (PDT)
In-Reply-To: <8F15D4F40F164250987F5DD3896AD825@PhilipOakley>
References: <20180326165520.802-1-pclouds@gmail.com> <CAPig+cTW7KRzXXY7vP-GZ23effYd5jLhiL15KqdRam4rNELCWw@mail.gmail.com>
 <FBB059C530054EEAB2E989D86CBE3BD5@PhilipOakley> <CACsJy8BqoW_YWBiMoOks+WM5XY7Mmadkd0LUBoUWLDXehx1GZQ@mail.gmail.com>
 <A9B6B3A17C4844C69F8865C01BCFC51A@PhilipOakley> <CACsJy8BTX=6FsH7-Dc86ExQRfBSNVn9yxD5JrNZyLT9VDQOPEg@mail.gmail.com>
 <20180417164831.GA18563@duynguyen.home> <8F15D4F40F164250987F5DD3896AD825@PhilipOakley>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 18 Apr 2018 17:33:36 +0200
Message-ID: <CACsJy8APfzL_VchsUT0KgKooijARbMqkcFd6rC4A2v5LV84Gww@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 18, 2018 at 12:47 AM, Philip Oakley <philipoakley@iee.org> wrote:
>>> > Is that something I should add to my todo to add a 'guide' category >
>>> > etc.?
>>>
>>> I added it too [1]. Not sure if you want anything more on top though.
>
>
> What I've seen is looking good - I've not had as much time as I'd like..
>
> I'm not sure of the status of the git/generate-cmdlist.sh though. Should
> that also be updated, or did I miss that?

Yes it's updated by other patches in the same thread.
-- 
Duy
