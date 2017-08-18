Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C50FE208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 19:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbdHRTd2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 15:33:28 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36226 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdHRTd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 15:33:27 -0400
Received: by mail-yw0-f180.google.com with SMTP id u207so64647688ywc.3
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q+B7bv97yVqSoWbbkVVYk5/G2nhv6TnYFifRB7Fr9x0=;
        b=H2rkahA7F8cXZtBu/BLx4sCi0Pn+GybJimuYRF6iqtFh0vMAbKSvML7ZRFOh518jaU
         W4NByZZYm4Fs34V+rj269EdA3xm1T2vNznogQytZVof1ZeyYYgz2y4Hiuru2RIT7HMlD
         GQBwskhbZDcWK9YVU75hakv3isnqtKx2Th4/Dr8IKyM6FXpUo9OEdIrtvvPLcaXBHWi3
         jRNJuXsmVNtmkAAgIfU5VexXxPDjQs2yABUA8CfQt9ocyXM3pBBasx4kZwBFHn8W/KZI
         77drVfJa+G+eV1sTikFQijNqbOE4pMdDp1wJuJpGNpR8xvruekxJPjbRB3ydgVRHV2NM
         BtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q+B7bv97yVqSoWbbkVVYk5/G2nhv6TnYFifRB7Fr9x0=;
        b=V8/fy+Y4nmwIlQBXNwfcjNe3u9PLVmlrsqSAX2p4CTKL9xO84BQUMAT2k0HzAVtcj1
         1fqu4rh36yKxW7XrDQ3MKVPt2CVl68UYf9SjYnC3P1+HVMkPgJxJJpptsWO9z77ORo7P
         +kIjKRqUSKisq+JhXTB/D8Y/VLhLWQkIR8l2goZVkxcNYtLg+f4yNRGAWf3nxbNB52Bo
         0lD/IH84hZTYWCLeBy9mW6uL2vQb5rKdIzERwE+dNH154NXSa5Cjto5cps4d/1xPzFLD
         LqaADKFSbfRPc6zkBvSzB0KFMEkZ1LG3NZycXgdcnqVDR8KFUrkQ+kdeIwsTC6cLvqkR
         VSDg==
X-Gm-Message-State: AHYfb5gVjBtM/YGV2Bi1pZxQbiIT8ZIcYGXGjfhOV4Quzmdp2V20vkOG
        5hgDeGdnWBC557K/79neNj3Rz32nTAxqLexzkw==
X-Received: by 10.13.198.6 with SMTP id i6mr6083539ywd.422.1503084806981; Fri,
 18 Aug 2017 12:33:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Fri, 18 Aug 2017 12:33:26 -0700 (PDT)
In-Reply-To: <CAAD4mYi24dHNhG1MFkPaeVv9P-9UN_FxSvZmX6XFHrfA7K0hoQ@mail.gmail.com>
References: <CAAD4mYi24dHNhG1MFkPaeVv9P-9UN_FxSvZmX6XFHrfA7K0hoQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Aug 2017 12:33:26 -0700
Message-ID: <CAGZ79kb+zuUNNTUb6y9ramEChc5N+vE1mXVxFHEWv6zamEnw7w@mail.gmail.com>
Subject: Re: [bug] Git submodule command interprets switch as argument and switch
To:     R0b0t1 <r030t1@gmail.com>, Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 10:16 PM, R0b0t1 <r030t1@gmail.com> wrote:
> The issue is as follows:
>
> R0b0t1@host:~/devel/project$ git submodule add
> https://github.com/user/project -f
> Cloning into '/home/R0b0t1/devel/project/-f'...
>
> My .gitignore's first line is *, and then I explicitly allow things.
> Despite the presence of "project/" in the .gitignore the submodule
> command says it is ignored.

That might indicate that another submodule command doesn't
cope with submodule names that look like a common flag.

> The "force" flag is interpreted as a flag
> and also as the destination directory.
>
> It is possible the argument parsing code for other commands exhibits this error.

Yes, though these other commands are in C, not in shell.
Note that Prathamesh is currently porting the "git submodule"
command to C, which would allow us to fix this bug easily.

Also note that the -f is ambigious, what if the user meant
to have the submodule at path "-f" ? (This issue comes
up in many other commands, for example when a path
and a branch name is accepted, the path of a potentially
deleted file.

To solve this git accepts a double dash, which signals git
that anything after the double dash there are arguments not
to be interpreted as a command line flag.


>
> R0b0t1.
