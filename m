From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix false positives in t3404 due to SHELL=/bin/false
Date: Sun, 26 Dec 2010 22:10:09 -0800
Message-ID: <7vsjxjyce6.fsf@alter.siamese.dyndns.org>
References: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Dec 27 07:10:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PX6Hp-0001Cy-Jf
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 07:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab0L0GKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 01:10:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0L0GKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 01:10:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19EE43833;
	Mon, 27 Dec 2010 01:10:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3dAqSCnnF1DKSVbR9s59s6Dd4Yc=; b=nXpMWk
	MBYux1zlHYvsjUFiUfZg0wyJ8aIhGtq6h35dm/4b5coLeZtBuIGVBvQNH7muBuD0
	3wudG/VDvVICR/GS8dfLZu41qc1GBdfBXx2ihnPsIfxvEAnSAXHzIVYIlxksl7jJ
	lJHWoMaay/bLi+TyZvjW2pjpBFyO+/jIc9K08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hq6MyiM9rUQoj2P1cXwsusWAI+8VFMo4
	aU1huIJS0ExXcmdtkwz/aN9ejp2JaHXrB5moAXAVuUqz2RBeEbamNJx1yBlLWzNm
	LJBHrUxdJVhoAtfciHPwh7gcrNK6vQGF2etxkgGFMtUZEtu72Hz+s0XnwnabRAar
	YEmhka7SurI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E734D3832;
	Mon, 27 Dec 2010 01:10:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1DD873831; Mon, 27 Dec 2010
 01:10:41 -0500 (EST)
In-Reply-To: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net> (Robin
 H. Johnson's message of "Mon\, 27 Dec 2010 02\:50\:43 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A664C52-1180-11E0-A00B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164210>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

>  # "exec" commands are ran with the user shell by default, but this may
>  # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>  # to create a file. Unseting SHELL avoids such non-portable behavior
> -# in tests.
> -SHELL=
> +# in tests. It must be exported for it to take effect where needed.
> +export SHELL=

Thanks.

This probably is still not portable.

	SHELL=
        export SHELL

would be Ok, though.
