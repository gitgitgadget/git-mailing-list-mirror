From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Documentation: warn prominently against merging
 with dirty trees
Date: Sun, 10 Jan 2010 18:30:38 -0800
Message-ID: <7vzl4lbcfl.fsf@alter.siamese.dyndns.org>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch> <20100110044949.GA8974@progeny.tock> <7vskaefp2v.fsf@alter.siamese.dyndns.org> <20100111021322.GA8480@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 03:30:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUA3T-00089O-16
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 03:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629Ab0AKCav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jan 2010 21:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136Ab0AKCav
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 21:30:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab0AKCau convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jan 2010 21:30:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44DC08FC65;
	Sun, 10 Jan 2010 21:30:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sToY6hFGFLTG
	wpCqhyR66MaGtlA=; b=OWMX25v+0E6xUFRPk1THavaiKhnrXzO4dHHh1KS3DlGm
	N25hPvqHsemx1aXh+aGY4eW3VmD35uMllsnAinWJ8pST07eL2pOVcfTKPAB44W4y
	34nLOHp/h8zKccvkTpVdB9e19BeyosmC78D4cVJfGLNBAMH2yTg6KFMAtm63I38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JMMNVi
	jE8DyRv+ZWWXrkDgBSHODCQp5jhGpzyjBpy68lorImcV9Pbq2lvhSciiyqM4M2Gh
	jwOISF+/+FsIkJ7XsCHpuxtA6UMv2lKvwlxcFyc0GGDAtPCqIt03PyhlqYd8TI6G
	IjM+KfDm3sGuxZK/LsAJAug2+6jVph/4OESjE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10BC68FC61;
	Sun, 10 Jan 2010 21:30:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 268C58FC5E; Sun, 10 Jan
 2010 21:30:40 -0500 (EST)
In-Reply-To: <20100111021322.GA8480@progeny.tock> (Jonathan Nieder's message
 of "Sun\, 10 Jan 2010 20\:13\:22 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5215D5EE-FE59-11DE-A484-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136599>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Here is a scenario I worry about:
>
> Suppose I have a change to main.c staged, to add a feature that other=
s
> have discussed as well.  After a short distraction, I return and run
> =E2=80=98git pull=E2=80=99 to see what upstream has been working on.

If your index is dirty, any "mergy" operation will refuse to work *befo=
re*
touching anything, so you won't use "git reset --merge" to begin with.

You are allowed to have local modifications only in your work tree.
=46urthermore, even git experts limit them to something they feel they =
can
afford to lose and recreate easily if necessary.  See for example:

  http://thread.gmane.org/gmane.comp.version-control.git/15148/focus=3D=
15476

That is why I said:

  Of course, the user needs to understand what he or she is doing (see
  http://thread.gmane.org/gmane.comp.version-control.git/136166/focus=3D=
136171
  for example).  And that is one reason we (at least I) try to teach ne=
w
  people to start working from a clean tree, until they get comfortable
  working with mergy operations.

and that is why the archived article referenced above refers to

  http://gitster.livejournal.com/29060.html

You need to be able to tell the two ways in which a "mergy" operation c=
an
"fail" apart [*1*].

 - One that stops before touching anything (either your index was dirty
   and nothing happened, or your index was clean but you had local
   modifications in your work tree).  You do not run "git reset --merge=
",
   for this one; and

 - Another that goes ahead and results in conflicts.  When you got thes=
e
   conflicts, you can "reset --merge" them away.

[Footnote]

*1* Strictly speaking, the latter is not even a "failure"; it allowed y=
ou
to make progress, merging all the auto-mergeable parts without your hel=
p,
and only asking you to handle the remainder.
