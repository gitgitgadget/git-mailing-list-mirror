Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF7BE1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 16:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965789AbeAJQc2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 11:32:28 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35698 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965750AbeAJQc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 11:32:26 -0500
Received: by mail-ua0-f195.google.com with SMTP id g16so6857291ual.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 08:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=77TgpTAsDervs+h2dk7H6zHaIHeNWr4J9gmmJJRj6CI=;
        b=bRrHCHlmLinLtGrn36YOFrUJYQOYf5b8NLn89vuW1JR60n3rE6i8jbwTC/l2yuyWg5
         JX4OGYmzsNoY+CMulMM8vFUTLiPhyc3fFuTX+N1X4F9Ez63Aqg3nGchS4vqBa3G6u7md
         PBY1qHC+9JT8S7KBleI2/tg4jhv9ICHMMywUUHFgODE7zXJID1yJrzEcg6doWRtFM/L5
         Jz+FW4UkPayguuMJy6YdpTOBUG05JbexrEsLyy5mvVIcu8Z0uZz/LKuD2apVK669gYi9
         IJ2+z1118bsMOWpZpM+HLIOS9weKv0WtfphtlFgBWtKxZPQ6hfC346PQw9XBWOx5MDu7
         XfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=77TgpTAsDervs+h2dk7H6zHaIHeNWr4J9gmmJJRj6CI=;
        b=m94/75fudQxR8vWyjTNpsh9SFDkAz4gr5b1IjsQe/KgTrLDhVYFFl3SyWOEfeQeXPH
         aq8PEFKNNlyEXZ95hSTLzPdkCpsExOC+Zqm83K8uPRVcU/2jsOJn2RgO5rEJgYeC2yTo
         5VmcMKCVQpbykm5xcg5P7Pmdh0QsQinwjx7bzRqDGkzqIVUn3us2oomwW4gsf5aXL3ZB
         dNvZ+Bf+iEYy6oUV58LqvMU8xVn1BiPN4ThMfoea93Z+31TwQEm3CsB2HO54LlDDp3o6
         9ssYQk/d1HG2UqsaMZSJbyFKsSTQNuVulvR411l5KoTSppUVghRxUxEK6DAXJOVcJ3LQ
         r/Kg==
X-Gm-Message-State: AKwxytfqab0qnfevjw8yYkGz915W/GDtyqTTAYcS9kmrA3blNfkAV4gE
        8k4x7llF6bgW5QLKxyxVVgnJ1AP0wXGDf7EfyLc=
X-Google-Smtp-Source: ACJfBouS515POjqJnnXbysrUdqxpGrWOKZ+5B11ABUt06YsJtcScZpAkjx+LgE9z1xmHh9OXtGCOuetHTo/2xIOcyBo=
X-Received: by 10.176.84.135 with SMTP id p7mr8350964uaa.186.1515601946116;
 Wed, 10 Jan 2018 08:32:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.142.195 with HTTP; Wed, 10 Jan 2018 08:32:25 -0800 (PST)
In-Reply-To: <000e01d38a30$44788a10$cd699e30$@nexbridge.com>
References: <CALKyTE7+qJSYHQRB44HjHXK_EjOxNnCfQOROSDVVwAFR-gMnXQ@mail.gmail.com>
 <CALKyTE7VpeCoofzzutdEmsjtGe7NaC3EywQWJvM0EOH3U6XvoA@mail.gmail.com>
 <87mv1laeoe.fsf@evledraar.gmail.com> <CALKyTE57dfy1XFxVZR9yYc9rm6uQ+e+=PU_5gL15HdFO47abaA@mail.gmail.com>
 <00c401d38a2f$51ded390$f59c7ab0$@nexbridge.com> <CALKyTE6S7KQjVUsK03XRPmdNjpEgUfNiCwaDoXu3MYJ_ka=oAg@mail.gmail.com>
 <000e01d38a30$44788a10$cd699e30$@nexbridge.com>
From:   Sam Millman <sam.millman@gmail.com>
Date:   Wed, 10 Jan 2018 16:32:25 +0000
Message-ID: <CALKyTE7MW1gB2YzT1SuahU4jXnBBzenPJU7rqnBzPGDgchevSw@mail.gmail.com>
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

Aha, thanks, I'll go annoy them :P

On 10 January 2018 at 16:29, Randall S. Becker <rsbecker@nexbridge.com> wro=
te:
> OpenSSH generally. Other providers (and platform providers) exist as well=
. It is hard to know which is really involved, but not git.
>
>> -----Original Message-----
>> From: Sam Millman [mailto:sam.millman@gmail.com]
>> Sent: January 10, 2018 11:26 AM
>> To: Randall S. Becker <rsbecker@nexbridge.com>
>> Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>; git@vger.=
kernel.org
>> Subject: Re: How to use multiple SSH keys on Git exe (not bash)
>>
>> Does the ssh.exe come from OpenSSH? I thought it was Git's implementatio=
n
>> of the SSH protocol
>>
>> On 10 January 2018 at 16:23, Randall S. Becker <rsbecker@nexbridge.com>
>> wrote:
>> > May I, with respect, ask you to take this to the OpenSSH email list?
>> (openssh-unix-dev@mindrot.org)  I think the discussion better belongs th=
ere
>> and you're likely to get more detailed information from that team.
>> > Sincerely,
>> > Randall
>> >
>> >> -----Original Message-----
>> >> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
>> >> Behalf Of Sam Millman
>> >> Sent: January 10, 2018 11:03 AM
>> >> To: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> >> Cc: git@vger.kernel.org
>> >> Subject: Re: How to use multiple SSH keys on Git exe (not bash)
>> >>
>> >> I actually played a bit more and got this:
>> >>
>> >> Host *
>> >> IdentityFile ~/.ssh/id_rsa_d
>> >> IdentityFile ~/.ssh/id_rsa
>> >>
>> >> Host bitbucket_1
>> >> User git
>> >> HostName bitbucket.org
>> >> IdentityFile ~/.ssh/id_rsa_d
>> >>
>> >> Host bitbucket_2
>> >> User git
>> >> HostName bitbucket.org
>> >> IdentityFile ~/.ssh/id_rsa
>> >>
>> >> And from basic testing it seems to actually work, it seems it is the
>> >> Host * that make sit work and it will actually iterate the keys and t=
ry them.
>> >>
>> >> Not sure why this is, any thoughts?
>> >>
>> >> On 10 January 2018 at 15:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> >> <avarab@gmail.com>
>> >> wrote:
>> >> >
>> >> > On Wed, Jan 10 2018, Sam Millman jotted:
>> >> >
>> >> >> I am trying, for the sake of PhpStorm, to get multiple SSH keys
>> >> >> working using git . exe, which means no GitBash.
>> >> >>
>> >> >> I can get the keys to work just fine with GitBash.
>> >> >>
>> >> >> I edited my .ssh/config to look like (I know this is incorrect):
>> >> >>
>> >> >> Host bitucket . org
>> >> >> IdentityFile ~/.ssh/id_rsa1
>> >> >>
>> >> >> Host bitbucket . org
>> >> >> IdentityFile ~/.ssh/id_rsa
>> >> >>
>> >> >>
>> >> >> And id_rsa1 works, I can actually pick from the other repo. But,
>> >> >> of course, id_rsa does not now.
>> >> >>
>> >> >> I change to:
>> >> >>
>> >> >> Host bitucket . org-dd
>> >> >> HostName bitbucket . org
>> >> >> IdentityFile ~/.ssh/id_rsa1
>> >> >>
>> >> >> Host bitbucket . org-sas
>> >> >> HostName bitbucket . org
>> >> >> IdentityFile ~/.ssh/id_rsa
>> >> >>
>> >> >> And now only id_rsa works.
>> >> >>
>> >> >> I also tried combining the two IdentityFile lines together like so
>> >> >> (for some reason):
>> >> >>
>> >> >> Host bitucket . org
>> >> >> IdentityFile ~/.ssh/id_rsa1
>> >> >> IdentityFile ~/.ssh/id_rsa
>> >> >>
>> >> >> I have even tried running ssh-agent . exe, adding id_rsa1 to that
>> >> >> and then running the git clone with no result.
>> >> >>
>> >> >> The weird thing is, I have two public keys as well and they both
>> >> >> load in the ssh . exe (they return errors about format), I just
>> >> >> cannot get my ssh . exe to work with multiple private keys.
>> >> >
>> >> > This might just be a special case of the problem of some hosting
>> >> > providers picking only the first key you provide, as described in
>> >> > this
>> >> > thread:
>> >> > https://public-inbox.org/git/20180103102840.27897-1-avarab@gmail.co
>> >> > m/
>> >> >
>> >> > If so, you either need to hack around this with ssh host aliases,
>> >> > or a custom GIT_SSH_COMMAND.
>> >> >
>> >> >> On 10 January 2018 at 15:29, Sam Millman <sam.millman@gmail.com>
>> >> wrote:
>> >> >>> I am trying, for the sake of PhpStorm, to get multiple SSH keys
>> >> >>> working using git . exe, which means no GitBash.
>> >> >>>
>> >> >>> I can get the keys to work just fine with GitBash.
>> >> >>>
>> >> >>> I edited my .ssh/config to look like (I know this is incorrect):
>> >> >>>
>> >> >>> Host bitucket . org
>> >> >>> IdentityFile ~/.ssh/id_rsa1
>> >> >>>
>> >> >>> Host bitbucket . org
>> >> >>> IdentityFile ~/.ssh/id_rsa
>> >> >>>
>> >> >>>
>> >> >>> And id_rsa1 works, I can actually pick from the other repo. But,
>> >> >>> of course, id_rsa does not now.
>> >> >>>
>> >> >>> I change to:
>> >> >>>
>> >> >>> Host bitucket . org-dd
>> >> >>> HostName bitbucket . org
>> >> >>> IdentityFile ~/.ssh/id_rsa1
>> >> >>>
>> >> >>> Host bitbucket . org-sas
>> >> >>> HostName bitbucket . org
>> >> >>> IdentityFile ~/.ssh/id_rsa
>> >> >>>
>> >> >>> And now only id_rsa works.
>> >> >>>
>> >> >>> I also tried combining the two IdentityFile lines together like
>> >> >>> so (for some
>> >> >>> reason):
>> >> >>>
>> >> >>> Host bitucket . org
>> >> >>> IdentityFile ~/.ssh/id_rsa1
>> >> >>> IdentityFile ~/.ssh/id_rsa
>> >> >>>
>> >> >>> I have even tried running ssh-agent . exe, adding id_rsa1 to that
>> >> >>> and then running the git clone with no result.
>> >> >>>
>> >> >>> The weird thing is, I have two public keys as well and they both
>> >> >>> load in the ssh . exe (they return errors about format), I just
>> >> >>> cannot get my ssh . exe to work with multiple private keys.
>> >> >>>
>> >> >>> Has anyone got any ideas on how to solve this?
>> >
>
