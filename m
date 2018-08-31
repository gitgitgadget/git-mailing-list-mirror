Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FECF1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 13:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeHaRvC (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 13:51:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39939 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbeHaRvC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 13:51:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so5374032wme.5
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=R31bmE0kfeZ1cQx7Hdd7WVVEm2qbroiwSLfteJf81aA=;
        b=ZFd63S07klAFh7oxh9l77BfHlIF3AzchWRtZVg1/veeT+gbk+GNkY25hh99a9uAopd
         mkbGDhVB7WARXsjO2k26kPo8B5fs6OIv6r3zUAYewPQCY+ed8gcRKhDPDYgSrNxMS3LO
         5AQlp0tjCKdHcxeNoMOKZOm1tSvb94UGZJmVtWQ5dFwUbgs+fY/TsC2cyxswTOdIE0NS
         wsk9td7Ya5eslfke7VRtYFmIATq0J9s6WAvbzK8OpWAGR8LUjQg0Bn4dA+DceT4kk3fJ
         fVgwWJKQkStqoSpzcUmhJ4On6IijAY9neQVfljOIXFS54+cN3rzo+t2Zu5a9YlNUrl/6
         MhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=R31bmE0kfeZ1cQx7Hdd7WVVEm2qbroiwSLfteJf81aA=;
        b=TEMshLMW/8d1xk6UpXtcpy6Ue0SxFwmv0dBES3IpQC/N8PTQMgz8tKurRjeDX+LBFp
         rgQhhxk2npDPN44c+6G9UTdySanMhjYciLuYuFN8QOVGvqzt/67syXTBxK1y/FZA88cs
         wjm0djqs0pV66NiBUbbAksZNNIo1MmQH3mrI0uriJ8ocRp4FGOgDQATHBFScB7cqXTh9
         BwUZ/Vj0theAXw2IDJlvCC6EDbUhYh091xtuNEzB4iWoo6Z5SMLJmBq+K25a5MpdGh+T
         A0j+ucHOg/Lnk+08+qlRL5RwMsCLYbt3hgZf2UHbGDIOiwBePUyo445OWpIWoGIXIM/Q
         +Giw==
X-Gm-Message-State: APzg51DHnhl2p+igosAAmPIavqinu2wvwkDN2k1QVbBAzqqJYw/qJf+X
        8C4GICSNFn5H1/ra7O4aO+zJrsRO2qE=
X-Google-Smtp-Source: ANB0VdYMEbTFjf/bJP+Q2nIi8FEcmEqJULK6nUuglp7M3kF01pG5tj/YcBVk3SK71leWOi1YvVaV8w==
X-Received: by 2002:a1c:1a48:: with SMTP id a69-v6mr4661226wma.43.1535723007039;
        Fri, 31 Aug 2018 06:43:27 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id o3-v6sm7922137wrn.58.2018.08.31.06.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 06:43:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Wesley Schwengle <wesley@mintlab.nl>
Cc:     Git mailinglist <git@vger.kernel.org>
Subject: Re: Feature request: hooks directory
References: <CAEpdsiYHri8FJ8VohnwxmPwDM4-0J4J9Zb9wTZjYYRnYqsb=nA@mail.gmail.com> <87pnxzdib7.fsf@evledraar.gmail.com> <CAEpdsianZo+_+dunOvF=kK4w_qt_5RjA-o8+ySv70vRALZ3X2g@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAEpdsiZFMphQTdJnqFYH03M80W8CcrCbr2Uewktm0jy4D+Fz1A@mail.gmail.com>
Date:   Fri, 31 Aug 2018 15:43:24 +0200
Message-ID: <874lfad537.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 31 2018, Wesley Schwengle wrote:

> Hop,
>
> 2018-08-30 16:45 GMT+02:00 Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
>
>>> Solution:
>>> We discussed this at work and we thought about making a .d directory
>>> for the hooks, eg.  $GIT_DIR/hooks/post-commit.d, where a user can put
>>> the post-commit hooks in. This allows us to provide post commit hooks
>>> and allows the user to add additional hooks him/herself. We could
>>> implement this in our own code base. But we were wondering if this
>>> approach could be shared with the git community and if this behavior
>>> is wanted in git itself.
>>
>> There is interest in this. This E-Mail of mine gives a good summary of
>> prior discussions about this:
>> https://public-inbox.org/git/877eqqnq22.fsf@evledraar.gmail.com/
>>
>> I.e. it's something I've personally been interested in doing in the
>> past, there's various bolt-on solutions to do it (basically local hook
>> runners) used by various projects.
>
> Thank you for the input. Do you by any chance still have that branch?
> Or would you advise me to start fresh, if so, do you have any pointers
> on where to look as I'm brand new to the git source code?

No, sorry. Start by grepping the hook names found in the githooks
manpage in the C code.

One of the things that's hard, well not hard, just tedious about this,
is that most of them are implementing their own ad-hoc way of doing
stuff. E.g. the *-receive hooks are in receive-pack.c in
run_receive_hook().

There is run_hook_le() and friends, but it's not used by everything.

So e.g. for the pre-receive hook in order to run 2 of them instead of 1
you need to untangle the state where we're feeding the hook with the
input (and potentially buffer it, not stream it), instead of doing it as
a one-off as we're doing now.

Then some hooks get nothing on stdin, some get stuff on stdin, some
produce output on stdout/stderr etc.

As a first approximation, just add a e.g. support for a pre-receive.2
hook, that gets run after pre-receive, to see what needs to be done to
run it twice.

> From the thread I've extracted three stories:
>
> 1) As a developer I want to have 'hooks.multiHooks' to enable
> multi-hook support in git
> Input is welcome for another name.

Yeah maybe we should have a setting, but FWIW I think we should just
stat() whether the hooks/$hook_name.d directory exist, and then use it,
although maybe we'll need stuff like hooks.multiHooks to give the likes
of GitLab (which already do that themselves) an upgrade path...

You can see their implementation here:
https://gitlab.com/gitlab-org/gitlab-shell/blob/master/lib/gitlab_custom_hook.rb

> 2) As a developer I want natural sort order executing for my githooks
> so I can predict executions
> See https://public-inbox.org/git/CACBZZX6AYBYeb5S4nEBhYbx1r=icJ81JGYBx5=H4wacPhHjFbQ@mail.gmail.com/
> for more information

Yeah, any sane implementation of this will execute the hooks in
hooks/$hook_name.d in glob() order.

> 3) As a developer I want to run $GIT_DIR/hooks/<hook> before
> $GIT_DIR/hooks/<hook>.d/*
> Reference: https://public-inbox.org/git/CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com/

For e.g. GitLab the hook/pre-receive is a runner that'll run all
hook/pre-receive.d/*, so this probably makes sense to hide behind a
config setting. I think it's sensible as a default to move to to just
try to move away from hooks/<hook> and use hook/<hook>.d/* instead.

> The following story would be.. nice to have I think. I'm not sure I
> would want to implement this from the get go as I don't have a use
> case for it.
> 4) As a developer I want a way to have a hook report an error and let
> another hook decide if we want to pass or not.
> Reference: https://public-inbox.org/git/xmqq60v4don1.fsf@gitster.mtv.corp.google.com/

I think a default that makes more sense is a while ! ret = glob(<hooks>)
loop, i.e. a failure will do early exit. But yeah. Junio seemed to want
this to be configurable.

> 2018-08-31 5:16 GMT+02:00 Jonathan Nieder <jrnieder@gmail.com>:
>> A few unrelated thoughts, to expand on this.
>>
>> Separately from that, in [1] I mentioned that I want to revamp how
>> hooks work somewhat, to avoid the attack described there (or the more
>> common attack also described there that involves a zip file).  Such a
>> revamp would be likely to also handle this multiple-hook use case.
>>
>> [1] https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
>
> The zip file attack vector doesn't change with adding a hook.d
> directory structure? If I have one file or multiple files, the attack
> stays the same?
> I think I'm asking if this would be a show stopper for the feature.

Yeah I don't see how what Jonathan's talking about there has any
relevance to whether we run 1 or 100 hooks.
