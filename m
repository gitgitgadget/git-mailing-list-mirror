From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: document --quiet option
Date: Tue, 12 Apr 2011 12:07:20 -0700
Message-ID: <7vfwpnp9uf.fsf@alter.siamese.dyndns.org>
References: <1302622538-7535-1-git-send-email-cmn@elego.de>
 <4DA36D95.6060108@windriver.com> <7v8vvgv5dm.fsf@alter.siamese.dyndns.org>
 <1302623497-7658-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Apr 12 21:07:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9iwA-0000e9-RR
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 21:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292Ab1DLTHi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 15:07:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab1DLTHh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 15:07:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51C473AB4;
	Tue, 12 Apr 2011 15:09:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UGEGDl7MZ8+z
	R07CCxhhQ3GXBFY=; b=NcYgy1gnv+8UPZcaQTP/rSEl0vnMzGFt77h7XQKOpk5P
	+DgJVqjBHkdIviTdgCY14PG9rzEf2b/AnOz1H0ecgdSmi5CQXlPYNP0BDZmwDxfx
	J4Hp7Yf9eE98VftYQZeMAbkVuOJH+bzLRr61k9oDmS5Ihm55pPyjncl7SsvmxhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gx0PYh
	BYf2yoaG7RlN9UgVCy45VPCrNGYDiLXwv36nsuQ2EAqI+O3Ba6S5fIG3ecNb6fan
	VQDjRyD0L/5FtJmp8xM8QVapXtFAtiG5H3hqmdAlrDWZM7HVZQJzDI5a7COtmOY9
	n4mON+OxGTavrVsDGyD5Px7lqyYhuwiLHQyts=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FB283AB1;
	Tue, 12 Apr 2011 15:09:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 85B383AAF; Tue, 12 Apr 2011
 15:09:20 -0400 (EDT)
In-Reply-To: <1302623497-7658-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 12 Apr 2011 17:51:37
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62283B6A-6538-11E0-936E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171413>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>
> I guess this should be squashed into the previous one. I forgot it
> wasn't documented, partly because reading the commit log for
> ec2956df59 (Nate Case, format-patch: Respect --quiet option) says the
> man page suggests this should work.

I don't think the manual page ever meant to say anything like that.  It
used to include generic "diff" options from manual pages from diff-tree
and friends, but the "output" the description refers to is the diff
output and later dropped by protecting the description in diff-options.=
txt
with "ifndef::git-format-patch[]" in the Documentation/ sources.

> @@ -192,6 +192,9 @@ will want to ensure that threading is disabled fo=
r `git send-email`.
>  	filenames, use specified suffix.  A common alternative is
>  	`--suffix=3D.txt`.  Leaving this empty will remove the `.patch`
>  	suffix.
> +
> +--quiet::
> +	Do not print the patch names to standard output.

I see "filenames" in the context and that is "generated filenames".

Be consistent and don't introduce an undefined term "patch names" here;=
 it
will lead to confusing readers to think as if the "generated filenames"
and "patch names" are different things.
