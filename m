Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76EB51F744
	for <e@80x24.org>; Sat,  9 Jul 2016 05:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbcGIFd5 (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 01:33:57 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34097 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbcGIFdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 01:33:55 -0400
Received: by mail-io0-f182.google.com with SMTP id i186so58992083iof.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 22:33:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LZjsZSrgDKVkuFlQ91SP31EHQaPM0sBl7i/MAxR3TS4=;
        b=aT68cKF2vse2IdpiTgmACUWd+HmTt4dA/xyUvH90dg/H4I/jAbjwtAZ/ZdO48f8Eq/
         aXvxZmuMHrK+CcMADeWGM1IlwFGjnK6+T0KicF+73kS+2kccHp1Duv32iHA0J7OF2aWV
         X8OGdQw10vCQV8H+E0YQ3l7oHlV3gZZBAANCoW4iQPGwZPZkAO1il75Y0sZ5+Na8HYmg
         9J4OXNbjb6au7AO2zM8cWSQ1SA++ZJPYKhWMyD4ivvdtlCX006hDrPOPre3VJ/R2gkpj
         bzGnE7QQID5tRzeLERNECNBR/wFDmiXqZ0KnuTxrDpAwFVhiD7V4Z3VNjxISU4uf6CCX
         x/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LZjsZSrgDKVkuFlQ91SP31EHQaPM0sBl7i/MAxR3TS4=;
        b=mSNaXSc28WkKspVjLSOJNhZ+5Zsiwn0dTNWq1+DxWs6gDHRDmOHQoMYJnVn76jWibC
         K3RqklVk4ErW928467L8gbKuibcSetJ+yB4s//mG6CWf9T/0pB5TPO4h53nfBcuuFsJ6
         PxQswz3RDROUp7tUEv/AJzcGnGqZMg5gXm9hwBvcT+6gi1YlOaBCiUgWZ+9dzOOD3on5
         88IhCC5mblH/iLYfu1U8pwXA/uVz7Gawj3rnYH5Vol6bhJw4+a9YnevkOBYkSlX5HD+m
         8BbriTmmEQiAP8sH+jKHoL7b2hoRUEjudFwoHQ4IZqSJ5e65JmD5MuUIj3C6uKadl/Qu
         TelQ==
X-Gm-Message-State: ALyK8tJlyvLyKLzN5g4OeA7OVRTNvB6bj8RiERwpFAtDLxeHSUQIj5A269mFoL+fPAwZT9JPFU2QQajcotR5pQ==
X-Received: by 10.107.8.140 with SMTP id h12mr2450461ioi.95.1468042434826;
 Fri, 08 Jul 2016 22:33:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 8 Jul 2016 22:33:25 -0700 (PDT)
In-Reply-To: <20160707184408.GA1916@gmail.com>
References: <20160707184408.GA1916@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 9 Jul 2016 07:33:25 +0200
Message-ID: <CACsJy8BWAirnni+-ZzShMrKO0Pjs8xiUw1gXSJAR2ZT9kJFtuQ@mail.gmail.com>
Subject: Re: git branch doesn't allow me to forcibly delete branch which was
 checked out in a now-deleted worktree dir
To:	Erik Johnson <palehose@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kazuki Yamaguchi <k@rhe.jp>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 7, 2016 at 8:44 PM, Erik Johnson <palehose@gmail.com> wrote:
> % git branch -D archive-extracted-xz
> error: Cannot delete branch 'archive-extracted-xz' checked out at
> '/home/erik/git/salt/archive-extracted-xz'

This is from commit f292244 (branch -d: refuse deleting a branch which
is currently checked out - 2016-03-29) which is about -d not -D, so
it's probably an oversight. I think -D, as a forced form, should allow
deleting branches on other worktrees, we could simply detach the
worktree first.

It's worth noting that before that commit, -D refuses to delete branch
on current worktree as well and f292244 simply applies the same
behavior on other worktrees. If we change the -D behavior about
deleting branches on other worktrees, we may need to consider to keep
the behavior on current branch, or treat it equally as any other
worktrees.
-- 
Duy
