From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: always respect core.worktree if set
Date: Mon, 28 Dec 2009 01:16:33 -0800
Message-ID: <7viqbrv4pa.fsf@alter.siamese.dyndns.org>
References: <fcaeb9bf0912272141j1def76e7v6f581636188e65f0@mail.gmail.com>
 <1261979704-30074-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 10:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPBie-0002oK-BQ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 10:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbZL1JQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 04:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbZL1JQr
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 04:16:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbZL1JQq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 04:16:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 788F3AAF52;
	Mon, 28 Dec 2009 04:16:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hCTOIzHIE1PC
	gT62CIiFqPFi9zY=; b=S38455kd5N2mi/Ajkyqy1FExD/ewmfk5d0iB48C8Ghk9
	05r/LAbws3BuzXD0e8C+j7rlCdMZk7izRWJCNYrBHKbIlvKZMCl1kw6gLZ0mJfRF
	rummV0YBt1t3HRD2ntOE/sZmlFJFa2rFNtH+3Gk+9k0WaUb2gCr5Itn0nqVW/UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=n/P5sm
	VwGq+sekVeqNqrs6PlbPMMHxsNL5VurrcGiuGxRxflHvkIWi5PX1VbWfP0p9uNuR
	NeNJBMl0UT1Bft1idNSARtcIddvrJuJ2ZCV9U3s5UfNT0RHAOK0sqomkYd8tsMUx
	tVo0K/ko1YUNcHnSJfoBT9Errd0SjRW2JacDc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 39B67AAF51;
	Mon, 28 Dec 2009 04:16:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98232AAF4F; Mon, 28 Dec 2009
 04:16:35 -0500 (EST)
In-Reply-To: <1261979704-30074-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 28 Dec
 2009 12\:55\:04 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B5A494BA-F391-11DE-851E-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135731>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> In the beginning, there was GIT_DIR environment variable, with a very
> simple semantics:
> ...

(Omitted an explanation of how GIT_DIR and core.worktree work together)=
=2E

> According to the current documentation, if GIT_DIR is not set,
> core.worktree is not respected, and the parent directory of the "git
> directory" may be used as worktree. This case, unless core.worktree
> matches the parent directory of the "git directory" in question, seem=
s
> a misconfiguration and nothing else. So remove this part of the
> documentation.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Junio may find the description highly familiar :) only slightly modi=
fied
>  at the end

I found it familiar, but I didn't see how that earlier part leads to th=
e
conclusion in, or even gives a necessary background information for, th=
e
last paragraph.  Perhaps you omitted something in the middle that was m=
ore
relevant?  If so, I would suggest omiting the earlier part, whose purpo=
se
was to prepare readers for that middle part, as well.

And I don't think the claim your last paragraph makes is consistent wit=
h
what the patch does at all.

Removing the "it will be ignored" from the documentation is a good chan=
ge
only in the sense that it makes the document closer to reality, but "it=
 is
a misconfiguration" is not a good justification of the change.

A documentation-only patch that can be justitifed by "a misconfiguratio=
n"
claim would probably read like this:

	The value of core.worktree in a ".git/config" is honored even when
	it differs from the directory that has the ".git" directory as its
	subdirectory.  This is likely to be a misconfiguration, so warn
	users about it.  Also, drop the part of the documentation that
	incorrectly claimed that we ignore such a misconfigured value.

	---

	core.worktree::
                Set the path to the root of the work tree.  Note that t=
his
        	is honored even when set in a configuration file in a
        	".git" subdirectory of a directory, and its value differs
        	from the latter directory (e.g. "/path/to/.git/config" has
        	core.worktree set to "/different/path"), which is most
        	likely a misconfiguration.  Running git commands in
        	"/path/to" directory will still use "/different/path" as
        	the root of the work tree and can cause great confusion to
        	the users.


Your earlier patch took a different approach to the misconfiguration.  =
"It
is an error, so we silently _ignore_".  It is a valid thing to say, but
the "silently" part is not friendly to the user and we would probably w=
ant
to diagnose and warn.  That is what I originally meant.
