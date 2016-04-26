From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] githooks.txt: Amend dangerous advice about 'update' hook ACL
Date: Tue, 26 Apr 2016 12:49:12 -0700
Message-ID: <xmqqmvogf8w7.fsf@gitster.mtv.corp.google.com>
References: <1461694402-9629-1-git-send-email-avarab@gmail.com>
	<1461694402-9629-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 21:49:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av8zB-0005Lx-Kj
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 21:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbcDZTtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 15:49:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753256AbcDZTtV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 15:49:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6464315D00;
	Tue, 26 Apr 2016 15:49:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vSGO778S55cZ
	W6WsqnfpFuXue3Y=; b=LNY2AMo9i2/wcDp6hNI0KdvRgqZFu6v3/rWe7fwUd1h6
	x0gdR3AzeSnI3NCXwFeBclt53ag4cQG2DxzSU+6iB4HbMRHvn4vmPACSCTljEkfl
	JHA92cRIfFAXgCdi4ld6ebgJWsRGiEJ3bkzRVE7ga4bisXqgqhVrmos6e+wRI6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wh0Cr5
	QtKzRdmEmQvw0gZvXfhBGqDFRtg4EuW3uPaPQ87LNzfhlzLncj/xFcQJio22RNHw
	VXEUJ2YJxgC8f7NXlDG3EvZM72iHW4CIYh6wXJ9WYJ4yhOmTyGw3tNkNjvrANSxh
	QqSUIGlb6NVi8tjldG8IcXfS/tPBvJtXWKSWY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CA2015CFF;
	Tue, 26 Apr 2016 15:49:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC9F515CFE;
	Tue, 26 Apr 2016 15:49:13 -0400 (EDT)
In-Reply-To: <1461694402-9629-3-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 26 Apr
 2016 18:13:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3E37C94-0BE7-11E6-8ADB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292655>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Any ACL you implement via an 'update' hook isn't actual access contro=
l
> if the user has login access to the machine running git, because they
> can trivially just built their own git version which doesn't run the

s/built their own git version/build their own version of git/;

> hook.
>
> Change the documentation to take this dangerous edge case into accoun=
t,
> and remove the mention of the advice originating on the mailing list,
> the users reading this don't care where the idea came up.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  Documentation/githooks.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 7660b95..9051584 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -275,9 +275,11 @@ does not know the entire set of branches, so it =
would end up
>  firing one e-mail per ref when used naively, though.  The
>  <<post-receive,'post-receive'>> hook is more suited to that.
> =20
> -Another use suggested on the mailing list is to use this hook to
> -implement access control which is finer grained than the one
> -based on filesystem group.
> +In an environment that restricts the users' access only to git
> +commands over the wire, this hook can be used to implement access
> +control without relying on filesystem ownership and group
> +membership. See linkgit:git-shell[1] for how you might use the login
> +shell to restrict the user's access to only git commands.
> =20
>  Both standard output and standard error output are forwarded to
>  'git send-pack' on the other end, so you can simply `echo` messages
