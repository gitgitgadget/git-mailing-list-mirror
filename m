Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB9E1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 21:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbeCLVj6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 17:39:58 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:45633 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeCLVj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 17:39:57 -0400
Received: by mail-wr0-f179.google.com with SMTP id h2so9912613wre.12
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zubkm/RyNa9xpAh1zKdOXrOUbkADw3QjSLio+go5ba0=;
        b=vJcWWL1H+yNTRAJBkHxMjvvPCtryQS0nZXySpCbqd9niBTrASfr61brTofClgCfzST
         eaS3Z/3gZ4bgMyN0EKbbAcW+UZy19FFDBXdGAilao0SSruHWM7Svm9Yrz8o9ZVnVXNfv
         3fH7uLkFD1dJivukrlk1HCM+x/N0rIqATWd0Yt9kdN4Qul4dtTdL9pVTio7okckWJWgv
         /0vkcyGYgb+EfEtvQgJUgdodpRUNJgSBO7PizKf+wgknLwlTD47itGp3Hwu6FN98SsVC
         fgqado1jRxDMrOeibwSwSa0db400rt0ZeKQ1w6WN9TFaUcuAhE3funWjxsXImEhOfYqz
         po9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zubkm/RyNa9xpAh1zKdOXrOUbkADw3QjSLio+go5ba0=;
        b=obyfVmg+dm1/+FWai4g7/FrYNGm7jUC9b57B76a4NsILZ789FXOn++EaKVdq6xON4j
         xsrrHWd1RG0SHPEsW5X+VDRl6O94r+JKgUguZsj0YUBfB3i6GBq0FeEZVILb9mQfel+a
         YFUElGDc6VczhimUasPs9yHVh3KoSHPCDGUVrbn9EjE5hOzdwWnVLtVB7vv8L+r/qIEP
         aUrw7Ndk+Ab5VPnVShpGWb0Wpw+wSiTpGwJ0iQYUlS6IPHTJK44A/aO6iQSLN+9ECOdm
         eJz5p9zFzR5F9MO+pbQWyzcQuPaY9uix5Cd3JN8MiAyS43+iGTkyuv5jY+wSxx5XeP/r
         JVtw==
X-Gm-Message-State: AElRT7HIn4KM+zmdOXrLOT93DGOpKwaoMADlbHkYx7aRfvwgDAp9nbYB
        EM1kw/z5E4znAZQvVOmwECk=
X-Google-Smtp-Source: AG47ELtG9uNecVFP/m5YFIZJfw5yiuEaciOoAVlJYXFESCxNnZS3ZpwcLFVPZE028DfYZSxiInd0tA==
X-Received: by 10.223.136.15 with SMTP id d15mr7960673wrd.127.1520890796093;
        Mon, 12 Mar 2018 14:39:56 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id v124sm5957526wme.27.2018.03.12.14.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 14:39:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug in "revision.c: --all adds HEAD from all worktrees" ?
References: <CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com> <CAE5ih7_uuVVrze9gNr3JMg5HNH8eAcH_wM4wrc2kH6u=Hw0JOg@mail.gmail.com> <xmqqtvxvyz3m.fsf@gitster.mtv.corp.google.com> <CAE5ih79wG3ws=OyXqvbd+QKyyAmM-D2JVO5r9G5VHtoOfiXdug@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAE5ih79wG3ws=OyXqvbd+QKyyAmM-D2JVO5r9G5VHtoOfiXdug@mail.gmail.com>
Date:   Mon, 12 Mar 2018 22:39:53 +0100
Message-ID: <878taxq8gm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 16 2017, Luke Diamand jotted:

> On 15 November 2017 at 22:08, Junio C Hamano <gitster@pobox.com> wrote:
>> Luke Diamand <luke@diamand.org> writes:
>>
>>> Quite a few of the worktrees have expired - their head revision has
>>> been GC'd and no longer points to anything sensible
>>> (gc.worktreePruneExpire). The function other_head_refs() in worktree.c
>>> bails out if there's an error, which I think is the problem. I wonder
>>> if it should instead just report something and then keep going.
>>
>> Am I correct to understand that your "git fsck" would fail because
>> these HEAD refs used by other stale worktrees are pointing at
>> missing objects?
>
> git fsck says:
>
> Checking object directories: 100% (256/256), done.
> Checking objects: 100% (1434634/1434634), done.
> error: HEAD: invalid reflog entry
> 7fa2b7ee4bc0d11529f659db8b13ed1f537d2a98
> error: HEAD: invalid reflog entry
> 7fa2b7ee4bc0d11529f659db8b13ed1f537d2a98
> error: HEAD: invalid reflog entry
> 7e79e09e8a7382f91610f7255a1b99ea59f68c0b
> error: refs/stash: invalid reflog entry
> feeb35e7b045d28943c706e761d0a2ac8206af2f
> error: refs/remotes/origin/master: invalid reflog entry
> 7fa2b7ee4bc0d11529f659db8b13ed1f537d2a98
> Checking connectivity: 1419477, done.
> missing tree 1480c0a7ed2ad59ae701667292399c38d294658e
> missing tree ca2a01116bfbbd1fcbcf9812b95d8dc6c39e69d5
> missing tree 5b7c41e547fc5c4c840e5b496da13d3daebc5fbe
> ...
> ...
>
>>
>> What do you mean by "expired"?  "Even though I want to keep using
>> them, Git for some reason decided to destroy them." or "I no longer
>> use them but kept them lying around."?
>
> git worktree automatically prunes work trees:
>
> "The working tree’s administrative files in the repository (see
> "DETAILS" below) will eventually be removed automatically (see
> gc.worktreePruneExpire in git-config(1)),"
>
> In my case I didn't actually want them removed, but fortunately
> there's nothing important in them (there certainly isn't anymore...).
>
>>
>> If the latter, I wonder "worktree prune" to remove the
>> admininstrative information for them would unblock you?
>
> It doesn't seem to help.
>
> $ git worktree prune -n
> <lists lots of unhappy trees>
> $ git worktree prune
> $ git fetch
> remote: Counting objects: 35, done.
> remote: Compressing objects: 100% (20/20), done.
> remote: Total 21 (delta 17), reused 5 (delta 1)
> Unpacking objects: 100% (21/21), done.
> fatal: bad object HEAD
> error: ssh://whatever/myrepol did not send all necessary objects
> $ /usr/bin/git-2.7.3 fetch
> <works fine>

Digging up this old thread. I've also noticed this bug because I tried
to "git repack -A -d" a repo on a GitLab server and just got "fatal: bad
object HEAD".

Bisect revealed that the reason was that GitLab itself runs 2.14.3,
which is the last release version that doesn't have Duy's d0c39a49cc
("revision.c: --all adds HEAD from all worktrees", 2017-08-23), and that
the HEAD revision of some worktrees was corrupt (GitLab creates squash-*
worktrees for some reason).

Doing a "git worktree prune" beforehand makes it work.

This can be reproduced with:

    (
        rm -rf /tmp/git &&
        git clone --bare https://github.com/git/git.git /tmp/git &&
        cd /tmp/git &&
        git worktree add blah HEAD &&
        echo 1111111111111111111111111111111111111111 > worktrees/blah/HEAD
    )

Now, obviously the root cause is that the repo is corrupt through some
other bug (since fixed?), but the error message here is really bad, and
should at least say "fatal: bad object HEAD in worktree blah" or
something like that.
