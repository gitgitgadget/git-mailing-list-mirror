Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAAB1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 15:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbfHFPyt (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 11:54:49 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40788 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732676AbfHFPys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 11:54:48 -0400
Received: by mail-ed1-f54.google.com with SMTP id k8so82714018eds.7
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+VJY0MgiXBSWZAzLrX7QZUP+VC7pEARLgP8+MkHcVNc=;
        b=EkKtzkr0PLFOWCfn4YAqBxOkPw8EfG+rHZtoIpR465Bpta5lyN610RjSpIyvdz9XXd
         r/7ax2/u1hepkChEnkSKtlnChGr10fVNdSa0R09ZCt4FZoc/tr0P9i1PpEz92QpCg6NX
         Q41ECOvygpwOJNg0ddDkdxj7mkohtrh+VUpB89s1zaMZCTfFRlq+EPGnVHbeEBLlwQgN
         qj3zxxx3K7/BCyoXHihQvCzu5QdPhUIC+s7nqibizA7kL/je72QTG/nmYbnrKjnMpKAl
         qin2QWtA2y68VmZNWSFwr3kRQ+1sqyvRY1F2QvZF2SvWQIdtCqlVFrVwQ1RMv84iJyfC
         0HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+VJY0MgiXBSWZAzLrX7QZUP+VC7pEARLgP8+MkHcVNc=;
        b=Ng1PJC0Lg4srVfBQf11bSsK9gKOSomlZQsoblFFflA8/u+Q0v8ksm8iY+iKFQZG8EY
         cwhm7JhSqKHvg4Aq2E/70GuM1PdevASbaKNgP2fu1Wz6q194GHsdj1JoZKP1BkvNoXIc
         qdTj/wPwBZwJ/LVV/qDoT23B3u6fs99P8HujweKJatUzd4VYSCn3kWT3MqpjK7uyXbOO
         camh1Nmzco05jtKluRnbCp6VlwjmoITJIUrtPNBSLa+OVlb2j5UACU5DOykOwMXdZPdu
         C3polGCmSlZfbWrRvGR4ZlpMdms9Iyi20ko9abhW4uYV4Pb5j/fjfRYWmVtSCFIVqRNu
         ICWg==
X-Gm-Message-State: APjAAAXTDTSBieHh4OeaspTApL6X8phPtXAluDADB8U1C+pqmYPfc8S4
        +747WN1En9qf0CExKh6yeL0Luso2nfCOOoBGQxUTLSpTFr77/w==
X-Google-Smtp-Source: APXvYqzPOHBfVg97hctGd5X4ge9dRIKS46NOLTp9CU76bGUyOQuNqGd2U6aJTrS7AM3jnGxwj17M0jgSJY23ke/I9G4=
X-Received: by 2002:a17:906:31c9:: with SMTP id f9mr3945983ejf.168.1565106886671;
 Tue, 06 Aug 2019 08:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <CADqa0D5wVWk2wa-raeVmCEhCqYznpba4TeUW_7UQOA0huR-RAg@mail.gmail.com>
In-Reply-To: <CADqa0D5wVWk2wa-raeVmCEhCqYznpba4TeUW_7UQOA0huR-RAg@mail.gmail.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Tue, 6 Aug 2019 17:54:20 +0200
Message-ID: <CABUeae9JhQ+JcNzYRMr40T2FTCJChYEz_riUr6Q1O5YO0uEDng@mail.gmail.com>
Subject: Re: Suggestion: git clone should warn if repository has submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 6 Aug 2019 at 16:04, Jason Sewall <jasonsewall@gmail.com> wrote:
>
> Submodules are great, and I used them at work. The problem is, people
> wind up cloning my repos without --recursive and then nothing works
> for them, because  the submodules weren't populated and those
> ultimately are needed to build my code.

What you need is a simple document for your team that outlines the common
Git workflow or README.md in root directory of your repositories with
fat heading:

## Clone

```
git clone --recursive ...
```


A team in another company may require non-recursive clones by default
and warnings from git may be quite annoying. Given the fact there is not
one but may valid "my way"-s available, acceptable and supported by Git,
I think, babysitting behaviour is not quite aligned with its philosophy, is it?

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
