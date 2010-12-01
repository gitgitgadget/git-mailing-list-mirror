From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: introduce add.ignoreerrors synonym for
 add.ignore-errors
Date: Wed, 01 Dec 2010 12:09:12 -0800
Message-ID: <7vipzduufr.fsf@alter.siamese.dyndns.org>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net> <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com> <20101201160503.GB26120@burratino> <m3aakp4g5o.fsf@localhost.localdomain> <20101201163406.GD26120@burratino> <20101201175517.GA7774@sigill.intra.peff.net> <20101201183615.GA27024@burratino> <20101201184659.GA9147@sigill.intra.peff.net> <20101201185711.GD27024@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 21:09:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNszs-0006vW-SD
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454Ab0LAUJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:09:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362Ab0LAUJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:09:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B7942F5F;
	Wed,  1 Dec 2010 15:09:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TvU+919IlXPbORYakx4nZVt9NME=; b=jvL8OW
	jSyldiKBSHZxDNqCtvm5doqzHxESY82wWCKAawY50JHRBKEYRjRP9g5CT+sUB3my
	5a2MfRAZGXsrmuvOFvFmoq2XV0hl5Et0PqS5RjekmE5H9SpCQKBx8ClLzVrDqZhF
	OOoRdAvXf+HnW2ZBQEaQn8FoHatq5s7xBqBxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=abwQ7E7JvV3paGF2D6ML3DpDCzbQOEmH
	5uEavslXIdx0D+7xhe0+cdIZlfGlpz1rynEByr+jANSRYd1XXbiM0yOy2DM+IwB2
	JQ4tkQ2i4+hNjRj5SOshVNlDLg5hDdDCtnawFXW8ztdQabQpI5ImUYL4oFVlXLmz
	BXjLxyePO0U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB7292F58;
	Wed,  1 Dec 2010 15:09:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E80C02F56; Wed,  1 Dec 2010
 15:09:32 -0500 (EST)
In-Reply-To: <20101201185711.GD27024@burratino> (Jonathan Nieder's message of
 "Wed\, 1 Dec 2010 12\:57\:11 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE39825E-FD86-11DF-A223-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162597>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> Yes, looks good to me. You could potentially drop the old one from the
>> config:
>> ...
>> which may be less confusing to new users (who might ask "is there a
>> difference between the two?").
>
> Right, I prefer to keep it documented for the old and forgetful users
> (who might ask "why does this configuration work?").

We actually need to stress the fact that _only_ newer git will understand
"add.ignoreErrors", so people with older git (especially the ones who need
to use both older and newer versions of git) may need to keep using the
older form in their configuration, no?

Perhaps phrasing it like this, and then issue v1.7.{0,1,2,3}.X maintenance
release to reduce the chance of inconveniencing the users?

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1df0f65..5b6f667 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -539,9 +539,12 @@ core.sparseCheckout::
 	linkgit:git-read-tree[1] for more information.
 
 add.ignore-errors::
+add.ignoreErrors::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
-	option of linkgit:git-add[1].
+	option of linkgit:git-add[1].  Older versions of git accept only
+	`add.ignore-errors`, whose name goes against the convention, so
+	newer versions of git honor `add.ignoreErrors` as well.
 
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
