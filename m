Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64BF91FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 13:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934876AbdCJNeS (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 08:34:18 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36378 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934354AbdCJNeP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 08:34:15 -0500
Received: by mail-ua0-f195.google.com with SMTP id y16so13949653uay.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O+YBRSuCjdS0LJzepiPW65UfgJXU5YiXXkb30qBBZsI=;
        b=gPob+0DA8e93H9v3A0XWCTifpseZKMb05u3NFvOMpVNmBCkMmfEgXcZ2h7eQwYjwci
         z0Rtn8kxJ2/GB5LMVnY0yPLgGl9v6rzHGa+AXfEWPbYWL6nfuZHT8RxWCUpxtrSYYB0g
         KMiu16vbZsbdRXxMs8xDmFFFPGxAo9AUk/mXh5QzS8LtNPcMelaCCoJDPD/n1Yixxfrn
         Qv4PPL7FnPxUbOMD6ine2XYYxaLiBfYqeKjugxMnJpr0ZNHg0JMXVAvwihaXpmgQT4oa
         s5zEs+R5F4KchbuZnewlin+eJ2AU0oeQKiJnHiQpBTGXhzEHua4dR2VzP5V0Q8uNCHDh
         HiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O+YBRSuCjdS0LJzepiPW65UfgJXU5YiXXkb30qBBZsI=;
        b=Gd3BJslVP1/gaC2wqVtGjEZ7aR0RkXticabD20kN/Np6qJeEbkmjJhcCjdncYItihY
         5OGRqP3T9a8RKbjQbUrtGqkqnv6Ylfgmps0ptQQ4dF/EgTPl7mrGlXL3VnpLBuQIag0d
         lbdLt58nFWU7kbyB+BwBmUrT4MmCa6tsfMxS/v1Zc6JCWvfFLhop1bt4LuultWbodo8/
         bOhS7FtmoOMjxzMYC+BrG3hEnXUicCGkPkLyBOKsvl4ue+oFLABXKimoRaw9uU8oydU1
         4ile3Efk1rHUw+aG9VLLQwtU4jYsTOECiWVyL5i7gSXJid2jaF3K7oXHYOc8inQclZ+b
         T0kg==
X-Gm-Message-State: AMke39m7AI7P/PDlT5+DOOYiZjJ/jngFp7NfgLzfXhaYFWgPT/N8YgdlekJJ7vBUWIhtqhTC5Q5j8UmsyArUtg==
X-Received: by 10.176.0.240 with SMTP id 103mr9244101uaj.114.1489152848649;
 Fri, 10 Mar 2017 05:34:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Fri, 10 Mar 2017 05:34:08 -0800 (PST)
In-Reply-To: <CAP8UFD19njU30HODYvp1pddpZaVSVGgn7whcTa2rdjMPe-vzYQ@mail.gmail.com>
References: <0102015ab26fcf13-1659be12-a85c-47be-9a77-8f1b0b8a3897-000000@eu-west-1.amazonses.com>
 <0102015ab27c6633-c61f56f2-0504-4af3-badc-34246cf635aa-000000@eu-west-1.amazonses.com>
 <CAP8UFD19njU30HODYvp1pddpZaVSVGgn7whcTa2rdjMPe-vzYQ@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Fri, 10 Mar 2017 19:04:08 +0530
Message-ID: <CAME+mvV0i7gZWUX_77Z2QrsdOWEq0LRDXX3iqKJ=9bCN+yv=vA@mail.gmail.com>
Subject: Re: [PATCH v2] t2027: avoid using pipes
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 6:00 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Mar 9, 2017 at 10:53 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
>> Whenever a git command is present in the upstream of a pipe, its failure
>> gets masked by piping and hence it should be avoided for testing the
>> upstream git command. By writing out the output of the git command to
>> a file, we can test the exit codes of both the commands as a failure exit
>> code in any command is able to stop the && chain.
>>
>> Signed-off-by: Prathamesh <pc44800@gmail.com>
>> ---
>
> Please add in Cc those who previously commented on the patch.

Actually I initially used submitGit to send patches, where there was
no option of
adding cc to the patch. But after your comment I have switched to git send-email
and git format-patch for sending patches.

>
>>  t/t2027-worktree-list.sh | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
>> index 848da5f..daa7a04 100755
>> --- a/t/t2027-worktree-list.sh
>> +++ b/t/t2027-worktree-list.sh
>> @@ -31,7 +31,7 @@ test_expect_success '"list" all worktrees from main' '
>>         test_when_finished "rm -rf here && git worktree prune" &&
>>         git worktree add --detach here master &&
>>         echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
>> -       git worktree list | sed "s/  */ /g" >actual &&
>> +       git worktree list >out && sed "s/  */ /g" <out >actual &&
>
> I still think that it would be better if the 'sed' commend was on its
> own line like this:
>
> +       git worktree list >out &&
> +       sed "s/  */ /g" <out >actual &&
>
>>         test_cmp expect actual
>>  '
