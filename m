Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69BB1F45F
	for <e@80x24.org>; Wed,  8 May 2019 21:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfEHVYx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 17:24:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37767 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfEHVYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 17:24:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id a12so18970453wrn.4
        for <git@vger.kernel.org>; Wed, 08 May 2019 14:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdYYJbJxnbfILHbKdBlanBogJbAgEpABvkRpjrCHO08=;
        b=rB68VdKdgkBTON7iJFl0qsTjPseXMVoodspIJPtaFj69XOEPMxRqmNNiRGoNvVWI5s
         Bpsm2Ag7f0YJAneHxTuWgYbI1prlw4I93f9JxClbeCuZ78MXFXU8/rtIz2FQoQzPcyBx
         8yfvNLIQMxxrHX805vD5JVXcifPDQHEDvejKF7ztJZvAKdpNyuXdimkd5zHEzRIiR4zR
         68fazEdqTLyic4eTQ7Ss4oS0+RFS4ImqlJy/fRzdaGDmFoMzEdWePRySdEe9qm1OUpjo
         3965FOfzdHvC8zWFnEH1cWVnRhDVqNAtVAAT8T+FAShT8tW3nVfn0SSBKQWDHgfA4t9d
         befg==
X-Gm-Message-State: APjAAAXVM1qQrh+QxgFbpl84Vfbb/0gN9Qds260d/oKhDLWgUlHrZ474
        bYpBYOpDQJaN3D2jtDKFQDkzyBu0xJtFR4zfhbU=
X-Google-Smtp-Source: APXvYqyx3vcOs/XcMib0bqhCPhchznQEZDQGCMOPjGDM6OPgmSFS4P+evckr/kuSymSaVRRjt1bprmOhha9QrrKbobI=
X-Received: by 2002:a5d:4206:: with SMTP id n6mr96297wrq.58.1557350691311;
 Wed, 08 May 2019 14:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzhnxfe3p.fsf@gitster-ct.c.googlers.com> <20190508105607.178244-3-gitster@pobox.com>
In-Reply-To: <20190508105607.178244-3-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 May 2019 17:24:39 -0400
Message-ID: <CAPig+cRrPsm+8Ja16A0t1ihM0OKZUn=pexhWaKGjUst-EvSOLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] send-email: honor transferencoding config option again
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 8, 2019 at 6:56 AM Junio C Hamano <gitster@pobox.com> wrote:
> Since e67a228cd8a ("send-email: automatically determine
> transfer-encoding"), the value of sendmail.transferencoding in the
> configuration file is ignored, because $target_xfer_encoding is

s/,//

> already defined read_config sub parses the configuration file.

s/defined/& when/ --or -- s/defined/& by the time/

> Instead of initializing variable $target_xfer_encoding to 'auto' on
> definition, we have to set it to the default value of 'auto' if is

s/if is/if it is/

> undefined after calling read_config() twice to parsing the

s/parsing/parse/

> configuration files for "sendemail.transferencoding" and

s/files/file/ (I think)

> "sendemail.$ident.transferencoding".
>
> It was made trivial to do so by the previous change.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
