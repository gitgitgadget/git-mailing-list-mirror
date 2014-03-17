From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/gitk: Document new config file location
Date: Mon, 17 Mar 2014 15:19:08 -0700
Message-ID: <xmqqbnx4bh9f.fsf@gitster.dls.corp.google.com>
References: <1394979023-2635-1-git-send-email-astrilhayato@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Astril Hayato <astrilhayato@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 23:19:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfsL-0000hx-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 23:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbaCQWTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 18:19:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbaCQWTL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 18:19:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 782DA75E5F;
	Mon, 17 Mar 2014 18:19:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PjQC9EWEHhVH1f7+vKmEi3kGLVs=; b=ijuMyM
	yfl3CNEZ4EYmxw97PMpwWccB2U89lXRbnZziJ8V/3W1TJhROd+ii/3jLfQ8LizoC
	ld3jHbGTiUsJrG/8xlh9VzOjDHyOdhFKyAqVSf77MCu41lJ5hXS58O9GVseMnoz+
	dEwEIHlhSwc/VsfOBIYARwZTdNJuT7LCgKpKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AFNLo3v/tGs+i8+m9AACf7N8eg/e9fcU
	6SgdXHlJw99kFrfv3j7U74E4ArcV17Mqx9+T4eSLyQ7S8OP9OSPBolzmsT+DhMlz
	L/adAAwZLoqnIRW2q3stVEq3qv9M/jxCZTuKUeuiX8FfXJZJgMlQpS8f0gUnmQ9p
	euJsO3xVCCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63E5F75E5E;
	Mon, 17 Mar 2014 18:19:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A41EE75E5A;
	Mon, 17 Mar 2014 18:19:10 -0400 (EDT)
In-Reply-To: <1394979023-2635-1-git-send-email-astrilhayato@gmail.com> (Astril
	Hayato's message of "Sun, 16 Mar 2014 14:10:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29ED9340-AE22-11E3-BF73-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244300>

Astril Hayato <astrilhayato@gmail.com> writes:

> User configuration file is now stored at $XDG_CONFIG_HOME/git/gitk
>
> Signed-off-by: Astril Hayato <astrilhayato@gmail.com>
> ---
>  Documentation/gitk.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index 1e9e38a..417a707 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -166,8 +166,8 @@ gitk --max-count=100 --all \-- Makefile::
>  
>  Files
>  -----
> -Gitk creates the .gitk file in your $HOME directory to store preferences
> -such as display options, font, and colors.
> +User configuration and preferences are stored at $XDG_CONFIG_HOME/git/gitk or
> +$HOME/.config/git/gitk if $XDG_CONFIG_HOME is not set.

It is a bit more complex than that, isn't it?

 - $XDG_CONFIG_HOME/git/gitk is used if $XDG_CONFIG_HOME is set; otherwise
 - $HOME/.gitk is used, if you already have one; otherwise
 - $HOME/.config/git/gitk is used.
