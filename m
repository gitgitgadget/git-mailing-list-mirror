From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2] Documentation: triangular workflow
Date: Mon, 06 Jun 2016 12:23:35 -0700
Message-ID: <xmqqk2i2w288.fsf@gitster.mtv.corp.google.com>
References: <1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<1465206518-1780-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, philipoakley@iee.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org, Matthieu.Moy@grenoble-inp.fr
To: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:23:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA07j-0007lb-BX
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 21:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbcFFTXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 15:23:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751085AbcFFTXi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 15:23:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 404FE227F6;
	Mon,  6 Jun 2016 15:23:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=anKt6Z3t36Pj
	vAKYDSMUKmXtVhk=; b=cFNqesxKpLR2wqQMST0D8vo+fhq+O3xSHfTdP1oqk63o
	r9Lvn4aY4l8y4ANnMS1FJ2YcmlrrksFCmuWIXnzNKjSoNb0S2QVeG8TEJA0hu1TB
	vrE95jYyHLnu37od5PpKZR9dw+FwbuOzr7zDxXlfSywD1MBEy1aDdv/Yj5rbBFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ncSjrW
	A6hX9NgJKlm65R/Gxra/jxsnxikJvAf+Z5aYbL17imKiHiI2V0uxG9/s4Ex/3lhM
	cKb2qAKqeEAaMe7WEIcSlkuem7p1414Vmu76ofuO/9Itmqu3X/PD/7sHiERkQ9AF
	vtbZB+P1Ox+AuBy9X8Iz/9CDFpEPdksUkHwAo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38246227F5;
	Mon,  6 Jun 2016 15:23:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB234227F4;
	Mon,  6 Jun 2016 15:23:36 -0400 (EDT)
In-Reply-To: <1465206518-1780-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	(Jordan DE's message of "Mon, 6 Jun 2016 11:48:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2AA85A8E-2C1C-11E6-9484-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296554>

Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:

> +TRIANGULAR WORKFLOW
> +-------------------
> +
> +In some projects, you cannot push directly to the project but have t=
o
> +suggest your commits to the maintainer (e.g. pull requests).
> +For these projects, it's common to use what's called a *triangular
> +workflow*:
> +
> +- Taking the last version of the project by fetching (e.g.
> +  **UPSTREAM**)
> +- Writing modifications and push them to a fork (e.g. **PUBLIC-FORK*=
*)
> +- Opening a pull request
> +- Checking of changes by the maintainer and, merging them into the
> +  **UPSTREAM** repository if accepted
> +
> +
> +........................................
> +------------------               -----------------
> +| UPSTREAM       |  maintainer   | PUBLIC-FORK   |
> +|  git/git       |- - - - - - - -|  me/remote    |
> +------------------       =E2=86=90       -----------------
> +              \                     /
> +               \                   /
> +          fetch=E2=86=93\                 /=E2=86=91push
> +                 \               /
> +                  \             /
> +                   -------------
> +                   |   LOCAL   |
> +                   -------------
> +........................................

I agree with other commenters that "PUBLIC-FORK" is a name that does
not capture the essense of the triangular being the next step
forward, compared to the "central shared repository" workflow, to
take advantage of the distributed nature of Git.

"Where you push so that somebody else can fetch from there" does not
have to be public.  You may be submitting a course assignment there,
only to be seen by your professor but not by others in the class.
Also, you do not your call "LOCAL" a "LOCAL-FORK" and that is a good
thing.  In a distributed world, everything is a fork, so adding
"-FORK" to a name is pretty much meaningless.

So neither "PUBLIC" nor "FORK" in "PUBLIC-FORK" is a good word to
describe this thing.

The only reason you are pushing there is because your "LOCAL" is
either not accessible from outside world, and/or you do not want to
give a direct access to it (otherwise you could have allowed an
access to whoever is going to fetch from you direct access to
"LOCAL" and be done with it without creating "PUBLIC-FORK").

That is why I reminded that we earlier in the design phase called
this "publish"; it is a place you give access to others a selected
work of yours that you choose to give them access to.  Whether you
are a leaf contributor, a student who got stuck and wants to ask
suggestions from your friends after looking your code over, or an
integrator of a big public project, I would view the act to push
into such a place you give selective visibility to your work to
others as publishing your work.
