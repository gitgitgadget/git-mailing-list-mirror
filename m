From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] user-manual: Use 'remote add' to setup push URLs
Date: Sun, 17 Feb 2013 17:58:16 -0800
Message-ID: <7vbobie62v.fsf@alter.siamese.dyndns.org>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <0016ba69f4157996dfbe66938056c4192bed62c1.1361146398.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 18 02:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7G1G-0005e6-E5
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 02:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393Ab3BRB6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 20:58:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757385Ab3BRB6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 20:58:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CF84B83C;
	Sun, 17 Feb 2013 20:58:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S9LicXqtqMFlFHqyH3+K4mA83I4=; b=Dos7z4
	tSu8mODopEb9uWrQPJJJ1OCGohiC1zsATl6hpf6AssxrWF2IDAnilrsguyb82AJf
	DDVuUWAz0oJB9M29lWoUsY1TrG3LwPb0/2f/PqpiZm68XYcGnTXCzNKEAWZZKqv5
	ESxSUXiWZDFcfD672pjlB2BNasDr6OCZx6+Hs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fe7oB+45SdmCtf91XYK/C9sevCMEewWZ
	63dWjZbiyurP4u/1/bCOghXJ9Me8xilflmvGaAMBcGQU4BbXJW662hI/NkMeYzQH
	nQs0/RGvzc8CM/Mbm8UVynb7VsswzPtRQE+JVUBIYIJ4wz5acb78PKWCK2/yqn+K
	2bz3JrgY3FA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 213B7B83B;
	Sun, 17 Feb 2013 20:58:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D377B838; Sun, 17 Feb 2013
 20:58:18 -0500 (EST)
In-Reply-To: <0016ba69f4157996dfbe66938056c4192bed62c1.1361146398.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 17 Feb 2013 19:15:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA4F3FF0-796E-11E2-A7CC-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216427>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> There is no need to use here documents to setup this configuration.
> It is easier, less confusing, and more robust to use `git remote add`
> directly.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---

This looks like a good 'maint' material that can be applied straight
away there in preparation for 1.8.1.4 to me; reviewers watching from
the sideline, please stop me if you see issues.

>  Documentation/user-manual.txt | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 5077e7c..a060eb6 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1998,16 +1998,21 @@ will not be updated by the push.  This may lead to unexpected results if
>  the branch you push to is the currently checked-out branch!
>  
>  As with `git fetch`, you may also set up configuration options to
> -save typing; so, for example, after
> +save typing; so, for example:
> +
> +-------------------------------------------------
> +$ git remote add public-repo ssh://yourserver.com/~you/proj.git
> +-------------------------------------------------
> +
> +adds the following to `.git/config`:
>  
>  -------------------------------------------------
> -$ cat >>.git/config <<EOF
>  [remote "public-repo"]
> -	url = ssh://yourserver.com/~you/proj.git
> -EOF
> +	url = yourserver.com:proj.git
> +	fetch = +refs/heads/*:refs/remotes/example/*
>  -------------------------------------------------
>  
> -you should be able to perform the above push with just
> +which lets you do the same push with just

As the additional "remote.public-repo.fetch" line hints, this does
more than "lets you do the same push with just [lazily]"; it also
starts pretending to have run a fetch from there immediately after
you pushed and update the remote tracking branches.  I couldn't
decide if it is a good idea to point it out in this point of the
flow as well, or it is too much detail that is not exactly relevant
while teaching "git push".  I tend to think it would be the latter.
