From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: Enhance tortoisemerge to work with
Date: Fri, 25 Jan 2013 10:28:24 -0800
Message-ID: <7v622l5d87.fsf@alter.siamese.dyndns.org>
References: <50FBD4AD.2060208@tu-clausthal.de>
 <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de>
 <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de>
 <51024B02.9020400@tu-clausthal.de>
 <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com>
 <5102837C.9000608@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Jan 25 19:28:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyo1G-0004rf-4c
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 19:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606Ab3AYS2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 13:28:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932596Ab3AYS21 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 13:28:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AC20C71A;
	Fri, 25 Jan 2013 13:28:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fWFlCy3pqwxUpf8rxgs0Rrq9E24=; b=stmrmM
	tgDcer1IQT0Vac3hQbcMLH5uCgDbfywcuShBlwAGBIr4iN/WOX3rAyWlDRvA/av2
	JnBEZnZJZ7WlX7hK6wyfgNxaOJxIDMzKIENf8QveqAfEFWxQvQyjBJuLW5rtK3T+
	0f6rmwEBGpjPMD1HbF/6p3hcbSQlBYtZFILAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p+MYBrdoRWVb2RSYmTuUTge8yXXepHLP
	XV2K4NiFQJYJjrG6JUBAaveP3CA0B3Zs6JjvzYCrSnE3R3W7U0aoOC3SnqaKNX4g
	76riwBHF64JxhqRP1q6MLMdQ+PlMhzTAGLL1JSLehB270Fc/Hg88cWcf4NJAMkyv
	m+YddikdLz4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 808B7C719;
	Fri, 25 Jan 2013 13:28:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8E92C718; Fri, 25 Jan 2013
 13:28:25 -0500 (EST)
In-Reply-To: <5102837C.9000608@tu-clausthal.de> (Sven Strickroth's message of
 "Fri, 25 Jan 2013 14:07:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01E941D4-671D-11E2-8790-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214565>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

>  TortoiseGitMerge and filenames with spaces

??? ECANNOTPARSE.

... ah, wait.  Is this a broken-off tail of your subject line?

It may be a sign that you are doing too many unrelated things in a
single patch when your subject does not fit on a single line.

Perhaps this is better done as a two-patch series?

 * mergetools: fix tortoisemerge support for pathnames with SP
 * mergetools: support tortoisegitmerge

>  mergetools/tortoisemerge | 51 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
> index ed7db49..8ee99a5 100644
> --- a/mergetools/tortoisemerge
> +++ b/mergetools/tortoisemerge
> @@ -1,17 +1,34 @@
> -can_diff () {
> -	return 1
> -}
> -
> -merge_cmd () {
> -	if $base_present
> -	then
> -		touch "$BACKUP"
> -		"$merge_tool_path" \
> -			-base:"$BASE" -mine:"$LOCAL" \
> -			-theirs:"$REMOTE" -merged:"$MERGED"
> -		check_unchanged
> -	else
> -		echo "TortoiseMerge cannot be used without a base" 1>&2
> -		return 1
> -	fi
> -}
> +can_diff () {
> +	return 1
> +}
> +
> +merge_cmd () {
> +	if $base_present
> +	then
> +		touch "$BACKUP"
> +		basename="$(basename "$merge_tool_path" .exe)"
> +		if test "$basename" = "tortoisegitmerge"
> +		then
> +			"$merge_tool_path" \
> +				-base "$BASE" -mine "$LOCAL" \
> +				-theirs "$REMOTE" -merged "$MERGED"
> +		else 
> +			"$merge_tool_path" \
> +				-base:"$BASE" -mine:"$LOCAL" \
> +				-theirs:"$REMOTE" -merged:"$MERGED"

Hmph.

How was the support for "names with spaces" added in this new code?
I do not spot what is different between this "else" clause and the
original body of the merge_cmd (which only supported tortoisemerge).

They seem to be doing exactly the same thing.

> +		fi
> +		check_unchanged
> +	else
> +		echo "$merge_tool_path cannot be used without a base" 1>&2
> +		return 1
> +	fi
> +}
> +
> +translate_merge_tool_path() {
> +	if type tortoisegitmerge >/dev/null 2>/dev/null
> +	then
> +		echo tortoisegitmerge
> +	else
> +		echo tortoisemerge
> +	fi
> +}
