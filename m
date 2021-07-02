Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCE1C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E291C613D8
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhGBWDS convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Jul 2021 18:03:18 -0400
Received: from elephants.elehost.com ([216.66.27.132]:57933 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBWDS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 18:03:18 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 162M0bcs018257
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Jul 2021 18:00:37 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'martin'" <test2@mfriebe.de>,
        "'Andreas Schwab'" <schwab@linux-m68k.org>
Cc:     <git@vger.kernel.org>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Junio C Hamano'" <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com> <20210702100506.1422429-6-felipe.contreras@gmail.com> <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch> <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de> <60def07e686c7_7442083a@natae.notmuch> <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de> <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com> <60df7ee3128d6_28bb2086c@natae.notmuch>
In-Reply-To: <60df7ee3128d6_28bb2086c@natae.notmuch>
Subject: RE: [PATCH 5/5] config: add default aliases
Date:   Fri, 2 Jul 2021 18:00:32 -0400
Message-ID: <03ce01d76f8d$b0cfa8b0$126efa10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFt4lYZIaBsC/3edPIiz2atDh3oKQJ0jboPAtZ1RKIBrdoWqQDA6SjYAdtwiv8B5YNkIAHEAWDFAd18l9mrim6JQA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 2, 2021 5:02 PM, Felipe Contreras wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>; 'martin' <test2@mfriebe.de>; 'Felipe Contreras' <felipe.contreras@gmail.com>;
>'Andreas Schwab' <schwab@linux-m68k.org>
>Cc: git@vger.kernel.org; 'Ævar Arnfjörð Bjarmason' <avarab@gmail.com>; 'Junio C Hamano' <gitster@pobox.com>
>Subject: RE: [PATCH 5/5] config: add default aliases
>
>Randall S. Becker wrote:
>
>> In my opinion, default aliases are not a good path. If a command is
>> intended to be part of the git command set, then it should be a
>> builtin not an alias.
>
>Commands cannot be overriden, aliases can.
>
>All SCM projects have aliases, except git. Why do you think that is?

I do not think my intent was conveyed. Default aliases made by the product provider, regardless of who that is, are not a good path. If I was RCS, I would not make an alias that everyone had to take. Same for git. git has aliases, but they are for the user. If the end-user team wants to implement a particular set of primitives for their environment, that's fantastic, and entirely possible in git. But I do not want to be constrained by someone else's primitives that are not core product.

>> Users have their own alias setups and implied conflicts are just going
>> to be confusing and end up in help, examples, presentations, and so
>> forth.
>
>There's no conflict. Either you use the alias or you don't. Just like today.

Then what is the point of this? I want my aliases, not someone else's. Again, if it is a core git alias, it is not an alias, it is a supported command and I should see it in the git help -a output.

>> If you want a default alias set, publish it as part of an extension
>> set, like the bash-completion, so that the user has to take action to
>> install them in their environment. Do not do this in the base git
>> product by default.
>
>The whole point is to help users so they don't have to do extra configurations.

The whole point is that a user team should give thought to the functional extensions they want, as a team, which is where aliases come in. We, as git contributors, should not be telling them what their extensions are.

>Today git is pretty much unbearable without a configuration. Default aliases would help quell some of that pain.

Git is entirely bearable particularly in my own pons and medulla. I have three bash aliases, two for log, one for removing tags and no git aliases and I am highly productive.

Would that make ECLIPSE intolerable?

>> If I was a committer on this project, I would have to be much more
>> convinced that there is long-term value in this series than appears on
>> the surface.
>
> 1. It doesn't affect anyone negatively
> 2. You don't have to use them if you don't want to  3. They don't affect your aliases, even if they have the same name  4. Everyone has
>aliases  5. Every SCM in history has had aliases
>
>What more would you need?
>
>> I am sorry if I am coming across too strongly on this subject, but I
>> do think we are overloading alias capability and intruding on a domain
>> that should be reserved for our users, not ourselves.
>
>But why? We provide plenty of defaults so that users don't have to configure git in order for the program to be useful. And we will
>continue to add more defaults.

I remain unconvinced and I found the assertion #5 somewhat specious and incorrect. SCCS and RCS use Shell aliases. There are no aliases in ClearCase. Granted Perforce has them, but that is not a sufficient differentiator to use that over git by any stretch.

Why are we trying to create a standard set of aliases? I do not like the RCS primitives - never did - as a base and would not use them. If the command set is not sufficient, then it should be extended. If it is sufficient but complex for some, *they* can create aliases. I come back to my point that a community-based set of alias extensions should be managed as a distinct Open Source product that can be cloned from some cloud service and maintained independently from git. There is nothing stopping that from happening, except perhaps for something like an include operation in .gitconfig, which I think would be either a really good idea, or subject to a CVE, or both.

I've expressed my opinion, and it's not my decision to adopt this. So whatever happens, as long as it does not pollute my community's expectation of git. Although, providing aliases will handcuff future command naming.

