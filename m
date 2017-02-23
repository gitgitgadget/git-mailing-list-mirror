Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0FB2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 20:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751222AbdBWU1W (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:27:22 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33390 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdBWU1U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:27:20 -0500
Received: by mail-wr0-f169.google.com with SMTP id u47so1300452wrb.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 12:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iBpjVxxFyjjvttqJ8D5r9lh4rOwRNDcF+rrczy7a9Vo=;
        b=oY6szZf7dQc1YPenRuxR577FA/iY709nN3HN2owxQeJCfxoiNVA3BoGl0VU9TS7BQZ
         bLtb99krjbDizpnf1mtb75cyTXCMjIAjoKlRyS/2oLi6e5AtBPfkB7KJZM1QFPKJjCQh
         EnBMdHaxqJdzzPUUk2AiHgFkG9LIIfox1ZIVem9/iTjLysHDtY5g3e9qO9f5sjfgx2zg
         NI5XXY0h9KOmaSzofpTtV3UrCYfoFIEbc6eGOv/RvSeeBvqpzUR1e7s6XMqJl7wQrZno
         xn+YyO8vUTMXwTC1BGHFHlp6FarnvJ+Yy5c0CqVug9bgUInyC/5JFWi/ofig2qEwNs+H
         q0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iBpjVxxFyjjvttqJ8D5r9lh4rOwRNDcF+rrczy7a9Vo=;
        b=RUQD21cYzaW6+EGRdHG/fC5ZNEMNlvmvfOgeWMmul10oyTKTLlsHR1gxZ4v6XdCsXO
         ykziYq3b4bdhE+VUV8IQjITEPjGitSTPZNcPQm4iV6tjCYVQBIzJnrBGMA+l/dnEZczG
         Goj58PqflteftGmkfHUFDsJACYtKrkHtZZZqJ21284pVbnohXzueh+Hnfvm0NtuwGPXm
         nppbQRS/XMsnifU76rAxoVKFVBjMEaFenvl04Eb1FQKVxwY8sSuZCFLew6/Bzdu709Lf
         4L3n1lNTg1mn+3a9ueOf8FSoSVozN/MoqmprmxSg2ugRVoiiM4vQIsa50JcEdADNj1+4
         5/4Q==
X-Gm-Message-State: AMke39nbi7LxWaeihbvJUohSzZu+bbPhFfKHSsKR7PYHWn00ZHZ1H5LlBO/Bw7pRK+A1WlC4X6OYfGPMLpR6BA==
X-Received: by 10.223.161.139 with SMTP id u11mr18460840wru.142.1487881634229;
 Thu, 23 Feb 2017 12:27:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.169.91 with HTTP; Thu, 23 Feb 2017 12:27:13 -0800 (PST)
From:   Sean Hunt <southpark67439@gmail.com>
Date:   Thu, 23 Feb 2017 14:27:13 -0600
Message-ID: <CAHikyLoK-h4tY_rxGikaSSv6AmcrBAXiayDFTtLa44A9qMZDqA@mail.gmail.com>
Subject: git bugs
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few bugs I git I noticed when using mingw, mingw64,
cygwin, and cygwin64. These bugs are the following:

if I do git ``rebase -i --root`` and tell it to edit every commit to
gpg sign all my commits it bugs out and merges all of the commits into
1 commit instead of only appending the ``-S`` to each and every commit
and keeping all of the commits. It is as if I told it to squash the
commits but yet I did not. There is also another bug where if I clone
a repo on Windows and not on github desktop and that I placed commits
to the repo on github web and then when I rebase to squash the commits
to 1 commit (some repos are doing it as a requirement for 1 commit
PR's) that all of my commits on the remote (fork in this case) that is
linked to an open pull request are discarded and then the pull request
is somehow and oddly closed. It is super annoying.
