From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/9] user-manual: Use 'git config --global user.*' for
 setup
Date: Sun, 17 Feb 2013 18:47:09 -0800
Message-ID: <7vobficp8y.fsf@alter.siamese.dyndns.org>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <27886ef1313956bc19ddb9e658c4eb181fab2e46.1361146398.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:47:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7GlV-0003M2-HS
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 03:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab3BRCrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 21:47:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab3BRCrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 21:47:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7042BC10;
	Sun, 17 Feb 2013 21:47:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zIKu3I3VMfetKtlOXjfy+vOfXUQ=; b=EjGlwB
	ERls7cEGuOXpvC9eqTwZlz/nTCZ7OMdFMtg4FDbzkVYngANFQ+XnfwXXQoe6awIf
	paPy8SuSvreRH5eyPiwk7xN5Af5aCG2WRUnDnYQYBBbsezkUQLMvxkjy5MisRtUr
	LJg4QNhXHc9k2lI9PucJXkaE+T4DbLFOyOCXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NAg7K62hBDmt7NSoGxEIXTz0slk8JQGl
	2cQrjBV4Z8PQpT7mpkZ7Ses2do2hfmTtDS1oO5YQC9v0ieNKiCo31/go8TKemYAa
	c3p61H1dYmW8KhQJecJH2jw8gJKy6++6Y2iZzOQXh0mHREgZ5LommPlCZDdZ8c+q
	0ahAmOWiWzU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBDB2BC0F;
	Sun, 17 Feb 2013 21:47:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52A08BC0B; Sun, 17 Feb 2013
 21:47:11 -0500 (EST)
In-Reply-To: <27886ef1313956bc19ddb9e658c4eb181fab2e46.1361146398.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 17 Feb 2013 19:15:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E68C7A6-7975-11E2-B5EC-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216433>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> A simple command line call is easier than spawning an editor,
> especially for folks new to ideas like the "command line" and "text
> editors".  This is also the approach suggested by 'git commit' if you
> try and commit without having configured user.name or user.email.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

This looks like a good 'maint' material that can be applied straight
away there in preparation for 1.8.1.4 to me (modulo typo); reviewers
watching from the sideline, please stop me if you see issues.

>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index a79b3e31..d9276d7 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -991,9 +991,16 @@ Developing with Git
>  Telling Git your name
>  ---------------------
>  
> -Before creating any commits, you should introduce yourself to Git.  The
> -easiest way to do so is to make sure the following lines appear in a
> -file named `.gitconfig` in your home directory:
> +Before creating any commits, you should introduce yourself to Git.
> +The easiest way to do so is to use linkgit:git-config[1]:
> +
> +------------------------------------------------
> +$ git config --global user.name 'Your Name Comes Here'
> +$ git config --global user.email 'you@yourdomain.example.com'
> +------------------------------------------------
> +
> +Which will adds the following to a file named `.gitconfig` in your

s/adds/add/;

> +home directory:
>  
>  ------------------------------------------------
>  [user]
> @@ -1001,8 +1008,9 @@ file named `.gitconfig` in your home directory:
>  	email = you@yourdomain.example.com
>  ------------------------------------------------
>  
> -(See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
> -details on the configuration file.)
> +See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
> +details on the configuration file.  The file is plain text, so you can
> +also edit it with your favorite editor.
>  
>  
>  [[creating-a-new-repository]]
