From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adds *~ to the .gitignore
Date: Thu, 09 Jun 2016 14:21:55 -0700
Message-ID: <xmqqh9d2girw.fsf@gitster.mtv.corp.google.com>
References: <1465506629-16577-1-git-send-email-Lars.Vogel@vogella.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lars Vogel <Lars.Vogel@vogella.com>
To: Lars Vogel <lars.vogel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:24:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB7PG-0007Qe-7t
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 23:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbcFIVWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 17:22:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752048AbcFIVWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 17:22:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C275F22E57;
	Thu,  9 Jun 2016 17:21:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XGYH2QxbrmybEhAJ6aMHcPtjheU=; b=ZPhbFw
	q6VTLC5CuFqiorkUxIcYk+2PmdBECrihbPxaSzhxlE5Kd4qWN8Vi2aqzWqseEJss
	/Ku4lgbV/+CuWlnJfbaRGAaG90Ya1JjJ1eE3V7USaSYAIxq91QDEUT89pf8dheVa
	fPz/Y2Q6rTNjWpT0PiN0gqcI2WQMPJYXG+oGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QPxJdge21KEO9GfoQ+bMrrVn9NLWa0LE
	zKAE68rIKMPc7q5IyqvoR2AKJh+Yzl+0IKsSA0qzpdEqZmQ37Du0H0WbBLerx+Ba
	vTdRMkj3MZ1lDtcotlvZ3DpqMBjv2Ijze4+m0D91vmWTQ8dLCaPBVzFRQhSWOBwx
	qq4sKA+48Qk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB5E522E56;
	Thu,  9 Jun 2016 17:21:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45D4822E4E;
	Thu,  9 Jun 2016 17:21:57 -0400 (EDT)
In-Reply-To: <1465506629-16577-1-git-send-email-Lars.Vogel@vogella.com> (Lars
	Vogel's message of "Thu, 9 Jun 2016 23:10:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3222E8BA-2E88-11E6-ADE5-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296928>

Lars Vogel <lars.vogel@gmail.com> writes:

> This helps contributors (like me) using editors which automatically create ~ copies of the changed data
>
> Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
> ---

We deliberately left this out and kept it out of .gitignore for the
past 10 years.  The justification was that use of Emacs is merely a
personal choice that is better served by .git/info/excludes; we do
not add .swp for vim users, either, for the same reason.

I personally do not care too deeply either way; I could even support
a move to add some selected small file extensions, as long as we
some (social) mechanism to avoid churning this file every time
somebody new comes and complains their favourite editor or other
tools are not supported.



>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index 05cb58a..13c7403 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -219,3 +219,4 @@
>  *.pdb
>  /Debug/
>  /Release/
> +*~
