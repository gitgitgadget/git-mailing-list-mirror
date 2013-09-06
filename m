From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 6/6] status: add missing blank line after list of "other" files
Date: Fri, 06 Sep 2013 11:42:02 -0700
Message-ID: <xmqq4n9xyepx.fsf@gitster.dls.corp.google.com>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
	<1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
	<1378489389-25802-7-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqbo45yfm5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Sep 06 20:42:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI0z5-0006Gy-JV
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 20:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167Ab3IFSmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 14:42:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab3IFSmO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 14:42:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 905363F10B;
	Fri,  6 Sep 2013 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7YFeIgEhVzOjNfoFT9w+BzkBdBI=; b=pKUZ1X
	LC6bM+l5bxdeCikZcy4ym0u1Ld0b/GtFbUmWAFhD9KliLpFIb+LVHiTAbR5PiBtz
	NE0nnK3BXk1LLHUQFZtDsLtaIKsR60ol2OfPyQmwvkxxGSBaZLDz4aIIy8ILpnaT
	kk3peMDXP/w1ISip9EO4TUzSZASkqdNsHpy4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WUJ02v3vlzQ2/JAxOR6C6eIl7URgzRHC
	spW2x5F0YaEcWybnswuKl+evfTvj/v9CDgi6TIrFeOaA1MDlw8wSzUQTokPEJq62
	llF9+Bvudt9/esEpjTtT1Z8LcNVWYdiJMMxLnj0YP4RgfD5ylqMxqyvU1YWxEYcw
	zRWNuMf27kA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 504E33F0FE;
	Fri,  6 Sep 2013 18:42:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E21593F0DB;
	Fri,  6 Sep 2013 18:42:06 +0000 (UTC)
In-Reply-To: <xmqqbo45yfm5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Sep 2013 11:22:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0898D460-1724-11E3-AC8F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234083>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> List of files in other sections ("Changes to be committed", ...) end with
>> a blank line.
>
> It is not like we want to add a blank line at the end of each
> element; it is rather that we want to have a blank line between each
> element, so that they can have a bit of breathing room between them.
>
> The output looks especially bad when there is nothing after the
> 'untracked' list.

We might want to revisit this later, but I take the above back at
least for now.

If we have absolutely nothing, we get this:

	$ git status
	On branch master
        nothing to commit
	$

And if we have something, we get this:

	$ git status
	On branch master
	Changes to be committed:
	  (use "git reset HEAD <file>..." to unstage)

	        new file:   foo

	$ git status
	On branch master
	Untracked files:
	  (use "git add <file>..." to include in what will be committed)

		bar
	nothing added to commit
	$ git status
	On branch master
	Changes to be committed:
	  (use "git reset HEAD <file>..." to unstage)

	        new file:   foo

	Untracked files:
	  (use "git add <file>..." to include in what will be committed)

		bar
	$

Given that we are already giving an unnecessary trailing blank line
in the "fully added without no untracked" case, it is not too bad to
add the same after the list of untracked files.

To properly "fix" this, we would need to refactor wt_status_print_*
which will get rid of wt_status_print_trailer(), so that routines
that produce each section is told if there is a previous output and
adds a separating line _before_ it emits anything on its own
(i.e. we switch from the "after we spit our stuff out, we leave a
blank line" mental model to "we are going to spit our stuff out but
we need a blank before it to separate our stuff from the previous
output"), and returns if the output now has something to the caller
so that the caller can pass that information to the function that
outputs the next section.

But until that happens, adding a trailing blank line unconditionally
is an OK thing to do, I think.

>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>  t/t7508-status.sh | 21 +++++++++++++++++++++
>>  wt-status.c       |  4 +++-
>>  2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
>> index d0444d3..9bf9701 100755
>> --- a/t/t7508-status.sh
>> +++ b/t/t7508-status.sh
>> @@ -84,6 +84,7 @@ test_expect_success 'status --column' '
>>  #
>>  #	dir1/untracked dir2/untracked output
>>  #	dir2/modified  expect         untracked
>> +#
>>  EOF
>>  	COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
>>  	test_i18ncmp expect output
>> @@ -117,6 +118,7 @@ cat >expect <<\EOF
>>  #	expect
>>  #	output
>>  #	untracked
>> +#
>>  EOF
>>  
>>  test_expect_success 'status with status.displayCommentPrefix=true' '
>> @@ -167,6 +169,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  
>>  test_expect_success 'status (advice.statusHints false)' '
>> @@ -241,6 +244,7 @@ Untracked files:
>>    (use "git add <file>..." to include in what will be committed)
>>  
>>  	dir2/modified
>> +
>>  Ignored files:
>>    (use "git add -f <file>..." to include in what will be committed)
>>  
>> @@ -250,6 +254,7 @@ Ignored files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	git status --ignored >output &&
>>  	test_i18ncmp expect output
>> @@ -308,6 +313,7 @@ Ignored files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	git status --ignored >output &&
>>  	test_i18ncmp expect output
>> @@ -430,6 +436,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	git status -unormal >output &&
>>  	test_i18ncmp expect output
>> @@ -488,6 +495,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	git status -uall >output &&
>>  	test_i18ncmp expect output
>> @@ -548,6 +556,7 @@ Untracked files:
>>  	../expect
>>  	../output
>>  	../untracked
>> +
>>  EOF
>>  	(cd dir1 && git status) >output &&
>>  	test_i18ncmp expect output
>> @@ -618,6 +627,7 @@ Untracked files:
>>  	<BLUE>expect<RESET>
>>  	<BLUE>output<RESET>
>>  	<BLUE>untracked<RESET>
>> +
>>  EOF
>>  	test_config color.ui always &&
>>  	git status | test_decode_color >output &&
>> @@ -747,6 +757,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	test_config status.relativePaths false &&
>>  	(cd dir1 && git status) >output &&
>> @@ -789,6 +800,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	git commit --dry-run dir1/modified >output &&
>>  	test_i18ncmp expect output
>> @@ -838,6 +850,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	git status >output &&
>>  	test_i18ncmp expect output
>> @@ -902,6 +915,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	git config status.submodulesummary 10 &&
>>  	git status >output &&
>> @@ -952,6 +966,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  no changes added to commit (use "git add" and/or "git commit -a")
>>  EOF
>>  	git commit -m "commit submodule" &&
>> @@ -1012,6 +1027,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	git config status.submodulesummary 10 &&
>>  	git commit --dry-run --amend >output &&
>> @@ -1066,6 +1082,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	echo modified  sm/untracked &&
>>  	git status --ignore-submodules=untracked >output &&
>> @@ -1177,6 +1194,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	git status --ignore-submodules=untracked > output &&
>>  	test_i18ncmp expect output
>> @@ -1238,6 +1256,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  EOF
>>  	git status --ignore-submodules=untracked > output &&
>>  	test_i18ncmp expect output
>> @@ -1319,6 +1338,7 @@ cat > expect << EOF
>>  ;	expect
>>  ;	output
>>  ;	untracked
>> +;
>>  EOF
>>  
>>  test_expect_success "status (core.commentchar with submodule summary)" '
>> @@ -1352,6 +1372,7 @@ Untracked files:
>>  	expect
>>  	output
>>  	untracked
>> +
>>  no changes added to commit (use "git add" and/or "git commit -a")
>>  EOF
>>  	git status --ignore-submodules=all > output &&
>> diff --git a/wt-status.c b/wt-status.c
>> index 3c795da..2a9ca0f 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -751,7 +751,7 @@ static void wt_status_print_other(struct wt_status *s,
>>  
>>  	strbuf_release(&buf);
>>  	if (!column_active(s->colopts))
>> -		return;
>> +		goto conclude;
>>  
>>  	strbuf_addf(&buf, "%s%s\t%s",
>>  		    color(WT_STATUS_HEADER, s),
>> @@ -765,6 +765,8 @@ static void wt_status_print_other(struct wt_status *s,
>>  	print_columns(&output, s->colopts, &copts);
>>  	string_list_clear(&output, 0);
>>  	strbuf_release(&buf);
>> +conclude:
>> +	status_printf_ln(s, GIT_COLOR_NORMAL, "");
>>  }
>>  
>>  static void wt_status_print_verbose(struct wt_status *s)
