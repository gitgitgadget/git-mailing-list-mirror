From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] doc: Generate a list of valid merge tools
Date: Sun, 27 Jan 2013 18:14:03 -0800
Message-ID: <7vvcaiyrys.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
 <1359334346-5879-5-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:14:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzeF3-0006VS-Tq
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105Ab3A1COI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:14:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab3A1COH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:14:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 118B8CC56;
	Sun, 27 Jan 2013 21:14:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5W4BvrjUfWxc8mkGGZH/h03m2Mw=; b=PpjFxs
	GwHyUDWXuGZiHPv04heXxO8HEG8wTZzC3gUTyCxUzGGRdMquoIx1HZT4+yEq8R6T
	ggL+vpEcY/YpTh34m2ECnmuZIGXxyAG8x5Yn6JBm5fRFRQNbhYM8LVe3GSLLFI5+
	GYEYB6VjEUgMkAEOoaf+2kkx+Wz5t/5BGqtGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G7wWg3ZMhxOhb5aIQMAMvGUzlvQSzeR5
	/0vZg60WUICe3DBMQPqPSF7cMAFZq92iFUuBOTSf4a5QqNGMZBaBZUrOTs82pSwO
	0ZVpKMsqgSLCu/WagpSPR1crXoUziHWKYrLgS5JYIxV3uATLHTd2yM50KWeqsL8w
	eDn/9ft1w2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06760CC55;
	Sun, 27 Jan 2013 21:14:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B009CC52; Sun, 27 Jan 2013
 21:14:05 -0500 (EST)
In-Reply-To: <1359334346-5879-5-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 16:52:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63F7C72C-68F0-11E2-AAD9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214786>

David Aguilar <davvid@gmail.com> writes:

> Use the show_tool_names() function to build lists of all
> the built-in tools supported by difftool and mergetool.
> This frees us from needing to update the documentation
> whenever a new tool is added.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Adjusted to use show_tool_names() and reworked the makefile dependencies.
> I could use another set of eyes on the Makefile..

Looks good from a quick scan and comparison with the previous
round.  Thanks for a quick reroll.


>  Documentation/.gitignore       |  1 +
>  Documentation/Makefile         | 22 ++++++++++++++++++++--
>  Documentation/diff-config.txt  | 13 +++++++------
>  Documentation/merge-config.txt | 12 ++++++------
>  git-mergetool--lib.sh          |  3 ++-
>  5 files changed, 36 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/.gitignore b/Documentation/.gitignore
> index d62aebd..2c8b2d6 100644
> --- a/Documentation/.gitignore
> +++ b/Documentation/.gitignore
> @@ -9,4 +9,5 @@ gitman.info
>  howto-index.txt
>  doc.dep
>  cmds-*.txt
> +mergetools-*.txt
>  manpage-base-url.xsl
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 267dfe1..834ec25 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -202,7 +202,11 @@ install-html: html
>  #
>  # Determine "include::" file references in asciidoc files.
>  #
> -doc.dep : $(wildcard *.txt) build-docdep.perl
> +docdep_prereqs = \
> +	mergetools-list.made $(mergetools_txt) \
> +	cmd-list.made $(cmds_txt)
> +
> +doc.dep : $(docdep_prereqs) $(wildcard *.txt) build-docdep.perl
>  	$(QUIET_GEN)$(RM) $@+ $@ && \
>  	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
>  	mv $@+ $@
> @@ -226,13 +230,27 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
>  	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) && \
>  	date >$@
>  
> +mergetools_txt = mergetools-diff.txt mergetools-merge.txt
> +
> +$(mergetools_txt): mergetools-list.made
> +
> +mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
> +	$(QUIET_GEN)$(RM) $@ && \
> +	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
> +		. ../git-mergetool--lib.sh && \
> +		show_tool_names can_diff "* "' > mergetools-diff.txt && \
> +	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
> +		. ../git-mergetool--lib.sh && \
> +		show_tool_names can_merge "* "' > mergetools-merge.txt && \
> +	date > $@
> +
>  clean:
>  	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
>  	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
>  	$(RM) *.pdf
>  	$(RM) howto-index.txt howto/*.html doc.dep
>  	$(RM) technical/api-*.html technical/api-index.txt
> -	$(RM) $(cmds_txt) *.made
> +	$(RM) $(cmds_txt) $(mergetools_txt) *.made
>  	$(RM) manpage-base-url.xsl
>  
>  $(MAN_HTML): %.html : %.txt
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 67a90a8..7c968d1 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -132,9 +132,10 @@ diff.<driver>.cachetextconv::
>  	conversion outputs.  See linkgit:gitattributes[5] for details.
>  
>  diff.tool::
> -	The diff tool to be used by linkgit:git-difftool[1].  This
> -	option overrides `merge.tool`, and has the same valid built-in
> -	values as `merge.tool` minus "tortoisemerge" and plus
> -	"kompare".  Any other value is treated as a custom diff tool,
> -	and there must be a corresponding `difftool.<tool>.cmd`
> -	option.
> +	Controls which diff tool is used by linkgit:git-difftool[1].
> +	This variable overrides the value configured in `merge.tool`.
> +	The list below shows the valid built-in values.
> +	Any other value is treated as a custom diff tool and requires
> +	that a corresponding difftool.<tool>.cmd variable is defined.
> +
> +include::mergetools-diff.txt[]
> diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
> index 861bd6f..5f40e71 100644
> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -52,12 +52,12 @@ merge.stat::
>  	at the end of the merge.  True by default.
>  
>  merge.tool::
> -	Controls which merge resolution program is used by
> -	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
> -	"bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
> -	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
> -	and "xxdiff".  Any other value is treated is custom merge tool
> -	and there must be a corresponding mergetool.<tool>.cmd option.
> +	Controls which merge tool is used by linkgit:git-mergetool[1].
> +	The list below shows the valid built-in values.
> +	Any other value is treated as a custom merge tool and requires
> +	that a corresponding mergetool.<tool>.cmd variable is defined.
> +
> +include::mergetools-merge.txt[]
>  
>  merge.verbosity::
>  	Controls the amount of output shown by the recursive merge
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index fe068f6..f665bee 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -1,6 +1,7 @@
>  #!/bin/sh
>  # git-mergetool--lib is a library for common merge tool functions
> -MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
> +
> +: ${MERGE_TOOLS_DIR=$(git --exec-path)/mergetools}
>  
>  mode_ok () {
>  	diff_mode && can_diff ||
