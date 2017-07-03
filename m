Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1220A201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 13:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754067AbdGCNSn (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 09:18:43 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32874 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdGCNSm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 09:18:42 -0400
Received: by mail-pf0-f170.google.com with SMTP id e7so100344316pfk.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:disposition-notification-to:date
         :mime-version:content-transfer-encoding;
        bh=uyaL+7Tjm+V/28GTrB8jGA4ewIlWsQdnpBj44vuxhvk=;
        b=Xesu5wHFyqjFbR2sP3dxuJKunvvtWufZBpZ0gC1nFIWDxjkLHpltRirrY2T/FTtkyY
         veHz3cXZY5+WBXRuBJM/KI7gLJ9SjA6u/KyV1i4RyiEMbbt41F5kloeRrNojrd7cdGx/
         XDUcx0Q7H1Sc1AO9s5WOIJiBWG0814YHhV1kBw59+6kKwdc331k6CXWTiP2Nj/jMHbgt
         2lylx8CGjf/A5TSK//aQKLDu72kyjCasAZX5gVmC02FaRWdJq3cm9faV1Xal2X311oho
         iAjlqsU9iLruReaLt7sHDhCj+q1j06r1JmYhVtcWtPLtYwzDE+i9SlwIQq4BiGDYSp8E
         YGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to
         :disposition-notification-to:date:mime-version
         :content-transfer-encoding;
        bh=uyaL+7Tjm+V/28GTrB8jGA4ewIlWsQdnpBj44vuxhvk=;
        b=OH5eKUstAWq/JYLkNL/faFO8ruw+vf06blzmkhDaYgn5E390OFyTkT9H5zB05NROr2
         E52POJX2wyR8HnynkwHe+9E4R6jiEmnpQ/X1/KLS006z0kSMhV8CA8ycdoSTbJYVJhpR
         wnS7lyydOrUPx56gQKpfMqfsA/lLqokqjJeS/deWuAqdNHqxJeshBqSdimINJ88HD0fL
         6UXsybULRsb07P0LTbz6XK6Vq2P4w/irnlOvCL5Cf/P9UV7CLKn/BGVRqae49v63Lp4H
         BXWK1Mg2jAikFick612K4b1nTv9f9YHeUw+eFYOo+ap8fv5a5JLXwgMqSSrA5i3at8Jb
         v+RA==
X-Gm-Message-State: AIVw113vKvBUh9dOcYosRc6WmR8PId4tw+Jvs2TkVAQAmmAefPgJU/vg
        duOG2+65I/kLmXgpk3Y=
X-Received: by 10.99.102.68 with SMTP id a65mr10506746pgc.252.1499087921909;
        Mon, 03 Jul 2017 06:18:41 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id u9sm38085637pfg.127.2017.07.03.06.18.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 06:18:41 -0700 (PDT)
Message-ID: <1499087898.4156.6.camel@gmail.com>
Subject: Help needed for solving a few issues with building git
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 03 Jul 2017 18:48:18 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Building without localization support
------------------------------------
I tried to build git from source without localization support by adding
the following line to the Makefile,

    NO_GETTEXT=1

It doesn't seem to be working for reasons I'm unable to find. I used
the following commands to build git.

    make prefix=$CUSTOM_BUILD_LOCATION
    make install prefix=$CUSTOM_BUILD_LOCATION

While trying to build (without the 'gettext' library that's required
for localization) I get the following error,

    Manifying 8 pod documents
        SUBDIR templates
        MSGFMT po/build/locale/pt_PT/LC_MESSAGES/git.mo
    /bin/sh: 1: msgfmt: not found
    Makefile:2179: recipe for target
    'po/build/locale/pt_PT/LC_MESSAGES/git.mo' failed
    make: *** [po/build/locale/pt_PT/LC_MESSAGES/git.mo] Error 127

    What could I be missing?


    Adding HTTPS support
    --------------------
    I tried to add HTTP/HTTPS support to the custom built version for which
    AFAIK 'git' depends on 'curl'. I tried providing the location of the
    curl source in the Makefile using the following line after reading the
    instructions in the Makefile.

    CURLDIR=/path/to/curl/source

    Even after doing this the custom built git errors with the following
    message when I try to use the 'git fetch' command,

    fatal: Unable to find remote helper for 'https'

    Any thing I'm missing?

    Note: In case you were wondering, I was able to build 'git' after
    installing the dependant package which I find useless as I don't
    require any localization messages.

-- 
Kaartic
