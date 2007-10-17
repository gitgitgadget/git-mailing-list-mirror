From: Gonzalo Garramuno <gga@filmaura.com>
Subject: Re: git update index question
Date: Wed, 17 Oct 2007 09:58:46 -0300
Message-ID: <47160706.2000706@filmaura.com>
References: <4715E2AB.4030900@filmaura.com> <8c5c35580710170549n25c8b692w2466091ea56d641e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 14:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii8UX-0002Xz-Nq
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 14:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbXJQM7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2007 08:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbXJQM7F
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 08:59:05 -0400
Received: from an.site5.com ([74.53.3.196]:50680 "EHLO an.site5.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbXJQM7E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 08:59:04 -0400
Received: from [201.255.33.200] (helo=[192.168.1.3])
	by an.site5.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <gga@filmaura.com>)
	id 1Ii8U9-0002F0-TI; Wed, 17 Oct 2007 07:58:56 -0500
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <8c5c35580710170549n25c8b692w2466091ea56d641e@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - an.site5.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - filmaura.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61375>

Lars Hjemli wrote:
> On 10/17/07, Gonzalo Garramuno <gga@filmaura.com> wrote:
>> what's the proper way to rebuild git's index file for all the files =
that
>> were to be committed but weren't due to the abort.
>=20
> Have you tried 'git commit -a'? It will run update-index on all
> modified files prior to executing the hook.
>=20
> Btw: If you want to inspect your changes for offending whitespace,
> 'git diff --color' and  'git diff --cached --color' are your friends.
> And if you give up, there is also 'git commit -a --no-verify'.
>=20

Thanks.  I found out the root of my problem was actually something else=
=2E=20
  I had incorrectly done a chmod a+x on the pre-commit hook when all my=
=20
previous commits had not been using it, so I think the pre-commit was=20
actually catching not my new fix but what was already in the repository=
=2E
git-commit -a had no effect due to that.

But it's good to know about the --no-verify option, thou.

--=20
Gonzalo Garramu=C3=B1o

=46ilm Aura
A New Dawn in Media Companies

gga@filmaura.com
http://www.filmaura.com
