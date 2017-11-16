Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2CC8201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 01:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932600AbdKPBGE (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 20:06:04 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:44592 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbdKPBGC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 20:06:02 -0500
Received: by mail-oi0-f54.google.com with SMTP id a75so11731985oib.1
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 17:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qtCDHGgZyBOVt4Em5HZBOtqB2DtySZ5WyGELsxn0lvE=;
        b=MDzeQ1678gfKTLTa0aiO61OkWInELhm5Ag7+pD9Yr0CznMaeX/BDt8ILNQ6rh4T+nP
         9J5GDRwXiyy7ymYWzkdq5gEG5sEG+lDHlLVX1NkHPSJ4dWt4t2GM4t/mfMyVfdbAQ3Lw
         lHWxPdGlM0mV/F6wyHjoNdJJgPCjr3bW4eVDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qtCDHGgZyBOVt4Em5HZBOtqB2DtySZ5WyGELsxn0lvE=;
        b=D08bUyxBlsEJXhdU+kBSVQ+jH7Zk9l5v2StuaIZy4WjMBManNnR5YTB+/QtmXBTJsH
         ZhPSE6b1vFPgIyUHVRFA/QHpGLY14EopuBAdAR5+2INGp+NQG/ifbwueVywJ5FvRPUgG
         esVzFJCbBsm+LKJs9Tm612/puTTpv9VRhGsDvHAcD5D8V3rIIGfPwpmJWfdimHRSYyc1
         TM1i04sARQrH8H45T+oMjvi+VxQOYG3NEKbTlHMgITJzclsz3kVn1qvm2RnIZ01IOhYk
         Z/mB76DdV7ZPi4ilIUjLaxreieNMeA1rGn9w+C+2N6/76yLGZQX0vkEB9gv83LfRY1FD
         ZILA==
X-Gm-Message-State: AJaThX5gf62cu1+eY9PqBYMGrG7jLxsXhRqC/btM4uIxBu7eMY/Yz9Sw
        VVSov7VM/PklWVARiNr3f/RhQdciWsJSKr8aDJdWSQ==
X-Google-Smtp-Source: AGs4zMYBkaYFPcRu05h0IsfQ+GrxO7ChEl6a5/a3SYkP+QcqN/y/FQ6gCaVWPim37AsdD/SIskAR/A9yX7BUlIdHkP4=
X-Received: by 10.202.223.194 with SMTP id w185mr4066081oig.45.1510794362196;
 Wed, 15 Nov 2017 17:06:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.12.236 with HTTP; Wed, 15 Nov 2017 17:06:01 -0800 (PST)
In-Reply-To: <xmqqtvxvyz3m.fsf@gitster.mtv.corp.google.com>
References: <CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com>
 <CAE5ih7_uuVVrze9gNr3JMg5HNH8eAcH_wM4wrc2kH6u=Hw0JOg@mail.gmail.com> <xmqqtvxvyz3m.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 16 Nov 2017 01:06:01 +0000
Message-ID: <CAE5ih79wG3ws=OyXqvbd+QKyyAmM-D2JVO5r9G5VHtoOfiXdug@mail.gmail.com>
Subject: Re: Bug in "revision.c: --all adds HEAD from all worktrees" ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 November 2017 at 22:08, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> Quite a few of the worktrees have expired - their head revision has
>> been GC'd and no longer points to anything sensible
>> (gc.worktreePruneExpire). The function other_head_refs() in worktree.c
>> bails out if there's an error, which I think is the problem. I wonder
>> if it should instead just report something and then keep going.
>
> Am I correct to understand that your "git fsck" would fail because
> these HEAD refs used by other stale worktrees are pointing at
> missing objects?

git fsck says:

Checking object directories: 100% (256/256), done.
Checking objects: 100% (1434634/1434634), done.
error: HEAD: invalid reflog entry
7fa2b7ee4bc0d11529f659db8b13ed1f537d2a98
error: HEAD: invalid reflog entry
7fa2b7ee4bc0d11529f659db8b13ed1f537d2a98
error: HEAD: invalid reflog entry
7e79e09e8a7382f91610f7255a1b99ea59f68c0b
error: refs/stash: invalid reflog entry
feeb35e7b045d28943c706e761d0a2ac8206af2f
error: refs/remotes/origin/master: invalid reflog entry
7fa2b7ee4bc0d11529f659db8b13ed1f537d2a98
Checking connectivity: 1419477, done.
missing tree 1480c0a7ed2ad59ae701667292399c38d294658e
missing tree ca2a01116bfbbd1fcbcf9812b95d8dc6c39e69d5
missing tree 5b7c41e547fc5c4c840e5b496da13d3daebc5fbe
...
...

>
> What do you mean by "expired"?  "Even though I want to keep using
> them, Git for some reason decided to destroy them." or "I no longer
> use them but kept them lying around."?

git worktree automatically prunes work trees:

"The working tree=E2=80=99s administrative files in the repository (see
"DETAILS" below) will eventually be removed automatically (see
gc.worktreePruneExpire in git-config(1)),"

In my case I didn't actually want them removed, but fortunately
there's nothing important in them (there certainly isn't anymore...).

>
> If the latter, I wonder "worktree prune" to remove the
> admininstrative information for them would unblock you?

It doesn't seem to help.

$ git worktree prune -n
<lists lots of unhappy trees>
$ git worktree prune
$ git fetch
remote: Counting objects: 35, done.
remote: Compressing objects: 100% (20/20), done.
remote: Total 21 (delta 17), reused 5 (delta 1)
Unpacking objects: 100% (21/21), done.
fatal: bad object HEAD
error: ssh://whatever/myrepol did not send all necessary objects
$ /usr/bin/git-2.7.3 fetch
<works fine>
