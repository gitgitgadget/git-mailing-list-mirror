Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E48207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 17:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbcJFRqz (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 13:46:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50660 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751476AbcJFRqy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 13:46:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3058743F84;
        Thu,  6 Oct 2016 13:46:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ToyBUmO7Vg8weHnKABsK2HDY0hk=; b=DhVCk0
        KTh6kYahaR8jUfLJ88WD9MUWvAoWKZ4LbzA0uL2HJYqH4aYA14n5LaA+7cLgtsue
        pgJm1uVixEAIbMRMRfJjyNxC6brCn78IUyHkxFwJ8GlE2lkPkXuYGJBM5ulVc0rU
        5G1Y1R5utpbtzmA9Tnvc0nvaPxDZRfHTi+kxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rwv0GAu8sgR41P9potd2NnC/MRiA3pXN
        NtTJ5blol3HxVVW8B2UHknaoddR5BXqByOn1tl1iFwKvOZO2pq3vvUpJT8ctVE78
        6V5P1TIcE2voyqmUAXjl4w+7FYDFnju56+12SUCoNBKzBbKBHE8xr+QBPoms16ED
        p7uevZAuue8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05F5C43F83;
        Thu,  6 Oct 2016 13:46:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 659B843F82;
        Thu,  6 Oct 2016 13:46:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] Documentation/git-merge.txt: improve short description in DESCRIPTION
References: <cover.1475678515.git.sorganov@gmail.com>
        <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
        <xmqq60p6pt4k.fsf@gitster.mtv.corp.google.com>
        <871szuqyjo.fsf@javad.com>
        <xmqqa8eio4n9.fsf@gitster.mtv.corp.google.com>
        <87mvihpsla.fsf@javad.com>
Date:   Thu, 06 Oct 2016 10:46:50 -0700
In-Reply-To: <87mvihpsla.fsf@javad.com> (Sergey Organov's message of "Thu, 06
        Oct 2016 15:30:57 +0300")
Message-ID: <xmqqshs9l69h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD649B4E-8BEC-11E6-AC79-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>>> Last, if "reference" is not good enough and we get to internals anyway,
>>> why not say SHA1 then?
>>
>> Because that is still colloquial? I think s/name/object name/ is a
>> sensible change, but not s/name/reference/.
>
> No, "reference" is more sensible here than any of "name", "object name",
> or "SHA-1", the same way as here:
>
> $ git help glossary
> [...]
> chain
>         A list of objects, where each object in the list contains a
>         reference to its successor (for example, the successor of a
>         commit could be one of its parents).
> [...]

The entry for "chain" and the description under discussion have
stress on different aspect, though.  The description of "chain" is
more general: an object refers to another object by referring to it,
by unspecified means.  The reason why it is left unspecified is
because the way a tree object refers to blobs and trees is different
from the way a commit object refers to its parents (the former has
object names of blobs and trees in the tree entries; the latter uses
"parent" entries in the object header part to record object names of
parent commits).  It wants to stress more on the fact that there is
some mechanism to associate one object to others, than how that
association/linkage is expressed.

The way the resulting commit is described in the original text of
"git merge" description stresses more on "how" by being a lot more
specific to commit objects.  It does not just say "refers to parents
(by unspecified means)"; instead it tries to say what exactly are
recorded, i.e. the parents are referred to by recording the object
names of them in a new commit object.  It stresses more on "how"
(because it can afford to be more specific, unlike the description
of more general concept of a "chain").

It may be debatable if we want to give the description of what is
exactly recorded at that point of the document, but I personally
think that the users deserve a chance to learn how a merge is
recorded in "git merge" documentation.


