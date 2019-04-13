Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5809420248
	for <e@80x24.org>; Sat, 13 Apr 2019 21:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDMVrl (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 17:47:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51504 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfDMVrl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 17:47:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so15491036wmf.1
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D5fY7CCwpjhY+Qf6b9sZFwwGwhUBUWxtIN9noVSCbg0=;
        b=qvmPKZSrOqHvHdYIctNwO8eG71yVDX1a4insYaGdwuS2YION4J42yQVCyyElvs9K+O
         2y68lOP0U7fFE5u4Q1nXHxECI4RNNo4oZGRND/hfAeY3yXaGoOoRUA6LQtkKPQe2o0dF
         l0KJNWkNaRqyWYFMTmfpEB/7jLAGL1ZL8OZCiZaKZ6xseTX82mjgQy/AhpzSby/nnQnO
         yNIApaVxo7KClesiXGDRr7FZ4K4Ku9gyFFUEMsQDvBAaTXAdIUj1Bi9QSTzseULPuzrG
         p0DzLYSG3tIhKwc97fV4GNHsC2w0FTRi7IOMyR2oOwRT+GZEH+Oc8DO0eSqXxC6Nk7o1
         LMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D5fY7CCwpjhY+Qf6b9sZFwwGwhUBUWxtIN9noVSCbg0=;
        b=b7lCC1rV9SD4y6eq7dm3qt6sHZ1s08wt8FvoXccrejVfa4Geff/nHB4Ip4mfGM+g9b
         bL8kky7W1fPvpirJED4ATF03rFOFgnemKyhoYrKqNjge879QTTqypznobROTkcy+qtrw
         Pw7sNlkdzqvGaZ6J69Q1ZraDq7dvPsbCo2AKbWLvGaKjQ5ESkbKVa8t6gR1sBQUmkM7L
         PqbZ6VKaE68RmRzaEpusXaJYO6SyvkXYpcj+WipGC3Uya2vuH/GPBCblzlM1WEvF32Fe
         NE758pwYNAIB+xT3R1BNCTi8qvED9IZgYrHKFF3OdLCszRHMB7on3JWi0GMR1BqMotRM
         PWJQ==
X-Gm-Message-State: APjAAAWUN4XsZtJ++RL2pZjJjLMslEPR16H/mYd4rMnu+9aFNBgRZtxs
        +BQhLeNVK0979qyYyA7WjTU=
X-Google-Smtp-Source: APXvYqwidSizJGmguL2vw6JwDYCp1BJOpQp9yvBvscbWI5Ml0ZSVT1NFEXz+0N2ZvR5qtmSb+9m0Kg==
X-Received: by 2002:a1c:804c:: with SMTP id b73mr15434535wmd.116.1555192059150;
        Sat, 13 Apr 2019 14:47:39 -0700 (PDT)
Received: from szeder.dev (x4dbd3ef2.dyn.telefonica.de. [77.189.62.242])
        by smtp.gmail.com with ESMTPSA id i28sm125261385wrc.32.2019.04.13.14.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 14:47:38 -0700 (PDT)
Date:   Sat, 13 Apr 2019 23:47:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [BUG] GIT_SSH_COMMAND is not being decomposed
Message-ID: <20190413214736.GD15936@szeder.dev>
References: <000d01d4f237$5cf2dc10$16d89430$@nexbridge.com>
 <874l71fxmg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874l71fxmg.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 13, 2019 at 10:39:35PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Apr 13 2019, Randall S. Becker wrote:
> 
> > I am encountering a problem on one of our NonStop platform variants where
> > the GIT_SSH_COMMAND string is not being broken into constituent parts. This
> > is causing SSH to not run properly. As background, SSH is not in a standard
> > location and has non-standard required arguments. This also occurs with
> > core.sshCommand. The situation is:
> >
> > git config --global core.sshCommand '/G/system/zssh/sshossz5 -Q'
> >
> > which correctly sets .gitconfig as:
> >
> > [core]
> >         sshCommand = /G/system/zssh/sshossz5 -Q
> >
> > When git is run with GIT_TRACE=true GIT_PACKET_TRACE=true git fetch
> >
> > We get the partial trace:
> > 14:19:56.027088 trace: built-in: git fetch
> > 14:19:56.029895 trace: run_command: '/G/system/zssh/sshossz5 -Q' -G
> > user@host
> >
> > The same trace on our systems that actually do work results in:
> > 14:19:56.029895 trace: run_command: '/G/system/zssh/sshossz5' '-Q' -G
> > user@host
> >
> > I need help resolving why this is happening (as in where to look and debug
> > the situation).
> 
> This doesn't seem to be documented *explicitly* (except between the
> lines & inferred), but it's only supported to pass a *command* there,
> i.e. the path of the ssh binary.

'man git' it quite explicit about this:

  $GIT_SSH_COMMAND takes precedence over $GIT_SSH, and is interpreted
  by the shell, which allows additional arguments to be included.
  $GIT_SSH on the other hand must be just the path to a program (which
  can be a wrapper shell script, if additional arguments are needed).

Quick test shows that the implementation agrees with the
documentation:

  $ GIT_TRACE=2 GIT_SSH_COMMAND='/usr/bin/ssh -v' git push -n github
  23:39:02.048870 git.c:419               trace: built-in: git push -n github
  23:39:02.060821 run-command.c:643       trace: run_command: unset GIT_PREFIX; '/usr/bin/ssh -v' git@github.com 'git-receive-pack '\''/szeder/git'\'''
  OpenSSH_7.2p2 Ubuntu-4ubuntu2.8, OpenSSL 1.0.2g  1 Mar 2016
  debug1: Reading configuration data /home/szeder/.ssh/config
  <... snipt rest of the verbose ssh output ...>

And the config setting works, too:

  $ GIT_TRACE=2 git -c core.sshCommand='/usr/bin/ssh -v' push -n github
  23:42:55.277776 git.c:439               trace: built-in: git push -n github
  23:42:55.285149 run-command.c:663       trace: run_command: unset GIT_CONFIG_PARAMETERS GIT_PREFIX; '/usr/bin/ssh -v' git@github.com 'git-receive-pack '\''/szeder/git'\'''
  OpenSSH_7.2p2 Ubuntu-4ubuntu2.8, OpenSSL 1.0.2g  1 Mar 2016
  debug1: Reading configuration data /home/szeder/.ssh/config
  <...>

Note that in both cases the trace shows '/usr/bin/ssh -v', IOW neither
$GIT_SSH_COMMAND nor 'core.sshCommand' are broken up.

But this is just an avarage Linux box, so perhaps this is a
NonStop-specific issue?


> See the code around get_ssh_command()
> in connect.c. The whole env/config value we look up gets passed as one.
> 
> So if you need arguments you need to create a wrapper script and set ssh
> command to that script.
