Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046DA1F859
	for <e@80x24.org>; Sun, 21 Aug 2016 11:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbcHULaT (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 07:30:19 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36578 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbcHULaR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 07:30:17 -0400
Received: by mail-io0-f178.google.com with SMTP id b62so86408878iod.3
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BWh582djQeHzaYg0qBi8UAvTdz9romFf4rGW/Lr2u8s=;
        b=IuirDn3srSlk9AkhvaXFwjdJ6gNxeXWON+9S4OEvMnzISoCLcRESHUAvmdkQPQghpS
         sDzAEabOMNg+/CruEa/BFlUA4sXoCYZI5/1z3nylHCxCMB0C0c5vOFClfNGr3mD2JNtY
         kAQ7d5lyQSiSrBT4xf0Ze4ecoeoxS1MXdFIsPK5+zSfb9miU/HRUcZDENymPsrgMGfV0
         +3cCbQrNTot/Qxw4THB86Fr4e3VoHXbPndRF+SwK5RaPet72kVhad3Xz4tBc90XjQ7la
         V8ey4csxt/GhydVUTw9qhyd1RSwpXmkyjoEumbP7ICsXjqAvD2EhaW45d19lJuBiZAWq
         WC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BWh582djQeHzaYg0qBi8UAvTdz9romFf4rGW/Lr2u8s=;
        b=KzKSdPymAYUXNRBx7wfjRZcOu8Gsclb4y8XIUYhboK4COJbJjWKAecnTs0e5Efvakv
         dP5UG3cS+b69NyKI5uZE/GaZywjP2x+hBXyVA8WDH+VP6uIlvTz0q+U2/HJu0wKq0W/j
         LIZqNdWiocgvdfERM/jDgakuU+NljVZzZCtrQe1aJoy5+OxsA4/Z8l1hdODCLHroMNgy
         n6RON3WuZ6FAzERx6bVH+QS9Di99GH8xQUwfvodWxv+sg9+2zgazfjoDYGCS548WnL2q
         Uj4DETyDSpzrIYWQdNpeHTTpEdH8XjnIla2yCaWkcVYo7QnrCiWHopTzxGTid7RaBJ1T
         awoA==
X-Gm-Message-State: AEkoous3e2VKIFZbzncuS7H23ZvSpJJAoc8v1nPF5S8qBlmPPGt+21DSyvk502YFDyOFxS+SIfTWS9dnsxLMtg==
X-Received: by 10.107.47.152 with SMTP id v24mr18299786iov.154.1471779017051;
 Sun, 21 Aug 2016 04:30:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.5 with HTTP; Sun, 21 Aug 2016 04:30:16 -0700 (PDT)
In-Reply-To: <20160821020537.eiyh4vnhmnuctgtz@x>
References: <CAB2VqoZh6zZV3Lk2B7dBPVE5h6H1LCwyxWrUo4yJFhqB=hAjig@mail.gmail.com>
 <20160821020537.eiyh4vnhmnuctgtz@x>
From:   Richard <richard.maw@gmail.com>
Date:   Sun, 21 Aug 2016 12:30:16 +0100
Message-ID: <CAB2VqoZdj1rhdt-4gUhXTAMQjJTOqCuwXiO6yfB2Fzyy_qSWHg@mail.gmail.com>
Subject: Re: Adding more namespace support to git
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 August 2016 at 03:05, Josh Triplett <josh@joshtriplett.org> wrote:
> On Sat, Aug 20, 2016 at 08:07:00PM +0100, Richard wrote:
>> Since when upload-pack and receive-pack run hooks they leave GIT_NAMESPACE set
>> there are hook scripts that expect that the current namespace is ignored,
>> so commands that now want to be namespace aware would have to opt-in.
>
> That seems really unfortunate.  While at the time we wanted to start
> with namespace support in upload-pack and receive-pack (and
> http-backend) because those would allow using it as a server-side
> storage format, I don't think we realized that leaving GIT_NAMESPACE in
> the hook environment would completely prevent other git commands from
> automatically handling namespaces.
>
> And conversely, we can't just have upload-pack and receive-pack start
> removing it from the hook environment, because a hook might expect to
> read the current namespace from it (and then run git commands that the
> hook expects will ignore it).

This is exactly what I've had to do for my proof of concept
https://git.gitano.org.uk/cgit.git/commit/?h=richardmaw/namespaces&id=379124469a8a13208f976eb816375b00901ae77f

> For that matter, someone could run "GIT_NAMESPACE=foo git push
> remotename branchname" or
> "GIT_NAMESPACE=foo git clone remotename", and based on the current
> behavior, they'd expect to have the namespace apply to the remote end,
> but not the local end.

I'm fairly sure this isn't the case, at least from what I've tried.
At one point it appeared to be working,
but that was just because it started the upload-pack as a subprocess,
which inherited the GIT_NAMESPACE environment variable rather than
being passed it.
I think this is why the test suite always sets up a remote with the ext:: helper
so it can set --namespace=foo in the command.

This is one of the reasons why I have been working on namespace
support in the git server,
you have to encode the namespace in the url somehow
since it isn't passed through the git protocol.

We were thinking of adding ssh://git@server/~username/repo/path.git syntax
for letting users have their own private namespace in a repository,
and later extending the backend of the git server's repository storage
so that other repositories could just be namespaces of a different repository
so we could do something like repository forks
provided the repositories have the same availability.

> Unfortunately, I think at this point, GIT_NAMESPACE has to exclusively
> refer to the namespace for the remote end, to avoid breakage.  Which
> means any automatic pervasive support for namespaces on the local side
> would need to use a different mechanism.  (In addition to applying to
> ref enumeration, this would also need to apply to the local end of
> refspecs.)  And this new mechanism would need to not affect the remote
> end, to allow remapping the local end while accessing an un-namespaced
> (or differently namespaced) remote.

The problem for hooks is that it is implicitly inherited,
so it could work if upload-pack receive-pack and http-backend work
with GIT_NAMESPACE set,
but everything else that wants to use a namespace has to set
--namespace on the command-line.
