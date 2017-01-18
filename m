Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5AE1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 19:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbdARTOs (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 14:14:48 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:50146 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbdARTOr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 14:14:47 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 65EDD10C00CF;
        Wed, 18 Jan 2017 11:04:48 -0800 (PST)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3F7EA196;
        Wed, 18 Jan 2017 11:04:48 -0800 (PST)
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 22B8C18D;
        Wed, 18 Jan 2017 11:04:48 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Wed, 18 Jan 2017 11:04:47 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Wed, 18 Jan 2017 20:04:46 +0100
Received: from [10.107.19.116] (10.107.19.116) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Wed, 18 Jan 2017 20:04:45 +0100
Subject: Re: Git: new feature suggestion
To:     Stefan Beller <sbeller@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
 <CAGZ79kYXQcUB+rVkboY9fMqu6R3RoHEJ7BTJn_+-RScFDjEduA@mail.gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
From:   Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <21caed00-d103-5534-156c-0c19f25e0879@synopsys.com>
Date:   Wed, 18 Jan 2017 19:04:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYXQcUB+rVkboY9fMqu6R3RoHEJ7BTJn_+-RScFDjEduA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.19.116]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Stefan,

Às 6:50 PM de 1/18/2017, Stefan Beller escreveu:
> On Wed, Jan 18, 2017 at 2:40 AM, Joao Pinto <Joao.Pinto@synopsys.com> wrote:
>> Hello,
>>
>> My name is Joao Pinto, I work at Synopsys and I am a frequent Linux Kernel
>> contributor.
>>
>> Let me start by congratulate you for the fantastic work you have been doing with
>> Git which is an excellent tool.
>>
>> The Linux Kernel as all systems needs to be improved and re-organized to be
>> better prepared for future development and sometimes we need to change
>> folder/files names or even move things around.
>> I have seen a lot of Linux developers avoid this re-organization operations
>> because they would lose the renamed file history, because a new log is created
>> for the new file, even if it is a renamed version of itself.
> 
> Well there are a couple of things to help with digging in the logs.
> 
> git log:
>        --follow
>            Continue listing the history of a file beyond renames (works only
>            for a single file).
> 
>         -M[<n>], --find-renames[=<n>]
>            If generating diffs, detect and report renames for each commit. For
>            following files across renames while traversing history, see
>            --follow. If n is specified, it is a threshold on the similarity
>            index (i.e. amount of addition/deletions compared to the file’s
>            size). For example, -M90% means Git should consider a delete/add
>            pair to be a rename if more than 90% of the file hasn’t changed.
>            Without a % sign, the number is to be read as a fraction, with a
>            decimal point before it. I.e., -M5 becomes 0.5, and is thus the
>            same as -M50%. Similarly, -M05 is the same as -M5%. To limit
>            detection to exact renames, use -M100%. The default similarity
>            index is 50%.
> 
>        -C[<n>], --find-copies[=<n>]
>            Detect copies as well as renames. See also --find-copies-harder. If
>            n is specified, it has the same meaning as for -M<n>.
> 
> 
> 
>> I am sending you this e-mail to suggest the creation of a new feature in Git:
>> when renamed, a file or folder should inherit his parent’s log and a “rename: …”
>> would be automatically created or have some kind of pointer to its “old” form to
>> make history analysis easier.
> 
> How do you currently analyse history, which detailed feature is missing?
> 
> Mind that in the Git data model we deliberately do not record the rename
> at commit time, but rather want to identify the renames at log time.
> This is because
> in the meantime between commit and log viewing someone could have written
> a better rename detection, whereas at commit time we'd be stuck with ancient
> cruft forever. ;)
> 
>>
>> I volunteer to help in the new feature if you find it useful. I think it would
>> improve log history analysis and would enable developers to better organize old
>> code.
> 
> IMHO complete renames (i.e. git mv path/a/file.c path/b/thing.c) are already
> covered quite well. Partial rename (e.g. moving code from one file into two
> separate files or vice versa) is still a bit hard.
> 
> I started such a new feature, see
> https://urldefense.proofpoint.com/v2/url?u=https-3A__public-2Dinbox.org_git_20160903033120.20511-2D1-2Dsbeller-40google.com_&d=DwIFaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=BseICq5hy9UHxmX2XP8oPYLbn-HoEUlEuVUzqPHkX58&s=PybtKK0ELH3Nld_CQSYZnLqCQOWvnU4Fjj5iV_7EKqE&e= 
> latest code is at https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_stefanbeller_git_commits_colored-5Fdiff12&d=DwIFaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=BseICq5hy9UHxmX2XP8oPYLbn-HoEUlEuVUzqPHkX58&s=pkTehcEmeHVLHdcNbUiU03meyH10cgUbGqLgOqXcL6w&e= ,
> but the latest two commits are bogus and need rewriting.
> 
> I think this feature is not 100% what you are aiming at, but is very close.
> 
> Thanks,
> Stefan
> 

Great info, helps a lot! I am going to analyse and get back to you ASAP.

Thanks

