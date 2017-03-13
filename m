Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31F9202C1
	for <e@80x24.org>; Mon, 13 Mar 2017 00:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbdCMABZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 20:01:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54089 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751334AbdCMABY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 20:01:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A93B6E22D;
        Sun, 12 Mar 2017 20:01:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lkWxWHsTC/n/
        SgTHXftv5SgAHtI=; b=LlQSJKZNuB6y9DQf18pxS1bLGUUONZuD8oAwCAouDUP9
        oN3ULCxSS3qzAmWh10cjO2iPx36lP8ridf4QAxi0/BdL94Jom9Q6PF7RVe2eDYOG
        PLyEUjDB0y3vc/PWUb8fCUxLNSI5T9pR1OddmNGXoYjQzq73HQ0KJVkFgxZ7Jyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RKxCtc
        SNNpLO5A+GI864OWQ6VsRmoi2V67IGCFja1JJUgLJmzg9tOhKCfXoOM1JuBeLsnG
        bbYkpbWhq9Y/207d7fojYbugDxAsjBVWCemjdtZ1UhcObh9T+cib8q5F5ydMtOSb
        H/FA9kK0FhPZ5Qmik+7WY0UleYFqm2OMEcTkE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1346C6E22C;
        Sun, 12 Mar 2017 20:01:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 754656E22A;
        Sun, 12 Mar 2017 20:01:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] l10n: add framework for localizing the manpages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170312200248.3610-2-jn.avila@free.fr>
Date:   Sun, 12 Mar 2017 17:01:20 -0700
In-Reply-To: <20170312200248.3610-2-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Sun, 12 Mar 2017 21:02:48 +0100")
Message-ID: <xmqq1su2ujsf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 30DA2672-0780-11E7-BF15-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila <jn.avila@free.fr> writes:

> +#. type: Title =3D
> +#: git-add.txt:2
> +#, no-wrap
> +msgid "git-add(1)"
> +msgstr "git-add(1)"
> +
> +#. type: Title -
> +#: git-add.txt:5
> +#, no-wrap
> +msgid "NAME"
> +msgstr "NOM"
> +
> +#
> +#. type: Plain text
> +#: git-add.txt:7
> +msgid "git-add - Add file contents to the index"
> +msgstr "git-add - Ajoute le contenu de fichiers =C3=A0 l'index"
> +
> +#. type: Title -
> +#: git-add.txt:9
> +#, no-wrap
> +msgid "SYNOPSIS"
> +msgstr "SYNOPSIS"

It is a wonderful goal to make localized manpages and corresponding
HTMLized documents available, and the above might look reasonable,
but other parts of what the translaters need to do we see below
makes me wonder if this is a sensible approach.

> +#. type: Plain text
> +#: git-add.txt:15
> +#, no-wrap
> +msgid ""
> +"'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interac=
tive | -i] [--patch | -p]\n"
> +"\t  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -=
u]]\n"
> +"\t  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-mi=
ssing]\n"
> +"\t  [--chmod=3D(+|-)x] [--] [<pathspec>...]\n"
> +msgstr ""
> +"'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p=
]\n"
> +"\t  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -=
u]]\n"
> +"\t  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-mi=
ssing]\n"
> +"\t  [--] [<chemin>...]\n"

This shows that even after adding just _one_ new option to the
command, the whole thing need to be re-translated (the SYNOPSIS
section may be a bad example, as not much is subject to i18n,
though).  If each paragraph of the description section becomes a
single string that need to be re-translated, as we can see below, I
am not sure if it really helps the translators.  A mere single
rephrasing of a word in a large paragraph would have to result in
the entire paragraph to be translated again?

> +#. type: Title -
> +#: git-add.txt:17
> +#, no-wrap
> +msgid "DESCRIPTION"
> +msgstr "DESCRIPTION"
> +
> +#
> +#. type: Plain text
> +#: git-add.txt:24
> +msgid ""
> +"This command updates the index using the current content found in the=
 "
> +"working tree, to prepare the content staged for the next commit.  It =
"
> +"typically adds the current content of existing paths as a whole, but =
with "
> +"some options it can also be used to add content with only part of the=
 "
> +"changes made to the working tree files applied, or remove paths that =
do not "
> +"exist in the working tree anymore."
> +msgstr ""
> +"Cette commande met =C3=A0 jour l'index en utilisant le contenu actuel=
 trouv=C3=A9 dans "
> +"la copie de travail, pour pr=C3=A9parer le contenu de la prochaine va=
lidation. "
> +"Typiquement, elle ajoute int=C3=A9gralement le contenu actuel des che=
mins "
> +"existant, mais peut aussi n'ajouter que certaines parties des modific=
ations "
> +"au moyen d'options ou soustraire certains chemins qui n'existent plus=
 dans "
> +"la copie de travail."

It almost makes me suggest that a totally different approach might
be more manageable.  For example, we can pick one version of a
source file (say, "v2.12.0:Documentation/git-add.txt"), have it
fully translated to the target languages, _and_ make it a convention
to record the original blob object name at the end of the translated
file.  Perhaps "Documentation/l10n/fr/git-add.txt" may record the
result of such translation effort.

And then, when somebody wants to update the translation for v2.13.0,
perhaps=20

    git diff --color-words $old_blob v2.13.0:Documentation/git-add.txt

(where $old_blob is taken from Documentation/l10n/fr/git-add.txt)
can be examined and then Documentation/l10n/fr/git-add.txt can be
adjusted to match the changes between the two versions.  After that,
update the "source" blob object name in the translation.

So, I dunno.  I like the goal and appreciate the effort to get to
that goal.  I am not sure what the best approach would be and the
sample translation mechanism I see in this patch makes me doubt that
it is the best approach.

Thanks.
