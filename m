From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] log.c: fix translation markings
Date: Tue, 06 Jan 2015 11:29:02 -0800
Message-ID: <xmqqzj9voght.fsf@gitster.dls.corp.google.com>
References: <ecb18f9d6ac56da0a61c3b98f8f2236@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:30:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Zog-0000x3-Az
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbbAFT3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 14:29:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753490AbbAFT3R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 14:29:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91C162D47E;
	Tue,  6 Jan 2015 14:29:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Cx42h6/M2IMWjH38sCKDpqwd3E=; b=wLK92x
	+I+wRihOU85ux+s8ngIhmr1rSYCCc8uVbyoI3D/GP6gzRnAwHleGvaj0dvkWd+Jt
	BJJjW/Z9RQsFqEhkAmWf9Q9oMYj8WMXfdYRr5JDadqnqjdLmvcp03AnBCeg7QtLK
	yZ1cCLLs3X+MEmjYo2c9nDz0VoPB4u66f0qNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rjxu6mK5D40Uku6M0oXj9sUyUj+wcFbN
	mbeaHus3NtYLvTrK5K12scHY7vUxHVQrVQqdE9opaUwPjSHKJ8XaYzwtUvEUoJNa
	xx6YkgvxgXZ/wYT9JuaEclD5vWw7XXGgTwxHrMxFVtL9nBuMzvq4xdmdyzU8KL1u
	9GAxjw/0j4I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87F972D47D;
	Tue,  6 Jan 2015 14:29:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE3762D46C;
	Tue,  6 Jan 2015 14:29:05 -0500 (EST)
In-Reply-To: <ecb18f9d6ac56da0a61c3b98f8f2236@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Tue, 6 Jan 2015 02:34:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4751CA50-95DA-11E4-8721-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262092>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Fix this by properly separating the two N_ marked strings with
> a comma ...

Sensible.

> ... and removing the embedded "\n" and "   or:" that are
> properly supplied by the parse_options API.

Wow.  I learn new things or reminded of old things every day.

Thanks.

>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  builtin/log.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index f2a9f015..923ffe72 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -38,8 +38,8 @@ static const char *fmt_patch_subject_prefix = "PATCH";
>  static const char *fmt_pretty;
>  
>  static const char * const builtin_log_usage[] = {
> -	N_("git log [<options>] [<revision range>] [[--] <path>...]\n")
> -	N_("   or: git show [options] <object>..."),
> +	N_("git log [<options>] [<revision range>] [[--] <path>...]"),
> +	N_("git show [options] <object>..."),
>  	NULL
>  };
