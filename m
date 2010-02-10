From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-archive documentation: .gitattributes must be
 committed
Date: Wed, 10 Feb 2010 12:33:58 -0800
Message-ID: <7veiks7rux.fsf@alter.siamese.dyndns.org>
References: <1265770284-14830-1-git-send-email-fmarier@gmail.com>
 <4B7303FC.6070701@lsrfire.ath.cx> <7v1vgsao21.fsf@alter.siamese.dyndns.org>
 <4B731043.6010108@lsrfire.ath.cx> <7vr5os7sl2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Francois Marier <fmarier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 21:34:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfJGV-0002V9-DJ
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 21:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab0BJUeW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 15:34:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756037Ab0BJUeV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 15:34:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5646A9880D;
	Wed, 10 Feb 2010 15:34:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=viBbsUr1f2Ln
	TxQLws7Oz/HfFdc=; b=dWOJzQm9OWgsEuZ+r+cQBCwDr2zvaUefrPdRQ9++/9SV
	8sTG8NRMlX6D/jgRGJ9gMk+OkGJXAToQJHZpOYvCT1uddNjY74t9PVYihGYYqPJ6
	CVndW93w6xsGXSflaFpj8gIkxKuQJEKL9I+tpp5RJd5MHOtg+ZqeU64zpeKVsEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RE7A9/
	FCBr1ZBbDlgDaGVkqwD6fhp5hjWwl41xnf9TFESUrEu9lLSmoHEBdhpHqeRTRy3B
	cssBovibGSJuw5jnKkJQhIZlYkYhPu7cl4p427svgeBQ+mD7DUMsOKnHN/eJLmh1
	1JNBIWtIAsYV9IdS6P7QRB/FUaAIFQ5LS1qXM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DDDC9880B;
	Wed, 10 Feb 2010 15:34:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAAB298806; Wed, 10 Feb
 2010 15:33:59 -0500 (EST)
In-Reply-To: <7vr5os7sl2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 10 Feb 2010 12\:18\:17 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1777BA0-1683-11DF-AB90-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139547>

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> ...  I think that the current
>> behaviour makes sense because it provides a repeatable default.
>
> I wouldn't insist on changing the default again too strongly, but I t=
hink
> the --worktree-attributes option should be advertised better in the
> documentation, as that mode of operation seems to match what the user=
s
> expect better, and I think that is how this thread started.

How about this?  Instead of stopping at saying "it is taken from the tr=
ee
and must be committed, period", we should continue giving insn to help
people who didn't do so to achieve what they want to do.

-- >8 --
Subject: archive documentation: attributes are taken from the tree by d=
efault

By default, git-archive takes attributes from the tree being archived.
People however often wonder why their attempts to affect the way how th=
e
command archives their tree by changing .gitattributes in their work tr=
ee
fail.

Add a bit of explanatory note to tell them how to achieve what they wan=
t
to do.

Noticed-by: Francois Marier
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-archive.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index 799c8b6..8d3e666 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -112,6 +112,14 @@ export-subst::
 	expand several placeholders when adding this file to an archive.
 	See linkgit:gitattributes[5] for details.
=20
+Note that attributes are by default taken from the `.gitattributes` fi=
les
+in the tree that is being archived.  If you want to tweak the way the
+output is generated after the fact (e.g. you committed without adding =
an
+appropriate export-ignore in its `.gitattributes`), adjust the checked=
 out
+`.gitattributes` file as necessary and use `--work-tree-attributes`
+option.  Alternatively you can keep necessary attributes that should a=
pply
+while archiving any tree in your `$GIT_DIR/info/attributes` file.
+
 EXAMPLES
 --------
 git archive --format=3Dtar --prefix=3Djunk/ HEAD | (cd /var/tmp/ && ta=
r xf -)::
