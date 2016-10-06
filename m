Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C5B207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935071AbcJFVaI (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 17:30:08 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36612 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933172AbcJFVaG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 17:30:06 -0400
Received: by mail-qk0-f170.google.com with SMTP id o68so27621277qkf.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JJ0vMwxbO0bFAwaJyMMdEgFFuNTuQfhjepLmLQNWYlI=;
        b=G0dsZ1vSB/T/ZMu1ESGi2FRCa96lKQGA/Qi+B8XPSUFn6D+ztwCH8h1MnCmtfdZomy
         4xLQG5vkCeMw5nUhDhXsB9T7p+CD6pLblXxU2tNughWcXxVOejc8jRgam/MnSXa1nJau
         A3kwQX9RrrS7R9RMWEQq56esr5WHZk7N+oqRzeVrxQ51G+NHPNBc6woVovnY9v2mjqHM
         f+iQRPMnQagTHwmrlW33vD9PpsFsA7Ed9Zu2cygUB2lNZhm5utkLcvvDWfsgvGdCupS3
         IpSNJvRkvjcK1aw4KM+/bKBB64lH/CveR/G/vTC/hItsGG9YEIMgRkReTFi/l5/jf3/u
         EKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JJ0vMwxbO0bFAwaJyMMdEgFFuNTuQfhjepLmLQNWYlI=;
        b=KInYFcFRuqWqBg9/vvO5pn/NAPRv+mZjfCMfktLqJ1cm6KDKCLoSN1YuVD13geMkC+
         oIW52sA/pukdxgNbTmTYue/ERdy7GR2ew22nOcrbfnIuWwrApr2mCx+x4Quy0UpAlsp8
         7Fw3NqMVKXo8EbWlncdNfXpyOR+T9hiTfEqrdvt2D98Sf6qeKPFZhPxg2PxBBYLq+PYA
         aE4YDnzB6vfAp7Dajr7ANnmWDV0y850dxI8XdsU4LSefvScfHFagx0sO0NplC0zbOShD
         Fq2+TIlokdSIaa0PchMpc7NW5MmosfabcKd64v8VGPEPOE8gfHSKjjtNkHtQ5BGU3oHY
         tdBQ==
X-Gm-Message-State: AA6/9Rk0Fdjk/UIPg2uw5O6aS0Nq58ZHhITl9+eaC6XznSWk9CilnczkcUDNhNKpwpaQ50Odte8IQ6Ud9c5mB190
X-Received: by 10.55.36.131 with SMTP id k3mr15607598qkk.86.1475789371591;
 Thu, 06 Oct 2016 14:29:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 6 Oct 2016 14:29:30 -0700 (PDT)
In-Reply-To: <xmqqoa2xi5rd.fsf@gitster.mtv.corp.google.com>
References: <20161006193725.31553-1-sbeller@google.com> <20161006193725.31553-3-sbeller@google.com>
 <xmqqoa2xi5rd.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Oct 2016 14:29:30 -0700
Message-ID: <CAGZ79kYij=7kfQa8cc1btRowBXbia01QgYTKTgz93ZBdx249Jw@mail.gmail.com>
Subject: Re: [PATCHv4 2/2] push: change submodule default to check when
 submodules exist
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 6, 2016 at 1:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When working with submodules, it is easy to forget to push the submodules.
>> The setting 'check', which checks if any existing submodule is present on
>> at least one remote of the submodule remotes, is designed to prevent this
>> mistake.
>>
>> Flipping the default to check for submodules is safer than the current
>> default of ignoring submodules while pushing.
>>
>> However checking for submodules requires additional work[1], which annoys
>> users that do not use submodules, so we turn on the check for submodules
>> based on a cheap heuristic, the existence of the .git/modules directory.
>
> ... and other things like .gitmodules, submodule stuff in
> .git/config, etc.?

Oh right, I need to update this commit message to mention this, too

>
>> +     } else if (starts_with(k, "submodule.") && ends_with(k, ".url"))
>> +             has_submodules_configured = 1;
>
> An in-code comment to explain why ".url" is so special would be
> helpful.  Documentation/config.txt says .path and .url are both

       submodule.<name>.path, submodule.<name>.url
           The path within this project and URL for a submodule. These
           variables are initially populated by git submodule init. See git-
           submodule(1) and gitmodules(5) for details.

The correct version is:

submodule.<name>.path::
    This is a config variable only found in .gitmodules files that
indicate at which
    path relative to the repository root the submodule is found.
    It is used to resolve the mapping (submodule name)<->path throughout all
    time, i.e. also later when a submodule is initialized and checked out, any
    subsequent operation that needs a submodule name/repsoitory uses it for
    lookup.

submodule.<name>.url::
    This is a config variable found both in .gitmodules files as well
as .git/config.
    In the .gitmodules files it serves as a hint where to obtain a
repository from
    to populate the gitlinks within the repository.
    On submodule-init the value will be copied over to the .git/config
file and there
    it serves as a holder of the value only until the first
submodule-update is run,
    as the initial submodule-update is using that url to clone the submodule.
    From then on it is only used as a boolean flag in the .git/config
to indicate
    whether the submodule is considered interesting for further submodule
    commands. (See the similar competing thing with submodule.<name>.ignore)

Given that it is obvious to my current me, that .url is the only
sensible thing as .path
is not found in the .git/config which we are searching in here.
So for the purpose of this patch I'd just add a line like this to
remind my future self:

    /* See if any submodule is considered interesting: */

I would like to avoid references to .path as that is not helping here.
(Why does that
comment point to a variable name that is not supposed to exist in the file?)
So I think we really need to think how to reduce confusion in the
future by readers that
have more or less overview of the submodules concept.

A future version of the man page may read:

submodule.<name>.path::
    <same as before>, we may want to consider if we copy it over to
.git/config, so the
    repository may trash the .gitmodules file and the submodules keep working.

submodule.<name>.url::
    indication in .gitmodules where the submodule is cloned from. It
will be copied over
    to .git/config on submodule-init. The user may adapt the
configured urls there before
    proceeding to submodule-update, which will delete the url setting
again, as the
    cloned submodule repository will hold the authoritative setting
where the remote
    of the submodule is.
    So it only exists in .git/config for submodules that are
initialized but have never
    been cloned. Even when the submodule is deinit'd and reinited we
don't even need
    to copy the url, as we still have the old submodule repository in
.git/module/<name>

submodule.<name>.exists::
    This setting is per working tree (unlike the previous 2) that
indicates if submodule
    related commands pay attention to the given submodule. It is still
unclear how this
    works together with the .ignore setting.


Note for this future to come true, we'd have to have only 2 big series
One that Duy started to introduce per working tree configs, see
    https://public-inbox.org/git/20160720172419.25473-1-pclouds@gmail.com/
The other one is a series that hasn't seen the mailing list yet, that
I started to
separate the 2 modes of the url both as a value holder (to point at a URL) as
well as just a boolean flag for commands to acknowledge the existence of the
submodule.


> initially populated by 'git submodule init', which might be outdated
> information that confuses readers of the above code.

A lot of text but I guess we can use some ideas from here to update the
.path and .url documentation. (The wording in this email is not of man
page quality).

Thanks,
Stefan
