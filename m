From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] errors: "strict subset" -> "ancestor"
Date: Mon, 5 Nov 2007 14:06:35 +0100
Message-ID: <E7B0CBAA-BB97-40A0-8CFB-A6F01A047D17@wincent.com>
References: <20071103023944.GA15379@fieldses.org> <A4169B7B-C05B-4CA0-B41B-E1E2D71491B6@zib.de> <ee77f5c20711030014x23ac6206rec81fe5968992147@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 14:07:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip1fj-0002Jf-Em
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 14:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbXKENHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 08:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754912AbXKENHE
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 08:07:04 -0500
Received: from wincent.com ([72.3.236.74]:44923 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836AbXKENHD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 08:07:03 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA5D6ajo005534;
	Mon, 5 Nov 2007 07:06:37 -0600
In-Reply-To: <ee77f5c20711030014x23ac6206rec81fe5968992147@mail.gmail.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63512>

El 3/11/2007, a las 8:14, David Symonds escribi=F3:

> On 11/3/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>
>> On Nov 3, 2007, at 3:39 AM, J. Bruce Fields wrote:
>>
>>> diff --git a/send-pack.c b/send-pack.c
>>> index 5e127a1..b74fd45 100644
>>> --- a/send-pack.c
>>> +++ b/send-pack.c
>>> @@ -297,9 +297,9 @@ static int send_pack(int in, int out, struct
>>> remote *remote, int nr_refspec, cha
>>>                               * commits at the remote end and likel=
y
>>>                               * we were not up to date to begin =20
>>> with.
>>>                               */
>>> -                             error("remote '%s' is not a strict "
>>> -                                   "subset of local ref '%s'. "
>>> -                                   "maybe you are not up-to-date =20
>>> and "
>>> +                             error("remote '%s' is not an =20
>>> ancestor of\n"
>>> +                                   " local  '%s'.\n"
>>
>> Two spaces in a row after local and before '%s'.
>
> So? That's presumably to align the remote and local strings.

Kind of: it aligns "error:" with "local":

	error: remote 'refs/heads/master' is not an ancestor of
	 local 'refs/heads/master'.

Personal I think it would be better to align the right edges of =20
"remote" and "local" so that it looks like the following; this more =20
clearly shows the correspondence between the remote and local refs:

	error: remote 'refs/heads/master' is not an ancestor of
	        local 'refs/heads/master'.

Or alternatively:

	error: remote 'refs/heads/master' is not an ancestor of
	       local  'refs/heads/master'.


Cheers,
Wincent
