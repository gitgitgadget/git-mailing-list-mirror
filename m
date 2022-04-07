Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF9FC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 16:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbiDGQpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiDGQpa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 12:45:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2729D1AFE8D
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 09:43:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96391134FB7;
        Thu,  7 Apr 2022 12:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gsOrzej6bqaI
        u5FEjk1S70EnmmgZhz7yy8xdL5xRln8=; b=A4DKNhBRoe0i+45XaJVIOF1Vn3bu
        61/z9z+JdAteJDOShA1LvDVaUoh36Zgb2NQrHUP9jX7f27E2LBcxwb29efL+mm+P
        hxCo2a7tJC0RmNy5lDq5JlFuP8w3LVNUazskwxvWL7c8RdbXO6qYanoNu1qqaOC7
        FOq5r8FhsjiAdWA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DF8A134FB6;
        Thu,  7 Apr 2022 12:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACBE5134FB5;
        Thu,  7 Apr 2022 12:43:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        COGONI Guillaume <cogoni.guillaume@gmail.com>,
        Matthieu.Moy@univ-lyon1.fr, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] contrib/vscode/: debugging with VS Code and gdb
References: <xmqqbkxex8oy.fsf@gitster.g>
        <20220406233946.45778-1-cogoni.guillaume@gmail.com>
        <20220406233946.45778-2-cogoni.guillaume@gmail.com>
        <220407.86tub5ce3m.gmgdl@evledraar.gmail.com>
        <ea70aed6-7111-0795-f6d8-15deb505b1c0@github.com>
Date:   Thu, 07 Apr 2022 09:43:24 -0700
In-Reply-To: <ea70aed6-7111-0795-f6d8-15deb505b1c0@github.com> (Derrick
        Stolee's message of "Thu, 7 Apr 2022 09:09:23 -0400")
Message-ID: <xmqqmtgwu9n7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D84FBE6A-B691-11EC-A261-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Sometimes, we need to meet people where they are. If they choose to
> use a proprietary editor, we can help them use that to work on our
> project.

Yes, that's a good point to make.  I found that the thrust of the
suggestion made in the last part of =C3=86var's message was "if you are
user of VSCode, what we have in contrib/ may help your use of
debuggers in it", which was in line with the above.

>> Leaving aside completely *where* we should put such a thing I'd expect
>> something much more like:
>> =09
>> 	BEGIN QUOTE
>> =09
>> 	=3D=3D Using debuggers =3D=3D
> ...
>> 	=3D=3D=3D GUIs =3D=3D=3D
> ...
>
> I was trying to make a similar recommendation in my review. The point i=
s
> not "You should use a debugger, here is VS Code", but rather ...

Yup, I guess that makes three of us?

> I think that we might want a new file where Git developers can
> share best practices and custom workflows. Such a document could
> help contributors optimize their process to their own tastes based
> on the experience of others. I can see a long list of integrations
> with editors fitting in there, along with tips like "create a RAM
> disk for running tests".
>
> My proposed name for such a file is "WorkingOnGit" but it's not
> fantastic. Suggestions welcome.

Sounds like a good thing to have, but would there truly be hints and
tips so specific to this project, I have to wonder.  I do not think
we are in the business of making "how to hack on and debug a project
code that is mostly written in C and whose history is managed in
Git" tutorial for each IDE, so I am not sure how well it would fly
(not opposed to, but skeptical).

> Cogoni: In conclusion, I think that if you remove the change to
> MyFirstContribution.txt, then your patch can be merged pretty
> quickly (probably, that's not my decision). I expect this discussion
> about a potential "WorkingOnGit" file to continue, but if it comes
> to fruition, your section on VS Code would be welcome.

Yeah, the change to that document did feel like it was working at a
different level from other changes.

Thanks.
