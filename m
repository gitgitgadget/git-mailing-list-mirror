From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: support --tool-help option like difftool does
Date: Mon, 23 Jul 2012 12:52:19 -0700
Message-ID: <7vhasyl0gc.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFAE1.3070304@gmail.com> <7vr4s2mnir.fsf@alter.siamese.dyndns.org>
 <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org> <500D9E5A.2000204@gmail.com>
 <500D9EDB.90603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:52:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StOg9-0008Hx-92
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 21:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab2GWTwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 15:52:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297Ab2GWTwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 15:52:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 105466857;
	Mon, 23 Jul 2012 15:52:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CrjVASGuFEncXBtEdQ7D19eDmoM=; b=EwCE6b
	mbozvzShMSd0SQjzg1Jsq/NQeQfJhvib30O70fJZWoav5wd9XZF0nK3zEIYt513t
	GaOlio5MfoLCQBiQQgjn9n0b/8fBQsmaO8WveRA5/VceSPXj3kh4enNbjLmJUl+Z
	pj1PfFI1ve4TCWRbmzDE1orX0AnYAiQEb+Hww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZR8TYUOd1u2bGGgwKPstzpHiidUvYzvU
	Rx8bFA8GgWlLawJjozX5NVsfnZ5fljITYtrrWBy7+LlvTilMPPIF8pmPGCAZ5JQo
	wrw346BWZZslwqZVxnzHseEF16eZPHtdL/QTpKkxGibawWpIpoKgEOANHd9iM62K
	vVCfVrT8baU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F289B6856;
	Mon, 23 Jul 2012 15:52:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0247F6852; Mon, 23 Jul 2012
 15:52:20 -0400 (EDT)
In-Reply-To: <500D9EDB.90603@gmail.com> (Sebastian Schuberth's message of
 "Mon, 23 Jul 2012 20:58:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA483EE0-D4FF-11E1-85A3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201969>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> This way we do not have to risk the list of tools go out of sync
> between the implementation and the documentation. Adjust the documentation
> accordingly to not explicitly list the tools but refer to --tool-help.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  Documentation/git-difftool.txt  |  7 ++++---
>  Documentation/git-mergetool.txt |  8 ++++----
>  git-mergetool--lib.sh           | 11 ++++++++++-
>  git-mergetool.sh                | 42 ++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 59 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> index 31fc2e3..0bdfe35 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -36,9 +36,10 @@ OPTIONS
>  
>  -t <tool>::
>  --tool=<tool>::
> -	Use the diff tool specified by <tool>.  Valid values include
> -	emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
> -	for the list of valid <tool> settings.
> +	Use the diff tool specified by <tool>.

I do not see how it is an improvement to drop the most common ones.
People sometimes read documentation without having an access to
shell to run "cmd --tool-help", and a list of handful of well known
ones would serve as a good hint to let the reader know the kind of
commands the front-end is capable of spawning, which in turn help
such a reader to imagine how the command is used to judge if it is
something the reader wants to use.

> +
> +--tool-help::
> +	List all supported values for <tool>.
>  +
>  If a diff tool is not specified, 'git difftool'
>  will use the configuration variable `diff.tool`.  If the
> diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
> index 2a49de7..99e53b1 100644
> --- a/Documentation/git-mergetool.txt
> +++ b/Documentation/git-mergetool.txt
> @@ -26,10 +26,10 @@ OPTIONS
>  -------
>  -t <tool>::
>  --tool=<tool>::
> -	Use the merge resolution program specified by <tool>.
> -	Valid merge tools are:
> -	araxis, bc3, diffuse, ecmerge, emerge, gvimdiff, kdiff3,
> -	meld, opendiff, p4merge, tkdiff, tortoisemerge, vimdiff and xxdiff.
> +	Use the merge tool specified by <tool>.

Likewise.  Dropping araxis, bc3, etc. to trim the list to 4-5 items
that people would know what they are would make sense, though.  The
purpose of the list is not to tell if the reader's favorite tool is
supported or not---it is to hint the flavor of what kind of things
the command spawned would be capable of.

> +
> +--tool-help::
> +	List all supported values for <tool>.
>  +
>  If a merge resolution program is not specified, 'git mergetool'
>  will use the configuration variable `merge.tool`.  If the
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index ed630b2..f0865d4 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -111,15 +111,18 @@ run_merge_tool () {
>  	return $status
>  }
>  
> -guess_merge_tool () {
> +list_merge_tool_candidates () {
> +	# Add tools that can either do merging or diffing, but not both.
>  	if merge_mode
>  	then
>  		tools="tortoisemerge"
>  	else
>  		tools="kompare"
>  	fi
> +
>  	if test -n "$DISPLAY"
>  	then
> +		# Prefer GTK-based tools under Gnome.
>  		if test -n "$GNOME_DESKTOP_SESSION_ID"
>  		then
>  			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
> @@ -128,6 +131,8 @@ guess_merge_tool () {
>  		fi
>  		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3"
>  	fi
> +
> +	# Prefer vimdiff if vim is the default editor.
>  	case "${VISUAL:-$EDITOR}" in
>  	*vim*)
>  		tools="$tools vimdiff emerge"
> @@ -136,6 +141,10 @@ guess_merge_tool () {
>  		tools="$tools emerge vimdiff"
>  		;;
>  	esac
> +}
> +
> +guess_merge_tool () {
> +	list_merge_tool_candidates
>  	echo >&2 "merge tool candidates: $tools"
>  
>  	# Loop over each candidate and stop when a valid merge tool is found.
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index a9f23f7..0db0c44 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -8,7 +8,7 @@
>  # at the discretion of Junio C Hamano.
>  #
>  
> -USAGE='[--tool=tool] [-y|--no-prompt|--prompt] [file to merge] ...'
> +USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
>  SUBDIRECTORY_OK=Yes
>  OPTIONS_SPEC=
>  TOOL_MODE=merge
> @@ -284,11 +284,51 @@ merge_file () {
>      return 0
>  }
>  
> +show_tool_help () {
> +	TOOL_MODE=merge
> +	list_merge_tool_candidates
> +	unavailable= available= LF='
> +'
> +	for i in $tools
> +	do
> +		merge_tool_path=$(translate_merge_tool_path "$i")
> +		if type "$merge_tool_path" >/dev/null 2>&1
> +		then
> +			available="$available$i$LF"
> +		else
> +			unavailable="$unavailable$i$LF"
> +		fi
> +	done
> +	if test -n "$available"
> +	then
> +		echo "'git mergetool --tool=<tool>' may be set to one of the following:"
> +		echo "$available" | sort | sed -e 's/^/	/'
> +	else
> +		echo "No suitable tool for 'git mergetool --tool=<tool>' found."
> +	fi
> +	if test -n "$unavailable"
> +	then
> +		echo
> +		echo 'The following tools are valid, but not currently available:'
> +		echo "$unavailable" | sort | sed -e 's/^/	/'
> +	fi
> +	if test -n "$unavailable$available"
> +	then
> +		echo
> +		echo "Some of the tools listed above only work in a windowed"
> +		echo "environment. If run in a terminal-only session, they will fail."
> +	fi
> +	exit 0
> +}
> +
>  prompt=$(git config --bool mergetool.prompt || echo true)
>  
>  while test $# != 0
>  do
>      case "$1" in
> +	--tool-help)
> +		show_tool_help
> +		;;
>  	-t|--tool*)
>  	    case "$#,$1" in
>  		*,*=*)
