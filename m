Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4BFC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351051AbiDZPoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348561AbiDZPow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:44:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7BE67D1E
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650987699;
        bh=gci+QiPp4tTVgvRfHoiIWOjWJHuywG+kaQIl50U3RGc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TRCPXh+b6dyg4CjgordjqPsQF8zhwtIy7M0CRID8554K1BwggmFDVJewiTRax+8Fq
         SLhhrwFB2Z0ppFO+fXWF4/1SXrbV1sDterZr42ZtLhz1ArjK5bP72QVw2vvtc7ik62
         4uuS2GeD8wbWYEx9TooV5zv2d5fYOqF+/mKcO7+0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.146.35] ([89.1.215.71]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1oB35j1hvo-00jJkY; Tue, 26
 Apr 2022 17:41:39 +0200
Date:   Tue, 26 Apr 2022 17:41:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
In-Reply-To: <YmdQcrl/uu7HFBlc@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2204261730210.355@tvgsbejvaqbjf.bet>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de> <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email> <xmqqczh73hns.fsf@gitster.g> <YmdQcrl/uu7HFBlc@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7ga/6F9Xxb0BRgu0kr5cjkK7ak1gRgIkOvFAOftIuP091bgmuth
 qtIim6+epfF5yoXDf7HCemvrCE04Rp5DGm/B3Jq/yJZR3dOaRrbqPx3hdXJAt5CJ6VrwfkU
 +ize0isxvy8llaITmOxyuKod698SHJQX87RxYw/M3LoJdb1ZI0LU/PZS3KpYegF99D2rnjT
 VQL0N99N2CEaxNgwz/s/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hxEVaUqXgNA=:dTlCAgdFmFZYSjCMJ4iFEh
 XUL4e1kFgmzqQphsdOC7VSec3Fb3QvTIgW7tbwU0q9h3ONPEOFRGDnXF4sa3/ghlfbGUK23BW
 9HNDmVfstf2VE++IdLZ5Mm59o5X/DuwtuM3it4F9DJo3XLARTNXzlL84ove/uiNXpRG+uYZi6
 UBpMDr6isyoYmV2NtiX6S7Zv7rpbft5qYPpCsFc/L5oYEws20wi+LfHx0ybo8Qv5cCBKxEE3m
 4WQnWJM712KCeC2O6TxatMpL/DLUplzZCpFnP1bEIQhy5tFx2sJ6Lg6NDYSu9Udyf8oPDexo7
 u009WRSyu56/67yOg07kqLXRAiIW+pk3hF09gTSp81MZvj+c5DL2+Ecw/VZ4qnu37aaGp1fDn
 CiiQ/TlxhmUY+5480O3+tPrR19uskh48JIOqgAAWO96iGUBPcSYd6anuVx8rTDQlTgeTjBGsq
 9RSEf5sK29QhwM9qJAC2yT4/PKbPjvZ1xSTlAEQQgDnYWSfuvq+xqdUmXuXroODOuROQCWCLc
 qpA7aEHyhHqKGMV8HQK4Yh/UBXDz64j2DetdrvYJEs4TvqZMQhEdbUiv+2DaALU0c6UGnMACk
 8m9ikHhMSDEhbD6hGH1PLlTJheuJNHq3JOxBmFoQUcbvCwcTh2740CoeNnRCCA9aaGl12eoND
 z+ioLC8u2zQeqDl7tiCpFf138u+IJ99VDURWSv4RX0Bnbztr6zhU3J8pnduioQUSSQ+xmJFb5
 JldAVlLgd62EMgx9V/zbbjJYJC20a019/CgiBerEJ5fr9t0uiUucxtu+dPlyb/BUQNkrFUd1P
 Ozb5iOkur4TdhKi62AFbpGzUrJ4liGzQ3oxC+sTFGT4R8CESJS1+2qKYi45Ble8tZKp/U/d+G
 c/otlzplKampF5pXVHk1zHUyVBwuujtldqN4YemWw15/Rwt/efQWIJYzbTHYXIdXhomFMHHxZ
 3MliKc6A4EMLL4qNVckNXVEEnWMEfVVaIDUPCgocPpeis970LKsMGX1V37Hy4KNoYfdejY+nH
 u/94E3gzGH1GlamVCF2lLTyR8zAoMVt1Z/S4VkMAGnEmH4BUk31cVACIV5wJbm+TJq/lJLCkF
 fK7u6PDrJYhvew=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Mon, 25 Apr 2022, Taylor Blau wrote:

> On Sat, Apr 23, 2022 at 09:09:59AM -0700, Junio C Hamano wrote:
> > Philip Oakley <philipoakley@iee.email> writes:
> >
> > >> guy@renard ~/Software/uncrustify $ sudo git describe --always --dir=
ty
> > > ...
> > > There has also been added an escape hatch of allowing "*" for the
> > > permitted safe directories. but do check the updated manuals, and th=
e
> > > git mailing list archive (update the search in the above link).
> >
> > In this particular case, I do not think '*' is needed, but you need
> > to be careful here.  Whose configuration are you suggesting to add
> > such an entry?  Yourself?  ~root/.gitconfig?
> >
> > I wonder if we should loosen "the same owner" check somewhat to
> > cover this situation better.  I expect people also run the
> > installation in repositories they own with "sudo make install",
> > and complaining "euid does not own that repository" when it is
> > merely because they are running as root (and their real identity
> > is still in ruid) feels a bit too strict to be useful.
>
> I was thinking about this today and realized that my original train of
> thought along the lines of "ignore the new safety check when the current
> user has higher permissions than the user who owns the repository we're
> working in" was misguided.
>
> What about loosening the check in a different way? Instead of causing
> Git to abort early, what if we:
>
>   - skipped reading the repository's configuration and hooks (unless
>     safe.directory includes $CWD)
>   - emit a warning (which goes away when safe.directory contains $CWD)
>   - otherwise continue executing as normal
>
> That would unbreak the case of $(git describe ...) in our Makefile in
> this instance, without opening ourselves up to execution-via-config.
>
> Though I think we'd have to be slightly more careful than that, since
> we definitely _do_ want to read repository format extensions.
>
> I'm hesitant to recommend reading some parts of the configuration
> without others, though this is slightly different than that. Instead of
> saying "read every entry of config except core.editor, core.pager,
> core.alternateRefsCommand, core.fsmonitor" and so on, this says "when
> operating in a repository not owned by the current user (or the
> repository is in our global safe.directory list) only read repository
> format extensions, but ignore everything else in config and hooks".

This idea to disable "just the unsafe parts" has come up before, and I do
not really like it. It would change Git's behavior in inconsistent,
hard-to-explain ways. For example, we would have to disable clean/smudge
filters, which would then break, say, Git LFS.

Sure, for something like `core.fsmonitor` which is a pure performance
knob, where Git works correctly whether you heed that setting or not (just
with different performance characteristics), it might be fine. But for
things like the clean/smudge filters, it changes behavior. And the worst
part? If we introduce something like this logic ("if the worktree is owned
by somebody else, just ignore the parts of the config that refer to
user-defined programs to be executed"), we give wrong results _without
having a way to tell the user that we do that_. Unless you want to see a
warning "you may see incorrect results" every time you run `sudo git
status`?

Don't get me wrong, we _will_ want to have a serious discussion about the
config and how we let features creep in that can be exploited if an
adversary gains write access to one of the various places from where Git
reads config, and how we can mitigate that. IIRC we used to treat the
config as something safe "because it does not execute code", this came up
e.g. when we introduced `.gitmodules`.

I just don't think that we can use "is this thing owned by us?" as a knob
that asks Git to ignore all config settings referring to paths of
executables it is supposed to run at one stage or another.

Ciao,
Dscho
