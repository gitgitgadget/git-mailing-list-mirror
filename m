From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided by default for git
Date: Wed, 29 May 2013 13:07:11 -0700
Message-ID: <7v38t5sg7k.fsf@alter.siamese.dyndns.org>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
	<CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
	<CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com>
	<CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?utf-8?Q?Br=C3=A1ulio?= Bhavamitra <brauliobo@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 22:07:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhmeV-0004GG-OW
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 22:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966585Ab3E2UHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 16:07:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965216Ab3E2UHO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 16:07:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A321323A45;
	Wed, 29 May 2013 20:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SaMA3B9qCIFD
	zpT/WOSjHcUTl/M=; b=gNZorh0GW75c1YN49gwBtOSC9knK8OOd976P9Ug6pfhG
	ziiJulwiPjXkbA99MGM61T9mji4VN+mUOnbFsmK4Nj1bbeTIacuW14ZCl2mPJchm
	xARPJZ+G6X7bSY2l20dFaj87zkaF3eCJPfPt0mtGgJOmo4F7TKTF3r56dvh2Vlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B5vBzE
	Jd/dsO5lMMith8dQ0ShuKtDjNk++Uu3qDTVLPI1li5Rno29hoot0T+fD6UAgx4bi
	wF2mRAG8ulGXkIgH5SGPBQNo6Pj8no6bBHrfLioPQfq9FbL7b0NOvtnIQnLdYDJv
	8mIo3bCBgSp78lkalWhjwXmZEJfMJ1an8XZtM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 994AD23A44;
	Wed, 29 May 2013 20:07:13 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0588323A42;
	Wed, 29 May 2013 20:07:12 +0000 (UTC)
In-Reply-To: <CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 29 May 2013 14:50:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A055710-C89B-11E2-B956-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225884>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 29, 2013 at 1:26 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Br=C3=A1ulio Bhavamitra wrote:
>>>   root =3D rev-parse --show-toplevel
>>
>> What is your usecase for this?
>
> Some Git commands expect to be in the top level directory (e.g. git b=
lame).

"Git" things we can fix [*1*], but more importantly, build structure
of many project may require you to go up to the top to build the
whole thing, so being able to get a relative path to the top when
you are deep inside is a necessity.


[Footnote]

*1* "blame" is an oddball (and I suspect the recent log -Ln,m:path
    may share the same) in that it really wants a concret path, not
    a pathspec, so you cannot even say

	cd Documentation; git blame :/Makefile

    I think the right fix is to teach it that the argument it has
    been taking as a pathname is actually a pathspec, match the
    pathspec with appropriate place (either in the working tree, or
    in the commit we start digging from), and use the path that the
    pathspec matches to a single one (otherwise barf).
