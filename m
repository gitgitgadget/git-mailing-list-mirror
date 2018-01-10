Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CEA1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 16:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965997AbeAJQ0V (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 11:26:21 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43969 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965714AbeAJQ0S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 11:26:18 -0500
Received: by mail-ua0-f194.google.com with SMTP id l12so11916392uaa.10
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KEZ87vJvfu/YHwv3LaOKZ0Ir8vOpLRf6tlTOQ05yoxg=;
        b=vEhffVh/WBNzDzTmXpd1Pt1OFZ1qCqTH6dlXopVznTMOdnNoyelWid6s8jIiz8bVL3
         sNsCG/1X4y+ZT01Va/KWexKCEoqgCB5mb48GaAtb3oNilshoNCAO26xaZ7w7gJZQf2+L
         bzjXMz/19rnyVRNMiL/TloaL2SPEANVLEMwDMO0xgzkj93nSQuPej19LpWUWMW8hdmO4
         kSaAi5BdtuZ1SXA8AKOueJZuwIhadEA+iguNqH3b26eAQF9zwlc6QsY/jHcZbfHnFFs6
         RFiBox+wZcf060T8JSqxMzsyPtsOksJ1ySmlFBtSGYq1JhoPm0O0GdLHen0CYRE8NxQk
         DuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KEZ87vJvfu/YHwv3LaOKZ0Ir8vOpLRf6tlTOQ05yoxg=;
        b=DFzo8B67l4fg5YbosECYVVeAUfnYHGzNJ+vP+x49SBD4uwEr8Fh7pVraskoCe3F/y2
         9ZGgOXQumOAqrfrT9T/BwoF2tEYf6AY2a3ACsR/agT48cVoefNhLm/Pp4KN1gaIP9M2S
         DkDa13MXBK31bXjxl6e2qi0WaGzVTP+ITXLJLTEkI07baHGUqr8zgLBuaaedAaExnNFx
         y1P5VXPyZZyJu3lfBROr6n4Nhurjgckkst12PaR5Y0RYiBkUPrfwGflYYplOJs5lQWcB
         UmmiTia8DTA6YfIGUzDgSmosrEm25Z2nQfdsAirAIn4uXR/xVPNs+XATJx46fDk5W16P
         /2zA==
X-Gm-Message-State: AKwxytfbe0P8x/6nPGt4RqhT+dtvB0LPsWlzFdNp4axub654JMsDZs3l
        ToQJjxXiHeCATotJgXClvELuhF4xY0rN/fe9m8A=
X-Google-Smtp-Source: ACJfBouVhcEGcuUTiqQcyPGrxJ0EbMICEBqoRUgXUmjxn8Bbiw/gWunS8YWwtWdNuoqiCOdHAbnFz1UbsH8elBGm39Y=
X-Received: by 10.176.21.165 with SMTP id i34mr5123649uae.108.1515601578028;
 Wed, 10 Jan 2018 08:26:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.142.195 with HTTP; Wed, 10 Jan 2018 08:26:17 -0800 (PST)
In-Reply-To: <00c401d38a2f$51ded390$f59c7ab0$@nexbridge.com>
References: <CALKyTE7+qJSYHQRB44HjHXK_EjOxNnCfQOROSDVVwAFR-gMnXQ@mail.gmail.com>
 <CALKyTE7VpeCoofzzutdEmsjtGe7NaC3EywQWJvM0EOH3U6XvoA@mail.gmail.com>
 <87mv1laeoe.fsf@evledraar.gmail.com> <CALKyTE57dfy1XFxVZR9yYc9rm6uQ+e+=PU_5gL15HdFO47abaA@mail.gmail.com>
 <00c401d38a2f$51ded390$f59c7ab0$@nexbridge.com>
From:   Sam Millman <sam.millman@gmail.com>
Date:   Wed, 10 Jan 2018 16:26:17 +0000
Message-ID: <CALKyTE6S7KQjVUsK03XRPmdNjpEgUfNiCwaDoXu3MYJ_ka=oAg@mail.gmail.com>
Subject: Re: How to use multiple SSH keys on Git exe (not bash)
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Does the ssh.exe come from OpenSSH? I thought it was Git's
implementation of the SSH protocol

On 10 January 2018 at 16:23, Randall S. Becker <rsbecker@nexbridge.com> wro=
te:
> May I, with respect, ask you to take this to the OpenSSH email list? (ope=
nssh-unix-dev@mindrot.org)  I think the discussion better belongs there and=
 you're likely to get more detailed information from that team.
> Sincerely,
> Randall
>
>> -----Original Message-----
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
>> Behalf Of Sam Millman
>> Sent: January 10, 2018 11:03 AM
>> To: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Cc: git@vger.kernel.org
>> Subject: Re: How to use multiple SSH keys on Git exe (not bash)
>>
>> I actually played a bit more and got this:
>>
>> Host *
>> IdentityFile ~/.ssh/id_rsa_d
>> IdentityFile ~/.ssh/id_rsa
>>
>> Host bitbucket_1
>> User git
>> HostName bitbucket.org
>> IdentityFile ~/.ssh/id_rsa_d
>>
>> Host bitbucket_2
>> User git
>> HostName bitbucket.org
>> IdentityFile ~/.ssh/id_rsa
>>
>> And from basic testing it seems to actually work, it seems it is the Hos=
t * that
>> make sit work and it will actually iterate the keys and try them.
>>
>> Not sure why this is, any thoughts?
>>
>> On 10 January 2018 at 15:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com>
>> wrote:
>> >
>> > On Wed, Jan 10 2018, Sam Millman jotted:
>> >
>> >> I am trying, for the sake of PhpStorm, to get multiple SSH keys
>> >> working using git . exe, which means no GitBash.
>> >>
>> >> I can get the keys to work just fine with GitBash.
>> >>
>> >> I edited my .ssh/config to look like (I know this is incorrect):
>> >>
>> >> Host bitucket . org
>> >> IdentityFile ~/.ssh/id_rsa1
>> >>
>> >> Host bitbucket . org
>> >> IdentityFile ~/.ssh/id_rsa
>> >>
>> >>
>> >> And id_rsa1 works, I can actually pick from the other repo. But, of
>> >> course, id_rsa does not now.
>> >>
>> >> I change to:
>> >>
>> >> Host bitucket . org-dd
>> >> HostName bitbucket . org
>> >> IdentityFile ~/.ssh/id_rsa1
>> >>
>> >> Host bitbucket . org-sas
>> >> HostName bitbucket . org
>> >> IdentityFile ~/.ssh/id_rsa
>> >>
>> >> And now only id_rsa works.
>> >>
>> >> I also tried combining the two IdentityFile lines together like so
>> >> (for some reason):
>> >>
>> >> Host bitucket . org
>> >> IdentityFile ~/.ssh/id_rsa1
>> >> IdentityFile ~/.ssh/id_rsa
>> >>
>> >> I have even tried running ssh-agent . exe, adding id_rsa1 to that and
>> >> then running the git clone with no result.
>> >>
>> >> The weird thing is, I have two public keys as well and they both load
>> >> in the ssh . exe (they return errors about format), I just cannot get
>> >> my ssh . exe to work with multiple private keys.
>> >
>> > This might just be a special case of the problem of some hosting
>> > providers picking only the first key you provide, as described in this
>> > thread:
>> > https://public-inbox.org/git/20180103102840.27897-1-avarab@gmail.com/
>> >
>> > If so, you either need to hack around this with ssh host aliases, or a
>> > custom GIT_SSH_COMMAND.
>> >
>> >> On 10 January 2018 at 15:29, Sam Millman <sam.millman@gmail.com>
>> wrote:
>> >>> I am trying, for the sake of PhpStorm, to get multiple SSH keys
>> >>> working using git . exe, which means no GitBash.
>> >>>
>> >>> I can get the keys to work just fine with GitBash.
>> >>>
>> >>> I edited my .ssh/config to look like (I know this is incorrect):
>> >>>
>> >>> Host bitucket . org
>> >>> IdentityFile ~/.ssh/id_rsa1
>> >>>
>> >>> Host bitbucket . org
>> >>> IdentityFile ~/.ssh/id_rsa
>> >>>
>> >>>
>> >>> And id_rsa1 works, I can actually pick from the other repo. But, of
>> >>> course, id_rsa does not now.
>> >>>
>> >>> I change to:
>> >>>
>> >>> Host bitucket . org-dd
>> >>> HostName bitbucket . org
>> >>> IdentityFile ~/.ssh/id_rsa1
>> >>>
>> >>> Host bitbucket . org-sas
>> >>> HostName bitbucket . org
>> >>> IdentityFile ~/.ssh/id_rsa
>> >>>
>> >>> And now only id_rsa works.
>> >>>
>> >>> I also tried combining the two IdentityFile lines together like so
>> >>> (for some
>> >>> reason):
>> >>>
>> >>> Host bitucket . org
>> >>> IdentityFile ~/.ssh/id_rsa1
>> >>> IdentityFile ~/.ssh/id_rsa
>> >>>
>> >>> I have even tried running ssh-agent . exe, adding id_rsa1 to that
>> >>> and then running the git clone with no result.
>> >>>
>> >>> The weird thing is, I have two public keys as well and they both
>> >>> load in the ssh . exe (they return errors about format), I just
>> >>> cannot get my ssh . exe to work with multiple private keys.
>> >>>
>> >>> Has anyone got any ideas on how to solve this?
>
