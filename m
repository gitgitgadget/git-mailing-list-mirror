Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61601F42D
	for <e@80x24.org>; Wed, 30 May 2018 18:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeE3SLM (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 14:11:12 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35773 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbeE3SLL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 14:11:11 -0400
Received: by mail-yw0-f170.google.com with SMTP id v131-v6so3517972ywg.2
        for <git@vger.kernel.org>; Wed, 30 May 2018 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QLlzvzzyD16y5Z1VHqNS6DhyrbcJR/ECUa4wwmwRtf0=;
        b=MSgNS9JljAWc035CaKWcqD6ebMxTwgm3upW3BInlDLtWxwyMvlyLITFRLdX74mj5k4
         lSqZjNnn83pJh0OwXWqyBTqoIRvwr6cNg/go3KUIHgBy8Qmm7TUmupmNRsgiSTwzY4wJ
         QU+Mpybav/XvF7sGm5ysQNv2K0An2oEquF5gsSiu8CivFgpX5WuNUuYBfLxi4ShPlYay
         eiCQGsTrLYtXw26b+gJi0rcKVAvENdnDZ24FtsCm4IvNmYKkof+8r5lGD64Anc1TmBjH
         HRnN6L0f4A20EaZz3Za5x74nG4bfi/JoCXe1E4XQhtuGAV5aXVLHVSUfOSiGDCugUvcF
         psQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QLlzvzzyD16y5Z1VHqNS6DhyrbcJR/ECUa4wwmwRtf0=;
        b=skUmwxvddwrB8oe4xVMqPuKw/bCVpbwnwqu1WzY8ndDyesBCyKeXYHmBbPZ9AAM4Wp
         pkb2C2jn883IdU4UwYOIEkzb52POf32cSewOkKrMgBzrS64l8V/Ba866kphof/rJmlGq
         olRn1XuW0rgII9uu4PcPrH4hFLSeuPhZzKcdB8Bq+rraO+iS/SCw2A9CK65wpnR2beGV
         uz7OJtlj0GRo/ne7BhXONnjmrWFBYlyVsGDbrVgEiU3B2VxWGMD6ZcZChk1Z4QwtC3et
         3as3lKoiyC6/Z0iiQLRhYQXw6Fh04yOaJEWITdjSvWtjo0wZFHh0NXLRyVu3lhjfrtS+
         aoRA==
X-Gm-Message-State: ALKqPweWT6Tvs3c0DQt5NXp2Z+LYBGUUgSdUuTmsJ4FVXkaRv+rUM1tf
        ag0lTxMDowiVIw16wdJMtMJ2CbZPAx4wo2pS2ip8HtiXgsk=
X-Google-Smtp-Source: ADUXVKLNa3uIbZUDiYE2EDMbZ4LnkWXmCNv7QCcCt/GX4azRmW9laEGNt5a1PxWabprMQ/dQXzZhxv0mN0KDLwAGKn8=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr2008574ywg.345.1527703870793;
 Wed, 30 May 2018 11:11:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 11:11:10 -0700 (PDT)
In-Reply-To: <1B7D3974-AA1C-42B5-A7F5-C5A36B28C34F@gmail.com>
References: <1B7D3974-AA1C-42B5-A7F5-C5A36B28C34F@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 11:11:10 -0700
Message-ID: <CAGZ79kb6S0NT7YVH6JBV3W+=ikeBJtdbrTK5y_q9hEaGPzpeeQ@mail.gmail.com>
Subject: Re: [bug-ish] [convenience] fatal: only [12] (reference)s? expected,
 [12] given
To:     mana vortex <manavortex@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 1:12 AM, mana vortex <manavortex@gmail.com> wrote:
> Hello git folks,
> I=E2=80=99m writing about something that annoys me since forever: The ref=
erence
> handling is not consistent between commands. For example, I do
>
> git checkout origin master

  $ git checkout origin master
  error: pathspec 'master' did not match any file(s) known to git.

(I am running a recent build of the next branch,
which version do you run?)

If I do
  git checkout or<TAB>
it auto-completes to
  git checkout origin/
which I can then type master after and it works with origin/master

> but I do
>
> git reset =E2=80=94hard origin/master

That worked for me, and the whitespaced version fails as:
  $ git reset --hard origin master
  fatal: Cannot do hard reset with paths.

I do not understand the problem, yet, as for these two commands
you'd want to give <remote>/<branch> with the slash in between.

> I always get it wrong the first time.

What exactly? The confusion with slash or whitespace?

> Is there a convenience option that circumvents the error?

I think understanding the Git model would help with that:

The only commands that need a whitespace between origin and
master I can think of are push and fetch. These two commands
are commands that use the network to directly talk to the specified
remote and the second argument "master" is just a short form of a
refspec, typed out long it would be "refs/heads/master:refs/heads/master"
which specifies the branch (with full prefix) once on the sending side
and once on the receiving side, separated by colon.

And for these commands we actually talk to the remote.
For all other commands we use the locally cached version of the
branch that we think the remote has, so the "origin" is just a prefix
in the namespace of branches, indicating that all branches under
"origin/" are "remote tracking branches", i.e. these local cached branches.

> If one argument is given, but two are expected, split the argument at the
> first / and retry - throw error if that isn=E2=80=99t valid
> If two arguments are given, but one is expected, concat the arguments wit=
h a
> /.
>
> Is that possible already, and if not, would you care to implement it?

I think that would make for hilarious error messages in corner cases;
I am not sure if we want to water down the difference of a remote + refspec
and a local remote tracking branch, such that it is harder to understand?

Thanks,
Stefan
