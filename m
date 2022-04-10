Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E294C433F5
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 15:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbiDJPVI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 10 Apr 2022 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbiDJPVH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 11:21:07 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690AE2981F
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 08:18:56 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23AFIXoY023979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Apr 2022 11:18:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <rsbecker@nexbridge.com>, "'Tao Klerks'" <tao@klerks.biz>,
        "=?utf-8?Q?'Michal_Such=C3=A1nek'?=" <msuchanek@suse.de>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <jurgen_gjoncari@icloud.com>, <git@vger.kernel.org>
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com> <YlC3devsgmv17PnQ@camp.crustytoothpaste.net> <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com> <20220409113244.GX163591@kunlun.suse.cz> <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com> <013101d84ceb$afaa51b0$0efef510$@nexbridge.com>
In-Reply-To: <013101d84ceb$afaa51b0$0efef510$@nexbridge.com>
Subject: RE: Make commit messages optional
Date:   Sun, 10 Apr 2022 11:18:28 -0400
Organization: Nexbridge Inc.
Message-ID: <013201d84cee$3e8d88a0$bba899e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ+1NMvkwKGNzc/71+8xIhD/VDquAGOScQnAanmRncBUJW1cAIoo/mqAbvFKEerWMi7oA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 10, 2022 11:00 AM, I wrote:
>On April 10, 2022 10:00 AM, Tao Klerks wrote:
>>To: Michal Suchánek <msuchanek@suse.de>
>>Cc: rsbecker@nexbridge.com; brian m. carlson
>><sandals@crustytoothpaste.net>; jurgen_gjoncari@icloud.com;
>>git@vger.kernel.org
>>Subject: Re: Make commit messages optional
>>
>>On Sat, Apr 9, 2022 at 1:32 PM Michal Suchánek <msuchanek@suse.de> wrote:
>>>
>>> On Fri, Apr 08, 2022 at 07:32:03PM -0400, rsbecker@nexbridge.com wrote:
>>> > On April 8, 2022 6:30 PM, brian m. carlson wrote:
>>> > >On 2022-04-08 at 03:35:04, jurgen_gjoncari@icloud.com wrote:
>>> > >> I think that often commit messages are unnecessary. I propose
>>> > >> that by default a user should be able to commit without a message.
>>[...]
>>> > >We want to encourage good software engineering practices.
>>> > >
>>[...]
>>> > >
>>> > >Users who want this behaviour can use --allow-empty-message or
>>> > >create an alias with that option.  The functionality already
>>> > >exists.  I use aliases extensively in my development and I know
>>> > >others do as well, so this shouldn't be an impediment if you're
>>> > >working on
>>projects where this is acceptable.
>>> > >
>>[...]
>>>
>>> There is nothing stopping you using '.' as the commit message which
>>> is as informative as when it is empty. Hence this enforcement of
>>> non-empty commit message does not serve the stated purpose.
>>
>>My apologies if this proposal has already been made in this or prior
>>discussions - the list server and gmail are having another
>>disagreement, so I think I'm a few hours out of date.
>>
>>I believe the main argument *for* allowing empty commit messages by
>>default is "we shouldn't make it hard to do what you want to do, if you
>>can fix it later", and the main argument *against* is "for most people
>>(non-advanced users), what you do initially is what you end up pushing,
>>or at least trying to push, and fixing things later is *hard*
>>- it requires a much deeper understanding of git than most people
>>otherwise necessarily need to develop".
>
>Adding commit messages has been part of SCM systems since virtually the
>beginning, at least on UNIX in the early 1970 and likely before. Adding a simple
>commit message is not onerous or difficult. "Fixing it later" will require the commit
>and any signature you put on at the time is lost. You also invalidate any signatures
>more recent in history. This does not corrupt your repo, but it does reduce its
>value. If you insist on doing this, use a single non-breaking space symbol in the -m
>option, which you can script or alias. Note that none of that will work on any git
>clients anyway.
>
>The main argument against is that this violates the basic principles of a well
>managed DevSecOps environment that requires who, what, where, when, why
>for every change, not just the ones you publish. The key point here of having
>comments in commits is that it allows organizations to pull in projects like OpenSSL
>that ends up in production and must have the accountability for the installation to
>be allowed. Otherwise, just give up on the concept of Open-Source because
>corporate auditors will reject any request to use your project. You will never get
>into a PCI environment without a full set of commit comments, not just the Pull
>Requests.
>
>Granted my requirements come from regulated industries around the globe, and
>if you are making toys, so be it. My teams are making production-hardened
>applications.
>
>>In that sense, allowing people to create empty commit messages when
>>they shouldn't, is often "trapping" them into a commit history that is
>>less valuable (or even acceptable) than they might otherwise have achieved.
>>
>>While I therefore disagree with Aevar's proposal to "allow empty, and
>>advise", I do think the notion of giving advice makes perfect sense -
>>let's do it the other way around, with an advice message something
>>like:
>>
>>---
>>Empty commit messages aren't normally allowed, as they reduce the
>>understandability of the commit history. If you do need to create a
>>commit with an empty message, you can do so by providing the '--allow-empty-
>message'
>>argument to 'git commit'.
>>---
>>
>>Has this already been considered/discussed? Would it meet the
>>objectives of those folks saying "the rejection of empty messages
>>wasted my time", while also keeping the spirit of "we should make it
>>easy to do the right thing and harder to do the wrong thing, especially for
>beginners"?
>
>I am not personally going to be convinced of any of this - forgive me but, I think
>this reduces git's value and credibility as the leading SCM solution on the planet
>(and off) and see no justification for enabling comment-less repositories other
>than laziness. Even if that were the case, it is grounds for termination in my
>company and most of my customers to deliberately bypass audit practices, so if git
>moves forward with this, we might have to move elsewhere.

And I still don't get why the --allow-empty-message is not sufficient to meet your use case. git supports what is being requested already, not that it is allowed where I am. Are we talking about setting --allow-empty-message as the default? That is a major behavioural change. You could create a git command alias to always specify this option. So what is the point of this?

