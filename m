From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixed translation in config file to enhance user output message from the porcelain command(git config). This fixes the error and die function by wrapping it in the _(...) function. This also avoid the code from breaking
Date: Wed, 06 May 2015 12:23:58 -0700
Message-ID: <xmqqoalxtsq9.fsf@gitster.dls.corp.google.com>
References: <554a6462.c2bbb40a.1e2a.0255@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 21:24:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq4vR-0008PB-PH
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 21:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbbEFTYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 15:24:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752726AbbEFTYC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 15:24:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45E074F0B7;
	Wed,  6 May 2015 15:24:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BKjf0XQ80XIIMW67R2GH6Pa8GEY=; b=IJozSg
	lvtY/2qo70e1b7khNMVoWCWOfOuPGbQ4V2qkfwdPHrIkwrZeL0Z6klmDV7wScW0K
	rmVIXilq18GdhWzqususYI6T4tHADj/Iu0xH8alFxEYQ3H6YTz6J/XUtSVteqLOe
	dyd6ac8BEP1bUyAqhIezFsi6cxOSo9zOKH1OU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nKdjzhl0EFBoIjtmyHxfU+PI/t9vKBvu
	64MMJxkRoDueshvJDl2JFslv/ciRX928bKsa6opjKHtiJty1F2rv4Nshl+BzmDLs
	4edA50ED34jzbVE1b1gshDOnGC+rLVP4Eb9BMn9HRxyp9b08ugJQe2tI4YVUPQNF
	PslDj9JMA7k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 132D84F0B6;
	Wed,  6 May 2015 15:24:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 588A04F0B5;
	Wed,  6 May 2015 15:23:59 -0400 (EDT)
In-Reply-To: <554a6462.c2bbb40a.1e2a.0255@mx.google.com> (Alangi Derick's
	message of "Wed, 6 May 2015 19:51:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7221B0AC-F425-11E4-83BF-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268484>

Alangi Derick <alangiderick@gmail.com> writes:

>> Cc: unlisted-recipients:; (no To-header on input)

The comments in $gmane/268330 still applies to this one.

    It seems you are posting putting the list in Bcc. Don't do that:
    it makes it painful to reply to your message (I had to re-add
    git@vger manually).


>> Subject: Re: [PATCH] fixed translation in config file to enhance user output message from the porcelain command(git config). This fixes the error and die function by wrapping it in the _(...) function. This also avoid the code from breaking

The first paragraph of your commit message becomes the patch title
and conveyed on the "Subject:" line.  So

 (1) Keep the first paragraph to one single line.
 (2) Keep the length of that line short and to the point.

Also the comments in $gmane/268335 still applies to this one.

SubmittingPatches prefers to see an "<area>:" prefix so
that output of "git shortlog --no-merges -100" would give the
readers a better overview of the changes.

When "fix a translation error in config file..." appears among 100
other commits in "git shortlog" output, what kind of change would a
reader imagine this to be, though?

My answer to that question would be: "There was an existing
translation in 'git config' output, that was incorrect in some
unspecified way, and this change corrects that breakage."

And that is not what is going on, so the change is mistitled.

Perhaps

    config.c: mark error strings for translation

or something, modelling after 8262aaa2 (config.c: mark error and
warnings strings for translation, 2014-08-07), may be more
appropriate.  Personally, I do not think the log message for this
change needs anything more than that title.

> Signed-off-by: Alangi Derick <alangiderick@gmail.com>
> ---
>  config.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/config.c b/config.c
> index 66c0a51..cc41dbb 100644
> --- a/config.c
> +++ b/config.c
> @@ -76,7 +76,7 @@ static int config_buf_ungetc(int c, struct config_source *conf)
>  	if (conf->u.buf.pos > 0) {
>  		conf->u.buf.pos--;
>  		if (conf->u.buf.buf[conf->u.buf.pos] != c)
> -			die("BUG: config_buf can only ungetc the same character");
> +			die(_("BUG: config_buf can only ungetc the same character"));

I do not think this change is a good idea.

Comments in $gmane/268373 still applies to this version.

"BUG:" is a sign that we encountered an unexpected condition, and
untranslated message is much easier for Git developers to spot where
it came from.

> @@ -976,8 +976,8 @@ static int git_default_push_config(const char *var, const char *value)
>  			push_default = PUSH_DEFAULT_CURRENT;
>  		else {
>  			error("Malformed value for %s: %s", var, value);

Why not this one?

> -			return error("Must be one of nothing, matching, simple, "
> -				     "upstream or current.");
> +			return error(_("Must be one of nothing, matching, simple, "
> +				     "upstream or current."));
>  		}
>  		return 0;
>  	}
