From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-difftool: allow skipping file by typing 'n' at
 prompt
Date: Fri, 07 Oct 2011 13:09:11 -0700
Message-ID: <7vwrcgtvh4.fsf@alter.siamese.dyndns.org>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
 <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
 <CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
 <7vty7oblpu.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gssgpy7nF46c1roJUCN5yvQaOYfVE_-ZrvMfHGWKvk0w@mail.gmail.com>
 <20111006125658.GB18709@sita-lt.atc.tcs.com>
 <7v62k210pj.fsf@alter.siamese.dyndns.org>
 <20111006181522.GA2936@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 22:09:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCGjQ-0006Ol-2R
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 22:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248Ab1JGUJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 16:09:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006Ab1JGUJO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 16:09:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC3DF6F42;
	Fri,  7 Oct 2011 16:09:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5MGxBVBN/h92PB2JFZs9bLUMuSw=; b=YBTg5D
	tDQke8RoDdL87cm2nLHlhhj+a05F35DH6NIxQm/dT8WmaHJCYFkl31B2zi/BBsgb
	fDta0navi9zcQu+0yxY8cCBsD9KEWtQgwHJlnLRA+H+BJeCP6GW2Kp9dC81P2Iu5
	9jPL2d0FKOeODKFJ175xRsrLM/frOy9IrGq9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QMApAA6Nc8mEMJrTImq63YQnNqIp5sDt
	1I72TM79heJVlmJRdo0CYI2eMTYETDZsWt0hDs6cF5vQbu8IvEqQKpK+gxwDfU3M
	GaL46eduTXYOZJfZzpphQK9vBQQb5XYhfSZEsr4OOx+YtOP7c3EN4lj8x2ZoBtTg
	ZQOb17Ky2ZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C13C16F41;
	Fri,  7 Oct 2011 16:09:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 470946F40; Fri,  7 Oct 2011
 16:09:13 -0400 (EDT)
In-Reply-To: <20111006181522.GA2936@sita-lt.atc.tcs.com> (Sitaram Chamarty's
 message of "Thu, 6 Oct 2011 23:45:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39DB1C76-F120-11E0-87AF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183103>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> This is useful if you forgot to restrict the diff to the paths you want
> to see, or selecting precisely the ones you want is too much typing.
>
> Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
> ---
>
> On Thu, Oct 06, 2011 at 10:36:40AM -0700, Junio C Hamano wrote:
>
>> Thanks. It is clear from the subject and the patch text that you are
>> changing "hit return to unconditionally launch" into "launch it if you
>> want to", but can you give justification why a choice not to launch is
>> needed in the log message?
>
> OK; done.

Looks OK from a cursory viewing. Do we want some additional tests?

For that matter, have you run the test suite with this patch applied (I
haven't)?

>  git-difftool--helper.sh |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 8452890..0468446 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -38,15 +38,16 @@ launch_merge_tool () {
>  
>  	# $LOCAL and $REMOTE are temporary files so prompt
>  	# the user with the real $MERGED name before launching $merge_tool.
> +	ans=y
>  	if should_prompt
>  	then
>  		printf "\nViewing: '$MERGED'\n"
>  		if use_ext_cmd
>  		then
> -			printf "Hit return to launch '%s': " \
> +			printf "Launch '%s' [Y/n]: " \
>  				"$GIT_DIFFTOOL_EXTCMD"
>  		else
> -			printf "Hit return to launch '%s': " "$merge_tool"
> +			printf "Launch '%s' [Y/n]: " "$merge_tool"
>  		fi
>  		read ans
>  	fi
> @@ -54,9 +55,9 @@ launch_merge_tool () {
>  	if use_ext_cmd
>  	then
>  		export BASE
> -		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
> +		test "$ans" != "n" && eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
>  	else
> -		run_merge_tool "$merge_tool"
> +		test "$ans" != "n" && run_merge_tool "$merge_tool"
>  	fi
>  }
