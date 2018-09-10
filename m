Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B0A1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 08:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeIJNBu (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 09:01:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38053 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeIJNBu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 09:01:50 -0400
Received: by mail-io1-f67.google.com with SMTP id y3-v6so6297486ioc.5
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sergei-haller-de.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Z/OqTrWqjo4+82yYtBsnOyU8sAl494pjR8XFwO4ZWi8=;
        b=igHiyxWr3lXIA/uh2D1FimNzg1wEJ3H+QN11mVWnEBAi1DqCeUBkM8CQlspvWbZ2r8
         nKr/Am22R5WxCFo+urQ4kdsRGv48ohNfDWDFPZzA3ii1t3ECBUgKfDxHL8NzAOLmJNQ9
         Bdhjbak8Of1ZgUa3oG7+3XJcUQapHF9KTIbUEe+EUXdN4p2WlzDuVeix+9sLktdPrHmY
         mXKbVzmYmf8B/5b1+dEUGK/HftQSNmQSsCbci9uqknJLCt8/PEuQvb+/7zF0pgAy2cTt
         3Q6NiRCnyWpyXD/EnSfj/03qoot9XKqTVhQDEniK/fQaBJioEW9mYmzuVlkohy3JTzpP
         gY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Z/OqTrWqjo4+82yYtBsnOyU8sAl494pjR8XFwO4ZWi8=;
        b=FS5MDYNoYKxBsHGxUBR39bXyOrKBlIje9nDm/zr6kmg40Fr4gZCXOZYmImS6n4/8Nn
         TRdOpYGphhDJtmLkI+VrkagGzrzwCt1j1mOQFjn+pJunQF17zDzbQ9UI+SU4bXx48SOu
         D0mfiIvzdgQKo+oPSawVUaHi1HGWyvgeR70xBZyutD3QmsCF0sNagW/YTY7hPFWh9btk
         ok9ezFv4ZazzTXk24eG7wV/gPuf2IXvXFWQ0E7+s48JT1emsQyeihgSGWALLmIDuVFua
         OTOb0s+vOBQ7yb9Aty1+D4hjvwqNn1FWJJjmoRT1NDxGY4LQfR1kDAkTSSmxGP4Nhwv5
         FKgw==
X-Gm-Message-State: APzg51CBxgT7xX6bsS9xp27Jwid+yThp4kaGdRQPvVBa7Zk9+CyPdQoW
        tr02nWDBotZzpISPvy3Tt2RhsPQ2BB7sfRHHJMWuzbEAwTQ=
X-Google-Smtp-Source: ANB0VdaYM+InHgHdAw51qL0AaCClvtYozOfLp9w41Yp9L+iYUMXPmvE5r8JBZ/gkukY2poDCy2olTmwFXSUO69plPqg=
X-Received: by 2002:a6b:e317:: with SMTP id u23-v6mr6927630ioc.131.1536566942235;
 Mon, 10 Sep 2018 01:09:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6666:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 01:09:01
 -0700 (PDT)
From:   Sergei Haller <sergei@sergei-haller.de>
Date:   Mon, 10 Sep 2018 10:09:01 +0200
Message-ID: <CAPO0KtU=do8nmJggP4-k1BingdseZUuRjWraGjuN01VoEYU=1Q@mail.gmail.com>
Subject: Multiple GIT Accounts & HTTPS Client Certificates - Config
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

my problem is basically the following: my git server (https) requires
authentication using a clent x509 certificate.

And I have multiple x509 certificates that match the server.

when I access the https server using a browser, the browser asks which
certificate to use and everything is fine.

When I try to access the git server from the command line (git pull or
similar), the git will pick one of the available
certificates (randomly or alphabetically) and try to access the server with
that client certificate. Ending in the situation
that git picks the wrong certificate.

I can workaround by deleting all client certificates from the windows
certificate store except the "correct" one => then git
command line will pick the correct certificate (the only one available) and
everything works as expected.

Workaround is a workaround, I need to use all of the certificates
repeatedly for different repos and different other
aplications (non-git), so I've been deliting and reinstalling the
certificates all the time in the last weeks...

How can I tell git cmd (per config option??) to use a particular client
certificate for authenticating to the https server
(I could provide fingerprint or serial number or sth like that)

current environment: windows 10 and git version 2.18.0.windows.1

Would be absolutely acceptable if git would ask interactively which client
certificate to use (in case its not configurable)

(I asked this question here before:
https://stackoverflow.com/questions/51952568/multiple-git-accounts-https-client-certificates-config
)


Thanks!



-- 
sergei@sergei-haller.de
.
