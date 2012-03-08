From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Maintaince script for l10n files and commits
Date: Thu, 08 Mar 2012 12:41:16 -0800
Message-ID: <7v399iddw3.fsf@alter.siamese.dyndns.org>
References: <7vr4x4mdae.fsf@alter.siamese.dyndns.org>
 <1331222706-81728-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 21:41:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5k9N-0003LD-Dy
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 21:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019Ab2CHUlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 15:41:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61120 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794Ab2CHUlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 15:41:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B26A16B0D;
	Thu,  8 Mar 2012 15:41:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wmbx7zvbY4w6m/xc1ytFuSHdT0o=; b=jeITjg
	Q5xVGDFpNsal2AOYc/fgBiyMOpiumFC3mnY9WB9xQrKphqoch3/CNWbrn9n+8Gdf
	suknA0LfQieQ4qvJJu1NrskHlOLtlC7rbMyFl8ht0m8XbdMrtY+7tsf9+9yT1YAi
	5zPA2De+0Ha1Z66ur0R7cJsmwetI4zueKwrds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WjU3/KVMv1jpYguJ1cnwLHAKLStrEYBS
	voaJeMmiTnWocvitQQaL9LgCU+9Fd/ObwePzywOakY/ZcozwuaE6wesrs65Z/3t1
	NsSuY1KFle4TPXZS0A1ISliDsi9Yhk/ASV8s9rinahOqCyyjgAcgMXrMtWFhlgxw
	+LjLelk/qQI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA79C6B0C;
	Thu,  8 Mar 2012 15:41:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA8446B08; Thu,  8 Mar 2012
 15:41:17 -0500 (EST)
In-Reply-To: <1331222706-81728-1-git-send-email-worldhello.net@gmail.com>
 (Jiang Xin's message of "Fri, 9 Mar 2012 00:05:06 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E3622B6-695F-11E1-85C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192646>

Jiang Xin <worldhello.net@gmail.com> writes:

> Usage of this script:
>
>  * po-helper.sh XX.po   : Init or update XX.po from git.pot
>
>  * po-helper.sh check [XX.po]
>                         : Perform all the checks for XX.po
>
>  * po-helper.sh commits [since] [til]
>                         : Check non-ascii chars in commit logs
>
>                           Don't write commit log with non-ascii chars
>                           without proper encoding settings.
>
>                           Subject of commit log must written in English.
>
>                           Don't change files outside this directory (po/)
>
>  * po-helper.sh pot     : Display summary of updates of git.pot file

That's quite a style deviation from out norm in the commit log
messages, don't you think (see "git log --no-merges -100", for
example)?  State the problem you are attempting to solve first, and
explain the solution to the problem, in separate paragraphs for
readability, perhaps like this:

	There are routine tasks translators need to perform that can
	be automated.

	Help them to

         (1) initialize or update the message files;
         (2) check errors in the message files they edited;
         (3) check errors in their commits; and
         (4) review recent updates to the message template file
             they base their translations on.

        by adding a helper script.

> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  po/po-helper.sh |  271 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 271 insertions(+)
>  create mode 100755 po/po-helper.sh
>
> diff --git a/po/po-helper.sh b/po/po-helper.sh
> new file mode 100755
> index 0000000..dd370a5
> --- /dev/null
> +++ b/po/po-helper.sh
> @@ -0,0 +1,271 @@
> +#!/bin/bash

Is there any bash-ism in this script?  Otherwise please start this
with "#!/bin/sh" to allow people who do not use bash to get involved
in the project.

> +#
> +# Copyright (c) 2012 Jiang Xin
> +
> +POTFILE=git.pot
> +
> +usage()
> +{

Style:

	usage () {

In general, it is safe to mimic the style "git-am.sh" is written in,
although some crufts seem to have slipped in with recent updates.

> +    cat <<-END_OF_USAGE

Style: unless you have substitutions ($var etc.) inside the here
text, please quote the end token to make it clear that readers do
not have to scan and look for what is substituted, i.e.

	cat <<-\END_OF_USAGE

> +Maintaince script for l10n files and commits.
> +
> +Usage:
> +
> + * po-helper.sh XX.po   : Init or update XX.po from git.pot

Will we later regret that we didn't give a command word for this
one?  Two common sources of such risks are:

 (1) it turns out XX.po matches the pattern we would want to use as
     a command; and

 (2) it turns out "init/update" is not the most often used action.

I do not think (1) is likely. I do not think anybody can decide
about (2) at this point yet.

> + * po-helper.sh check [XX.po]
> +                        : Perform all the checks for XX.po
> +
> + * po-helper.sh commits [since] [til]
> +                        : Check non-ascii chars in commit logs
> +
> +                          Don't write commit log with non-ascii chars
> +                          without proper encoding settings.
> +
> +                          Subject of commit log must written in English.
> +
> +                          Don't change files outside this directory (po/)
> +
> + * po-helper.sh pot     : Display summary of updates of git.pot file
> +
> +END_OF_USAGE

Do you really want the blank line output at the end?

> +
> +    exit 1
> +}
> +
> +# Display summary of updates of git.pot
> +show_pot_update_summary()
> +{
> +    pnew="^.*:([0-9]+): this message is used but not defined in"
> +    pdel="^.*:([0-9]+): warning: this message is not used"
> +    new_count=0
> +    del_count=0
> +    new_lineno=""
> +    del_lineno=""
> +
> +    status=$(git status --porcelain -- $POTFILE)
> +    if [ -z "$status" ]; then
> +        echo "Nothing changed."
> +    else
> +        tmpfile=$(mktemp /tmp/git.po.XXXX)
> +        LANGUAGE=C git show HEAD:./git.pot > $tmpfile
> +        LANGUAGE=C msgcmp -N --use-untranslated $tmpfile $POTFILE 2>&1 |
> +        {    while read line; do
> +                if [[ $line =~ $pnew ]]; then

That sounds like a blatant bash-ism to me.

> +...
> +}
> +
> +# Syntax check on XX.po, or all .po files if nothing provided
> +check_po()
> +{
> +    if [ $# -eq 0 ]; then
> +        ls *.po | while read f; do
> +            echo "============================================================"

Style:

	if test $# = 0
        then
		ls *.po |
		while read f
		do
                	...

Also indentation is done with HT, not runs of SP.

> +# Create or update XX.po file from git.pot
> +create_or_update_po()
> +{
> +    if [ $# -eq 0 ]; then
> +        usage
> +    fi
> +    while [ $# -gt 0 ]; do
> +        po=$1
> +        shift
> +        if [ -f $po ]; then
> +            msgmerge --add-location --backup=off -U $po $POTFILE
> +        else
> +            msginit -i $POTFILE --locale=${po%.po}
> +            perl -pi -e 's/(?<="Project-Id-Version: )PACKAGE VERSION/Git/' $po

Ah ;-) show_pot_update_summary() can be written so that this script
does not have to rely on bash-ism at all, as you are going to use
Perl anyway.

> +verify_commit_encoding()
> +{
> ...
> +}

I am not sure if the protection these checks offer is worth the
complexity of the script, but it is primarily to reduce back and
forth between the l10n coordinator and the language teams, so I
won't complain.

> +# vim: et ts=4 sw=4

I prefer not to see scripts forcing author's personal preference.
Especially, wouldn't ts=4 make it hard to avoid indenting with runs
of spaces by mistake?
