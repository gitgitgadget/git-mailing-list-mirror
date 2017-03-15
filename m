Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A306A20953
	for <e@80x24.org>; Wed, 15 Mar 2017 07:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbdCOH7G (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 03:59:06 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:16443 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbdCOH7F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 03:59:05 -0400
Received: from [192.168.1.112] (unknown [164.177.97.114])
        (Authenticated sender: jn.avila)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 18BFF7803A9
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 08:58:52 +0100 (CET)
Subject: Re: [PATCH] l10n: add framework for localizing the manpages
References: <20170312200248.3610-1-jn.avila@free.fr>
 <20170312200248.3610-2-jn.avila@free.fr>
 <xmqq1su2ujsf.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
To:     git <git@vger.kernel.org>
Message-ID: <0ae83f7f-e178-31b3-87ea-324e3f00d469@free.fr>
Date:   Wed, 15 Mar 2017 08:58:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq1su2ujsf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 13/03/2017 à 01:01, Junio C Hamano a écrit :
> +#. type: Plain text
>> +#: git-add.txt:15
>> +#, no-wrap
>> +msgid ""
>> +"'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]\n"
>> +"\t  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]\n"
>> +"\t  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]\n"
>> +"\t  [--chmod=(+|-)x] [--] [<pathspec>...]\n"
>> +msgstr ""
>> +"'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]\n"
>> +"\t  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]\n"
>> +"\t  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]\n"
>> +"\t  [--] [<chemin>...]\n"
> This shows that even after adding just _one_ new option to the
> command, the whole thing need to be re-translated (the SYNOPSIS
> section may be a bad example, as not much is subject to i18n,
> though).  If each paragraph of the description section becomes a
> single string that need to be re-translated, as we can see below, I
> am not sure if it really helps the translators.  A mere single
> rephrasing of a word in a large paragraph would have to result in
> the entire paragraph to be translated again?

I'm not sure to clearly understand your point: if there is the
introduction of a new option, there is a need to update the translation
for sure.

 

The use of po files introduces tools to automatically mark the
paragraphs that need to be retranslated or if the translation was near
enough to be reviewed (entries are translated with the approaching
translation and marked as "fuzzy"). Using po, it is also possible to use
translation memories (such as the po file for the programs).

 

Now the choice of segmentation of the text might be discussed, but
usually, the translators prefer to keep a paragraph level, because
that's the range that can span an idea and allows shuffling the
sentences if needed. If a finer grain can be used, that's usually at the
step of writing the original text that the decision is taken to ease the
translation burden.

>> +#. type: Title -
>> +#: git-add.txt:17
>> +#, no-wrap
>> +msgid "DESCRIPTION"
>> +msgstr "DESCRIPTION"
>> +
>> +#
>> +#. type: Plain text
>> +#: git-add.txt:24
>> +msgid ""
>> +"This command updates the index using the current content found in the "
>> +"working tree, to prepare the content staged for the next commit.  It "
>> +"typically adds the current content of existing paths as a whole, but with "
>> +"some options it can also be used to add content with only part of the "
>> +"changes made to the working tree files applied, or remove paths that do not "
>> +"exist in the working tree anymore."
>> +msgstr ""
>> +"Cette commande met à jour l'index en utilisant le contenu actuel trouvé dans "
>> +"la copie de travail, pour préparer le contenu de la prochaine validation. "
>> +"Typiquement, elle ajoute intégralement le contenu actuel des chemins "
>> +"existant, mais peut aussi n'ajouter que certaines parties des modifications "
>> +"au moyen d'options ou soustraire certains chemins qui n'existent plus dans "
>> +"la copie de travail."
> It almost makes me suggest that a totally different approach might
> be more manageable.  For example, we can pick one version of a
> source file (say, "v2.12.0:Documentation/git-add.txt"), have it
> fully translated to the target languages, _and_ make it a convention
> to record the original blob object name at the end of the translated
> file.  Perhaps "Documentation/l10n/fr/git-add.txt" may record the
> result of such translation effort.
>
> And then, when somebody wants to update the translation for v2.13.0,
> perhaps 
>
>     git diff --color-words $old_blob v2.13.0:Documentation/git-add.txt
>
> (where $old_blob is taken from Documentation/l10n/fr/git-add.txt)
> can be examined and then Documentation/l10n/fr/git-add.txt can be
> adjusted to match the changes between the two versions.  After that,
> update the "source" blob object name in the translation.

That's the whole point of using po files which embed the management of
change (the original strings) independently from git, compared to
diffing between revisions of the original file and applying the
translations of the changes into the translated ones.



>
> So, I dunno.  I like the goal and appreciate the effort to get to
> that goal.  I am not sure what the best approach would be and the
> sample translation mechanism I see in this patch makes me doubt that
> it is the best approach.

That may sound like an authority argument, the po4a was specifically
developped and used for the translation of man pages (in debian for
instance), with success.

 

Anyway, we can manage the po4a workflow outside of the git repo and only
push the end results (the asciidoc files). The initial proposition was
also aimed at putting in common the tools for other translators (CC'ed),
to the expense of yet another dependency.


Thanks



