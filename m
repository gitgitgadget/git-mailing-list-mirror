Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4AA1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 17:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbdKJRmr (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 12:42:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54789 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752625AbdKJRmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 12:42:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BEFE9DF8D;
        Fri, 10 Nov 2017 12:42:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+AJLkuoFer20
        7076Uxbc9Trs8a4=; b=XKEnGFuoZ7iaoqMcj3md1F4lKjHNSZd08WcFjxxJMSxu
        66iYuUzi6GqYg87RUUwZ87RSjA6No98oGZKcxWTMyNGkGDa3HqioPsKUASLQiIW/
        yKptdk/PMoLxbqQ31DEl5FRb+jgNEuVMRWoNjQaL0z7ys8S7w1XmcDCqze3FvWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VHwZe2
        2Wz2mw5IN+xD2+8OwcVVL1qwA7P0WxRVXrpsfRZsj+xyYqkAmDdIWU4X8FS7rNR6
        yL2qMeyRd60YchQ2uElphyR+eYcloHvQRG9+YitbPi7g+6CS7jXPW3Un7beFXCku
        Eq352EWo5BFGAhbzOqNkL42CG3tdEswhhyJyM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01E009DF8C;
        Fri, 10 Nov 2017 12:42:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34C109DF89;
        Fri, 10 Nov 2017 12:42:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org,
        me@ikke.info, hjemli@gmail.com, mhagger@alum.mit.edu,
        pclouds@gmail.com, ilari.liusvaara@elisanet.fi
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
References: <20171104004144.5975-1-rafa.almas@gmail.com>
        <20171104004144.5975-3-rafa.almas@gmail.com>
        <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
        <B24042DB-BB27-41DE-82B7-5F3ED502D7D0@gmail.com>
        <xmqqbmkfhrf3.fsf@gitster.mtv.corp.google.com>
        <89e7f8e0-8b0d-fde0-5e28-31173213a26e@gmail.com>
Date:   Sat, 11 Nov 2017 02:42:43 +0900
In-Reply-To: <89e7f8e0-8b0d-fde0-5e28-31173213a26e@gmail.com> ("Rafael
        =?utf-8?Q?Ascens=C3=A3o=22's?= message of "Fri, 10 Nov 2017 13:38:48
 +0000")
Message-ID: <xmqqo9oaf2ss.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8F4E95EE-C63E-11E7-978D-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:

> I agree that describe should receive the "normalize" treatment. However=
,
> and following the same reasoning, why should describe users adopt the
> rules imposed by --glob? I could argue they're also used to the way it
> works now.
>
> That being said, the suggestion I mentioned earlier would allow to keep
> both current behaviors consistent at the expense of the extra call to
> refs.c::ref_exists().

In any case, updating the "describe" for consistency is something we
can and should leave for later, to be done as a separate topic.

While I agree with you that the consistent behaviour between
commands is desirable, and also I agree with you that given a
pattern $X that does not have any glob char, trying to match $X when
a ref whose name exactly is $X exists and trying to match $X/*
otherwise would give us a consistent semantics without hurting any
existing uses, I do not think you need to pay any extra expense of
calling ref_exists() at all to achieve that.

That is because when $X exists, you already know $X/otherthing does
not exist.  And when $X does not exist, $X/otherthing might.  So a
naive implementation would be just to add two patterns $X and $X/*
to the filter list and be done with it.  If you exactly have
refs/heads/master, even with the naive logic may throw both
refs/heads/master and refs/heads/master/* to the filter list,
nothing will match the latter to contaminate your result (and vice
versa).

A bit more clever implementation "just throw in two items" would go
like this.  It is not all that involved:

 - In load_ref_decorations(), before running add_ref_decoration for
   each ref and head ref, iterate over the elements in the refname
   filter list.  For each element:

   - if item->string has a trailing '/', trim that.

   - store NULL in the item->util field for item whose string field
     has a glob char.

   - store something non-NULL (e.g. item->string) for item whose
     string field does not have a glob char.

 - In add_ref_decoration(), where your previous round iterates over
   filter->{include,exclude}, get rid of normalize_glob_ref() and
   use of real_pattern.  Instead do something like:

	matched =3D 0;
	if (item->util =3D=3D NULL) {
		if (!wildmatch(item->string, refname, 0))
                	matched =3D 1;
	} else {
		const char *rest;
		if (skip_prefix(refname, item->string, &rest) &&
                    (!*rest || *rest =3D=3D '/'))
			matched =3D 1;
	}
	if (matched)
		...

   Of course, you would probably want to encapsulate the logic to
   set matched =3D 1/0 in a helper function, e.g.

	static int match_ref_pattern(const char *refname,
				     const struct string_list_item *item) {
		int matched =3D 0;
		... do either wildmatch or head match with tail validation
		... depending on the item->util's NULLness (see above)
		return matched;
	}

   and call that from the two loops for exclude and include list.

Hmm?
