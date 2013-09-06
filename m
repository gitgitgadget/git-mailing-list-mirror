From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 6/6] status: add missing blank line after list of "other" files
Date: Fri, 06 Sep 2013 11:22:42 -0700
Message-ID: <xmqqbo45yfm5.fsf@gitster.dls.corp.google.com>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
	<1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
	<1378489389-25802-7-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Sep 06 20:23:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI0gN-0005Ex-Uq
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 20:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab3IFSWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 14:22:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab3IFSWs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 14:22:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEF403FBFF;
	Fri,  6 Sep 2013 18:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v35A7GTEo46lGbPVQTZFz17hY9w=; b=o4bGDA
	yyRe+iTKekGxY/I8Mmjfy7N4FBkRtaeQoBdoQX2bqpbDqbkb2Qg1j8l+UXvtlZDz
	XQU+yqRrPiwrJsWJ3ZDNxfmSrPN72/9SUd7uAhoLBuRqDu53P4wMSuQCKct441jq
	2szwBjbif+kmIQ1g51ErUNt6tjJJysCdA67AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rHD+vovhTIgVuejLUjLFy4D7wraTOXAk
	nmnzi6PFh+rhUEKvlASvUpw0BZOBHHJP9KUUbg11kIQQPmioVwC8+Vb9RrlrhsEk
	1zTz54zBR5CkKfN2+6F5RbnlFQwimuD5O1aXK7sWExKIe5OUDM21pOZDOJ2qIwKB
	t2Ma8HTD4XE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E3AB3FBFE;
	Fri,  6 Sep 2013 18:22:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07AC03FBF8;
	Fri,  6 Sep 2013 18:22:44 +0000 (UTC)
In-Reply-To: <1378489389-25802-7-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Fri, 6 Sep 2013 19:43:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 53631832-1721-11E3-9A1B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234082>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> List of files in other sections ("Changes to be committed", ...) end with
> a blank line.

It is not like we want to add a blank line at the end of each
element; it is rather that we want to have a blank line between each
element, so that they can have a bit of breathing room between them.

The output looks especially bad when there is nothing after the
'untracked' list.


> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  t/t7508-status.sh | 21 +++++++++++++++++++++
>  wt-status.c       |  4 +++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index d0444d3..9bf9701 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -84,6 +84,7 @@ test_expect_success 'status --column' '
>  #
>  #	dir1/untracked dir2/untracked output
>  #	dir2/modified  expect         untracked
> +#
>  EOF
>  	COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
>  	test_i18ncmp expect output
> @@ -117,6 +118,7 @@ cat >expect <<\EOF
>  #	expect
>  #	output
>  #	untracked
> +#
>  EOF
>  
>  test_expect_success 'status with status.displayCommentPrefix=true' '
> @@ -167,6 +169,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  
>  test_expect_success 'status (advice.statusHints false)' '
> @@ -241,6 +244,7 @@ Untracked files:
>    (use "git add <file>..." to include in what will be committed)
>  
>  	dir2/modified
> +
>  Ignored files:
>    (use "git add -f <file>..." to include in what will be committed)
>  
> @@ -250,6 +254,7 @@ Ignored files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	git status --ignored >output &&
>  	test_i18ncmp expect output
> @@ -308,6 +313,7 @@ Ignored files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	git status --ignored >output &&
>  	test_i18ncmp expect output
> @@ -430,6 +436,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	git status -unormal >output &&
>  	test_i18ncmp expect output
> @@ -488,6 +495,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	git status -uall >output &&
>  	test_i18ncmp expect output
> @@ -548,6 +556,7 @@ Untracked files:
>  	../expect
>  	../output
>  	../untracked
> +
>  EOF
>  	(cd dir1 && git status) >output &&
>  	test_i18ncmp expect output
> @@ -618,6 +627,7 @@ Untracked files:
>  	<BLUE>expect<RESET>
>  	<BLUE>output<RESET>
>  	<BLUE>untracked<RESET>
> +
>  EOF
>  	test_config color.ui always &&
>  	git status | test_decode_color >output &&
> @@ -747,6 +757,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	test_config status.relativePaths false &&
>  	(cd dir1 && git status) >output &&
> @@ -789,6 +800,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	git commit --dry-run dir1/modified >output &&
>  	test_i18ncmp expect output
> @@ -838,6 +850,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	git status >output &&
>  	test_i18ncmp expect output
> @@ -902,6 +915,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	git config status.submodulesummary 10 &&
>  	git status >output &&
> @@ -952,6 +966,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  no changes added to commit (use "git add" and/or "git commit -a")
>  EOF
>  	git commit -m "commit submodule" &&
> @@ -1012,6 +1027,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	git config status.submodulesummary 10 &&
>  	git commit --dry-run --amend >output &&
> @@ -1066,6 +1082,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	echo modified  sm/untracked &&
>  	git status --ignore-submodules=untracked >output &&
> @@ -1177,6 +1194,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	git status --ignore-submodules=untracked > output &&
>  	test_i18ncmp expect output
> @@ -1238,6 +1256,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  EOF
>  	git status --ignore-submodules=untracked > output &&
>  	test_i18ncmp expect output
> @@ -1319,6 +1338,7 @@ cat > expect << EOF
>  ;	expect
>  ;	output
>  ;	untracked
> +;
>  EOF
>  
>  test_expect_success "status (core.commentchar with submodule summary)" '
> @@ -1352,6 +1372,7 @@ Untracked files:
>  	expect
>  	output
>  	untracked
> +
>  no changes added to commit (use "git add" and/or "git commit -a")
>  EOF
>  	git status --ignore-submodules=all > output &&
> diff --git a/wt-status.c b/wt-status.c
> index 3c795da..2a9ca0f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -751,7 +751,7 @@ static void wt_status_print_other(struct wt_status *s,
>  
>  	strbuf_release(&buf);
>  	if (!column_active(s->colopts))
> -		return;
> +		goto conclude;
>  
>  	strbuf_addf(&buf, "%s%s\t%s",
>  		    color(WT_STATUS_HEADER, s),
> @@ -765,6 +765,8 @@ static void wt_status_print_other(struct wt_status *s,
>  	print_columns(&output, s->colopts, &copts);
>  	string_list_clear(&output, 0);
>  	strbuf_release(&buf);
> +conclude:
> +	status_printf_ln(s, GIT_COLOR_NORMAL, "");
>  }
>  
>  static void wt_status_print_verbose(struct wt_status *s)
