From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] format-patch: add format.cover-letter
 configuration
Date: Sun, 07 Apr 2013 01:14:46 -0700
Message-ID: <7v4nfi92q1.fsf@alter.siamese.dyndns.org>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
 <1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 10:15:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOkki-0002wU-2T
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 10:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161508Ab3DGIOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 04:14:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758426Ab3DGIOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 04:14:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B68D10A7C;
	Sun,  7 Apr 2013 08:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iiBYYle0iynW3SjLWZXc5M04H6o=; b=sQKkH6
	O/R1q11qbFK3khgtRiA1lFtNtX2REfni4kFZXHuG4zWDn4hgCwKBoLFNx38sFMtu
	EFyc/DMxfwC/HTeD1Ze7DjWbRqIgO2hon+aVrrlmDvg7H+/TRIeJJpnTMuTVnIeE
	GjGT0EhMRio9e4OIwR4/sXhB8ubUUzthoe/xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CdPk04hkY3S69Os1EizBmbt2tg8Dts3a
	mjTmhtWoCsz/y5MNenxxBhek0iygGEDHAqHxgPLqE66Wtn6Y9hNem+ei0Qp1tJ6T
	3yGt6e3f4+pQHXnW2eTTz2EPfZSusP3gHoIz//P/7spFGAZEDGHPV+uthNA8KRZ4
	+6aWatI1OcA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ECBB10A7B;
	Sun,  7 Apr 2013 08:14:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A0AB10A79; Sun,  7 Apr
 2013 08:14:48 +0000 (UTC)
In-Reply-To: <1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 7 Apr 2013 01:10:30 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36D50916-9F5B-11E2-8E7A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220294>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Also, add a new option: 'auto', so if there's more than one patch, the
> cover letter is generated, otherwise it's not.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/config.txt           |  6 ++++++
>  Documentation/git-format-patch.txt |  5 +++--
>  builtin/log.c                      | 22 ++++++++++++++++------
>  3 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c8e2178..c10195c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1092,6 +1092,12 @@ format.signoff::
>      the rights to submit this work under the same open source license.
>      Please see the 'SubmittingPatches' document for further discussion.
>  
> +format.cover-letter::

I thought I saw somebody already pointed out that this was wrong.

> +	Allows to configure the --cover-letter option of format-patch by
> +	default.
> +	In addition, you can set it to 'auto' to automatically
> +	determine based on the number of patches (generate if there's more than
> +	one).

I find this somewhat a strange phrasing.  It _sets_ the default for
the cover-letter option, either to true or false or auto, so there
is no "in addition" about it.

Perhaps

format.coverLetter::
	Setting this variable to `true` (or `false`) tells the
	`format-patch` command to pretend the `--cover-letter` (or
	`--no-cover-letter`) was given from the command line.  When
	set to `auto`, `format-patch` assumes `--cover-letter` if
	and only if it is working on more than one commit.

or something?

It also is somewhat strange why the command line argument does not
accept `--cover-letter=auto` option.  In general, a configuration
variable should not be more flexible mechanism than what the command
line could give the user.  As I already said, I think that would be
a better longer-term default, and that makes it even more stand-out.

> @@ -1360,6 +1366,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		numbered = 1;
>  	if (numbered)
>  		rev.total = total + start_number - 1;
> +	if (cover_letter == -1)
> +		cover_letter = (total > 1);
>  	if (in_reply_to || thread || cover_letter)
>  		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
>  	if (in_reply_to) {
> @@ -1371,6 +1379,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	if (cover_letter) {
>  		if (thread)
>  			gen_message_id(&rev, "cover");
> +		if (!branch_name)
> +			branch_name = find_branch_name(&rev);
>  		make_cover_letter(&rev, use_stdout,
>  				  origin, nr, list, head, branch_name, quiet);
>  		total++;

This part is nicely done, thanks to the previous two steps.  You
might even want to remove the call to the find_branch_name() helper
function from here, and instead call it from make_cover_letter()
when branch_name is not yet there.

We would need tests to make sure future changes will not break this.
