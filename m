Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F17C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB12C61425
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhGBN3T convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Jul 2021 09:29:19 -0400
Received: from elephants.elehost.com ([216.66.27.132]:22818 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhGBN3S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 09:29:18 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 162DQaeq071933
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Jul 2021 09:26:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'martin'" <test2@mfriebe.de>,
        "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'Andreas Schwab'" <schwab@linux-m68k.org>
Cc:     <git@vger.kernel.org>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Junio C Hamano'" <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com> <20210702100506.1422429-6-felipe.contreras@gmail.com> <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch> <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de> <60def07e686c7_7442083a@natae.notmuch> <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
In-Reply-To: <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
Subject: RE: [PATCH 5/5] config: add default aliases
Date:   Fri, 2 Jul 2021 09:26:30 -0400
Message-ID: <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFt4lYZIaBsC/3edPIiz2atDh3oKQJ0jboPAtZ1RKIBrdoWqQDA6SjYAdtwiv8B5YNkIKum70qA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 2, 2021 7:15 AM, martin wrote:
>On 02/07/2021 12:54, Felipe Contreras wrote:
>> martin wrote:
>>> IMHO it would be good to (partly) follow other vcs, and have commit =
>>> ci
>> I'm fine with leaving co out of the default aliases if it's deemed
>> "too controversial".
>>
>> But ci doesn't make sense. ci comes from "check in" which has no
>> similitude in git.
>svn uses it for "commit".
>It can be seen as CommIt.
>
>But of course other letters can be picked. I don't see an advantage in it though.
>Like CoMmit cm ? or CommiT ct ? None of them seems any better to me.
>
>> I don't think it's a good idea to leave "git checkout" without an
>> alias (it's perhaps the second or third most used command), but at
>> least some aliases are better than no aliases.
>Well, that goes back to a bigger question. And from the brief time I have been on this mail list, it appears to me there is a divide into 2
>groups.
>
>If checkout is really meant to give way to switch/restore then it needs no further advertising. And then the current usage statistics are a
>relict from the before switch/restore time.
>
>If on the other hand checkout is not just to be kept for backward compatibility, but should always remain an equal alternative to
>switch/restore (i.e. it should still be taught to new user in 20 years) then it wants to have a default alias.

In my opinion, default aliases are not a good path. If a command is intended to be part of the git command set, then it should be a builtin not an alias. Users have their own alias setups and implied conflicts are just going to be confusing and end up in help, examples, presentations, and so forth.

If you want a default alias set, publish it as part of an extension set, like the bash-completion, so that the user has to take action to install them in their environment. Do not do this in the base git product by default.

Further, if you are deprecating a command like checkout (which I know is not happening), then the command should go away rather than become an alias, unless a specific user wants to include this. That's what deprecation is. Keeping it around as an alias means you are keeping it around as a command, just providing a new access path.

If I was a committer on this project, I would have to be much more convinced that there is long-term value in this series than appears on the surface.

I am sorry if I am coming across too strongly on this subject, but I do think we are overloading alias capability and intruding on a domain that should be reserved for our users, not ourselves.

Sincerely,
Randall

