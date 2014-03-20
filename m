From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Documentation/gitk: Document new config file location
Date: Thu, 20 Mar 2014 11:01:00 -0700
Message-ID: <xmqqy504yckj.fsf@gitster.dls.corp.google.com>
References: <1395322429-1501-1-git-send-email-astrilhayato@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Astril Hayato <astrilhayato@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 19:01:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQhHD-0008Dg-Mq
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 19:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbaCTSBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 14:01:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbaCTSBE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 14:01:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D34074EE6;
	Thu, 20 Mar 2014 14:01:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bxhhWC1uyAd+bDDhkS7cttPHixs=; b=aimvAD
	2YqqqmWDu5un7YU3T7bO3NakHwPjyZqy0jUumMwRi6fCvyKkPIcQHnEUsBB2mkOJ
	lZpeFqc4Jjy7D7sUko4H6X+c8urdy7WJNkrlyT7IeZcILPLidawlus4sPEafqNCI
	RitH6EA4MS+P0t0UUCh1hKDx4lEj+oc9t+6mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Va3zqWieHtBHSwh/r+jgxHj/ZefFzMIn
	VyCuo9ZPYBTZKRSnUdQbvi60NWkXfMY19XBMFQ9mBSphXfAfFDVO/ILFNAtQGTch
	TtDhYKh4JUu7A+yjyPMuyZ+KtHddiAnZPM6+vrUoe8fRLt7uUsjFzo0rQKd1Ou1P
	ujlSfRBBQ78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFADB74EE5;
	Thu, 20 Mar 2014 14:01:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2415474EDA;
	Thu, 20 Mar 2014 14:01:02 -0400 (EDT)
In-Reply-To: <1395322429-1501-1-git-send-email-astrilhayato@gmail.com> (Astril
	Hayato's message of "Thu, 20 Mar 2014 13:33:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9949BAA0-B059-11E3-8CFF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244566>

Astril Hayato <astrilhayato@gmail.com> writes:

> User config file location now complies with the XDG base directory specification
>
> Signed-off-by: Astril Hayato <astrilhayato@gmail.com>
> ---
>  Documentation/gitk.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index 1e9e38a..7e03fcc 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -166,8 +166,14 @@ gitk --max-count=100 --all \-- Makefile::
>  
>  Files
>  -----
> -Gitk creates the .gitk file in your $HOME directory to store preferences
> -such as display options, font, and colors.
> +User configuration and preferences are stored at:
> +
> +* '$XDG_CONFIG_HOME/git/gitk' if it exists, otherwise
> +* '$HOME/.gitk' if it exists
> +
> +If neither of the above exist then '$XDG_CONFIG_HOME/git/gitk' is created and
> +used by default. If '$XDG_CONFIG_HOME' is not set it defaults to
> +'$HOME/.config' in all cases.

Thanks; looks good.
