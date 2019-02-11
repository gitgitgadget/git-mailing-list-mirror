Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94FE71F453
	for <e@80x24.org>; Mon, 11 Feb 2019 23:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfBKXpe (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 18:45:34 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:35312 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfBKXpe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 18:45:34 -0500
Received: by mail-it1-f173.google.com with SMTP id v72so2917061itc.0
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 15:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=0377EyNTWth7wvKMfWoOLWUB6O0R9LfQ2ca/3Np4NIA=;
        b=DwXks8EXMW04sq6G+LCKImcSUB8hfd0MPAvUUR5g6DMEObvlrs49MUdM6kHKTLb9qr
         V8j46kQjIUUJDmdilNVzcwcDJ52DINklG+apK9VSy9Bi1NSuwIuJLCc/ylu6nLgvGqwe
         YEq1LeE9cZhIGSv45Zch6Pblcs+4FXAupsXU9lX0s+HM4OVIkGhKAN0xMq/259WrMNRb
         95qotNX8RWPVh1GZNo4aJPw6nN/R4aoMjYRK/h80Si4RGyHH58ec4hqKtmBY8DDqkptO
         5e/Rs7+zWRjV9/00mfIeuzmxCtBRFm+z2aDXb67cgtrbyD+Ahf0cLJAcOjnGeSvycMne
         oDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0377EyNTWth7wvKMfWoOLWUB6O0R9LfQ2ca/3Np4NIA=;
        b=JQ5jrqYUYP52Jym9xj83TLdk3o5F58GYK1PwIPyowNcJnMdk9WzhUVOnX1wqTyIsw6
         FO6QZk34avnc8BYy2bkDmwCZJX9zfTIANDaQ5H+X0o0rwTiEbpNieN48KB51gEOkIuU5
         5FJm5Sw+PeyrMgzHxC9hkswyWdImdk/NEYVhVt7hAaqK+yqpw2Y0T26Xecl0VTLBUNNy
         NC7y69q1Saac6SRwKOgmtRgfPyJRo7PCCrocs6YbIm+hw8sEzySbFfAwDJ7LqJkxkepD
         kv0qju2gNsLGCJa0A32NjYkKDyeRLd+3RJ4INqML//nhviD2cUpyVK62rFPDdpjUO1/Z
         1R4g==
X-Gm-Message-State: AHQUAuYRemc9p5Ezdzt8CbwoviwZfOFLml6SoMAt0dzFea9/Eg9gB+Fy
        CByhPcCytWRWFSSg9NOtVn3mW0lggReBCpKOsPcsZ0bIABA=
X-Google-Smtp-Source: AHgI3IaB+oggRnT3gMSB4Jv0ZOZSXkUU3DHRKQcQvnNa9AR42pmTB2sQ4Br33/qK0nJEcdxJoRAR+4rBCGG7i9w5en0=
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr408030ite.72.1549928732962;
 Mon, 11 Feb 2019 15:45:32 -0800 (PST)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 11 Feb 2019 21:45:21 -0200
Message-ID: <CAHd-oW4p6XUjF_j+XXwYWGt__L_5bTJGwxmgWhxJfpuAFac=dQ@mail.gmail.com>
Subject: [GSoC] Microproject on git-credential-cache
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I've been contributing to the Linux Kernel for the past semester and
I'm now looking to take my first steps in the git community. I'm also
interested in GSoC 2019.

I started looking at https://git.github.io/SoC-2019-Microprojects/ and
one that got my attention was "Move ~/.git-credential-cache to
~/.cache/git". But looking around at the code and the mailing list,
this microproject seems to have been already solved at 60759ba
("credential-cache: use XDG_CACHE_HOME for socket", 2017-03-17),
right?

For the microproject "Add configuration options for some commonly used
command-line options", are there some options already known to be good
for adding to configuration file?

Finally, a non GSoC-related question. Just to confirm my understanding
of Documentation/SubmittingPatches: I must send patches to the mailing
list first and after some feedback from community, send to the
maintainer with CC to the list, is that correct?

Thanks in advance,
Matheus Tavares
