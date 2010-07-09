From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] war on echo in scripts
Date: Thu, 08 Jul 2010 21:46:06 -0700
Message-ID: <7vocehmfe9.fsf@alter.siamese.dyndns.org>
References: <20100706225522.GA31048@genesis.frugalware.org>
 <7vpqyz278o.fsf@alter.siamese.dyndns.org>
 <20100707091633.GB31048@genesis.frugalware.org>
 <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
 <20100707094620.GC31048@genesis.frugalware.org>
 <7v7hl6stna.fsf@alter.siamese.dyndns.org>
 <20100708103552.GF31048@genesis.frugalware.org>
 <20100708171418.GA18229@burratino> <m2k4p58tum.fsf@igel.home>
 <20100709024633.GA13739@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 06:46:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX5To-0000J6-SK
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 06:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab0GIEqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 00:46:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab0GIEqW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 00:46:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22F61C2420;
	Fri,  9 Jul 2010 00:46:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L8jNZ2VlwyAIX3yLybsUpxPKrM0=; b=PvGMsv
	0/wk1oOYQh3MJuEIQAp2NzHPf8vgzxAU95RS55zw8Z8j+Yue0XhiN06/5nJEcleT
	g/sMIgKScCJewXv5XqtZUDwql2jVk5pQDz+1bSaerzR3o5lXhtNlaIQCRZKWJeB8
	GEH6ffI7uTdXMmU0zOfsltNP9FWYKqqm+GqWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fdeA+9iVapwuTCvxNmsEsfAerD99oII6
	WYu/W7ZnE7D9m+Hzr0xmkoDvjdMygejHY/ubkyPCye8ut43GnOS8OVY1gp54k0hk
	abYSfBKUorgqcvu6+nMS5cUdgsCUVU0fgmoSW5oR+UqgGegyKGV9Kr0imEIgLUld
	9kc62YazSJk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3678C241E;
	Fri,  9 Jul 2010 00:46:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0124C241C; Fri,  9 Jul
 2010 00:46:08 -0400 (EDT)
In-Reply-To: <20100709024633.GA13739@dert.cs.uchicago.edu> (Jonathan Nieder's
 message of "Thu\, 8 Jul 2010 21\:46\:33 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8524F54-8B14-11DF-944F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150640>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hmm, maybe something like this would be easier.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 6131670..b38b40b 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -39,6 +39,10 @@ git_broken_path_fix () {
>  
>  # @@BROKEN_PATH_FIX@@
>  
> +echo() {
> +	printf '%s\n' "$*"
> +}

As long as we don't have "echo -n" and "echo -e", this should
work, but...
