From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool/mergetool: make the form of yes/no questions consistent
Date: Tue, 12 Apr 2016 09:15:47 -0700
Message-ID: <xmqq8u0isszw.fsf@gitster.mtv.corp.google.com>
References: <1460465982.3214.7.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Nikola =?utf-8?Q?Forr=C3=B3?= <nforro@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 18:16:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq0yw-0006Z6-HA
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 18:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576AbcDLQPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 12:15:52 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756056AbcDLQPu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 12:15:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44A52536FA;
	Tue, 12 Apr 2016 12:15:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pBXYiWmqNuZ/
	eXVHARE9oaR43Go=; b=QeCgG3vjkD5kjABm5++Uz8Rf5tVrCj/40zKpEbemn9Uq
	LX2Cw+h+r7BCJ0aqEb4uZAOEo5paeqBzB6JfVkLgvgYc1CoY1+bSQKO+Egxti5/0
	KyCcEAeHTQD4WueoTRm/Zg9PiMSKsq3sevr8TpFw477yFtJL8ZB6z5Cqj083828=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vAoX2M
	VC4dzUq7CWrPCs8GjpWV3cRlp510J3yknUOWCodZ0EaqxVUezpN8P3fl9FJEld23
	vX1KR8XL0OlZafDN4kTSvBpODtDhnPEPQN+ff4bK1jrqoSoiHMYrQdRVg08RrCVP
	9wmITQ+wnn1Bth+tWrwkrQ19S91fmsGdjr6gM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AD81536F9;
	Tue, 12 Apr 2016 12:15:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A4182536F8;
	Tue, 12 Apr 2016 12:15:48 -0400 (EDT)
In-Reply-To: <1460465982.3214.7.camel@redhat.com> ("Nikola =?utf-8?Q?Forr?=
 =?utf-8?Q?=C3=B3=22's?= message of
	"Tue, 12 Apr 2016 14:59:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1A25C46-00C9-11E6-A76A-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291274>

Nikola Forr=C3=B3 <nforro@redhat.com> writes:

> Every yes/no question in difftool/mergetool scripts has slightly
> different form, and none of them is consistent with the form git
> itself uses.
>
> Make the form of all the questions consistent with the form used
> by git, i.e. "Question [y/n]? ".
>
> Signed-off-by: Nikola Forr=C3=B3 <nforro@redhat.com>
> ---

Looks good from a cursory read.  David?

>  git-difftool--helper.sh | 4 ++--
>  git-mergetool--lib.sh   | 2 +-
>  git-mergetool.sh        | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 2b11b1d..84d6cc0 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -44,10 +44,10 @@ launch_merge_tool () {
>  			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
>  		if use_ext_cmd
>  		then
> -			printf "Launch '%s' [Y/n]: " \
> +			printf "Launch '%s' [Y/n]? " \
>  				"$GIT_DIFFTOOL_EXTCMD"
>  		else
> -			printf "Launch '%s' [Y/n]: " "$merge_tool"
> +			printf "Launch '%s' [Y/n]? " "$merge_tool"
>  		fi
>  		read ans || return
>  		if test "$ans" =3D n
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 54ac8e4..92adcc0 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -100,7 +100,7 @@ check_unchanged () {
>  		while true
>  		do
>  			echo "$MERGED seems unchanged."
> -			printf "Was the merge successful? [y/n] "
> +			printf "Was the merge successful [y/n]? "
>  			read answer || return 1
>  			case "$answer" in
>  			y*|Y*) return 0 ;;
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 9f77e3a..2e0635a 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -396,7 +396,7 @@ done
>  prompt_after_failed_merge () {
>  	while true
>  	do
> -		printf "Continue merging other unresolved paths (y/n) ? "
> +		printf "Continue merging other unresolved paths [y/n]? "
>  		read ans || return 1
>  		case "$ans" in
>  		[yY]*)
