Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2FCC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 11:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbiDKLiE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 11 Apr 2022 07:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345956AbiDKLhh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 07:37:37 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674F1AF31
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 04:35:23 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23BBZBke081199
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Apr 2022 07:35:11 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'demerphq'" <demerphq@gmail.com>
Cc:     "'Tao Klerks'" <tao@klerks.biz>,
        "=?utf-8?Q?'Michal_Such=C3=A1nek'?=" <msuchanek@suse.de>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <jurgen_gjoncari@icloud.com>, "'Git'" <git@vger.kernel.org>
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com> <YlC3devsgmv17PnQ@camp.crustytoothpaste.net> <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com> <20220409113244.GX163591@kunlun.suse.cz> <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com> <013101d84ceb$afaa51b0$0efef510$@nexbridge.com> <CANgJU+UPOOiDiErtht3T3GEhU+6HbkouZ4NUqPdk4o7X03kwpQ@mail.gmail.com>
In-Reply-To: <CANgJU+UPOOiDiErtht3T3GEhU+6HbkouZ4NUqPdk4o7X03kwpQ@mail.gmail.com>
Subject: RE: Make commit messages optional
Date:   Mon, 11 Apr 2022 07:35:06 -0400
Organization: Nexbridge Inc.
Message-ID: <016701d84d98$350000b0$9f000210$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ+1NMvkwKGNzc/71+8xIhD/VDquAGOScQnAanmRncBUJW1cAIoo/mqAbvFKEcBUS5usatPkohQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 11, 2022 5:05 AM, demerphq wrote:
>On Mon, 11 Apr 2022 at 09:27, <rsbecker@nexbridge.com> wrote:
>>
>> On April 10, 2022 10:00 AM, Tao Klerks wrote:
>> >To: Michal Suchánek <msuchanek@suse.de>
>> >Cc: rsbecker@nexbridge.com; brian m. carlson
>> ><sandals@crustytoothpaste.net>; jurgen_gjoncari@icloud.com;
>> >git@vger.kernel.org
>> >Subject: Re: Make commit messages optional
>> >
>> >On Sat, Apr 9, 2022 at 1:32 PM Michal Suchánek <msuchanek@suse.de> wrote:
>> >>
>> >> On Fri, Apr 08, 2022 at 07:32:03PM -0400, rsbecker@nexbridge.com wrote:
>> >> > On April 8, 2022 6:30 PM, brian m. carlson wrote:
>> >> > >On 2022-04-08 at 03:35:04, jurgen_gjoncari@icloud.com wrote:
>> >> > >> I think that often commit messages are unnecessary. I propose
>> >> > >> that by default a user should be able to commit without a message.
>> >[...]
>> >> > >We want to encourage good software engineering practices.
>> >> > >
>> >[...]
>> >> > >
>> >> > >Users who want this behaviour can use --allow-empty-message or
>> >> > >create an alias with that option.  The functionality already
>> >> > >exists.  I use aliases extensively in my development and I know
>> >> > >others do as well, so this shouldn't be an impediment if you're
>> >> > >working on
>> >projects where this is acceptable.
>> >> > >
>> >[...]
>> >>
>> >> There is nothing stopping you using '.' as the commit message which
>> >> is as informative as when it is empty. Hence this enforcement of
>> >> non-empty commit message does not serve the stated purpose.
>> >
>> >My apologies if this proposal has already been made in this or prior
>> >discussions - the list server and gmail are having another
>> >disagreement, so I think I'm a few hours out of date.
>> >
>> >I believe the main argument *for* allowing empty commit messages by
>> >default is "we shouldn't make it hard to do what you want to do, if
>> >you can fix it later", and the main argument *against* is "for most
>> >people (non-advanced users), what you do initially is what you end up
>> >pushing, or at least trying to push, and fixing things later is
>> >*hard*
>> >- it requires a much deeper understanding of git than most people
>> >otherwise necessarily need to develop".
>>
>> Adding commit messages has been part of SCM systems since virtually the
>beginning, at least on UNIX in the early 1970 and likely before. Adding a simple
>commit message is not onerous or difficult. "Fixing it later" will require the commit
>and any signature you put on at the time is lost. You also invalidate any signatures
>more recent in history. This does not corrupt your repo, but it does reduce its
>value. If you insist on doing this, use a single non-breaking space symbol in the -m
>option, which you can script or alias. Note that none of that will work on any git
>clients anyway.
>>
>> The main argument against is that this violates the basic principles of a well
>managed DevSecOps environment that requires who, what, where, when, why
>for every change, not just the ones you publish. The key point here of having
>comments in commits is that it allows organizations to pull in projects like OpenSSL
>that ends up in production and must have the accountability for the installation to
>be allowed. Otherwise, just give up on the concept of Open-Source because
>corporate auditors will reject any request to use your project. You will never get
>into a PCI environment without a full set of commit comments, not just the Pull
>Requests.
>>
>> Granted my requirements come from regulated industries around the globe,
>and if you are making toys, so be it. My teams are making production-hardened
>applications.
>
>First off, git already allows empty commit messages. If you aren't already
>validating the commits that are being pushed to your central repo then you are
>already allowing commits with no commit message.
>Have your auditors noticed or complained?
>
>Second, I think you really did not understand Avar's point. Let me try to restate it
>in simple terms.
>
>One of the things that separates git from most other SCM's, especially legacy
>SCM's, is that it separates the act of creating a commit and that of pushing it to the
>upstream repo.
>
>Advanced git users make very heavy use of git rebase --interactive and similar
>tools to modify, reorder, reword, merge, split, and otherwise munge the commits
>they have created *locally* before they push them upstream.
>
>What Avar is saying is that there really is no reason to require a commit message
>*locally* when a user is likely to be doing such activities. Instead what should
>happen is that the upstream should be taught to refuse commits pushed to it
>which do not comply with whatever audit rules you wish to enforce.
>
>For instance, your audit rules could require that every commit includes verbiage
>like "I understand that I am responsible for the content of this commit, I
>understand the rules which this commit must comply with, and that I will be held
>accountable for any deviations from those rules."  Would there be any point in
>enforcing this locally on commits which are intended to be thrown away and
>squashed before they are sent? I would say no, for a bunch of reasons, not least
>being that preventative controls cannot be relied on in an uncontrolled
>environment like someone's laptop, and if you weren't *also* validating those
>rules upstream then your protections would be as secure as using client side JS to
>validate entry to a web-form - that is not secure *at all*.
>
>The only way to be really sure that no commits end up in your master repository
>that do not comply with your rules is to validate the rules on push to the master
>repository, and to reject any attempt to push commits which do not comply.
>
>I often create dozens of tiny commits with the words "WIP" (work in progress),
>which I then later reorder, and then squash together into a nice logical and well
>explained series of commits, at which time I give them nice detailed commit
>messages. Requiring me to type 'WIP"
>every time is really unnecessary and not particularly helpful to anyone. I dont use -
>-allow-empty-mesage because -m'WIP' is less to type than --allow-empty-
>message, but that is besides the point 'WIP'
>is not an acceptable commit message to an auditor and should not be merged.
>
>> >In that sense, allowing people to create empty commit messages when
>> >they shouldn't, is often "trapping" them into a commit history that
>> >is less valuable (or even acceptable) than they might otherwise have achieved.
>> >
>> >While I therefore disagree with Aevar's proposal to "allow empty, and
>> >advise", I do think the notion of giving advice makes perfect sense -
>> >let's do it the other way around, with an advice message something
>> >like:
>> >
>> >---
>> >Empty commit messages aren't normally allowed, as they reduce the
>> >understandability of the commit history. If you do need to create a
>> >commit with an empty message, you can do so by providing the '--allow-
>empty-message'
>> >argument to 'git commit'.
>> >---
>> >
>> >Has this already been considered/discussed? Would it meet the
>> >objectives of those folks saying "the rejection of empty messages
>> >wasted my time", while also keeping the spirit of "we should make it
>> >easy to do the right thing and harder to do the wrong thing, especially for
>beginners"?
>>
>
>> I am not personally going to be convinced of any of this - forgive me but, I think
>this reduces git's value and credibility as the leading SCM solution on the planet
>(and off) and see no justification for enabling comment-less repositories other
>than laziness. Even if that were the case, it is grounds for termination in my
>company and most of my customers to deliberately bypass audit practices, so if git
>moves forward with this, we might have to move elsewhere.
>
>With respect I dont think you actually understand how the audit process works; a
>developers laptop is not a controlled environment which is trustable by an auditor.
>As has already been stated by several posters git *already* allows empty commits
>messages, and if you are not implementing controls in your master repository that
>all pushed commits to controlled branches comply with your rules then you
>*already* have a vector to allow such commits into your master repository and
>you are probably not in compliance with your auditors requirements.
>
>Preventive controls can *only* be effective and relied on when executed inside of
>a completely controlled context. A dev's local working context is NOT a completely
>controlled context. Think about it, they have a compiler on hand, they can do
>anything their skills allow them to do. Even if git did not *already* allow empty
>messages a suitably skilled dev could always hack git to allow them. If you did not
>have preventive controls upstream at the master repo you are using for audit
>controls then whatever policy might be baked into the current git client is moot.
>Someone could hand roll a commit that violated them and send them using
>something other than git. This is all just software after all.
>
>If you are concerned about the audit practices that your company needs to comply
>with then you should be looking at server-side hooks (pre-receive hooks) in your
>master repository, not client side rules in the git executable your devs use, those
>rules are ineffective and ultimately should be deemed unreliable by any
>competent auditor.
>
>Note that most auditors do *not* require every control to be preventive, they
>strongly prefer preventive controls for obvious reasons, but they also understand
>that not every rule can be implemented as a preventive control, so they also allow
>*detective* controls, eg, a daily report showing that all commits in the master
>repo comply with their requirements. You may be able to work with your auditor
>to implement detective controls instead. However, given that git absolutely does
>have the ability to implement upstream preventive controls it seems that you
>should focus your concerns there.
>
>BTW, I am saying this as someone who has had extensive experience working with
>auditors on git controls for many years. Nothing you do client side is relevant to
>the auditor and if it is you should hire a new auditor yours is not competent. If you
>dont verify things in a controlled environment then you haven't controlled things
>at all.
>
>Consider if one of your devs writes a commit with an empty message and that
>commit is never pushed upstream have they broken a rule? I bet not. Consider a
>common audit policy of requiring "two head approval", eg two people need to
>approve that a commit is reasonable to be merged. In corporate context most
>auditors will consider the author of the commit to be one, head, but usually some
>upstream tool, say github or gitlab, is responsible for managing the approval
>process for the second head. Since every commit created locally cannot have two
>approvers at its time of creation this means that every commit is created in
>violation of the audit rules.  But auditors don't have any concern with this because
>they know that the real concern is ensuring a robust controls process is applied
>before that commit can be pushed upstream and merged into the central
>repository.
>
>So with respect, I think you really don't understand how the audit process works
>and you really haven't thought through your concern.
>Whatever happens locally on the developers box is immaterial to the auditor, they
>only care about the upstream master repo. Heck they might not even care about
>that and only care about the commits that are actually compiled or deployed to a
>production environment. So you could have your preventive controls in the build
>stage and not in the SCM at all. But most companies would prefer to implement
>such controls relatively close to the person/subject being controlled and would
>prefer to see proper well implemented and strong preventive controls in your
>master repo's pre-receive hooks.

I am going to bow out of this conversion since it has become personal and attacks my credibility in a manner that is offensive. You are obviously entitled to have your opinion but I would appreciate if you would keep this on the facts and use cases instead of saying of going with an ad hominem approach to the discussion that I do not understand this or that so my argument must be wrong. My experience is my own and you do not know me or what I do or with whom I work. Thank you for your critique.
--Randall

