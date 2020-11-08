Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7792C388F9
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 17:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1DA206DC
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 17:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgKHRXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 12:23:35 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:53583 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHRXf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 12:23:35 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kboPa-0008b6-7H; Sun, 08 Nov 2020 17:23:30 +0000
Subject: Re: Extending and updating gitglossary (was: Re: [PATCH v4 06/10]
 commit-graph: implement corrected commit date)
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
 <85r1pjzejg.fsf@gmail.com> <20201103114432.GA3577@Abhishek-Arch>
 <85pn4tnk8u.fsf@gmail.com> <efa3488a-3983-3435-e5e4-2eb71e76a33a@iee.email>
 <xmqqtuu3k6jf.fsf@gitster.c.googlers.com> <85zh3ujq9c.fsf_-_@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <8d43335d-a0b4-511e-f132-057343234503@iee.email>
Date:   Sun, 8 Nov 2020 17:23:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <85zh3ujq9c.fsf_-_@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,

On 06/11/2020 18:26, Jakub Narębski wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>> This may be not part of the the main project, but could you consider, if
>>> time permits, also adding some entries into the Git Glossary (`git help
>>> glossary`) for the various terms we are using here and elsewhere, e.g.
>>> 'topological levels', 'generation number', 'corrected commit date' (and
>>> its fancy technical name for the use of date heuristics e.g. the
>>> 'chronological ordering';).
>>>
>>> The glossary can provide a reference, once the issues are resolved. The
>>> History Simplification and Commit Ordering section of git-log maybe a
>>> useful guide to some of the terms that would link to the glossary.
>> Ah, I first thought that Documentation/rev-list-options.txt (which
>> is the relevant part of "git log" documentation you mention here)
>> already have references to deep technical terms explained in the
>> glossary and you are suggesting Abhishek to mimic the arrangement by
>> adding new and agreed-upon terms to the glossary and referring to
>> them from the commit-graph documentation updated by this series.
>>
>> But sadly that is not the case.  What you are saying is that you
>> noticed that rev-list-options.txt needs a similar "the terms we use
>> to explain these two sections should be defined and explained in the
>> glossary (if they are not) and new references to glossary should be
>> added there" update.
>>
>> In any case, that is a very good suggestion.  I agree that updating
>> "git log" doc may be outside the scope of Abhishek's theme, but it
>> would be very good to have such an update by anybody ;-)
> The only possible problem I see with this suggestion is that some of
> those terms (like 'topological levels' and 'corrected commit date') are
> technical terms that should be not of concern for Git user, only for
> developers working on Git.  (However one could encounter the term
> "generation number" in `git commit-graph verify` output.)
However we do mention "topolog*"  in a number of the manual pages, and
rather less, as yet, in the technical pages.

"Lexicographic" and "chronological" are in the same group of fancy
technical words ;-)

>
> I don't think adding technical terms that the user won't encounter in
> the documentation or among messages that Git outputs would be not a good
> idea.  It could confuse users, rather than help them.
>
> Conversely, perhaps we should add Documentation/technical/glossary.txt
> to help developers.

I would agree that the Glossary probably ought to be split into the
primary, secondary and background terms so that the core concepts are
separated from the academic/developer style terms.

Git does rip up most of what folks think about version "control",
usually based on the imperfect replication of physical artefacts.
>
> P.S. By the way, when looking at Documentation/glossary-content.txt, I
> have noticed few obsolescent entries, like "Git archive", few that have
> description that soon could be or is obsolete and would need updating,
> like "master" (when default branch switch to "main"), or "object
> identifier" and "SHA-1" (when Git switches away from SHA-1 as hash
> function).
The obsolescent items can be updated. I'm expecting that the 'main' and
'SHA-' changes will eventually be picked up as part of the respective
patch series, hopefully as part of the global replacements.

--
Philip
