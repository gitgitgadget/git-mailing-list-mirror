Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60F420A21
	for <e@80x24.org>; Wed, 13 Sep 2017 13:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbdIMNiy (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 09:38:54 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:48930 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdIMNix (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 09:38:53 -0400
Received: by mail-it0-f42.google.com with SMTP id c195so2654813itb.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LZ1U65slLBMwn7j7vSYwGTUi7HG9InUoUJHGWbgLQDc=;
        b=gwPKkK2dMfyCsaCm3MI+zWUWfjEryBBnHoetN3Rn4s143ieBION6ewBu68HDj1AIVw
         kCQewEVoKRz5b20DMuVdYyeB1kGtVUplrIGDLpmX1q3sShO4tHiEEvcpvJuPwsJrqrmP
         Ol88jeUn9e9nMHNLYwaoF6PgQE4QoevjTXUeU02QHl/aJPBk4J1RJEMgqg96aIW/zW89
         2QnT4DMo7O43wmkLuDnuDayx0PEUsdsWR5xnm1YUO8vZR3spvgzxxx3fzb5R+4kl+Lx3
         uaLM9HN8YmFuLhT2RrcGdO6DMzEkKwa2e4oajo9LM9EhWfVL/clJXjyBcycRJDA8FRcU
         am0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LZ1U65slLBMwn7j7vSYwGTUi7HG9InUoUJHGWbgLQDc=;
        b=dspsfO487NngInTonSqtd5qaAhxAAFxU5eMQBrnIRuDHxHzLnl37XXQ6aGxgp+hfsC
         8uTGXZH5yyArfAPlpBMGpId5JyDPPNSMAmRneRulQXPgoAcX9dwK/b2uZRWMJ/RjpnSH
         cy8an+MFyn/yTni6NypdN2g8WiT/VNnnFDPvMmnYvfQl/vT5vdS8QYUUMcrYFqLTrozL
         Wb+Eq3PSpNIilYXLdwaPGvDbbMTcxsuyoTbkzlz1BCH9T1wI7h/CAXiVe3yAALxFP/ST
         v0sJb7iQbHhQhjsB5ynCXySuiHDpdeBq//eAFmyWwculn/SDnfY/7LIljo6DiOHIxywj
         AlYg==
X-Gm-Message-State: AHPjjUhs/mqo26zopaTA3btu/VpUnTp41YA2QzqorcX9gqvDET7Rb7dd
        4x+uLej0bKXXXyrywCUgtLvuPVpoA8nrpa+nmGk=
X-Google-Smtp-Source: AOwi7QDFEbVCYT1L2hXQ84gEMOaRNnF1umYDt1fZxLAL8R6hzBNr7j83o5NogX+DeL1pu2bfY/ivA1UrhaAo9H3RWxI=
X-Received: by 10.36.68.207 with SMTP id o198mr4376828ita.74.1505309933228;
 Wed, 13 Sep 2017 06:38:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.4 with HTTP; Wed, 13 Sep 2017 06:38:52 -0700 (PDT)
In-Reply-To: <20170913123420.die3thfcpaweakce@sigill.intra.peff.net>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
 <20170913123420.die3thfcpaweakce@sigill.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 13 Sep 2017 15:38:52 +0200
Message-ID: <CANgJU+U3Vzmmag9fpFGf7sx4Sq4S9qjLc5bnR4e+U0C3aaQXJA@mail.gmail.com>
Subject: Re: Bug: git branch --unset-upstream command can nuke config when
 disk is full.
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 September 2017 at 14:34, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 13, 2017 at 01:59:17PM +0200, demerphq wrote:
>
>> After being away for a while I saw the following message in one of my git repos:
>>
>> $ git status
>> On branch yves/xxx
>> Your branch is based on 'origin/yves/xxx', but the upstream is gone.
>>   (use "git branch --unset-upstream" to fixup)
>>
>> nothing to commit, working tree clean
>> $ git branch --unset-upstream
>> fatal: could not unset 'branch.yves/simple_projection.merge'
>
> Hrm. I wonder what caused this failure. The error would be in
> git_config_set_multivar_in_file_gently(). Most errors there produce
> another error message before hitting the die(). In fact, the only case I
> see where it would not produce another message is if it found nothing to
> unset (but in that case, "branch" would never have called the function
> in the first place).

I just double checked the terminal history and this is all i saw:

$ git status
On branch yves/xxx
Your branch is based on 'origin/yves/xxx', but the upstream is gone.
  (use "git branch --unset-upstream" to fixup)

nothing to commit, working tree clean
$ git branch --unset-upstream
fatal: could not unset 'branch.yves/xxx.merge'
$ git status
On branch yves/xxx
nothing to commit, working tree clean
$ git fetch
fatal: No remote repository specified.  Please, specify either a URL or a
remote name from which new revisions should be fetched.

>> At this point my .git/config file was empty, and all of my config was lost.
>>
>> I assume that things that rewrite .git/config do not check for a
>> successful write before deleting the old version of the file.
>
> No, it writes the new content to "config.lock" and then renames it into
> place.
> All of the write() calls to the temporary file are checked.

I was going to say that perhaps the write was not checked... But if
you are confident they are then...

>The
> old data is copied over after having been ready by mmap (which is also
> error-checked).
>
> Given that your output is consistent with it failing to find the key,
> and that the result is an empty file, it sounds like somehow the mmap'd
> input appeared empty (but neither open nor fstat nor mmap returned an
> error). You're not on any kind of exotic filesystem, are you?

I don't think so, but I don't know. Is there a command I can run to check?

BTW, with a bit of faffing I can probably recreate this problem.
Should I try? Is there something I could do during recreation that
would help?

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
