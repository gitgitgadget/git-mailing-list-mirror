Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A65A1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 16:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965920AbeAJQaN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 10 Jan 2018 11:30:13 -0500
Received: from elephants.elehost.com ([216.66.27.132]:47309 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965892AbeAJQaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 11:30:12 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0AGU4UC003477
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Jan 2018 11:30:05 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Sam Millman'" <sam.millman@gmail.com>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>
References: <CALKyTE7+qJSYHQRB44HjHXK_EjOxNnCfQOROSDVVwAFR-gMnXQ@mail.gmail.com> <CALKyTE7VpeCoofzzutdEmsjtGe7NaC3EywQWJvM0EOH3U6XvoA@mail.gmail.com> <87mv1laeoe.fsf@evledraar.gmail.com> <CALKyTE57dfy1XFxVZR9yYc9rm6uQ+e+=PU_5gL15HdFO47abaA@mail.gmail.com> <00c401d38a2f$51ded390$f59c7ab0$@nexbridge.com> <CALKyTE6S7KQjVUsK03XRPmdNjpEgUfNiCwaDoXu3MYJ_ka=oAg@mail.gmail.com>
In-Reply-To: <CALKyTE6S7KQjVUsK03XRPmdNjpEgUfNiCwaDoXu3MYJ_ka=oAg@mail.gmail.com>
Subject: RE: How to use multiple SSH keys on Git exe (not bash)
Date:   Wed, 10 Jan 2018 11:29:58 -0500
Message-ID: <000e01d38a30$44788a10$cd699e30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFzCLrCGGicWqGvpjV838qgPZ2fEwIRwFhoATDT+cEBP/NqgwNhLvx9AORVSjaj6A4tYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OpenSSH generally. Other providers (and platform providers) exist as well. It is hard to know which is really involved, but not git.

> -----Original Message-----
> From: Sam Millman [mailto:sam.millman@gmail.com]
> Sent: January 10, 2018 11:26 AM
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>; git@vger.kernel.org
> Subject: Re: How to use multiple SSH keys on Git exe (not bash)
> 
> Does the ssh.exe come from OpenSSH? I thought it was Git's implementation
> of the SSH protocol
> 
> On 10 January 2018 at 16:23, Randall S. Becker <rsbecker@nexbridge.com>
> wrote:
> > May I, with respect, ask you to take this to the OpenSSH email list?
> (openssh-unix-dev@mindrot.org)  I think the discussion better belongs there
> and you're likely to get more detailed information from that team.
> > Sincerely,
> > Randall
> >
> >> -----Original Message-----
> >> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> >> Behalf Of Sam Millman
> >> Sent: January 10, 2018 11:03 AM
> >> To: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >> Cc: git@vger.kernel.org
> >> Subject: Re: How to use multiple SSH keys on Git exe (not bash)
> >>
> >> I actually played a bit more and got this:
> >>
> >> Host *
> >> IdentityFile ~/.ssh/id_rsa_d
> >> IdentityFile ~/.ssh/id_rsa
> >>
> >> Host bitbucket_1
> >> User git
> >> HostName bitbucket.org
> >> IdentityFile ~/.ssh/id_rsa_d
> >>
> >> Host bitbucket_2
> >> User git
> >> HostName bitbucket.org
> >> IdentityFile ~/.ssh/id_rsa
> >>
> >> And from basic testing it seems to actually work, it seems it is the
> >> Host * that make sit work and it will actually iterate the keys and try them.
> >>
> >> Not sure why this is, any thoughts?
> >>
> >> On 10 January 2018 at 15:58, Ævar Arnfjörð Bjarmason
> >> <avarab@gmail.com>
> >> wrote:
> >> >
> >> > On Wed, Jan 10 2018, Sam Millman jotted:
> >> >
> >> >> I am trying, for the sake of PhpStorm, to get multiple SSH keys
> >> >> working using git . exe, which means no GitBash.
> >> >>
> >> >> I can get the keys to work just fine with GitBash.
> >> >>
> >> >> I edited my .ssh/config to look like (I know this is incorrect):
> >> >>
> >> >> Host bitucket . org
> >> >> IdentityFile ~/.ssh/id_rsa1
> >> >>
> >> >> Host bitbucket . org
> >> >> IdentityFile ~/.ssh/id_rsa
> >> >>
> >> >>
> >> >> And id_rsa1 works, I can actually pick from the other repo. But,
> >> >> of course, id_rsa does not now.
> >> >>
> >> >> I change to:
> >> >>
> >> >> Host bitucket . org-dd
> >> >> HostName bitbucket . org
> >> >> IdentityFile ~/.ssh/id_rsa1
> >> >>
> >> >> Host bitbucket . org-sas
> >> >> HostName bitbucket . org
> >> >> IdentityFile ~/.ssh/id_rsa
> >> >>
> >> >> And now only id_rsa works.
> >> >>
> >> >> I also tried combining the two IdentityFile lines together like so
> >> >> (for some reason):
> >> >>
> >> >> Host bitucket . org
> >> >> IdentityFile ~/.ssh/id_rsa1
> >> >> IdentityFile ~/.ssh/id_rsa
> >> >>
> >> >> I have even tried running ssh-agent . exe, adding id_rsa1 to that
> >> >> and then running the git clone with no result.
> >> >>
> >> >> The weird thing is, I have two public keys as well and they both
> >> >> load in the ssh . exe (they return errors about format), I just
> >> >> cannot get my ssh . exe to work with multiple private keys.
> >> >
> >> > This might just be a special case of the problem of some hosting
> >> > providers picking only the first key you provide, as described in
> >> > this
> >> > thread:
> >> > https://public-inbox.org/git/20180103102840.27897-1-avarab@gmail.co
> >> > m/
> >> >
> >> > If so, you either need to hack around this with ssh host aliases,
> >> > or a custom GIT_SSH_COMMAND.
> >> >
> >> >> On 10 January 2018 at 15:29, Sam Millman <sam.millman@gmail.com>
> >> wrote:
> >> >>> I am trying, for the sake of PhpStorm, to get multiple SSH keys
> >> >>> working using git . exe, which means no GitBash.
> >> >>>
> >> >>> I can get the keys to work just fine with GitBash.
> >> >>>
> >> >>> I edited my .ssh/config to look like (I know this is incorrect):
> >> >>>
> >> >>> Host bitucket . org
> >> >>> IdentityFile ~/.ssh/id_rsa1
> >> >>>
> >> >>> Host bitbucket . org
> >> >>> IdentityFile ~/.ssh/id_rsa
> >> >>>
> >> >>>
> >> >>> And id_rsa1 works, I can actually pick from the other repo. But,
> >> >>> of course, id_rsa does not now.
> >> >>>
> >> >>> I change to:
> >> >>>
> >> >>> Host bitucket . org-dd
> >> >>> HostName bitbucket . org
> >> >>> IdentityFile ~/.ssh/id_rsa1
> >> >>>
> >> >>> Host bitbucket . org-sas
> >> >>> HostName bitbucket . org
> >> >>> IdentityFile ~/.ssh/id_rsa
> >> >>>
> >> >>> And now only id_rsa works.
> >> >>>
> >> >>> I also tried combining the two IdentityFile lines together like
> >> >>> so (for some
> >> >>> reason):
> >> >>>
> >> >>> Host bitucket . org
> >> >>> IdentityFile ~/.ssh/id_rsa1
> >> >>> IdentityFile ~/.ssh/id_rsa
> >> >>>
> >> >>> I have even tried running ssh-agent . exe, adding id_rsa1 to that
> >> >>> and then running the git clone with no result.
> >> >>>
> >> >>> The weird thing is, I have two public keys as well and they both
> >> >>> load in the ssh . exe (they return errors about format), I just
> >> >>> cannot get my ssh . exe to work with multiple private keys.
> >> >>>
> >> >>> Has anyone got any ideas on how to solve this?
> >

