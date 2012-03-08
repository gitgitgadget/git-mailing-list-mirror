From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 11:29:30 -0800
Message-ID: <7vty1ydh7p.fsf@alter.siamese.dyndns.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk>
 <CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com>
 <7vlinbdkb0.fsf@alter.siamese.dyndns.org> <vpq1up3aqk8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Morton <jeremy@configit.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 08 20:29:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5j1u-00081p-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 20:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab2CHT3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 14:29:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab2CHT3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 14:29:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1F2D75E8;
	Thu,  8 Mar 2012 14:29:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8bh9LHlmTKhFBJpEb7/EO0OjraQ=; b=Fnl8VM
	ZWj7mOCAD5HqDL8oEgQg1oRylg+v7DQ9Jh/udObS4u2TfSU4yzVtHtaEj5DWc4yk
	btUJbsArqquzsZ/KoLT+Bjas9tqyaLE1yKqA54b2z1KCn5LB9hWwIcxuCskCbweh
	xL4FTI/yYUbBoNCilB4ViDgV7egcqQfI6ThC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=va51USJBKd1I1/tOehPP6fZaWXl0dp63
	mT4+XG/XYUviYXMKwLiYqBpLCK+sU9Dkwq18AY9OKAvOmmii8pSIZThzq8FunPoX
	R96rxvdGU5SAycAWW0R3S5RDO48o5ORjwDjaahehwhZH5Tb54wnRvh+RoS7xnLxn
	6xCdIt7dx1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7BDC75E7;
	Thu,  8 Mar 2012 14:29:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A61F75E0; Thu,  8 Mar 2012
 14:29:32 -0500 (EST)
In-Reply-To: <vpq1up3aqk8.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 08 Mar 2012 19:35:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07C34F3A-6955-11E1-A777-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192635>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> If you publish to your own repository
>> and let others pull, the behaviour is not dangerous at all with or
>> without --force (well, --force brings its own danger but that does
>> not have anything to do with which branches are pushed).  If you
>> default to 'current' in such a workflow, you risk forgetting to
>> push, which is the more dangerous option between the two.
>
> Forgetting to push a branch is a danger, but far less dangerous than
> what "push --force" can do in a shared repository.
>
> In a shared repository, there's actually a race condition that you
> cannot avoid AFAICT:
> ...
> If someone else did a push between my first push and the "push --force",
> then the other user's push is discarded.

That is exactly what I said in the parentheses above, isn't it?  The
danger of "--force" does not have anything to do with which branches
are pushed. It comes primarily from the use of shared repository.
The first advice Carlos gave us in this thread, which was perfectly
sane, applies to your observation: before you "push --force", think
twice.

That does not change the conclusion that current is more suitable
for shared repository workflow and matching is more (not "equally to
current") suitable for publishing repository workflow, and we have a
way for user to tell Git which one is being used in a particular
project exactly for that purpose.
