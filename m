From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .gitignore: Ignore editor backup and swap files
Date: Thu, 16 Jan 2014 14:06:00 -0800
Message-ID: <xmqqtxd3y43b.fsf@gitster.dls.corp.google.com>
References: <1389907164-13400-1-git-send-email-alexander@plaimi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Berntsen <alexander@plaimi.net>
X-From: git-owner@vger.kernel.org Thu Jan 16 23:06:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3v4p-0005q2-EW
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 23:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbaAPWGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 17:06:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbaAPWGK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 17:06:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A41F762764;
	Thu, 16 Jan 2014 17:06:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E1wQ36xJScexEMuB+JjaGBCNUXA=; b=JGc3WC
	i1Qk11YWSiYZx07h2pM4gKTEWS2aGlRAC2ANX5uvyp2WGOVOikX9m5vEqrWTZJdb
	Ta8QLKgzvED9LjF+FOYesXtqj7JXKyc21DjdK2oxUn03tNeqac+wo1nSTIhkYVXX
	UZW2lHeeE63ZbOtiqtNjXaILlRjZjcSvLrasU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JezPcnhXTW9ZqMQYd96fcCyL7c1EJkYa
	Bp7EBZ/oTYwXhE4J7rXGFvt5igxKKDWSZdiLyPhE1/qKd6C1KXdR5rYLX4wFFjJB
	XtwEg3QYzcpznjulUMb/+5SQPgJI/IWJXCMUKWv+OAvHCd7NUcI2T7f4+1bjbznP
	m3I1mJBYUy8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9239C62763;
	Thu, 16 Jan 2014 17:06:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9EC162762;
	Thu, 16 Jan 2014 17:06:08 -0500 (EST)
In-Reply-To: <1389907164-13400-1-git-send-email-alexander@plaimi.net>
	(Alexander Berntsen's message of "Thu, 16 Jan 2014 22:19:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6734D206-7EFA-11E3-9BA2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240539>

Alexander Berntsen <alexander@plaimi.net> writes:

> Signed-off-by: Alexander Berntsen <alexander@plaimi.net>
> ---
>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index b5f9def..2905c21 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -240,3 +240,5 @@
>  *.pdb
>  /Debug/
>  /Release/
> +*~
> +.*.swp

I personally do not mind listing these common ones too much, but if
I am not mistaken, our policy on this file so far has been that it
lists build artifacts, and not personal preference (the *.swp entry
is useless for those who never use vim, for example).

These paths that depend on your choice of the editor and other tools
can still be managed in your personal .git/info/exclude in the
meantime.
