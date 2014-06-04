From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] t9001: avoid not portable '\n' with sed
Date: Wed, 04 Jun 2014 20:47:17 +0200
Message-ID: <878upc7bre.fsf@fencepost.gnu.org>
References: <538ED6DF.5020505@web.de>
	<xmqqr434vaeh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:47:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGDk-0000C7-MS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbaFDSr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 14:47:29 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:60621 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbaFDSr2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2014 14:47:28 -0400
Received: from localhost ([127.0.0.1]:59663 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WsGDf-00051O-FT; Wed, 04 Jun 2014 14:47:27 -0400
Received: by lola (Postfix, from userid 1000)
	id 3D61EE0D19; Wed,  4 Jun 2014 20:47:17 +0200 (CEST)
In-Reply-To: <xmqqr434vaeh.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 Jun 2014 10:42:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250757>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=F6gershausen <tboegi@web.de> writes:
>
>> t9001 used a '\n' in a sed expression to split one line into two lin=
es.
>> Some versions of sed simply ignore the '\' before the 'n', treating
>> '\n' as 'n'.
>>
>> As the test already requires perl as a prerequisite, use perl instea=
d of sed.
>>
>> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
>> ---
>
> Hmph.  I read this in pubs.opengroup.org/onlinepubs/9699919799/utilit=
ies/sed.html
>
>     The escape sequence '\n' shall match a <newline> embedded in the
>     pattern space.
>
> so it may be better to be a bit more explicit in the log message to
> say whose implementation has this issue to warn people.

"shall match" talks about the match expression, not the replacement.

--=20
David Kastrup
