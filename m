From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: --no-walk is no-op if range is
 specified
Date: Fri, 15 Jun 2012 10:37:53 -0700
Message-ID: <7vk3z8bhn2.fsf@alter.siamese.dyndns.org>
References: <1339765943.4625.57.camel@beez.lab.cmartin.tk>
 <1339770796-542-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yann Dirson <dirson@bertin.fr>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Jun 15 19:38:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfaTF-0001nX-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 19:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab2FORiC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jun 2012 13:38:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900Ab2FORiA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2012 13:38:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9880884B1;
	Fri, 15 Jun 2012 13:37:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ktfENP5lRSeO
	M1XjYDAfI2BQQPI=; b=Wz0MpkePJ7rL1dqtJqmFmx8QB2huV9qWqnyt2MIAiei/
	lGIKjwJor2XS1wY4fkM2JX6UKBgXVlM5QtQR9g+62n5o90zQP7WLqZ1e8lwQtd+F
	P5096N8rvaD3Ohc0NaLz6/8JG5wzQIs8oGNKz3waIMTNlaNcmGzafyWrS1mM4gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UjRKQ0
	9PM5R8AvPZcKUlZpDzW1NwRoY/gDv+8giXIr2sZWd4IwaBFnuR9Fjoa7E/TpFnbt
	O9OUXFA8e/OxWEKRJE51nuoSNx7EZfaEIDohS3OMtnwnNy3FoG5rSjJqfQQqoyHC
	1tcvOQyMIEw8XcqxqdoFs3q1Og5U0VOzz7hQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 845AF84B0;
	Fri, 15 Jun 2012 13:37:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F9F084A3; Fri, 15 Jun 2012
 13:37:54 -0400 (EDT)
In-Reply-To: <1339770796-542-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 15 Jun 2012 16:33:15
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D69FD98C-B710-11E1-81F3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200068>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> The existing description can be misleading and cause the reader to
> think that --no-walk will do something if they specify a range in the
> command line instead of a set of revs.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>  Documentation/rev-list-options.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-l=
ist-options.txt
> index 1ae3c89..84e34b1 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -622,6 +622,7 @@ These options are mostly targeted for packing of =
git repositories.
>  --no-walk::
> =20
>  	Only show the given revs, but do not traverse their ancestors.
> +	This has no effect if a range is specified.
> =20
>  --do-walk::

This is correct as a description of the current behaviour, but I
have to wonder if we should error out when the user explicitly
(i.e. the implicit uses of --no-walk by "show" and "cherry-pick"
need to be treated differently) gives --no-walk and a negative
commit (either by A..B range, or a separate ^A).

Would that break a valid script, and if not, how involved would such
a fix be?
