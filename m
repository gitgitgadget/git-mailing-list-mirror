Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD062018F
	for <e@80x24.org>; Fri, 15 Jul 2016 07:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbcGOHqo (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 03:46:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33709 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbcGOHqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 03:46:38 -0400
Received: by mail-it0-f67.google.com with SMTP id d65so812101ith.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 00:46:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6F1TWz7oFa4nmP4aViQMSJk8ey7HUf67IMvR7qq8OjI=;
        b=r26RjUhSQwHqKi1Ur0NDuclwr371H0D8sxgcgkidAelwNJrgubfG/Ppywe7IH+gkJu
         3DIFVa3cTVn/kDabFmtnjOpIgzWSjy3owXjkVxn2ulXE5/Eeh9ZkuePrDhdkEWBM6so/
         hs5NBczkNhwq3seZY/0rdC66AxxKE15rrAiXkpqhsRtou2w19GCKgAHIW9K1lyhW3qSD
         mdkVOpRbJxDokaQbOj7vfuX9/8plwYwyzUdnmOvRRqbMGBPH0yBLaehfJ09PP0JLsheQ
         tkLG1qFLEnQkeSUkkOXDzDjEUPcfO3V0BmuMnBzV0udqsjitKTw8nVcQGrZCWw07IIZB
         2d/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6F1TWz7oFa4nmP4aViQMSJk8ey7HUf67IMvR7qq8OjI=;
        b=AtpGQ4U9gmxCoqUgSOrOEJ4HcnbrrT7MkLLjDN0kQrb6htaBiXSAwdciiWrAQY5pOH
         FM049pJFnlp2/0K6NjstZNMV2pLCeswmCYbHYJAfCrry7fF2pw0z2unK6KdD0O9h/HJV
         pVTHqTqGSS8n1CtrzIuFtnOVbBiJTyjL9+TWIsHVntqhxKm2KBKhsOBe6o2fGWo8NECi
         jbjq0xu9YcolOlTNcpLtl6D8GBxOX9s9e2jM4sjIati8CA5DSV5ApUuwVf+b0bIl7H06
         /nxGPnO++kw912rQJpislbYglL78FZrvBUyRKqv65U1j4AA77JicaJR2kC9W+Oh6N3ue
         sz3g==
X-Gm-Message-State: ALyK8tI1sgrAQg3S4VXrPmaBzGm9uhi31fpnIzMZccXd8AnKVoVWOMILjxI+F1AEBsUPfaLl+aLNFErAXq4wFg==
X-Received: by 10.36.5.17 with SMTP id 17mr19838662itl.29.1468568797812; Fri,
 15 Jul 2016 00:46:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.7.16 with HTTP; Fri, 15 Jul 2016 00:46:37 -0700 (PDT)
In-Reply-To: <ab717fc4-fd07-53d1-1a88-ceba6155889c@kdbg.org>
References: <1468550579-9298-1-git-send-email-avagin@openvz.org> <ab717fc4-fd07-53d1-1a88-ceba6155889c@kdbg.org>
From:	Andrey Vagin <avagin@openvz.org>
Date:	Fri, 15 Jul 2016 00:46:37 -0700
X-Google-Sender-Auth: hG1Dv31CDnh9F8poegdAUHpBgAM
Message-ID: <CANaxB-y6XW7-ps1G2CB=N9CiD0VnSLhSer2nsf+2R4pm5TyswA@mail.gmail.com>
Subject: Re: [PATCH] git-clean: remove fifo, devices, socket files
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 10:56 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 15.07.2016 um 04:42 schrieb Andrey Vagin:
>>
>> Currently git-clean removes only links and files, but
>> there can be special files like fifo, sockets, devices.
>>
>> I think git-clean has to remove them too.
>
>
> I think that is not necessary. If you do
>
>   mkfifo fifo && sudo mknod zero c 1 5
>
> then 'git status' will not report them and 'git add' will not add them to a
> repository.
>
> Similarly, if you happen to have a special file under a name in your working
> tree where the repository has regular files, then 'git status' will report
> the names as modified, and 'git reset --hard' will replace the special files
> by the files recorded in the repository.
>
> IOW: These special files are invisible for Git unless it already knows the
> names. The latter case is outside 'git clean's domain, and the former case
> really means that special files in the working tree are left at the user's
> discretion.

I understand your points, but I don't see any reasons to ignore these files.

What will be wrong if 'git status' will reports these files?
What will be wrong if 'git add' will returns an error instead of
skipping them silently?

How it works now:
[avagin@laptop tmp]$ git add README
[avagin@laptop tmp]$ git add fifo && echo ok
ok
[avagin@laptop tmp]$ git commit -a -m "Add fifo file"
[master b04da32] Add fifo file
 1 file changed, 1 insertion(+)

How it works with this patch:

[avagin@laptop tmp]$ ../git/bin-wrappers/git add fifo && echo ok
error: fifo: can only add regular files, symbolic links or git-directories
fatal: adding files failed

I like more when 'git add' reports an error when it can't add a file.

The git-clean man page says that it removes untracked files from the
working tree. It doesn't specifies that there are only links and
regular files.

I won't insist on my point, it may be wrong. But I like when a
behavior is predictable. I didn't expect that 'git status' doesn't
show special files and 'git clean' doesn't remove them. I asked my
colleagues and the current behavior was not obvious for them too.

Thanks,
Andrew

>
> -- Hannes
>
