From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-branch: color the commit status signs
Date: Wed, 22 Apr 2009 14:16:25 -0700
Message-ID: <7vskk01j9y.fsf@gitster.siamese.dyndns.org>
References: <1240350779-9686-1-git-send-email-markus.heidelberg@web.de>
 <780e0a6b0904221226s43a40a12k8bf83de12fa7815d@mail.gmail.com>
 <200904222245.24034.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Apr 22 23:18:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwjpa-00073T-GJ
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610AbZDVVQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 17:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbZDVVQe
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:16:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbZDVVQe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 17:16:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DECA0AC6BD;
	Wed, 22 Apr 2009 17:16:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 68F47AC6BA; Wed,
 22 Apr 2009 17:16:27 -0400 (EDT)
In-Reply-To: <200904222245.24034.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Wed, 22 Apr 2009 22:45:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DAAEF774-2F82-11DE-A3CC-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117264>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Stephen Boyd, 22.04.2009:
>> On Tue, Apr 21, 2009, Markus Heidelberg <markus.heidelberg@web.de> w=
rote:
>> > +--color::
>> > + =C2=A0 =C2=A0 =C2=A0 Color the status sign of the commits. Each =
branch uses a single color.
>>=20
>> I don't know what the status sign of a commit is without reading you=
r commit
>> message. Maybe reword this to be:
>>=20
>> Color the status sign ('*' '!' '+' '-') of each commit corresponding
>> to the branch
>> it's in.
>
> I had some problems with finding the right words for the description =
and
> still wasn't satisfied with it. I think your suggestion makes it easi=
er
> and will include it.
>
>> > +static char column_colors[][COLOR_MAXLEN] =3D {
>> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_RED,
>> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_GREEN,
>> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_YELLOW,
>> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_BLUE,
>> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_MAGENTA,
>> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_CYAN,
>> > +};
>> > +
>> > +#define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors))
>>=20
>> This looks like a copy/paste (with a small edit) from graph.c so may=
be you
>> want to refactor the original code from graph.c to color.h?
>
> How exactly do you think it can be refactored and then combined?

These tables belong to each command.  Your show-branches do not
necessarily want to get different set or number of colors when graph
output updates its color palette to have richer set of colors.  I do no=
t
see any need for "refactoring" here.
