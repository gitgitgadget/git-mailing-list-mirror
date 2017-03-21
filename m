Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 744962095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbdCUSEW (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:04:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51540 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757267AbdCUSDo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:03:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6EA96E719;
        Tue, 21 Mar 2017 13:58:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RoJt9ykcFmqf
        J6U7NsIN3agjp4o=; b=Fgu5hjiIra0kSKfQxamJuGNknTIotNNY1PVb+diO4kVO
        2nBmN016ieWRNqnFskaacPBt+eAFD8sxDv7A+nN8ggToKQhleqmcLBawxEPeiM8J
        swJmc+xOoE6CneYlFY9H95/4uVM307b7if0DFw+fLlrpV+szpJ38TAt9Gwp8FO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KZNI7+
        2p0OaffByx7tVnBz2jBD5hbCddMA1qQ+daKyFh6w8w7AC4lVfXdNo5BhPxSV+SCp
        zHmlFlte0oozHjt4sRFs8irCQowl0YqYdCW9qDgrg2RoUlPBL5ZvuAjXZk1oaMx+
        AYJERHweFTYrcJsm8FqyphWasxLXVWXX69Uk0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF4CB6E718;
        Tue, 21 Mar 2017 13:58:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 582606E717;
        Tue, 21 Mar 2017 13:58:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] doc/SubmittingPatches: show how to get a CLI commit summary
References: <20170321155153.20753-1-szeder.dev@gmail.com>
Date:   Tue, 21 Mar 2017 10:58:56 -0700
In-Reply-To: <20170321155153.20753-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 21 Mar 2017 16:51:53 +0100")
Message-ID: <xmqqvar2qzof.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0E10C3BC-0E60-11E7-8E05-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>>  The "Copy commit summary" command of gitk can be used to obtain this
>> -format.
>> +format, or this invocation of "git show":
>> =20
>> +    git show -s --date=3Dshort --pretty=3D'format:%h ("%s", %ad)' <co=
mmit>
>> +
>> +To turn that into a handy alias:
>> +
>> +    git config --global alias.git-commit-summary "show -s --date=3Dsh=
ort --pretty=3D'format:%h (\"%s\", %ad)'"
>> +
>> +And then to get the commit summary:
>> +
>> +    git git-commit-summary <commit>
>
> - 'tformat:' is a better fit than 'format:' in this case, because it
>   adds a trailing newline.

That depends on what you use it for.  I most often use mine to
insert the reference that flows in a sentence, not as a separate
displayed material, e.g.

    1f6b1afe ("Git 2.12.1", 2017-03-20)

so for that purpose, not adding a trailing newline is a feature.

> - I find that the two subsequent 'git's in 'git git-<whatever>' look
>   strange.  However, to make this point moot right away:
>
> - I don't think SubmittingPatches is the right place to show how to
>   create and use a command alias.

These two I do agree with.
