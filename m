Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B0A1F488
	for <e@80x24.org>; Wed,  8 May 2019 02:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEHCpj (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 22:45:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56750 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEHCpj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 22:45:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3967E14E995;
        Tue,  7 May 2019 22:45:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZzyCAxzu8AU8CHDhfIZveqAut60=; b=hHdsOV
        SkhNzJr6+4oDFmtjGm/J/9XpA7/LsZBJ3jLfRwLl/YaRMSu+lJ5bSgpxT36MYxrj
        ptbuptqkIkNSfVbMrhRNSWGZExZihe7wUqNerZ1MOeAr5fb0pvdV8AllObh89T5r
        1eJbsQcxIiMEQyC39jt4m/FUE3wGFyEmCfILw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=As2c4A7xwsV6/SPwOAPaIy3TALyNnVRJ
        Qk907IKQMzwKHFYaOdk/tcqdHQxtsa2vLtYeyZI9bQ1npGx9YE9ZwBIiuOzalp+i
        D+I2ygEkocUixu0UPyBppfXtbEqPOtt5Mv6pMfD2pnZzt2h3vL04zSB93oP/KQDP
        rvudDShoFCU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30AD614E994;
        Tue,  7 May 2019 22:45:32 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 895B514E993;
        Tue,  7 May 2019 22:45:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     emilyshaffer@google.com, git@vger.kernel.org,
        sunshine@sunshineco.com
Subject: Re: [PATCH v4] documentation: add tutorial for first contribution
References: <20190423193410.101803-1-emilyshaffer@google.com>
        <20190506222844.261788-1-jonathantanmy@google.com>
Date:   Wed, 08 May 2019 11:45:30 +0900
In-Reply-To: <20190506222844.261788-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 6 May 2019 15:28:44 -0700")
Message-ID: <xmqq5zqlk6k5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58A5DE22-713B-11E9-9CDA-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Sorry for not looking at this sooner. 
>
> Firstly, I'm not sure if this file should be named without the ".txt",
> like SubmittingPatches.

SubmittingPatches has historical baggage but this does not, so its
source can be left as .txt (alternatively we could have added .txt
to SubmittingPatches and left a symlink to keep the historical name,
without introducing "copy X to produce X.txt" rule).

cf. http://public-inbox.org/git/xmqqbm15kxi0.fsf@gitster-ct.c.googlers.com/

>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 26a2342bea..fddc3c3c95 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -74,6 +74,7 @@ API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technica
>>  SP_ARTICLES += $(API_DOCS)
>>  
>>  TECH_DOCS += SubmittingPatches
>> +TECH_DOCS += MyFirstContribution
>
> Any reason not to keep this alphabetized?

I do not think the order matters to $(MAKE), and I do not know if
the order matters to humans---sane ordering is done to futureproof
when we know we will have many more, but I do not know if we will.

So I find it a borderline Meh, but let's not waste your finding, as
sorting them in alpha order would be the sensible default.

>> +=== Pull the Git codebase
>> +
>> +Git is mirrored in a number of locations. https://git-scm.com/downloads
>> +suggests one of the best places to clone from is GitHub.
>> +
>> +----
>> +$ git clone https://github.com/git/git git
>> +----
>
> I would rename the header to "Clone the Git repository" instead, since
> "pull" has a specific meaning. Also, I think that "one of the best
> places" is unnecessary (I would just say "Clone the Git repository from
> one of its many mirrors, e.g.:"), but perhaps you want to leave it in
> there to maintain the informal tone.

I am guilty of the verbosity there---just did not want to give an
impression that that one is the single authoritative copy (the k.org
one is probably the one, if only that it is the one pushed to first
when a new development happens).  I personally feel that your
rephrasing is fine, too, and do not have strong preference between
the two.

>> +We'll also need to add the extern declaration of psuh; open up `builtin.h`,
>> +find the declaration for `cmd_push`, and add a new line for `psuh` immediately
>> +before it, in order to keep the declarations sorted:
>> +
>> +----
>> +extern int cmd_psuh(int argc, const char **argv, const char *prefix);
>> +----
>
> I was going to say to not include the "extern", but I see that builtin.h
> has them already, so it's probably better to leave it there for
> consistency.

Yup, this was discussed before.  If we can have the "NEEDSWORK" in
the asciidoc source that is not rendered in the end result, it may
be worth leaving a note to say when we remove them from builtin.h we
need to update this example, or something like that.

>> +----
>> +$ git send-email --to=target@example.com
>> +----
>
> Hmm...don't you need to specify a directory?

Even better would be the directory/*.patch glob pattern, as we'll
show how to emit format-patch output for v2 into the same directory
in a later step.  Just giving the directory and letting readdir()
collect would work for v1 but not for later iterations.

>> +Your Message-Id is `<foo.12345.author@example.com>`. This example will be used
>> +below as well; make sure to replace it with the correct Message-Id for your
>> +**previous cover letter** - that is, if you're sending v2, use the Message-Id
>> +from v1; if you're sending v3, use the Message-Id from v2.
>
> I think it's better to describe the message ID as without the angle
> brackets. Reading the RFC (https://tools.ietf.org/html/rfc2392), the
> message-id doesn't have them.

See earlier review(s).
Your reading is probably wrong, as that directly contradicts my
earlier suggestion based on the same RFC ;-)

>> +----
>> +$ git send-email --to=target@example.com
>> +		 --in-reply-to=<foo.12345.author@example.com>
>> +----
>
> The angle brackets can be omitted. Also, directory (or glob expression
> in this case)?

Yeah, a glob would be appropriate.

>> +=== Bonus Chapter: One-Patch Changes
>
> This is not truly a bonus - the mailing list prefers this if the patch
> set contains only one patch.
>
>> +In some cases, your very small change may consist of only one patch. When that
>> +happens, you only need to send one email. Your commit message should already be
>> +meaningful and explain the at a high level the purpose (what is happening and
>> +why) of your patch, but if you need to supply even more context, you can do so
>> +below the `---` in your patch. Take the example below, generated with
>> +`git format-patch` on a single commit:
>
> It's not clear to me how `git format-patch` can generate the extra
> paragraph below. The user would either have to include "---" in the
> commit message (in which case there would be an extra "---" below the
> extra paragraph, which is perfectly safe) or edit the email *after*
> `git-format-patch` has generated the email.

Yes, I think the editions after v2 of this series has consistently
encouraged users to edit format-patch output in a separate editor
session (be it 0/n cover letter, or 1/1 single patch) before sending
it out, discouraging use of --compose in send-email or driving
format-patch from within a send-email session.

And the following example just shows how the finished result of such
an editing session would look like.

> The other meta-concern is maintaining the informal tone when we update
> this document (for example, when we add features like range-diff which
> can be used when sending v2 - well, somebody can add information about
> that to this document once it has been merged); but I don't think that
> is a concern in practice (either we keep the tone or there is a slight
> tone mismatch, and I don't think that either is a big deal).

I am OK as long as those who care about maintaining coherent tone
pay attention to changes proposed to this document in the future ;-)

Thanks for comments.  Let's finish this topic and merge it down
soonish.
