Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61CC91F404
	for <e@80x24.org>; Tue,  6 Feb 2018 20:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbeBFU0f (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 15:26:35 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:37148 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeBFU0d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 15:26:33 -0500
Received: by mail-qt0-f181.google.com with SMTP id s27so3941821qts.4
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 12:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WLF/pA3Zjnlh02bbNICxpinO68KpxmHdpJxgGMomJY0=;
        b=bv07UEam+Im2ioTGnIcXWQ1wWBeMVkzrSGQwtoz1ADT0/RCmImYPSR127unS9MxAOv
         3AIMTmDKod1nRX4FU8Kd8nVRQ2BwfPnRezouBmGxgsWeYAmjYno3rx/N0OFh4mVU/79+
         TlS/tZeu7oyk7Mfx5LIVwXbmVr7JZYYBlccAMgh+iCw4XswBF2NZkQA9GVJ1ETIlcmxM
         M2y3mEMM5PPZ6H8Tsgz70LQaMDGorKPQ/LjecuKlOFxWhLkiMOaIsz4pFpLJrEzqk1X/
         4Bn5PFyjCT9F9l5ybH/ORrKVpzmLVieHNLmeB+N8Dk/KTUGxQm725b+Q446aPL+tveHT
         lp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WLF/pA3Zjnlh02bbNICxpinO68KpxmHdpJxgGMomJY0=;
        b=HxY7sAEzv0nzeohudN/49E8sPR/+8+5g7KZdpKIPpJjj1PCYLl9LzTzu0lANnZSdVZ
         HdTDiZwpLgJXJ4ut+Wm8BOh/blhVL92TrPIpP1PudsdqgwFn0PCI+I0YGtgQNSVrTRbI
         WFDtFDq7jlwkaVsKy6D61um0FIF+wop98SCUMPVb1Gp9h3nSG7xVywmDi4oLOQgNWgxX
         KNjIxy4jZDvhC/iOAyi6sXpwJx013IDP9/WOxMEMNvY+CAJiGBLN5kkyR71UhXolw2ls
         99TJFSFjVR2ABoKpwS50xbCCC2Gx1PDMYCg69GlEw7byMbXBv48b+oSdx8pOCnmyysIq
         ikog==
X-Gm-Message-State: APf1xPDq+KXeYItanC3uSaXWuCleQ+0S5JBcVg5B7+acB5E0bjc0vSzc
        M9Frpcxg8wYWxbG02BNSPldTwTi2h+Rz2g4QCV7kTo6q
X-Google-Smtp-Source: AH8x22615vHJBiQpybfoOw4XginMJ/gkgz+GCX6gEIl9kDIo8K6Yr1rz7kRhaHmR9mm5AtRam1FnN9XGZ1C0yerUVqo=
X-Received: by 10.237.52.162 with SMTP id x31mr5540068qtd.72.1517948793215;
 Tue, 06 Feb 2018 12:26:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.138.10 with HTTP; Tue, 6 Feb 2018 12:26:32 -0800 (PST)
In-Reply-To: <20180206201047.GE104086@aiede.svl.corp.google.com>
References: <CAGUnuBHY9nQvGiROm4S_JvBWMrzieHC1FE50fJqxaauzZhH7xw@mail.gmail.com>
 <20180206201047.GE104086@aiede.svl.corp.google.com>
From:   Ian Norton <inorton@gmail.com>
Date:   Tue, 6 Feb 2018 20:26:32 +0000
Message-ID: <CAGUnuBHRH5NV31yDiBPdZouNicdfU9z9iPK1wcBNrEhoo+Xw8A@mail.gmail.com>
Subject: Re: Are concurrent git operations on the same repo safe?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sure, my office is still devoid of power, i'll have to get back to you
to be more precise but I was using a morally equivalent process to
https://gitlab.com/inorton/git-multi-sync

cd repo
python -m gitmultisync --update-submodules

where I had a superproject containing 5-6 submodules, some of which
were quite large (1-2Gb history)

Afterwards, I had trouble doing "git pull -r" in my submodules to pull
in newer changes.

On 6 February 2018 at 20:10, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ian Norton wrote:
>
>>                      Specifically I'm trying to speed up "git
>> submodule update" by doing several at the same time.
>
> Can you say more about this?  E.g. how can I reproduce your experience?
> Is there a script I can run?
>
> Thanks,
> Jonathan
