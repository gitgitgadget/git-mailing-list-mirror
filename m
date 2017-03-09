Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9D61FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 09:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754260AbdCIJbd (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 04:31:33 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36615 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbdCIJbN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 04:31:13 -0500
Received: by mail-ua0-f193.google.com with SMTP id y16so8731479uay.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 01:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SbLuDJrJ3YVY53+oXnxxyPdr44PjjJt10fVdY2qFktw=;
        b=nuDQFJThSC3Fl/GKgMhLXzw72Nk7Z1nYNsxk7sDpX62I6tN3k2NQI/nn55lcfbnGKz
         /+uk1PY389rFFA1gDsQvn+k8WoLddam4SDgj8XD2TcnBIp84sC/gEDEohV58KDuhvRQ5
         boGN29eZuSV3JmbsLBUi3sQs4LskYCHL6A/IN0Znn2oY/TwalqicxeL4hOcxC4l7H6fQ
         OhR7OlleHwU+4+8sB4VzaCjpr3sFOCvtO1JlIQ8QKbv4ipHlWTqKKuIw/Q80NuRrteQS
         QmnGHplU3yOlA9AK6G5nt0uQZWwEYX9o+CHRpTBELON5QTmA/qjOqjrCWFdy4yS+308B
         NYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SbLuDJrJ3YVY53+oXnxxyPdr44PjjJt10fVdY2qFktw=;
        b=pfgMSLNNUdx1HJ4LaVmx1BaiyfZm3YxA0rZupWCB/Kns93XacFqBiezIYRE3xce2+J
         4wUfTgzsq+5REgsqnUNpRo6OCoASaJ3DN6SLPSG3YGqN6VBtjNPfyixZ+mphWwfY3vST
         he1tLnO4Oy9dHk9R9g7oH2ERffTMDp4DzhfPpw7rja+Td68ieu2iZ6PhJkWEqyDBEHCl
         Y+fwfJzuqTBbMIeILhBA9la+9SoH+JfFLKj00tgaVtBGNq5FSBXwqNGGu3Rrp5JXzR9q
         8CR/eRZdN1Le8PZVi9RVHBeqTmCG86W5t44ygn+S35WMu56J9xKqnH4Y38+vrFJ0FXIo
         I7gQ==
X-Gm-Message-State: AMke39kSDcMms9dgNKl54GbHqELVGP2KPsDGzh3DVHS85rxbgOYIj8xDItaEJzKzqYvWXIvv6zJI+1pQ47N3nw==
X-Received: by 10.31.1.7 with SMTP id 7mr6272095vkb.0.1489049769312; Thu, 09
 Mar 2017 00:56:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Thu, 9 Mar 2017 00:56:09 -0800 (PST)
In-Reply-To: <CAP8UFD0GtRdjCMcbhjgA0rVaAMFtyto8JxfqbivODarBB0eK8w@mail.gmail.com>
References: <0102015aae7b8536-00c57d0a-1d48-4153-a202-87c4ea9e0e19-000000@eu-west-1.amazonses.com>
 <CAP8UFD0GtRdjCMcbhjgA0rVaAMFtyto8JxfqbivODarBB0eK8w@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Thu, 9 Mar 2017 14:26:09 +0530
Message-ID: <CAME+mvUDsBec0L9o_wpAMin-rbn-SqS1OZcuyfRw+U7b-EOXeQ@mail.gmail.com>
Subject: Re: [PATCH] t2027: avoid using pipes
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 1:38 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, Mar 8, 2017 at 4:13 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
>> The exit code of the upstream of a pipe is ignored thus we should avoid
>> using it.
>
> You might want to say more specifically that we should avoid piping a
> git command into another one as this could mask a failure of the git
> command.

Yes. I will add be specific, and update my patch.

>
>> By writing out the output of the git command to a file, we
>> can test the exit codes of both the commands.
>>
>> Signed-off-by: Prathamesh <pc44800@gmail.com>
>> ---
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
> I think it's better if the 'sed' command is on a separate line.
>
> Also you may have used just "out" instead of "<out" in the 'sed' command...
>

Actually I noticed that:
$ git grep sed |grep "<" |wc -l
307

As at most places, wherever pipes aren't being used, the input to sed command is
passed using "<". Hence I chose to use "<" at places specifically at
places where sed
was used, even after knowing that just "out" will work.


>>         test_cmp expect actual
>>  '
>>
>> @@ -118,9 +118,9 @@ test_expect_success 'broken main worktree still at the top' '
>>                 cd linked &&
>>                 echo "worktree $(pwd)" >expected &&
>>                 echo "ref: .broken" >../.git/HEAD &&
>> -               git worktree list --porcelain | head -n 3 >actual &&
>> +               git worktree list --porcelain >out && head -n 3 out >actual &&
>
> ... as above you use "out" not "<out" in the 'head' command.
>
>>                 test_cmp ../expected actual &&
>> -               git worktree list | head -n 1 >actual.2 &&
>> +               git worktree list >out && head -n 1 out >actual.2 &&
>>                 grep -F "(error)" actual.2
>>         )
>>  '
