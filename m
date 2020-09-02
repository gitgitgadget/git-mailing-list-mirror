Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AD0C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A431204FD
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LBrXLFOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgIBSKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:10:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63513 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgIBSKi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 14:10:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D7DFD9481;
        Wed,  2 Sep 2020 14:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xkHnWUZKOOXa9jVqXgDphvhO/vg=; b=LBrXLF
        OJMHsO4Nw7yU8hsdlEmDznnO3qjaMJYU5a2sZng5gdGu249ZDgLh4JR8ziZmpIOJ
        fMkUw+RnniUWTGDCBsBuvrF1lzhMMGi59GXYZ5cWQlexE2qrmV8w0KduWtzbPZFc
        Drurt18ZdTrRUBDD1U8CkJOgp1YORretkvD8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IxCMXi37lgABz+vGME/CylqKC54iCyY2
        j6XBn7Xqkyq8dkXcXKTXD9Pi7oCVh9fmKIRU6IKIlVsOywrwT2GpcqtXEufTK841
        N4c5SboJGO2ORReCnh5AmobV2FP2hiwOqVQtDZGLzeHXxjQdLewoxXCq5iKNXFts
        /8DSCWqsw4M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66238D9480;
        Wed,  2 Sep 2020 14:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72F6DD947D;
        Wed,  2 Sep 2020 14:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2020, #01; Tue, 1)
References: <xmqqblipchk6.fsf@gitster.c.googlers.com>
        <CAPig+cTUhLoPvs+ygnc0Y4Ez3M3tfGncPzON0ejb=xEOMBixHQ@mail.gmail.com>
        <xmqq7dtcceka.fsf@gitster.c.googlers.com>
        <CAPig+cTGspJAGxRu+vqdko1ntkBonVaoStYde3+P5UxPxrCs7g@mail.gmail.com>
Date:   Wed, 02 Sep 2020 11:10:29 -0700
In-Reply-To: <CAPig+cTGspJAGxRu+vqdko1ntkBonVaoStYde3+P5UxPxrCs7g@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 2 Sep 2020 12:58:50 -0400")
Message-ID: <xmqqwo1caw2y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96B11EC8-ED47-11EA-A945-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 2, 2020 at 12:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > I wonder if this could be reworded so it's clearer that "git worktree
>> > repair" is a new command, and to mention fixes to "git init
>> > --separate-git-dir". Perhaps like this?
>> >
>> >     "git worktree" gained a "repair" subcommand to help users recover
>> >     from problems arising from factors outside of Git's control.
>> >     Also, "git init --separate-git-dir" no longer corrupts
>> >     administrative data related to linked worktrees.
>>
>> OK that reads much better.
>>
>> -from problems arising from factors outside of Git's control.
>> +after moving the worktrees manually without telling Git.
>>
>> The latter is slightly shorter; does the "repair" help situations
>> other than that, or is the above cover all the "factors outside" out
>> control?
>
> The current implementation also helps out when the main worktree (or
> bare repository) is moved.

That is why I wrote "secondary worktrees" initially and then dropped
"secondary" from the description ;-)

> However, in the "git worktree repair" documentation, I intentionally
> avoided nailing down precisely the problems it repairs, instead
> leaving it open-ended since it may learn more repairs in the future.
> (The documentation is careful to say that it repairs "administrative
> files", and then talks about the currently-implemented repairs as
> _examples_ of what it might repair, without locking it into only those
> repairs.)
>
> I think the same generality of description can apply to the blurb
> here, as well. We don't necessarily need to give precise detail in
> this blurb -- the reader can learn the details by consulting the
> documentation.

Well given that the primary reason why I add these blub in What's
cooking is to draft the release notes for upcoming release, my
preference is to give "we help these cases" than giving overly large
promises to our users.

So...
