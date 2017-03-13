Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDAFD201C2
	for <e@80x24.org>; Mon, 13 Mar 2017 10:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbdCMKPC (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 06:15:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57462 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750783AbdCMKPA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Mar 2017 06:15:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 28B0B20709;
        Mon, 13 Mar 2017 06:14:59 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 13 Mar 2017 06:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=E2C5krip8eNhaDh
        Mnl+oFivZup4=; b=auBcaIrRKlxdSOPrK+MG73Lpbaqn/D57Zim3XvC9P3WzW+m
        kQelQ/hwPjP0Qy8FkcsHj3AOn+LL2clv3x+10MgcLbwzQ6zLxT55i1wabiRU0pXO
        nrHuhBwasJQ8lxwMW7HR8zuKPy6PW+Hyik3FAromZys0eV9maKlFx0JVKobc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=E2C5krip8eNhaDhMnl+oFivZup4=; b=N2/Kc+OeKvQgeaoHrQFX
        QhohPHKJkoqg2S6bQ60tsCW8NA5e3+1L/XVgrHyi/YpHT3B3FcipXPfce3PtL9Fm
        UGXcwWCfJcNT+jgq4WB/Fo1DVM1pvTWIyjtTmLXKcelGAWjFIRiE6/gmCWToHVls
        VkbERpI+L8KySCwaWa2gTcA=
X-ME-Sender: <xms:I3HGWIZiXz5Bz6LAh6J_CWbPPmk3vZ5pngs5PFUqN5OJ6V1sC_7xig>
X-Sasl-enc: t7RiSJoudwyn1/dsq1bJv6sYllL4Z3zTFt9tlvugt7DV 1489400098
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 485C0246E4;
        Mon, 13 Mar 2017 06:14:58 -0400 (EDT)
Subject: Re: Stable GnuPG interface, git should use GPGME
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
References: <201703101100.15214.bernhard.reiter@intevation.de>
 <CACBZZX4Av-D6hxE9ceDFPuG-_qUQbH_6KW5JKsJf0SuH62jkuQ@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, gnupg-devel@gnupg.org,
        Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <a5161dd2-977b-8195-e558-01787fb3f01b@drmicha.warpmail.net>
Date:   Mon, 13 Mar 2017 11:14:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX4Av-D6hxE9ceDFPuG-_qUQbH_6KW5JKsJf0SuH62jkuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason venit, vidit, dixit 10.03.2017 15:23:
> On Fri, Mar 10, 2017 at 11:00 AM, Bernhard E. Reiter
> <bernhard.reiter@intevation.de> wrote:
>> Dear Git-Devs,
> 
> I haven't contributed to Git's GPG code, but I'm taking the liberty of
> CC-ing some people who have.
> 
>> git uses an pipe-and-exec approach to running a GnuPG binary
>> as writen in the documentation [1]:
>>
>>     gpg.program
>>            Use this custom program instead of "gpg" found on $PATH when making
>>            or verifying a PGP signature. The program must support the same
>>            command-line interface as GPG
>>
>> please consider using libgpgme interfacing to GnuPG, because the gpg
>> command-line interface is not considered an official API to GnuPG by the
>> GnuPG-devs and thus potentially unstable.
>>
>> == Details
>>
>> I'm involved in GnuPG development. For most applications using libgpgme is the
>> way what GnuPG-devs would recommend, also see
>>
>>   https://wiki.gnupg.org/APIs .
>>
>> GnuPG devs are making a good effort of trying to keep the command-line
>> interface stable, though it is not for sure. Git is only using a small part
>> of the interface, so the risk when keeping the current way is small.
>> Still I believe git's stability and usability would profit when moving to
>> libgpgme, especially with the coming move to GnuPG 2.2, better diagnosing
>> messages and for cross-plattform usage.
>>
>> == Usability problem with `gpg2` vs `gpg`
>>
>> My use case today was signing and git by default found the `gpg` binary by
>> default and the command failed. The reason is that I have `gpg2` installed
>> and most applications use it right away. So git failed signing because
>> the .gnupg configuration of the user was not ready for the old `gpg` which is
>> still installed on Debian GNU/Linux for purposes of the operating system. If
>> git would have used libgpgme, gpgme would have choosen the most uptodate
>> version of `gpg` available (or configured) without me intervening via
>> gpg.program. Now because of this problem you could adding a check for `gpg2`
>> and fallback to `gpg`, but even better would be to move to libgpgme. >:)
> 
> I'm on Debian but haven't had these issues. What's your gpg & gpg2
> --version & Debian release? And what in particular failed?
> 
> And what git version was this? I see we've had a couple of workarounds
> for gpg2, in particular Linus's v2.8.4-1-gb624a3e67f, but if you have
> v2.10.0 or later that won't fix whatever issue you had.
> 
> Using the library sounds good, but a shorter-term immediate fix would
> be to figure out what bug you encountered in our use of the
> command-line version, and see if we've fixed that already or not.
> Regardless of what we do with a gpg library in the future some distros
> might want to backport such a small patch if we can come up with it.

As far as I know, Git handles different GPG versions just fine.

The problem is the "difficult" upgrade path and mixed installations with
gpg and gpg2.1+ that some distributions force upon you:

As soon as you start gpg2.1, your (secret) key store is migrated to a
new format without technically invalidating it. Similarly, users may
enter gpg2.1+-only comand in the config that is actually shared with
gpg, throwing off any use of gpg - not just by git, but also by anything
that your distro requires gpg for (such as packaging tools and the like).

In short: Users will run into problems anyway; git provides the quick
way out (git config gpg.program gpg2), users won't be as lucky with
other things that require gpg.

As for the library: While - technically speaking - the command line is
not a stable API for gpg, it does work across versions of gpg, and gpg
2.2 will be the first real stable branch that uses the new key store
layout. So I'd rather wait for that to stabilize before going away from
what turned out to be most stable so far.

Note that we (git) refrain from parsing ordinary output/return codes of
gpg and use status-fd as we should (and as documented).

Michael
