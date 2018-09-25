Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1350D1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 16:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeIYXBz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 19:01:55 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37589 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIYXBz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 19:01:55 -0400
Received: by mail-yw1-f66.google.com with SMTP id y14-v6so2354467ywa.4
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n59taTCwVA7VpDGkqyU7PV6li4LQQ/Dg/rzeCERlWlM=;
        b=k8PBU6052QRz5+TJUQULh1S297q0RLicUvU1pTY7TOslfHGf4Jjnlx75KlDl1VW2vE
         wAZB1dpRLLxZiRd93WvIhXXUU2TmFU0QWB1WieTdbUbPPMz5BwVKu4jUPa8WkaN5eJZz
         MNGH3fxVQJwqDEe+4C/EAX316i1d0B56J7VvrFug/pPyEmgzBCRW9vNYdSh1IfyrHXEB
         rgFOdWeT0TTIKoAu82qHz/v4TxDUA/8DxnX6dw3AxX0mRNJQ9xR5+dsCyxJFKD/oed5P
         SK7hruyqOkVK1IBHZzgS8dNNi3C9FBvoBetiePTSurneg2kP+ibiHqlpfJT82pBPPF+3
         ceUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n59taTCwVA7VpDGkqyU7PV6li4LQQ/Dg/rzeCERlWlM=;
        b=qvAz29uMxvDriGmfU6Wos9dEBxqqECJWXQ0q9wNAh4Uz3aiaGL4Z/TrvtqYaeyKsui
         QhfP3gtfGOuwyji3dYZvI58kxkLV6WUzrhsiJ1Kf1G0Cgna4uzgWrajCfZEr5AsianwT
         LdOWRkaVSLwgRFI4rK3LunuTrcbWUMHuZ9WR+CCYM7Enlmw3RhK34hUEhPvk/Qd7oAdy
         EP05rq4NNFbbwbg/PLE1vKks9eWCTgXdQIVavRuxq8G0XBcWLFmQWqzKIqV4pXYuJzKV
         W3bI/CH8FFuqrHFzDdg7xKWvxI/6lw5m7n1oEVhhlInGyyCgu+yJD4cvOe8pPDkbb2PT
         NZpw==
X-Gm-Message-State: ABuFfoilloG3OLbCSsB99vGM57HQKOV8CQjX4+3Omd2e9Z5Mv4Yw9w3F
        VCFHFsKh6u8E1vv5kL3jT5RVZSm5XDgQNvHAOw3GQA==
X-Google-Smtp-Source: ACcGV63r4hnrbk6VBUaawV+t63fI02Bwy735sXJGdj2oXd1upozo9f4qIdK1EMK5a9nTZ8aIrQ87lV8Ysy2kQjM9lTE=
X-Received: by 2002:a81:5710:: with SMTP id l16-v6mr1046626ywb.3.1537894412983;
 Tue, 25 Sep 2018 09:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-4-pclouds@gmail.com>
 <CAGZ79kYTzs=Xx-K-ghUa=as7Q0tiw-z1h7_D2=6zaO3fpWMrWg@mail.gmail.com> <CACsJy8DsykQzUzx7iTqPeuGBSJ9gcEHJRw_UCXJCrsXxf+hntQ@mail.gmail.com>
In-Reply-To: <CACsJy8DsykQzUzx7iTqPeuGBSJ9gcEHJRw_UCXJCrsXxf+hntQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Sep 2018 09:53:21 -0700
Message-ID: <CAGZ79kaDoV-1rtOzXasQ+-sfcoWV7FSBhDrm_kueTt_+a95gUw@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs: new ref types to make per-worktree refs visible
 to all worktrees
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 8:49 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Sep 25, 2018 at 4:48 AM Stefan Beller <sbeller@google.com> wrote:
> > > This patch also makes it possible to specify refs from one worktree in
> > > another one, e.g.
> > >
> > >     git log worktrees/foo/HEAD
> >
> > This has strong similarities to remote refs:
> > Locally I may have a branch master, whose (stale local copy of its
> > distributed) counterpart is named origin/master.
>
> If you think of each worktree as independent clones (which is more or
> less true, the fact that they share ODB is more like an implementation
> detail) then yes it's almost like remotes.

Apart from the ODB and the refs subsystem, there is also the config
space, which is shared (but you have sent out patches to have local
config as well).

So I would think worktrees are better than having two clones not just
due to the shared ODB, but also due to the common config as then I
have to setup my repo only once and can add/remove worktrees
cheaply (in terms of "how much time do I need to spend to configure
it as I need").

> > It is also possible to have a working tree named origin
> > (just I like to name my worktree "git", when working on git.git),
> > how do we differentiate between the neighbor-worktree
> > "origin/master" and the remote-tracking branch "origin/master" ?
>
> Hmm.. I think you're thinking that origin/master could either mean
> refs/worktrees/origin/master or refs/remotes/origin/master. I do not
> think we're going to support expanding origin/master to
> refs/worktrees/origin/master. This part about ref resolution did cross
> my mind but I didn't see a good reason to support it.
>
> Even if we do support it, this is not even a new problem. If you have
> refs/heads/origin/master and refs/remotes/origin/master now, we have
> ref ambiguity anyway and a solution for this should handle
> refs/worktrees/origin/master well if it comes into the picture.

So once origin/master is overloaded, I would have to spell out
refs/worktrees/origin/master and refs/remotes/origin/master to
avoid confusing the DWIM machinery. Makes sense.

> > How do we deal with that?
>
> main is accessed via worktrees/main/HEAD while the main worktree's
> HEAD is accessed via main/HEAD (which is _not_ automatically expanded
> to refs/worktrees/main/HEAD). But if it is, yes we need to detect
> ambiguity and tell the user to specify full ref name, either
> refs/main/HEAD or refs/worktrees/main/HEAD.

Ah, I see. Now I actually understand the last paragraph of the
commit message. Thanks for explaining!

Stefan
