From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Clarify documentation on the "ours" merge strategy.
Date: Sun, 15 Nov 2009 01:10:24 -0800
Message-ID: <7vk4xsqhkv.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
 <7vskckn5b4.fsf@alter.siamese.dyndns.org> <20091111213049.GJ27518@vidovic>
 <200911120037.11901.trast@student.ethz.ch>
 <7vvdhggote.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0911121034580.8825@ds9.cixit.se>
 <20091114111259.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	<Johannes.Schindelin@gmx.de>, <B.Steinbrink@gmx.de>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 10:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9b8J-0002Kl-3s
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 10:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbZKOJKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 04:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbZKOJKn
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 04:10:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbZKOJKl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 04:10:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF57C7F3F7;
	Sun, 15 Nov 2009 04:10:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=WWEy9be+VmcxAjQxB0fN4ep9a
	zM=; b=BJbLvjIiwvBj9dHQK6xyVWKDLlgVLjpDyHIu9LqYQ0Afbst2GFCEYLlZu
	KVjkoPm6oaYwwDTDrw4yfwKZK9WaKwMeW/wNRJwc8GH2TQv5VxyJ4AhEEU6sKXea
	XU79Vi04C7AHdf3/8djxzOo61sb2nhCFqW/Al10ekebtzxI/mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=a0yCHrJ3zMySfiaFSi+
	dHobSCPl0Z9dbC1lbP/b1RcqT9DNLuTdZ5QOAmAtFlX3CUIDY1q4tmLDttnQRXOx
	oLjcNqL/xNc5eAF9Bu1hWwkkGF3BDhcKEywzqQ9jCJ3vvAj9sFX9KePkciMCxv3+
	0QDG2Dbg+DK0Ecy5/dmqZOR8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 335247F3F6;
	Sun, 15 Nov 2009 04:10:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 908237F3F5; Sun, 15 Nov
 2009 04:10:25 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BE28CBFC-D1C6-11DE-A89D-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132920>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Peter Krefting <peter@softwolves.pp.se>
>
>> The web tree checkout script uses rebase to avoid introducing merge
>> commits every time the blog comment is updated, as it in 99 % of cas=
es
>> is unrelated to any other changes found in the central repo.
>>
>> In the few cases where the blog comment update from the web tree
>> conflicts with a change in the central repo, I want the "git pull
>> --rebase" call to overwrite any changes in the central repo with my
>> changes in the web tree (meaning that I would later have to manually
>> re-delete the spam comments, but I can live with that).
>
> That sounds like "-Xours" merge option that was discussed some time=20
> ago. See
>
>     http://thread.gmane.org/gmane.comp.version-control.git/76650/focu=
s=3D89021
>
> I remember that Junio and Petr were against it because it would=20
> encourage a bad workflow. Dscho was against the syntax used to=20
> pass the options also.

Yeah, Bj=C3=B6rn seems to speculate the same.

Even though I still think -Xours/-Xtheirs are nonsense options in the
context of source code management, I suspect that they might be exactly
what Peter needs in this situation.

As long as the changes made on the "web tree" side only consist of
user-generated blog contents and never touch framework code that is
controlled by his "central repo" side (and that condition should
hold true; otherwise Peter's web site is seriously broken from the
security point of view and no SCM can fix that), running a merge with
the fabled -Xours option in the "web tree" to slurp in the changes made=
 on
the "central repo" side does not sound like an unreasonable thing to do=
=2E
