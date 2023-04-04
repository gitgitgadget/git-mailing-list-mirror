Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12806C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 18:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjDDS3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbjDDS3H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 14:29:07 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD4B6E8B
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 11:26:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 999673C09FA04;
        Tue,  4 Apr 2023 11:26:00 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 95-7Sq2pH7TB; Tue,  4 Apr 2023 11:26:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 57B053C09FA08;
        Tue,  4 Apr 2023 11:26:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 57B053C09FA08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1680632760;
        bh=FYW4ECUW8MUCylXzUhT21AzRYAuNwByZMArOjfDZ+6A=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=HYhxH1aNvKIJjxXiUlUK7/K6lLKOMOLMCVz/ZSwngWyMpluC1Reh+RB6VOYjmggNR
         uVCF237LceyP1veG3HZBJr3Rfe5S7tojXIi3WOP3BqEHg8j2frOmu1x87sacvnNBWl
         InfUvQzVvzvyr4FmPv4dkUtzsIs0IKRQ45/0CK/1c3D4NcVPBLv5oRYKqEIDOaitkc
         UCoUe9JG5vKjI8QxiD+fQIBIPNXxMyqVbFIjr42xitME9nYQ+g1uRYh7xOkCsCiXd0
         Xt3yrvgUGMGnYqIyCusnaGmuWuVqhld4j4DhdFQNhkpP91bjYE7LOnCWos3JONtGEd
         2/9x9rz3yJnEg==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H9BFLE10cWjv; Tue,  4 Apr 2023 11:26:00 -0700 (PDT)
Received: from [131.179.64.200] (Penguin.CS.UCLA.EDU [131.179.64.200])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id 2DB283C09FA04;
        Tue,  4 Apr 2023 11:26:00 -0700 (PDT)
Message-ID: <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu>
Date:   Tue, 4 Apr 2023 11:25:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: bug#60690: -P '\d' in GNU and git grep
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>
Cc:     demerphq@gmail.com, 60690@debbugs.gnu.org,
        mega lith01 <megalith01@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?Q?Tukusej=e2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        pcre-dev@exim.org
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/23 23:56, Carlo Arenas wrote:
> On Mon, Apr 3, 2023 at 2:38=E2=80=AFPM Paul Eggert <eggert@cs.ucla.edu>=
 wrote:
>>
>> on March 23 Git disabled
>> the use of PCRE2_UCP in PCRE2 10.34 or earlier[6], due to a PCRE2 bug
>> that can cause a crash when PCRE2_UCP is used[7]. A bug fix[8] should
>> appear in the next PCRE2 release.
>=20
> Presume PCRE2 is a typo and should have been "git" here?

No, I was talking about what options Git uses when it calls PCRE2=20
functions. In other words, this is about whether GNU 'grep -P' should be=20
compatible with 'git grep -P' (as well as with Perl and with pcregrep),=20
when interpreting \d and similar constructs.

This is an evolving area. Git master is fiddling with flags and options,=20
and so is GNU grep master, and so is PCRE2, and there are bugs. If=20
you're running bleeding-edge versions of this code you'll get different=20
behavior than if you're running grep 3.8, pcregrep 8.45, Perl 5.36, and=20
git 2.39.2 (which is what Fedora 37 has).

What I'm fearing is that we may evolve into mutually incompatible=20
interpretations of how Perl regular expressions deal with UTF-8 text.=20
That'd be a recipe for confusion down the road.
