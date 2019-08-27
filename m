Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A931F461
	for <e@80x24.org>; Tue, 27 Aug 2019 22:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfH0W0J (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 18:26:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45576 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0W0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 18:26:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so632378qki.12
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=d7Hv9DmG3oKHxh3xyjKtw0p0y2qQrZ/u4/x+zgVS8/U=;
        b=IgdZDYP6Itw2iCOKpkwB/Vgp0B71azyqaPLPoxk/O5maeZyiLJJ3Ydt0iiSFkeL4SO
         PWpu3Q+pl5LDE7/3k6SVXv8qwX6KeGiOFgRkvtPma27MTLfzVp0S+dQVyvkn7IZ1bwVY
         2IPEhVH7suHcSDurOR6vDWG4dcPONCDVh5rpGqgTH9A6lBwO5M2Eg5lSBNA6mL8BQXk8
         NGGP3KQUxlQ8oSW7izJjBa9jLD7UMYbPqLAsfRGIVxAHJZRuQSLm/ifL1Ye3UM6lx4VV
         z83GwbjaQQypLoHOGcafNRvUSynWh0YG54aWOuw7dXQ1APswHhiGzkUX4iGUQl5/ONTT
         lLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=d7Hv9DmG3oKHxh3xyjKtw0p0y2qQrZ/u4/x+zgVS8/U=;
        b=RQDJ5Xgrxy2ealmLkMC9pBje98wQKo7Fqa6j9wgUO5VmgkO47Ovfa8zE9NqPjUrhwN
         o3oXoJ/w9Wbdc+YmwFKSd6uxx1iV24n/GAo7og58fGrKD6PSqHNvRo2ETCs8+Hu9X1Kn
         r+6we34vE+Z6JVFXDLDCz43S1O4f3fr+eaKep+2mp9gY65T8iGTlOJzmJda2scQ6dPUk
         nks1gnXVskKNXnc/zRa9JY+RYMXNO2mjvCu+/3VpH48vjIe1FkXJ1NH7TQ0tkZVlRZCv
         qgU63xIEdH97sGD7PnILUiS2gishuDIr79vLtq31VrPXeTxPkuNrDmQRqCc8zuHL4D23
         zK2w==
X-Gm-Message-State: APjAAAVj2MGUqyzR7UZyMFzMNbAP9TEI72HH+fyQXwaHbwPZNFnX9/jQ
        9T81FePzK4w14rwnov+ifKwVw1L+4OY4NTk79hbLwzEFwJg=
X-Google-Smtp-Source: APXvYqyPuQEx5qG7mjLbkdIvpz2mHvunOCHUYk411LENHxXgiaTC5RAe3rCxDZmRLdwLxeA7sprujbJidMXkCAodKWk=
X-Received: by 2002:a37:9cce:: with SMTP id f197mr925981qke.129.1566944768232;
 Tue, 27 Aug 2019 15:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
In-Reply-To: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
From:   Dmitry Nikulin <pastafariant@gmail.com>
Date:   Wed, 28 Aug 2019 01:25:57 +0300
Message-ID: <CAH53Sy=zcP=DRg5WQFkaBp9CoHP+phCA_NasM5OqOdfwQGkQyQ@mail.gmail.com>
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF incorrectly?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have put up a demo repo here: https://github.com/dniku/git-external-diff-argv

On Tue, 27 Aug 2019 at 21:24, Dmitry Nikulin <pastafariant@gmail.com> wrote:
>
> I wrote a very simple Python script to see which arguments git-diff
> passes to the external diff program when comparing files across
> branches:
>
> $ env GIT_EXTERNAL_DIFF=./print_argv.py git diff
> origin/branch1:file1.txt origin/branch2:file2.txt
> ['./print_argv.py',
>  'file1.txt',
>  '/tmp/QRaIJ1_file1.txt',
>  '802b1c4ed7b06162b2ce09b7db72a576695b96e5',
>  '100644',
>  '/tmp/AZuOJ1_file2.txt',
>  '076e8e37a712d8a66c0c3d1a103050dc509ca6ff',
>  '100644',
>  'file2.txt',
>  'index 802b1c4..076e8e3 100644\n']
>
> According to the docs
> (https://www.git-scm.com/docs/git/2.22.0#Documentation/git.txt-codeGITEXTERNALDIFFcode),
> git-diff is supposed to pass 7 parameters:
>
> path old-file old-hex old-mode new-file new-hex new-mode
>
> This is not what I am seeing here. Is this a bug or
> incorrect/incomplete documentation?
>
> Tested with git 2.22.0 and 2.17.1.
