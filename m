Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F82D1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 19:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfAaTsV convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 31 Jan 2019 14:48:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40495 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfAaTsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 14:48:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so2620513qki.7
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 11:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wcrFWWSwI4lH90v1Zplu+c0kt1pTMjM4p8VzZaPEz+8=;
        b=knIgMQAqb4v5+rzgsn4693PWIfrPBHkEUw30hH90YcdSEhX/1vBjyfGIBglmSK4Ufe
         qiSGPYXhi7uEXHD3wurLv73yp9OXAMWMVPRetqUFafbZOPmxxAMhnmXBD4E2SHFxubuG
         PSHCQ7KXhD+oGo8Bl/jeSn/BhNzI0pPs5V/Fcc1sSzA//M+3w7fFx+AT11MElpmhX/m6
         ZOnMplVQiH4ZykJt987vJ0Wg2r6WtHRN/Oc3RKvrUP4I2ETSM5C/RkxbfpzxG9xHsscT
         fwuc4dB+09WxvdC37KkEsjOVZXhN4FqgHA8kr3/21rPrV8VeSES1OKyPp4JBnKC97mOE
         V94w==
X-Gm-Message-State: AJcUukcLItk7iWGsA4UfDRC6SrusKwdb+h6WWj2oxuXfmFBnBuZ1pUcq
        cFn48t1+w5BGBbbjudF8xA3G5mlZ5R5GSjSIUfs=
X-Google-Smtp-Source: ALg8bN4dpbzqMi9Fc3/0hXGmKDpZH6QJq7GU7w9k1IilDwcI6glsYXXJem2weaPcbmiGIOdXXzi5P/jxQTXlQJIu5Oo=
X-Received: by 2002:a37:66c1:: with SMTP id a184mr32845835qkc.314.1548964100049;
 Thu, 31 Jan 2019 11:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-2-jeremyhu@apple.com>
 <CAPig+cSkm-M7fP=KLOCO5J8OSYCEyjy950AM=VzTnP9C6AcKxw@mail.gmail.com>
 <534F20EC-2B29-46C3-BAD9-3CBE7312257F@apple.com> <nycvar.QRO.7.76.6.1901301340270.41@tvgsbejvaqbjf.bet>
 <8B5241CB-2E1E-4521-8FE1-A84C4896AE82@apple.com> <xmqq4l9o4sm7.fsf@gitster-ct.c.googlers.com>
 <F67B3B30-64D8-4B0D-A4FD-7263415B0064@apple.com>
In-Reply-To: <F67B3B30-64D8-4B0D-A4FD-7263415B0064@apple.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 31 Jan 2019 14:48:08 -0500
Message-ID: <CAPig+cST93AUt+7LHsigeA2=AHvNwveCPEszP6-kvjpkRTNmQQ@mail.gmail.com>
Subject: Re: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches
 *.S on case insensitive filesystem
To:     Jeremy Sequoia <jeremyhu@apple.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 1:17 PM Jeremy Sequoia <jeremyhu@apple.com> wrote:
> > On Jan 31, 2019, at 09:57, Junio C Hamano <gitster@pobox.com> wrote:
> > I still do not see what problem you need a "solution" for in the
> > first place---I saw a few comments asking it in the thread, but saw
> > no answer.  ppc/sha1ppc.S is already tracked, so any modification
> > you make in the working tree can be added to the index with "git
> > add" and "git status" would report when you have modification to
> > that file in the working tree, without any such extra entry in
> > .gitignore, no?
>
> This would have implications for anyone doing something similar or
> to anyone intending to add new assembly files to the tree (since
> they wouldn’t show up in status or get added with add -A),

This nugget finally gives readers an idea of the sort of issue this
patch wants to "fix", which happens to be related to HFS+ being
case-insensitive. As noted upstream, though, files which are already
tracked, such as ppc/sha1ppc.S, are not subject to .gitignore, so
Dscho's proposed modification to .gitignore:

    ...
    *.[aos]
    !ppc/sha1ppc.S
    ...

doesn't actually help. Moreover, this .gitignore change doesn't at all
help the case you describe about new assembly files not being noticed
by "git status" or "git add -A" since any new files won't be named
"ppc/sha1ppc.S".

As Junio said upstream, .gitignore ignoring "*.s" files is the right
thing to do for this project and, as adding new .S files is so rare,
it seems unlikely that a patch changing .gitignore to accommodate the
above use-case for case-insensitive filesystems would make sense to
the project as a whole.
