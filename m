From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix for
 long forms of -M and -C.
Date: Mon, 29 Nov 2010 16:37:27 -0800
Message-ID: <7vfwujy7co.fsf@alter.siamese.dyndns.org>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org>
 <1289420833-20602-2-git-send-email-ydirson@altern.org>
 <7884E3F5-D622-49E2-BEBE-12936F388C30@sb.org>
 <7vmxorzr8k.fsf@alter.siamese.dyndns.org>
 <34E173EF-658B-49CC-99C4-C455074D4A05@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Nov 30 01:37:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNEE5-00032c-6Q
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 01:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab0K3Ahi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 19:37:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab0K3Ahh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 19:37:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E1A039A6;
	Mon, 29 Nov 2010 19:37:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=id1AmHCRTl4qDjuKMcfqPwtfKCI=; b=SLUKFa
	KcTevs93C8/AsvgBk7UMar/6+3c3CgYvMudDFr11bpnYnmyTOySVQaHgXolORJLX
	B/vPFk2oHcLXDvIMA5FgAYdWuDD+vVgyWeKHiWrgSbNi1+NzC/S2p/EghH/bs/j2
	oU81K9T10ZifCv0w8dHiPgC8i2gD9C6glhCNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o2+mn3jw7zDCRrPT3CqjnapYZhe+sxr/
	hn6R2+s2RHtrO22EhnJaRmz84JLLMLxxcpTmuvfpXlNTn7q3LVyOt+IFkWAlmB+Z
	E9eH+kxnWo2reXn0X/WIraSMK6yuoed43/4FJb8ykKXvd0YGGFiNlCQOtb2Uw5N9
	4lbaZJ55+Ls=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC1F5399F;
	Mon, 29 Nov 2010 19:37:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3ED383999; Mon, 29 Nov 2010
 19:37:45 -0500 (EST)
In-Reply-To: <34E173EF-658B-49CC-99C4-C455074D4A05@sb.org> (Kevin Ballard's
 message of "Mon\, 29 Nov 2010 14\:52\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0FBECD30-FC1A-11DF-B468-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162455>

Kevin Ballard <kevin@sb.org> writes:

>> So I think using the same verb would make sense, either by introducing a
>> new synonym "detect-copies-harder", or by giving longer "find-copies" and
>> "find-renames" options to not-so-hard ones.
>
> Given my druthers, I'd prefer to go with --detect-copies-harder, but at this
> point I don't have as much of a strong preference anymore.

The patch is smaller, and we often say "rename detection", not "rename
finding", so it may probably make more sense.

Thanks.

> -Kevin Ballard
>
> -- 8< --
> Subject: [PATCH] diff: add --detect-copies-harder as a synonym for --find-copies-harder
>
>
> Signed-off-by: Kevin Ballard <kevin@sb.org>
> ---
>  Documentation/diff-options.txt |    1 +
>  diff.c                         |    2 +-
>  2 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index f3e9538..7246e10 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -251,6 +251,7 @@ endif::git-log[]
>  	If `n` is specified, it has the same meaning as for `-M<n>`.
>  
>  --find-copies-harder::
> +--detect-copies-harder::
>  	For performance reasons, by default, `-C` option finds copies only
>  	if the original file of the copy was modified in the same
>  	changeset.  This flag makes the command
> diff --git a/diff.c b/diff.c
> index 6991ed4..faa8dc0 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3198,7 +3198,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		DIFF_OPT_SET(options, TEXT);
>  	else if (!strcmp(arg, "-R"))
>  		DIFF_OPT_SET(options, REVERSE_DIFF);
> -	else if (!strcmp(arg, "--find-copies-harder"))
> +	else if (!strcmp(arg, "--find-copies-harder") || !strcmp(arg, "--detect-copies-harder"))
>  		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
>  	else if (!strcmp(arg, "--follow"))
>  		DIFF_OPT_SET(options, FOLLOW_RENAMES);
> -- 
> 1.7.3.2.615.g83f72.dirty
