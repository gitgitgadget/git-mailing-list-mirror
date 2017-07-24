Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACFFF2047F
	for <e@80x24.org>; Mon, 24 Jul 2017 04:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdGXE7U (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 00:59:20 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:38341 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdGXE7T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 00:59:19 -0400
Received: by mail-qt0-f177.google.com with SMTP id t37so10004763qtg.5
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 21:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P3lZRYS/TLuWrYhdcwGyu25HAxSTzY0L4S0NT3FAw58=;
        b=CO/a57iV5qZwLQEQmKtOQCR5XkflDo8zTQb1zxiINb7wLlVn6Ckg0yjoTnwdCjj5yp
         UGzkK3eEdgNM+H2VNg1atTKfcwc82JuVc5Ck0QVfaaVkM9UlEPRy/qQhZll0oDfy9DQ1
         878MyyE70VcG9JA+l8nO7jqosOcO7w+PhLrt0g4w+XTpQ5HB8H5nr0+2P6M+bxh0aCK8
         +g1QN3IR8VzpLoB9CPRvJi4SkYOWmvVw+ZZhNEx6LzF9naj2yG27hnQuKURkBaXug4Jt
         XP1dFarn+7WX38L4BNHFDl6Qh8yGyA8W4uInzKNqGNBLzsJ40iEqyzWchvn0Bpv0N6AZ
         8p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P3lZRYS/TLuWrYhdcwGyu25HAxSTzY0L4S0NT3FAw58=;
        b=SKSbxIMt6moIYrV/qKVZ4yw6R8zzeOrabnjRVxZ8Rz6ngupg7msa9vRViwzTB5bL7J
         YocdbI4RAnnZhdmnnwQN/y4eiLlNyHnzsG1QLJRFdQhUMN8B2eaEIrWfD5HyL8yHLLpg
         SGLnpUkfB8NsQ0G4leTeUW/eWcbzWnTKRhnd9ZOfemssyptPDS28gpPgMPGZ4VnX4Aqo
         2Yu7gqC3vkWrVbmITrHAb2u1X4SO2hMS53w8TQvApm0hQSx7ThKTn+VCYjRt/h8qkjX/
         NLG4LQcdkN7N2zwKM509Q2rz0cD/F7E7OQyXgwk9dFFVqDb0j0/hMnvtvHj9H4+7dwAB
         TKpQ==
X-Gm-Message-State: AIVw110BP7lfYrphH3FW0Qv9WvfVfp4Xcv/hEduRcClY/xUTFVdx3P6g
        EOmTlmfaLOwdTg8JXXYLyJJYZhZ9MQ==
X-Received: by 10.237.60.26 with SMTP id t26mr15937669qte.141.1500872359006;
 Sun, 23 Jul 2017 21:59:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.39.151 with HTTP; Sun, 23 Jul 2017 21:58:38 -0700 (PDT)
In-Reply-To: <CANENsPr271w=a4YNOYdrp9UM4L_eA1VZMRP_UrH+NZ+2PWM_qg@mail.gmail.com>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
 <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com> <CANENsPr271w=a4YNOYdrp9UM4L_eA1VZMRP_UrH+NZ+2PWM_qg@mail.gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Mon, 24 Jul 2017 14:58:38 +1000
Message-ID: <CAH5451m0P4eZMXj8ojgbd+q-8scoJpwn9UcZLvqYKM=+8hhWPg@mail.gmail.com>
Subject: Re: Should I store large text files on Git LFS?
To:     Farshid Zavareh <fhzavareh@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Farshid,

On 24 July 2017 at 13:45, Farshid Zavareh <fhzavareh@gmail.com> wrote:
> I'll probably test this myself, but would modifying and committing a 4GB
> text file actually add 4GB to the repository's size? I anticipate that it
> won't, since Git keeps track of the changes only, instead of storing a copy
> of the whole file (whereas this is not the case with binary files, hence the
> need for LFS).

I decided to do a little test myself. I add three versions of the same
data set (sometimes slightly different cuts of the parent data set,
which I don't have) each between 2 and 4GB in size.
Each time I added a new version it added ~500MB to the repository, and
operations on the repository took 35-45 seconds to complete.
Running `git gc` compressed the objects fairly well, saving ~400MB of
space. I would imagine that even more space would be saved
(proportionally) if there were a lot more similar files in the repo.
The time to checkout different commits didn't change much, I presume
that most of the time is spent copying the large file into the working
directory, but I didn't test that. I did test adding some other small
files, and sometimes it was slow (when cold I think?) and other times
fast.

Overall, I think as long as the files change rarely, and the
repository remains responsive, having these large files in the
repository is ok. They're still big, and if most people will never use
them it will be annoying for people to clone and checkout updated
versions of the files. If you have a lot of the files, or they update
often, or most people don't need all the files, using something like
LFS will help a lot.

$ git version  # running on my windows machine at work
git version 2.6.3.windows.1

$ git init git-csv-test && cd git-csv-test
$ du -h --max-depth=2  # including here to compare after large data
files are added
35K     ./.git/hooks
1.0K    ./.git/info
0       ./.git/objects
0       ./.git/refs
43K     ./.git
43K     .

$ git add data.txt  # first version of the data file, 3.2 GB
$ git commit
$ du -h --max-depth=2  # the data gets compressed down to ~580M of
objects in the git store
35K     ./.git/hooks
1.0K    ./.git/info
2.0K    ./.git/logs
580M    ./.git/objects
1.0K    ./.git/refs
581M    ./.git
3.7G    .


$ git add data.txt  # second version of the data file, 3.6 GB
$ git commit
$ du -h --max-depth=1  # an extra ~520M of objects added
1.2G    ./.git
4.7G    .


$ time git add data.txt  # 42.344s - second version of the data file, 2.2 GB
$ git commit  # takes about 30 seconds to load editor
$ du -h --max-depth=1
1.7G    ./.git
3.9G    .

$ time git checkout HEAD^  # 36.509s
$ time git checkout HEAD^  # 44.658s
$ time git checkout master  # 38.267s

$ git gc
$ du -h --max-depth=1
1.3G    ./.git
3.4G    .

$ time git checkout HEAD^  # 34.743s
$ time git checkout HEAD^  # 41.226s

Regards,

Andrew Ardill
