Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529AE1F463
	for <e@80x24.org>; Sun, 15 Sep 2019 22:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfIOWSP (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 18:18:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55356 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfIOWSO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 18:18:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A79E488540;
        Sun, 15 Sep 2019 18:18:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CfLVgRWK03p75xay3nhw4LmIVT4=; b=T48RS5
        upjsrMypNbwaDFXDGaIRroIWJ+vUajgq9RKGvnKeeAMkhDuAstZAZVksJPc2IsC1
        EBO6Rnum2apSYEo7c+WnqlMpnwYp5Y3qChJA7JurkO6WDNqpPlEYz4JybEP7TrIb
        4oIQfq14AezSBpb+MxsNUJ6X2wckrU79x/cSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QKj+3cT01LcTNHM/v0Nrc2JVoHW7oyZy
        qhqk7rBRcsYXQKxOYv5ps94k9YPjZyaMmSM3sqgjAX1AkHBeG4kRKbY1ZYAF03VE
        qWoLhi2mnbugChE2iafqZNVpQmETvxYefZOL3zAvfzX9D6Nsvz4yRvGKnLaC3mds
        Hb36ghaR0GA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9ECBC8853F;
        Sun, 15 Sep 2019 18:18:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CB82C8853E;
        Sun, 15 Sep 2019 18:18:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] doc: provide guidance on user.name format
References: <20190914210219.753136-1-sandals@crustytoothpaste.net>
Date:   Sun, 15 Sep 2019 15:18:07 -0700
In-Reply-To: <20190914210219.753136-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 14 Sep 2019 21:02:19 +0000")
Message-ID: <xmqqtv9db3vk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3255F4E-D806-11E9-81A2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Users may or may not read the documentation, but at least we've done our
> best at providing them helpful information should they choose to do so.

Good.

>  Documentation/git-commit-tree.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
> index 4b90b9c12a..34a8496b0e 100644
> --- a/Documentation/git-commit-tree.txt
> +++ b/Documentation/git-commit-tree.txt
> @@ -92,6 +92,12 @@ if set:
>  
>  (nb "<", ">" and "\n"s are stripped)
>  
> +The author and committer names are by convention some form of a personal name,
> +as opposed to a username, although Git does not enforce or require any
> +particular form.

I have a lot of trouble with 'username' in the context of this
paragraph.

After all, you are describing the name appropriate to be set as the
value of the user.name configuration, and you are trying to stress
that the name used there is different from and has nothing to do
with the name machines use to identify the user.  In the paragraph
that follows this new paragraph, there is a reference to "system
user name", which is still not great but probably better than
"username" above.  Perhaps there is a term that is distinct enough
from "user name" that is commonly used I am forgetting?  I am almost
tempted to say "user id", but there must be even better phrases.  I
dunno.

> Arbitrary Unicode may be used, subject to the constraints
> +listed above. This name has no effect on authentication; for that, see the
> +`credential.username` variable in linkgit::git-config[1].
> +
>  In case (some of) these environment variables are not set, the information
>  is taken from the configuration items user.name and user.email, or, if not
>  present, the environment variable EMAIL, or, if that is not set,

Thanks.

